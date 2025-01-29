import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // GeneratedPluginRegistrant.register(with: self)
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.example.app/browser", binaryMessenger: controller.binaryMessenger)
    
    channel.setMethodCallHandler { (call, result) in
      if call.method == "openBrowser", let args = call.arguments as? [String: Any], let urlStr = args["url"] as? String, let url = URL(string: urlStr) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
