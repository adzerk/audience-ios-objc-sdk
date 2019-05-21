import UIKit
import Foundation
import Quick
import Nimble
import VelocidiSDK

class UtilTests: QuickSpec {
    override func spec() {
        super.spec()
        describe("VSDKUtil") {
            it("should generate a valid User-Agent containing information about VelocidiSDK") {
                let userAgent = VSDKUtil().getVersionedUserAgent()
                let regexStr = String(format:".*/.* VelocidiSDK\\/%0.0f \\(%@; %@ %@; Scale\\/%0.2f\\)",
                    VelocidiSDKVersionNumber,
                    UIDevice.current.model,
                    UIDevice.current.systemName,
                    UIDevice.current.systemVersion,
                    UIScreen.main.scale)

                expect(userAgent).to(match(regexStr))
            }
        }
    }
}
