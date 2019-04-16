import UIKit
import Quick
import Nimble
import Mockingjay
import VelocidiSDK

extension Data {
    /**
     Consumes the specified input stream, creating a new Data object
     with its content.
     - Parameter reading: The input stream to read data from.
     - Note: Closes the specified stream.
     */
    init(reading input: InputStream) {
        self.init()
        input.open()
        
        let bufferSize = 1024
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        while input.hasBytesAvailable {
            let read = input.read(buffer, maxLength: bufferSize)
            self.append(buffer, count: read)
        }
        buffer.deallocate(capacity: bufferSize)
        
        input.close()
    }
}

class NetworkTests: QuickSpec {
    override func spec() {
        super.spec()
        describe("VelocidiSDK") {
            context("test track request"){
                let trackURL = "http://tr.testdomain.com"
                let matchURL = "http://match.testdomain.com"

                func  responseBuilder(url: String, expectedData: Data) -> (URLRequest) -> (Response) {
                    return { (request: URLRequest)   in
                        if(request.url!.absoluteString.starts(with: url)
                            && request.allHTTPHeaderFields?["Content-Type"] == "application/json"
                            && request.allHTTPHeaderFields?["User-Agent"] != nil
                            && request.httpBodyStream != nil
                            ){
                            
                            let receivedData = Data(reading: request.httpBodyStream!)
                            if(receivedData == expectedData){
                                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                                return .success(response, .noContent)
                            }
                        }
                        return .failure(NSError(domain: trackURL, code: 400))
                    }
                }
    
                it("should make track successful requests") {
                    let trackingEvent = VSDKPageView()
                    trackingEvent.siteId = "0"
                    trackingEvent.clientId = "0"

                    self.stub({(request: URLRequest) in
                        return request.url!.absoluteString.starts(with: trackURL)
                    }, responseBuilder(url:trackURL, expectedData:trackingEvent.toJSONData()))

                    var success: Bool? = nil

                    let config = VSDKConfig(hosts:trackURL, matchURL)
                    VSDKVelocidi.start(config!)
                    
                    VSDKVelocidi.sharedInstance().track(trackingEvent, onSuccess:{ (response: URLResponse, responseObject: Any) in
                        success = true
                    }, onFailure:{(error: Error) in
                        NSLog("Error \(error.localizedDescription)")
                        success = false
                    })
    
                    expect(success).toEventuallyNot(beNil(), timeout: 4)
                    expect(success).toEventuallyNot(beFalse())
                }
            }
        }
    }
}
