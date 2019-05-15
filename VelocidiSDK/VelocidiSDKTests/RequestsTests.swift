import UIKit
import Quick
import Nimble
import Mockingjay
import VelocidiSDK

class RequestsTests: QuickSpec {
    override func spec() {
        super.spec()
        describe("VSDKRequests") {
            it("should not make a track requests if tracking is not allowed") {
                
                class MockUtil: VSDKUtil {
                    override func getAdvertisingIdentifier() -> UUID {
                        return UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
                    }
                    override func isAdvertisingTrackingEnabled() -> Bool {
                        return false
                    }
                }

                let url = "http://testdomain.com"
                let trackingEvent = VSDKPageView()
                trackingEvent.siteId = "0"
                trackingEvent.clientId = "0"

                var requestExecuted: Bool? = nil

                self.stub({(request: URLRequest) in
                    return request.url!.absoluteString.starts(with: url)
                }, failure(NSError(domain: url, code: 403)))

                let request = VSDKRequest()
                request.util = MockUtil()
                request.url = URL(string: url)!
                request.data = trackingEvent

                request.perform({_,_ in
                    requestExecuted = true
                }, {(error: Error) in
                    if ((error as NSError).domain == VSDKRequest.trackingNotAllowedError) {
                        requestExecuted = false
                    } else {
                        requestExecuted = true
                    }
                })

                expect(requestExecuted).toEventuallyNot(beNil())
                expect(requestExecuted).toNot(beTrue())
            }
            
            it("should use the provided User-Agent") {
                
                class MockUtil: VSDKUtil {
                    override func getVersionedUserAgent() -> String {
                        return "fooUserAgent"
                    }
                }
                
                let url = "http://testdomain.com"
                let trackingEvent = VSDKPageView()
                trackingEvent.siteId = "0"
                trackingEvent.clientId = "0"
                
                var requestExecuted: Bool = false
                
                self.stub({(request: URLRequest) in
                    return request.url!.absoluteString.starts(with: url)
                }, { (request: URLRequest) in
                    if(request.allHTTPHeaderFields?["User-Agent"] == MockUtil().getVersionedUserAgent()) {
                        print("Is correct")
                        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                        return .success(response, .noContent)
                    }
                    print("Is incorrect")
                    return .failure(NSError(domain: url, code: 400))
                })
                
                let request = VSDKRequest()
                request.util = MockUtil()
                request.url = URL(string: url)!
                request.data = trackingEvent
                
                request.perform({_,_ in
                    print("success")
                    requestExecuted = true
                }, {(error: Error) in
                    print("failure")
                    print(error.localizedDescription)
                    requestExecuted = false
                })
                
                expect(requestExecuted).toEventually(beTrue())
            }
        }
    }
}
