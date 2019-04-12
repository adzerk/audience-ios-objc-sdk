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
    NSString *expectedResult = [NSString
                                stringWithFormat:@"(null)/(null) VelocidiSDK/%@ (%@; %@ %@; Scale/%0.2f)",
                                @(VelocidiSDKVersionNumber),
                                [d model],
                                [d systemName],
                                [d systemVersion],
                                [[UIScreen mainScreen] scale]
                                ];
    bool result = [VSDKRequest.versionedUserAgent isEqualToString:expectedResult];
    XCTAssert(result, @"%@ != %@", expectedResult, VSDKRequest.versionedUserAgent);
}

- (void)testTrackingRequest {
    VSDKTrackingEvent * trackingEvent = [[VSDKPageView alloc] init];
    trackingEvent.clientId = @"0";
    trackingEvent.siteId = @"1";

    VSDKRequest * request = [[VSDKRequest alloc] init];

    request.data = trackingEvent;
    request.url = [NSURL URLWithString:@"http://localhost:8080"];

    [request performRequest];

    [NSThread sleepForTimeInterval:5.0f];
}

@end
