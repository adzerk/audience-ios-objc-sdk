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
    override func spec() { // swiftlint:disable:this function_body_length
        super.spec()
        describe("VelocidiSDK") {
            let trackURL = "http://tr.testdomain.com"
            let matchURL = "http://match.testdomain.com"

            context("test track request") {
                it("should fail when the userId is not valid") {
                    let userId = VSDKUserId(
                        id: "1c3eae0a556ed83200d7962f72f19961a609e9e59a3551701690f43a13263dc3",
                        type: "")
                    let trackingEvent = VSDKPageView()
                    trackingEvent.siteId = "0"
                    trackingEvent.clientId = "0"
                    let config = VSDKConfig(trackingBaseUrl: trackURL, matchURL)
                    VSDKVelocidi.start(config!)

                    var error: Error?
                    VSDKVelocidi.sharedInstance().track(
                        trackingEvent,
                        userId: userId,
                        onSuccess: { (_: URLResponse, _: Any) in },
                        onFailure: {(err: Error) in
                            error = err
                        })
                    expect(error).notTo(beNil())
                    expect(error?.localizedDescription).to(match("InvalidArgument"))
                }

                it("should successfuly execute tracking requests") {
                    var responded = false
                    self.stub({(request: URLRequest) in
                        return request.url!.absoluteString.starts(with: trackURL)
                    }, { (request: URLRequest) in
                        responded = true
                        let res = HTTPURLResponse(
                            url: request.url!,
                            statusCode: 200,
                            httpVersion: nil,
                            headerFields: nil)!
                        return .success(res, .noContent)
                    })

                    let trackingEvent = VSDKPageView()
                    trackingEvent.siteId = "0"
                    trackingEvent.clientId = "0"
                    let userId = VSDKUserId(
                        id: "1c3eae0a556ed83200d7962f72f19961a609e9e59a3551701690f43a13263dc3",
                        type: "email_sha256")
                    let config = VSDKConfig(trackingBaseUrl: trackURL, matchURL)
                    VSDKVelocidi.start(config!)
                    VSDKVelocidi.sharedInstance().track(trackingEvent, userId: userId)

                    expect(responded).toEventually(beTrue(), timeout: 4)
                }

                it("should successfuly execute tracking requests using success and error handlers") {
                    func responseBuilder(url: String, expectedData: Data) -> (URLRequest) -> (Response) {
                        return { (request: URLRequest) in
                            if request.url!.absoluteString.starts(with: url)
                                && request.allHTTPHeaderFields?["Content-Type"] == "application/json"
                                && request.allHTTPHeaderFields?["User-Agent"] != nil
                                && request.httpBodyStream != nil {

                                let receivedData = Data(reading: request.httpBodyStream!)
                                if receivedData == expectedData {
                                    let response = HTTPURLResponse(
                                        url: request.url!,
                                        statusCode: 200,
                                        httpVersion: nil,
                                        headerFields: nil)!
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
                        }, responseBuilder(url: trackURL, expectedData: trackingEvent.toJSONData()))

                        let config = VSDKConfig(trackingBaseUrl: trackURL, matchURL)
                        VSDKVelocidi.start(config!)

                        let userId = VSDKUserId(
                            id: "1c3eae0a556ed83200d7962f72f19961a609e9e59a3551701690f43a13263dc3",
                            type: "email_sha256")
                        VSDKVelocidi
                            .sharedInstance()
                            .track(trackingEvent, userId: userId, onSuccess: { (_: URLResponse, _: Any) in
                            success.pointee = true
                        }, onFailure: {(err: Error) in
                            success.pointee = false
                            error.pointee = err
                        })
                    }

                    var success: Bool?
                    var error: Error?
                    test(success: &success, error: &error)

                    expect(success).toEventually(beTrue(), timeout: 4)
                    expect(error).to(beNil())
                }
            }

            context("test match requests") {
                it("should fail when provider is empty") {
                    let userId1 = VSDKUserId(
                        id: "1c3eae0a556ed83200d7962f72f19961a609e9e59a3551701690f43a13263dc3",
                        type: "email_sha256")
                    let userId2 = VSDKUserId(
                        id: "2c3eae0a556ed83200d7962f72f19961a609e9e59a3551701690f43a13263dc3",
                        type: "email_sha256")
                    let arrUserIds = NSMutableArray(array: [userId1, userId2])

                    var error: Error?
                    let config = VSDKConfig(trackingBaseUrl: trackURL, matchURL)
                    VSDKVelocidi.start(config!)
                    VSDKVelocidi
                        .sharedInstance()
                        .match("", userIds: arrUserIds,
                               onSuccess: { (_: URLResponse, _: Any) in },
                               onFailure: {(err: Error) in
                                error = err
                        })

                    expect(error).notTo(beNil())
                    expect(error?.localizedDescription).to(match("InvalidArgument"))
                }

                it("should fail when there are not enough user ids") {
                    let userId1 = VSDKUserId(
                        id: "1c3eae0a556ed83200d7962f72f19961a609e9e59a3551701690f43a13263dc3",
                        type: "email_sha256")
                    let arrUserIds = NSMutableArray(array: [userId1])

                    var error: Error?
                    let config = VSDKConfig(trackingBaseUrl: trackURL, matchURL)
                    VSDKVelocidi.start(config!)
                    VSDKVelocidi
                        .sharedInstance()
                        .match("baz", userIds: arrUserIds,
                               onSuccess: { (_: URLResponse, _: Any) in },
                               onFailure: {(err: Error) in
                                error = err
                        })

                    expect(error).notTo(beNil())
                    expect(error?.localizedDescription).to(match("InvalidArgument"))
                }

                it("should successfuly execute match requests") {
                    let userId1 = VSDKUserId(
                        id: "1c3eae0a556ed83200d7962f72f19961a609e9e59a3551701690f43a13263dc3",
                        type: "email_sha256")
                    let userId2 = VSDKUserId(
                        id: "2c3eae0a556ed83200d7962f72f19961a609e9e59a3551701690f43a13263dc3",
                        type: "email_sha256")

                    let arrUserIds = NSMutableArray(array: [userId1, userId2])

                    var responded = false
                    self.stub({(request: URLRequest) in
                        return request.url!.absoluteString.starts(with: matchURL)
                    }, { (request: URLRequest) in
                        responded = true
                        let res = HTTPURLResponse(
                            url: request.url!,
                            statusCode: 200,
                            httpVersion: nil,
                            headerFields: nil)!
                        return .success(res, .noContent)
                    })

                    VSDKVelocidi.sharedInstance().match("baz", userIds: arrUserIds)
                    expect(responded).toEventually(beTrue(), timeout: 4)
                }

                it("should successfuly execute match requests using success and error handlers") {
                    func  responseBuilder(url: String, expectedParams: [String: String]) -> (URLRequest) -> (Response) {
                        return { (request: URLRequest) in
                            let requestUrl = request.url!.absoluteString
                            var hasAllParams = true
                            expectedParams.forEach { (key, value) in
                                if !requestUrl.contains("\(key)=\(value)") {
                                    hasAllParams = false
                                }
                            }

                            if requestUrl.starts(with: url)
                                && request.allHTTPHeaderFields?["User-Agent"] != nil
                                && hasAllParams {
                                let response = HTTPURLResponse(
                                    url: request.url!,
                                    statusCode: 200,
                                    httpVersion: nil,
                                    headerFields: nil)!
                                return .success(response, .noContent)
                            }
                            return .failure(NSError(domain: trackURL, code: 400))
                        }
                    }

                    func test(success: UnsafeMutablePointer<Bool?>, error: UnsafeMutablePointer<Error?>) {
                        let userId1 = VSDKUserId(
                            id: "1c3eae0a556ed83200d7962f72f19961a609e9e59a3551701690f43a13263dc3",
                            type: "email_sha256")
                        let userId2 = VSDKUserId(
                            id: "2c3eae0a556ed83200d7962f72f19961a609e9e59a3551701690f43a13263dc3",
                            type: "email_sha256")

                        let arrUserIds = NSMutableArray(array: [userId1, userId2])

                        var expectedParams = [String: String]()
                        expectedParams["cookies"] = "false"
                        for case let userId as VSDKUserId in arrUserIds {
                            expectedParams["id_\(userId.type)"] = userId.userId
                        }

                        self.stub({(request: URLRequest) in
                            return request.url!.absoluteString.starts(with: matchURL)
                        }, responseBuilder(url: matchURL, expectedParams: expectedParams))

                        let config = VSDKConfig(trackingBaseUrl: trackURL, matchURL)
                        VSDKVelocidi.start(config!)

                        VSDKVelocidi
                            .sharedInstance()
                            .match("baz", userIds: arrUserIds, onSuccess: { (_: URLResponse, _: Any) in
                            success.pointee = true
                        }, onFailure: {(err: Error) in
                            success.pointee = false
                            error.pointee = err
                        })
                    }

                    var success: Bool?
                    var error: Error?
                    test(success: &success, error: &error)

                    expect(success).toEventually(beTrue(), timeout: 4)
                    expect(error).to(beNil())
                }
            }
        }
    }
}
