import Quick
import Nimble
import Mockingjay
import VelocidiSDK
import AdSupport
import Foundation

class RequestsTests: QuickSpec {
    override func spec() {
        super.spec()
        describe("VSDKRequests") {
            it("should use the provided User-Agent") {
                class MockRequest: VSDKTrackingRequest {
                    override func getVersionedUserAgent() -> String {
                        return "fooUserAgent"
                    }
                }

                let url = "http://testdomain.com"
                let trackingEventJson = (try? VSDKUtil.tryParseJsonEventString(ExampleEvents.appViewJsonStr))!
                var requestExecuted: Bool = false

                self.stub({(request: URLRequest) in
                    return request.url!.absoluteString.starts(with: url)
                }, { (request: URLRequest) in
                    if request.allHTTPHeaderFields?["User-Agent"] == "fooUserAgent" {
                        let response = HTTPURLResponse(
                            url: request.url!,
                            statusCode: 200,
                            httpVersion: nil,
                            headerFields: nil)!
                        return .success(response, .noContent)
                    }
                    return .failure(NSError(domain: url, code: 400))
                })

                let request = MockRequest()
                request.userId = VSDKUserId(
                    id: "1c3eae0a556ed83200d7962f72f19961a609e9e59a3551701690f43a13263dc3",
                    type: "email_sha256")
                request.url = URL(string: url)!
                request.data = trackingEventJson

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
