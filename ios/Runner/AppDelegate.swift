import UIKit
import Flutter
import GoogleMaps  // Add this import
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    GeneratedPluginRegistrant.register(with: self)
    // TODO: Add your Google Maps API key
        GMSServices.provideAPIKey("AIzaSyDdrlQ0uizrpuZzm0F23Gi1GEjG0wdyUzI")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

