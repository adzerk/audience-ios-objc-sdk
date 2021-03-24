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
                let userAgent = VSDKUtil.getVersionedUserAgent()
                let regexStr = String(format: ".*/.* VelocidiSDK\\/%@ \\(%@; %@ %@; Scale\\/%0.2f\\)",
                    Bundle(identifier: "com.velocidi.VelocidiSDK")?
                        .infoDictionary!["CFBundleShortVersionString"] as! String, // swiftlint:disable:this force_cast
                    UIDevice.current.model,
                    UIDevice.current.systemName,
                    UIDevice.current.systemVersion,
                    UIScreen.main.scale)

                expect(userAgent).to(match(regexStr))
            }
        }
    }
}
