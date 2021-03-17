import Quick
import Nimble
import Mockingjay
import VelocidiSDK
import AdSupport
import Foundation

// swiftlint:disable function_body_length
class RequestsTests: QuickSpec {
    override func spec() {
        super.spec()
        describe("VSDKRequests") {
            it("should not make a tracking request if tracking is not allowed") {

                class MockRequest: VSDKTrackingRequest {
                    override func tryGetIDFA() throws -> String {
                        throw NSError(domain: "com.velocidi.VSDKTrackingNotAllowedError", code: 1, userInfo: nil)
                    }
                }

                let url = "http://testdomain.com"
                let trackingEvent = VSDKPageView()
                trackingEvent.siteId = "0"
                trackingEvent.clientId = "0"

                var requestExecuted: Bool?

                self.stub({(request: URLRequest) in
                    return request.url!.absoluteString.starts(with: url)
                }, failure(NSError(domain: url, code: 403)))

                let request = MockRequest()
                request.url = URL(string: url)!
                request.data = trackingEvent

                request.perform({_, _ in
                    requestExecuted = true
                }, {(error: Error) in
                    if (error as NSError).domain == "com.velocidi.VSDKTrackingNotAllowedError" {
                        requestExecuted = false
                    } else {
                        requestExecuted = true
                    }
                })

                expect(requestExecuted).toEventuallyNot(beNil())
                expect(requestExecuted).to(beFalse())
            }

            it("should use the provided User-Agent") {

                class MockRequest: VSDKTrackingRequest {
                    override func tryGetIDFA() throws -> String {
                        return "00000000-0000-0000-0000-000000000000"
                    }
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
                    if request.allHTTPHeaderFields?["User-Agent"] == "fooUserAgent" {
                        let response = HTTPURLResponse(
                            url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                        return .success(response, .noContent)
                    }
                    return .failure(NSError(domain: url, code: 400))
                })

                let request = MockRequest()
                request.url = URL(string: url)!
                request.data = trackingEvent

                request.perform({_, _ in
                    requestExecuted = true
                }, {(_: Error) in
                    requestExecuted = false
                })

                expect(requestExecuted).toEventually(beTrue())
            }
        }
    }
}
