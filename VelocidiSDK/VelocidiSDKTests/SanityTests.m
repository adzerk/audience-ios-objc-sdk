#import <XCTest/XCTest.h>
@import VelocidiSDK;
#import "VSDKUserId.h"


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

// FIXME This test has an 'A' after 'test' because xcode runs the tests in alphabetical order
// Disabled until it is not depending on test order
//- (void)testAVelocidiInstanceFail {
//    XCTAssertThrowsSpecificNamed(
//                                 VSDKVelocidi.sharedInstance,
//                                 NSException,
//                                 NSInternalInconsistencyException
//                                 );
//
//}

- (void)testVelocidiInstanceSuccess {
    VSDKConfig * config = [[VSDKConfig alloc]
                           initWithTrackingBaseUrl:@"https://tr.testdomain.com:8080":@"https://match.testdomain.com:8080"];
    [VSDKVelocidi start:config];
    XCTAssert(VSDKVelocidi.sharedInstance);
}

- (void)testTrackingEventDefaultIds {
    [VSDKTrackingEvent setDefaultIds:@"foo" :@"bar"];
    VSDKPageView * pageView = [[VSDKPageView alloc] initWithDefaultIds];
    pageView.title = @"fooPage";
    pageView.pageType = @"homepage";
    XCTAssert([@"{\"siteId\":\"bar\",\"pageType\":\"homepage\",\"title\":\"fooPage\",\"clientId\":\"foo\",\"type\":\"pageView\"}"
               isEqualToString:[pageView toJSONString]]
              );
}

- (void)testCreateConfigFromDomain {
    VSDKConfig * config = [[VSDKConfig alloc] initWithDomain:@"https://domain.com"];
    
    XCTAssert([@"https://tr.domain.com/events" isEqualToString: config.trackingUrl.string]);
    XCTAssert([@"https://match.domain.com/match" isEqualToString: config.matchUrl.string]);
}

- (void)testCreateConfigFromBaseURLAndKeepPath {
    VSDKConfig * config = [[VSDKConfig alloc] initWithTrackingBaseUrl
                           : @"https://tr.domain.com/v1"
                           : @"https://match.domain.com/v1"];

    XCTAssert([@"https://tr.domain.com/v1/events" isEqualToString: config.trackingUrl.string]);
    XCTAssert([@"https://match.domain.com/v1/match" isEqualToString: config.matchUrl.string]);
}

@end
