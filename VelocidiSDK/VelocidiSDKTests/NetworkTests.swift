import UIKit
import Quick
import Nimble
import Mockingjay
import VelocidiSDK

class NetworkTests: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("VelocidiSDK") {
            it("should make track requests") {
                func successBuilder(request: URLRequest) -> Response {
                    let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                    return .success(response, .noContent)
                }

                let trackingEvent = VSDKPageView()
                trackingEvent.siteId = "0"
                trackingEvent.clientId = "0"
                var success: Bool? = nil

                let config = VSDKConfig(hosts:"http://tr.testdomain.com", "http://match.testdomain.com")
                VSDKVelocidi.start(config!)
                VSDKVelocidi.sharedInstance().track(trackingEvent, onSuccess:{ (response: URLResponse, responseObject: Any) in
                    success = true
                }, onFailure:{(error: Error) in
                    NSLog("Error \(error.localizedDescription)")
                    success = false
                })

                self.stub(uri("http://tr.testdomain.com"), successBuilder)
                expect(success).toEventuallyNot(beNil(), timeout: 4)
                expect(success).toEventuallyNot(beFalse())
            }
        }
    }
}
