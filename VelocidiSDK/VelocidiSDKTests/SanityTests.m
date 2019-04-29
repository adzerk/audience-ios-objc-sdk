#import <XCTest/XCTest.h>
<<<<<<< HEAD
#import <VelocidiSDK/VelocidiSDK.h>
=======
#import "VelocidiSDK.h"
>>>>>>> Make track requests

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
                           initWithTrackingHost:@"https://tr.testdomain.com:8080":@"https://match.testdomain.com:8080"];
    [VSDKVelocidi start:config];
    XCTAssert(VSDKVelocidi.sharedInstance);
}

<<<<<<< HEAD
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
    
    XCTAssert([@"https://tr.domain.com" isEqualToString:[[config trackingHost] absoluteString]]);
    XCTAssert([@"https://match.domain.com" isEqualToString:[[config matchHost] absoluteString]]);
}

- (void)testMatchRequest {
    VSDKUserId * userId1 = [[VSDKUserId alloc] init];
    userId1.type = @"foo";
    userId1.userId = @"bar";
    
    VSDKUserId * userId2 = [[VSDKUserId alloc] init];
    userId2.type = @"x";
    userId2.userId = @"y";
    
    NSMutableArray<VSDKUserId *> * uidArray = [[NSMutableArray alloc] init];
    [uidArray addObject:userId1];
    [uidArray addObject:userId2];

    VSDKConfig * config = [[VSDKConfig alloc] initWithTrackingHost:@"http://localhost:8080":@"http://localhost:8080"];
    [[VSDKVelocidi start:config] match:@"baz"
                               userIds:uidArray
                             onSuccess:^(NSURLResponse * response, id responseObject) {
                                 NSLog(@"Success %@", response);
                             }
                             onFailure:^(NSError * error){
                                 NSLog(@"Error %@", error.localizedDescription);
                             }];
    [NSThread sleepForTimeInterval:5.0f];
}

@end
