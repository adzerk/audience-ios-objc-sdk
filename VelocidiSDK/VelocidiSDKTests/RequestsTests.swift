import UIKit
import Quick
import Nimble
import Mockingjay
import VelocidiSDK
import AdSupport

class MockASIdentifierManager: ASIdentifierManager {
    override var advertisingIdentifier: UUID {
        return UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
    }
    override var isAdvertisingTrackingEnabled: Bool {
        return false
    }
}

class MockIdfaUtil: VSDKIdfaUtil {
    override var identifierManager: ASIdentifierManager { return MockASIdentifierManager() }
}

class MockUtil: VSDKUtil {
    override func getVersionedUserAgent() -> String {
        return "fooUserAgent"
    }
}

class RequestsTests: QuickSpec {
    override func spec() {
        super.spec()
        describe("VSDKRequests") {
            it("should not make a tracking request if tracking is not allowed") {
                
                class MockRequest: VSDKTrackingRequest{
                    override var idfaUtil: VSDKIdfaUtil { return MockIdfaUtil() }
                }

                let url = "http://testdomain.com"
                let trackingEvent = VSDKPageView()
                trackingEvent.siteId = "0"
                trackingEvent.clientId = "0"

                var requestExecuted: Bool? = nil

                self.stub({(request: URLRequest) in
                    return request.url!.absoluteString.starts(with: url)
                }, failure(NSError(domain: url, code: 403)))

                let request = MockRequest()
                request.url = URL(string: url)!
                request.data = trackingEvent

                request.perform({_,_ in
                    requestExecuted = true
                }, {(error: Error) in
                    if ((error as NSError).domain == "com.velocidi.VSDKTrackingNotAllowedError") {
                        requestExecuted = false
                    } else {
                        requestExecuted = true
                    }
                })

                expect(requestExecuted).toEventuallyNot(beNil())
                expect(requestExecuted).to(beFalse())
            }
            
            it("should use the provided User-Agent") {
               
                class MockRequest: VSDKTrackingRequest{
                    override var util: VSDKUtil { return MockUtil() }
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
                        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                        return .success(response, .noContent)
                    }
                    return .failure(NSError(domain: url, code: 400))
                })
                
                let request = MockRequest()
                request.url = URL(string: url)!
                request.data = trackingEvent
                
                request.perform({_,_ in
                    requestExecuted = true
                }, {(error: Error) in
                    requestExecuted = false
                })
                
                expect(requestExecuted).toEventually(beTrue())
            }
        }
    }
}
