import UIKit
import Quick
import Nimble
import Mockingjay
import VelocidiSDK

class MockUtil: VSDKUtil {
    override func getAdvertisingIdentifier() -> UUID {
        return UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
    }
    override func isAdvertisingTrackingEnabled() -> Bool {
        return false
    }
}

class MockRequest: VSDKRequest<JSONModel> {
    override init() {
        super.init()
        self.util = MockUtil()
    }
    
}

class RequestsTests: QuickSpec {
    override func spec() {
        super.spec()
        describe("VSDKRequests") {
            it("should not make a track requests if tracking is not allowed") {
                let url = "http://testdomain.com"
                let trackingEvent = VSDKPageView()
                trackingEvent.siteId = "0"
                trackingEvent.clientId = "0"
                
                var requestExecuted: Bool = false

                self.stub({(request: URLRequest) in
                    return request.url!.absoluteString.starts(with: url)
                }, failure(NSError(domain: url, code: 403)))

                let request = MockRequest()
                request.url = URL(string: url)!
                request.data = trackingEvent

                request.perform({_,_ in
                    requestExecuted = true
                }, {(error: Error) in
                    requestExecuted = true
                })
                
                Thread.sleep(forTimeInterval: 5.0)

                expect(requestExecuted).toNot(beTrue())
            }
        }
    }
}
