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

- (void)testUserAgentStr {
    UIDevice *d = [UIDevice currentDevice];
    NSString *expectedResult = [NSString
                                stringWithFormat:@"(null)/(null) VelocidiSDK/%@ (%@; %@ %@; Scale/%0.2f)",
                                @(VelocidiSDKVersionNumber),
                                [d model],
                                [d systemName],
                                [d systemVersion],
                                [[UIScreen mainScreen] scale]
                                ];
    bool result = [VSDKUtil.getVersionedUserAgent isEqualToString:expectedResult];
    XCTAssert(result, @"%@ != %@", expectedResult, VSDKUtil.getVersionedUserAgent);
}

- (void)testTrackingRequest {
    VSDKTrackingEvent * trackingEvent = [[VSDKPageView alloc] init];
    trackingEvent.clientId = @"0";
    trackingEvent.siteId = @"1";

    VSDKConfig * config = [[VSDKConfig alloc] initWithHosts:@"https://localhost:8080":@"https://localhost:8080"];
    [VSDKVelocidi start:config];

//    [[VSDKVelocidi sharedInstance] track:trackingEvent];

    [NSThread sleepForTimeInterval:5.0f];
}

@end
