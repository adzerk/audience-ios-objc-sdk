import UIKit
import VelocidiSDK
import AppTrackingTransparency
import AdSupport

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    var trackingIsAllowed = false
    var idfa = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func useIDFA(completionHandler: @escaping (String?) -> Void) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                let isTrackingEnabled = status == .authorized
                var idfa: String?
                if isTrackingEnabled {
                    idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                }
                completionHandler(idfa)
            }
        } else {
            let isTrackingEnabled = ASIdentifierManager.shared().isAdvertisingTrackingEnabled
            var idfa: String?
            if isTrackingEnabled {
                idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            }
            completionHandler(idfa)
        }
    }

    var trackingNumber = 0
    var matchNumber = 0

    // MARK: Actions
    @IBAction func sendTrackingEvent(_ sender: UIButton) {

        useIDFA(completionHandler: { idfaOpt in
            if let idfa = idfaOpt {
                let trackingEvent = [
                  "type": "appView",
                  "siteId": "foo",
                  "clientId": "bar",
                  "title": "Welcome Screen",
                  "customFields": [
                    "debug": "true",
                    "role": "superuser"
                  ]
                ] as [String: Any]

                self.trackingNumber += 1
                let currentTrNumber = self.trackingNumber

                let userId = VSDKUserId(id: idfa, type: "idfa")
                VSDKVelocidi.sharedInstance()
                    .track(trackingEvent,
                            user: userId,
                            onSuccess: { (_: URLResponse, _: Any) in
                                self.mainLabel.text =
                                    "Tracking request #\(currentTrNumber) successful!"
                            },
                            onFailure: {(error: Error) in
                                self.mainLabel.text =
                                    "Error with tracking request #\(currentTrNumber)." +
                                    "\n Error: \(error.localizedDescription)"
                            })
            } else {
                self.mainLabel.text = "Could not retrieve IDFA identifier to send as User ID!"
            }
        })
    }

    var customTrackingNumber = 0

    @IBAction func sendCustomTrackingEvent(_ sender: Any) {
        useIDFA(completionHandler: { (idfaOpt) in
            if let idfa = idfaOpt {
                let trackingEvent =
                """
                {
                  "clientId": "bar",
                  "siteId": "foo",
                  "type": "custom",
                  "customFields": {
                    "key": "value"
                  },
                  "customType": "custom-type"
                }
                """

                self.customTrackingNumber += 1
                let currentCustomTrNumber = self.customTrackingNumber

                let userId = VSDKUserId(id: idfa, type: "idfa")
                VSDKVelocidi
                    .sharedInstance()
                    .track(trackingEvent, userId: userId, onSuccess: { (_: URLResponse, _: Any) in
                    self.mainLabel.text = "Custom Tracking request #\(currentCustomTrNumber) successful!"
                }, onFailure: {(error: Error) in
                    self.mainLabel.text =
                        "Error with custom tracking request #\(currentCustomTrNumber).\n" +
                        "Error: \(error.localizedDescription)"
                })
            } else {
                self.mainLabel.text = "Could not retrieve IDFA identifier to send as User ID!"
            }
        })
    }

    @IBAction func sendMatchEvent(_ sender: Any) {
        useIDFA(completionHandler: { (idfaOpt) in
            if let idfa = idfaOpt {
                let userId1 = VSDKUserId(id: idfa, type: "idfa")
                let userId2 = VSDKUserId(id: "baz", type: "fooType")
                let idsArray = NSMutableArray(array: [userId1, userId2])

                self.matchNumber += 1
                let currentMatchNumber = self.matchNumber

                VSDKVelocidi
                    .sharedInstance()
                    .match("1234-providerId-56789", userIds: idsArray, onSuccess: { (_: URLResponse, _: Any) in
                    self.mainLabel.text = "Match request #\(currentMatchNumber) successful!"
                }, onFailure: {(error: Error) in
                    self.mainLabel.text =
                        "Error with match request #\(currentMatchNumber).\nError: \(error.localizedDescription)"
                })
            } else {
                self.mainLabel.text = "Could not retrieve IDFA identifier to send as User ID!"
            }
        })
    }
}
