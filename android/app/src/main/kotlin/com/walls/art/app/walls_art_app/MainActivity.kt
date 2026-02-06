package com.walls.art.app.walls_art_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private var wallpaperChannel: WallpaperChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        wallpaperChannel = WallpaperChannel(this)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            WallpaperChannel.CHANNEL_NAME
        ).setMethodCallHandler(wallpaperChannel)
    }

    override fun onDestroy() {
        wallpaperChannel?.dispose()
        super.onDestroy()
    }
}
