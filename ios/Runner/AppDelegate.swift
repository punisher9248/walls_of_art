import Flutter
import UIKit
import Photos

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
      name: "com.wallsofart/wallpaper",
      binaryMessenger: controller.binaryMessenger
    )

    channel.setMethodCallHandler { [weak self] (call, result) in
      switch call.method {
      case "saveToGallery":
        guard let args = call.arguments as? [String: Any],
              let url = args["url"] as? String else {
          result(FlutterError(code: "INVALID_ARGS", message: "URL is required", details: nil))
          return
        }
        self?.saveToGallery(url: url, result: result)
      case "setWallpaper":
        result(FlutterError(
          code: "NOT_SUPPORTED",
          message: "Setting wallpaper directly is not supported on iOS. Save the image and set it from Photos.",
          details: nil
        ))
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func saveToGallery(url: String, result: @escaping FlutterResult) {
    guard let imageURL = URL(string: url) else {
      result(FlutterError(code: "INVALID_URL", message: "Invalid URL", details: nil))
      return
    }

    var request = URLRequest(url: imageURL)
    request.setValue(
      "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15",
      forHTTPHeaderField: "User-Agent"
    )
    request.timeoutInterval = 30

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        DispatchQueue.main.async {
          result(FlutterError(code: "DOWNLOAD_ERROR", message: error.localizedDescription, details: nil))
        }
        return
      }

      guard let data = data, let image = UIImage(data: data) else {
        DispatchQueue.main.async {
          result(FlutterError(code: "DECODE_ERROR", message: "Failed to decode image", details: nil))
        }
        return
      }

      PHPhotoLibrary.shared().performChanges({
        PHAssetChangeRequest.creationRequestForAsset(from: image)
      }) { success, error in
        DispatchQueue.main.async {
          if success {
            result(["success": true, "message": "Wallpaper saved to Photos"])
          } else {
            result(FlutterError(
              code: "SAVE_ERROR",
              message: error?.localizedDescription ?? "Failed to save image",
              details: nil
            ))
          }
        }
      }
    }
    task.resume()
  }
}
