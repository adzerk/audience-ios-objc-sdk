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
        buffer.deallocate()

        input.close()
    }
}

class NetworkTests: QuickSpec {
    override func spec() {
        super.spec()
        describe("VelocidiSDK") {
            let trackURL = "http://tr.testdomain.com"
            let matchURL = "http://match.testdomain.com"
            
            context("test track request"){

                func responseBuilder(url: String, expectedData: Data) -> (URLRequest) -> (Response) {
                    return { (request: URLRequest) in
                        if(request.url!.absoluteString.starts(with: url)
                            && request.allHTTPHeaderFields?["Content-Type"] == "application/json"
                            && request.allHTTPHeaderFields?["User-Agent"] != nil
                            && request.httpBodyStream != nil) {

                            let receivedData = Data(reading: request.httpBodyStream!)
                            if(receivedData == expectedData){
                                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                                return .success(response, .noContent)
                            }
                        }
                        return .failure(NSError(domain: trackURL, code: 400))
                    }
                }
                
                func test(success: UnsafeMutablePointer<Bool?>, error: UnsafeMutablePointer<Error?>) {
                    let trackingEvent = VSDKPageView()
                    trackingEvent.siteId = "0"
                    trackingEvent.clientId = "0"

                    self.stub({(request: URLRequest) in
                        return request.url!.absoluteString.starts(with: trackURL)
                    }, responseBuilder(url:trackURL, expectedData:trackingEvent.toJSONData()))


                    let config = VSDKConfig(trackingBaseUrl: trackURL, matchURL)
                    VSDKVelocidi.start(config!)

                    VSDKVelocidi.sharedInstance().track(trackingEvent, onSuccess:{ (response: URLResponse, responseObject: Any) in
                        success.pointee = true
                    }, onFailure:{(err: Error) in
                        success.pointee = false
                        error.pointee = err
                    })
                }
                
                // iOS 14 is opt-in and so these requests fail.
                // We cannot configure the environment to act in a different way.
                if #available(iOS 14, *) {
                    it("should fail to execute tracking requests when the user is not opted-in in iOS 14") {
                        var success: Bool? = nil
                        var error: Error? = nil
                        test(success: &success, error: &error)
                        
                        expect(success).toEventually(beFalse(), timeout: 4)
                        expect(error).toEventually(beAnInstanceOf(NSError.self), timeout: 4)
                        expect(error!._domain).to(equal("com.velocidi.VSDKTrackingNotAllowedError"))
                    }
                } else {
                    it("should successfuly execute tracking requests") {
                        var success: Bool? = nil
                        var error: Error? = nil
                        test(success: &success, error: &error)
                        
                        expect(success).toEventually(beTrue(), timeout: 4)
                        expect(error).to(beNil())
                    }
                }
            }

            context("test match requests"){
                func  responseBuilder(url: String, expectedParams: Dictionary<String, String>) -> (URLRequest) -> (Response) {
                    return { (request: URLRequest) in
                        let requestUrl = request.url!.absoluteString
                        var hasAllParams = true
                        expectedParams.forEach { (key, value) in
                            if(!requestUrl.contains("\(key)=\(value)")){
                                hasAllParams = false
                            }
                        }

                        if(requestUrl.starts(with: url)
                            && request.allHTTPHeaderFields?["User-Agent"] != nil
                            && hasAllParams
                            ){
                            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                            return .success(response, .noContent)
                        }
                        return .failure(NSError(domain: trackURL, code: 400))
                    }
                }
                
                func test(success: UnsafeMutablePointer<Bool?>, error: UnsafeMutablePointer<Error?>) {
                    let userId1 = VSDKUserId(userId: "bar", "foo")
                    let userId2 = VSDKUserId(userId: "y", "x")

                    let arrUserIds = NSMutableArray(array: [userId1,userId2])
                    
                    var expectedParams = Dictionary<String, String>()
                    expectedParams["cookies"] = "false"
                    for case let userId as VSDKUserId in arrUserIds {
                        expectedParams["id_\(userId.type)"] = userId.userId
                    }

                    self.stub({(request: URLRequest) in
                        return request.url!.absoluteString.starts(with: matchURL)
                    }, responseBuilder(url:matchURL, expectedParams: expectedParams))
                    
                    let config = VSDKConfig(trackingBaseUrl: trackURL, matchURL)
                    VSDKVelocidi.start(config!)
                    
                    VSDKVelocidi.sharedInstance().match("baz", userIds: arrUserIds, onSuccess:{ (response: URLResponse, responseObject: Any) in
                        success.pointee = true
                    }, onFailure:{(err: Error) in
                        success.pointee = false
                        error.pointee = err
                    })
                }
                
                
                // iOS 14 is opt-in and so these requests fail.
                // We cannot configure the environment to act in a different way.
                if #available(iOS 14, *) {
                    it("should fail to execute match requests when the user is not opted-in in iOS 14") {
                        var success: Bool? = nil
                        var error: Error? = nil
                        test(success: &success, error: &error)
                        
                        
                        expect(success).toEventually(beFalse(), timeout: 4)
                        expect(error).toEventually(beAnInstanceOf(NSError.self), timeout: 4)
                        expect(error!._domain).to(equal("com.velocidi.VSDKTrackingNotAllowedError"))
                    }
                } else {
                    it("should successfuly execute match requests") {
                        var success: Bool? = nil
                        var error: Error? = nil
                        test(success: &success, error: &error)
                        
                        expect(success).toEventually(beTrue(), timeout: 4)
                        expect(error).to(beNil())
                    }
                }
            }
        }
    }
}
