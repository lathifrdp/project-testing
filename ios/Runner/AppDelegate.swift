import UIKit
import Flutter
//import FBSDKCoreKit
//import FBSDKLoginKit
import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if FirebaseApp.app() == nil {
      FirebaseApp.configure()
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    // ApplicationDelegate.shared.application(
    //         application,
    //         didFinishLaunchingWithOptions: launchOptions
    //     )

    //     return true
  }

  // override func application(
  //       _ app: UIApplication,
  //       open url: URL,
  //       options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  //   ) -> Bool {
  //       ApplicationDelegate.shared.application(
  //           app,
  //           open: url,
  //           sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
  //           annotation: options[UIApplication.OpenURLOptionsKey.annotation]
  //       )
  //   }
}
