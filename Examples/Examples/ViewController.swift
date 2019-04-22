import UIKit
import VelocidiSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let config = VSDKConfig(hosts: "http://localhost:8080", "http://localhost:8080")!
        VSDKVelocidi.start(config)
    }

    //MARK: Actions
    @IBAction func TrackingEvent(_ sender: UIButton) {
        let trackingEvent = VSDKPageView()
        trackingEvent.siteId = "0"
        trackingEvent.clientId = "0"
        
        VSDKVelocidi.sharedInstance().track(trackingEvent, onSuccess:{ (response: URLResponse, responseObject: Any) in
            print("Success")
        }, onFailure:{(error: Error) in
            print("Error \(error.localizedDescription)")
        })
    }
}

