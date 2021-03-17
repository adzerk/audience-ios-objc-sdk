import UIKit
import VelocidiSDK
import AppTrackingTransparency

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in })
        }

        let config = VSDKConfig(trackingBaseUrl: "http://localhost:8080", "http://localhost:8080")!
        VSDKVelocidi.start(config)

        return true
    }
}
