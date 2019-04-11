#import <XCTest/XCTest.h>
@import VelocidiSDK;

@interface SanityTests : XCTestCase
@end

@implementation SanityTests

- (void)testJsonModel {

    VSDKTrackingEvent * trackingEvent = [[VSDKPageView alloc] init];
    trackingEvent.clientId = @"0";
    trackingEvent.siteId = @"1";
    XCTAssert([@"{\"siteId\":\"1\",\"clientId\":\"0\",\"type\":\"pageView\"}"
            isEqualToString:[trackingEvent toJSONString]]
            );
}

- (void)testVelocidiInstanceFail {
    XCTAssertThrowsSpecificNamed(
                                 VSDKVelocidi.sharedInstance,
                                 NSException,
                                 NSInternalInconsistencyException
                                 );

}

- (void)testVelocidiInstanceSuccess {
    VSDKConfig * config = [[VSDKConfig alloc] init];
    [VSDKVelocidi start:config];
    XCTAssert(VSDKVelocidi.sharedInstance);
}

- (void)testUserAgentStr {
    UIDevice *d = [UIDevice currentDevice];
    bool result = [VSDKRequest.versionedUserAgent
            isEqualToString:[NSString
                    stringWithFormat:@"(null)/(null) VelocidiSDK/%f (%@/%@; %@)",
                    VelocidiSDKVersionNumber,
                    [d systemName],
                    [d systemVersion],
                    [d model]]];
    XCTAssert(result);
}

@end
