import UIKit
import VelocidiSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let config = VSDKConfig(trackingBaseUrl: "http://localhost:8080", matchBaseUrl: "http://localhost:8080")!
        VSDKVelocidi.start(config)

        return true
    }
}
