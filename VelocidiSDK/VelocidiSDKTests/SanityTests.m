#import <XCTest/XCTest.h>
@import VelocidiSDK;
#import "VSDKUserId.h"

@interface SanityTests : XCTestCase
@end

@implementation SanityTests

// FIXME This test has an 'A' after 'test' because xcode runs the tests in
// alphabetical order Disabled until it is not depending on test order
//- (void)testAVelocidiInstanceFail {
//    XCTAssertThrowsSpecificNamed(
//                                 VSDKVelocidi.sharedInstance,
//                                 NSException,
//                                 NSInternalInconsistencyException
//                                 );
//
//}

- (void)testVelocidiInstanceSuccess {
  VSDKConfig *config = [[VSDKConfig alloc]
      initWithTrackingBaseUrl:@"https://tr.testdomain.com:8080"
                 matchBaseUrl:@"https://match.testdomain.com:8080"];
  [VSDKVelocidi start:config];
  XCTAssert(VSDKVelocidi.sharedInstance);
}

- (void)testCreateConfigFromDomain {
  VSDKConfig *config =
      [[VSDKConfig alloc] initWithDomain:@"https://domain.com"];

  XCTAssert([@"https://tr.domain.com/events"
      isEqualToString:config.trackingUrl.string]);
  XCTAssert([@"https://match.domain.com/match"
      isEqualToString:config.matchUrl.string]);
}

- (void)testCreateConfigFromBaseURLAndKeepPath {
  VSDKConfig *config = [[VSDKConfig alloc]
      initWithTrackingBaseUrl:@"https://tr.domain.com/v1"
                 matchBaseUrl:@"https://match.domain.com/v1"];

  XCTAssert([@"https://tr.domain.com/v1/events"
      isEqualToString:config.trackingUrl.string]);
  XCTAssert([@"https://match.domain.com/v1/match"
      isEqualToString:config.matchUrl.string]);
}

@end
