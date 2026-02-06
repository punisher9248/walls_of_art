package com.walls.art.app.walls_art_app

import android.app.WallpaperManager
import android.content.ContentValues
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.net.URL
import javax.net.ssl.HttpsURLConnection

class WallpaperChannel(private val context: Context) : MethodChannel.MethodCallHandler {

    companion object {
        const val CHANNEL_NAME = "com.wallsofart/wallpaper"
    }

    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "setWallpaper" -> {
                val url = call.argument<String>("url")
                val target = call.argument<String>("target") ?: "both"

                if (url.isNullOrEmpty()) {
                    result.error("INVALID_ARGS", "URL is required", null)
                    return
                }

                setWallpaper(url, target, result)
            }
            "saveToGallery" -> {
                val url = call.argument<String>("url")
                val fileName = call.argument<String>("fileName") ?: "wallpaper_${System.currentTimeMillis()}.jpg"

                if (url.isNullOrEmpty()) {
                    result.error("INVALID_ARGS", "URL is required", null)
                    return
                }

                saveToGallery(url, fileName, result)
            }
            else -> result.notImplemented()
        }
    }

    private fun downloadBitmap(url: String): Bitmap? {
        val connection = URL(url).openConnection() as HttpsURLConnection
        connection.setRequestProperty(
            "User-Agent",
            "Mozilla/5.0 (Linux; Android) AppleWebKit/537.36"
        )
        connection.connectTimeout = 30000
        connection.readTimeout = 30000
        connection.connect()

        val inputStream = connection.inputStream
        val bitmap = BitmapFactory.decodeStream(inputStream)
        inputStream.close()
        connection.disconnect()

        return bitmap
    }

    private fun setWallpaper(url: String, target: String, result: MethodChannel.Result) {
        scope.launch {
            try {
                val bitmap = downloadBitmap(url)

                if (bitmap == null) {
                    withContext(Dispatchers.Main) {
                        result.error("DECODE_ERROR", "Failed to decode image", null)
                    }
                    return@launch
                }

                val wallpaperManager = WallpaperManager.getInstance(context)

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    val flag = when (target) {
                        "home" -> WallpaperManager.FLAG_SYSTEM
                        "lock" -> WallpaperManager.FLAG_LOCK
                        else -> WallpaperManager.FLAG_SYSTEM or WallpaperManager.FLAG_LOCK
                    }
                    wallpaperManager.setBitmap(bitmap, null, true, flag)
                } else {
                    wallpaperManager.setBitmap(bitmap)
                }

                bitmap.recycle()

                withContext(Dispatchers.Main) {
                    result.success(
                        mapOf(
                            "success" to true,
                            "message" to "Wallpaper set successfully"
                        )
                    )
                }
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    result.error(
                        "WALLPAPER_ERROR",
                        e.message ?: "Failed to set wallpaper",
                        e.stackTraceToString()
                    )
                }
            }
        }
    }

    private fun saveToGallery(url: String, fileName: String, result: MethodChannel.Result) {
        scope.launch {
            try {
                val bitmap = downloadBitmap(url)

                if (bitmap == null) {
                    withContext(Dispatchers.Main) {
                        result.error("DECODE_ERROR", "Failed to decode image", null)
                    }
                    return@launch
                }

                val contentValues = ContentValues().apply {
                    put(MediaStore.Images.Media.DISPLAY_NAME, fileName)
                    put(MediaStore.Images.Media.MIME_TYPE, "image/jpeg")
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                        put(MediaStore.Images.Media.RELATIVE_PATH, Environment.DIRECTORY_PICTURES + "/WallsOfArt")
                        put(MediaStore.Images.Media.IS_PENDING, 1)
                    }
                }

                val resolver = context.contentResolver
                val uri = resolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, contentValues)

                if (uri == null) {
                    bitmap.recycle()
                    withContext(Dispatchers.Main) {
                        result.error("SAVE_ERROR", "Failed to create media entry", null)
                    }
                    return@launch
                }

                resolver.openOutputStream(uri)?.use { outputStream ->
                    bitmap.compress(Bitmap.CompressFormat.JPEG, 100, outputStream)
                }

                bitmap.recycle()

                // Mark as complete so it appears in gallery immediately
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    contentValues.clear()
                    contentValues.put(MediaStore.Images.Media.IS_PENDING, 0)
                    resolver.update(uri, contentValues, null, null)
                }

                withContext(Dispatchers.Main) {
                    result.success(
                        mapOf(
                            "success" to true,
                            "message" to "Wallpaper saved to gallery"
                        )
                    )
                }
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    result.error(
                        "SAVE_ERROR",
                        e.message ?: "Failed to save image",
                        e.stackTraceToString()
                    )
                }
            }
        }
    }

    fun dispose() {
        scope.cancel()
    }
}
