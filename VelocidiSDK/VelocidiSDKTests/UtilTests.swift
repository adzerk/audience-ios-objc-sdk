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
                let regexStr = String(format:".*/.* VelocidiSDK\\/%@ \\(%@; %@ %@; Scale\\/%0.2f\\)",
                    Bundle(identifier: "com.velocidi.VelocidiSDK")?.infoDictionary!["CFBundleShortVersionString"] as! String,
                    UIDevice.current.model,
                    UIDevice.current.systemName,
                    UIDevice.current.systemVersion,
                    UIScreen.main.scale)

                expect(userAgent).to(match(regexStr))
            }
            
            if #available(iOS 14, *) { // ios14 is opt-in
                it("should throw an error when trying to get the IDFA on iOS 14+") {
                    // this style is necessary because of https://github.com/Quick/Nimble/issues/809
                    expect(expression: { try VSDKUtil.tryGetIDFA() }).to(throwError { (error: Error) in
                        expect(error._domain).to(equal("com.velocidi.VSDKTrackingNotAllowedError"))
                    })
                }
            } else { // previous ios version are opt-out
                it("should successfuly provide the IDFA") {
                    expect(try? VSDKUtil.tryGetIDFA()).to(contain("00000000-0000-0000-0000-000000000000"))
                }
            }
            
        }
    }
}
