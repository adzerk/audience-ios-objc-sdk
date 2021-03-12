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

        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                self.trackingIsAllowed = status == .authorized
            }
        } else {
            self.trackingIsAllowed = ASIdentifierManager.shared().isAdvertisingTrackingEnabled
        }

        if (trackingIsAllowed) {
            print("andre")
            print(self.trackingIsAllowed)
            self.idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        }
    }
    
    var trackingNumber = 0
    var matchNumber = 0

    //MARK: Actions
    @IBAction func sendTrackingEvent(_ sender: UIButton) {

        if (self.trackingIsAllowed) {
            let trackingEvent = VSDKPageView()
            trackingEvent.siteId = "foo"
            trackingEvent.clientId = "bar"

            trackingNumber += 1
            let currentTrNumber = trackingNumber

            let userId = VSDKUserId(id: self.idfa, type: "idfa")
            VSDKVelocidi.sharedInstance().track(trackingEvent, userId: userId, onSuccess:{ (response: URLResponse, responseObject: Any) in
                self.mainLabel.text = "Tracking request #\(currentTrNumber) successful!"
            }, onFailure:{(error: Error) in
                self.mainLabel.text = "Error with tracking request #\(currentTrNumber).\n Error: \(error.localizedDescription)"
            })
        } else {
            self.mainLabel.text = "Could not retrieve IDFA identifier to send as User ID!"
        }
    }
    
    var customTrackingNumber = 0
    
    @IBAction func sendCustomTrackingEvent(_ sender: Any) {
        if (self.trackingIsAllowed) {
            let trackingEvent = CustomEvent()
            trackingEvent.siteId = "foo"
            trackingEvent.clientId = "bar"
            trackingEvent.customField = "baz"

            customTrackingNumber += 1
            let currentCustomTrNumber = customTrackingNumber

            let userId = VSDKUserId(id: self.idfa, type: "idfa")
            VSDKVelocidi.sharedInstance().track(trackingEvent, userId: userId, onSuccess:{ (response: URLResponse, responseObject: Any) in
                self.mainLabel.text = "Custom Tracking request #\(currentCustomTrNumber) successful!"
            }, onFailure:{(error: Error) in
                self.mainLabel.text = "Error with custom tracking request #\(currentCustomTrNumber).\n Error: \(error.localizedDescription)"
            })
        } else {
            self.mainLabel.text = "Could not retrieve IDFA identifier to send as User ID!"
        }
    }

    @IBAction func sendMatchEvent(_ sender: Any) {
        if (self.trackingIsAllowed) {
            let userId1 = VSDKUserId(id: self.idfa, type: "idfa")
            let userId2 = VSDKUserId(id: "baz", type: "fooType")
            let idsArray = NSMutableArray(array: [userId1, userId2])

            matchNumber += 1
            let currentMatchNumber = matchNumber

            VSDKVelocidi.sharedInstance().match("1234-providerId-56789", userIds: idsArray, onSuccess:{ (response: URLResponse, responseObject: Any) in
                self.mainLabel.text = "Match request #\(currentMatchNumber) successful!"
            }, onFailure:{(error: Error) in
                self.mainLabel.text = "Error with match request #\(currentMatchNumber).\n Error: \(error.localizedDescription)"
            })
        } else {
            self.mainLabel.text = "Could not retrieve IDFA identifier to send as User ID!"
        }
    }
}

