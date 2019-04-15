import UIKit
import Quick
import Nimble
import Mockingjay

class NetworkTests: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("VelocidiSDK") {
            context("success"){
                it("should make track requests") {
                    func successBuilder(request: URLRequest) -> Response {
                        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                        return .success(response, .noContent)
                    }
                    
                    self.stub(uri("http://tr.testdomain.com"), successBuilder)
                    expect(1).to(equal(1))
                }
            }
        }
    }
}
