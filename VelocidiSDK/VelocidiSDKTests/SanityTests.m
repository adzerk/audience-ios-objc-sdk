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

// FIXME This test has an 'A' in the beginning because xcode runs the tests in alphabetical order
- (void)AtestVelocidiInstanceFail {
    XCTAssertThrowsSpecificNamed(
                                 VSDKVelocidi.sharedInstance,
                                 NSException,
                                 NSInternalInconsistencyException
                                 );

}

- (void)testVelocidiInstanceSuccess {
    VSDKConfig * config = [[VSDKConfig alloc]
                           initWithHosts:@"https://tr.testdomain.com:8080":@"https://match.testdomain.com:8080"];
    [VSDKVelocidi start:config];
    XCTAssert(VSDKVelocidi.sharedInstance);
}

@end
