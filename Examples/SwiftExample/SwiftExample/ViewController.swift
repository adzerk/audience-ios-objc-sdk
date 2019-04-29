import UIKit
import VelocidiSDK

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var trackingNumber = 0
    var matchNumber = 0

    //MARK: Actions
    @IBAction func sendTrackingEvent(_ sender: UIButton) {
        let trackingEvent = VSDKPageView()
        trackingEvent.siteId = "foo"
        trackingEvent.clientId = "bar"
        
        trackingNumber += 1
        let currentTrNumber = trackingNumber
        
        VSDKVelocidi.sharedInstance().track(trackingEvent, onSuccess:{ (response: URLResponse, responseObject: Any) in
            self.mainLabel.text = "Tracking request #\(currentTrNumber) successful!"
        }, onFailure:{(error: Error) in
            self.mainLabel.text = "Error with tracking request #\(currentTrNumber).\n Error: \(error.localizedDescription)"
        })
    }
    
    var customTrackingNumber = 0
    
    @IBAction func sendCustomTrackingEvent(_ sender: Any) {
        let trackingEvent = CustomEvent()
        trackingEvent.siteId = "foo"
        trackingEvent.clientId = "bar"
        trackingEvent.customField = "baz"
        
        customTrackingNumber += 1
        let currentCustomTrNumber = customTrackingNumber
        
        VSDKVelocidi.sharedInstance().track(trackingEvent, onSuccess:{ (response: URLResponse, responseObject: Any) in
            self.mainLabel.text = "Custom Tracking request #\(currentCustomTrNumber) successful!"
        }, onFailure:{(error: Error) in
            self.mainLabel.text = "Error with custom tracking request #\(currentCustomTrNumber).\n Error: \(error.localizedDescription)"
        })
    }

    @IBAction func sendMatchEvent(_ sender: Any) {
        let userId1 = VSDKUserId(userId: "bar", "fooType")
        let userId2 = VSDKUserId(userId: "baz", "fooType")
        let idsArray = NSMutableArray(array: [userId1, userId2])

        matchNumber += 1
        let currentMatchNumber = matchNumber
        
        VSDKVelocidi.sharedInstance().match("1234-providerId-56789", userIds: idsArray, onSuccess:{ (response: URLResponse, responseObject: Any) in
            self.mainLabel.text = "Match request #\(currentMatchNumber) successful!!!"
        }, onFailure:{(error: Error) in
            self.mainLabel.text = "Error with match request #\(currentMatchNumber).\n Error: \(error.localizedDescription)"
        })
    }
}

