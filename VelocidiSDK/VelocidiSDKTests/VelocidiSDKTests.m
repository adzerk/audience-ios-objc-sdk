//
//  VelocidiSDKTests.m
//  VelocidiSDKTests
//
//  Created by Duarte Pinto on 2019-03-26.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import <XCTest/XCTest.h>
@import VelocidiSDK
//#import <VelocidiSDK/VelodiciSDK.h>
//#import "VSDKPageView.h"
//#import "VSDKSearch.h"

@interface VelocidiSDKTests : XCTestCase

@end

@implementation VelocidiSDKTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSLog(@"This is the event type: %@", VSDKPageView.type);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSLog(@"This is the event type: %@", VSDKSearch.type);
    }];
}

@end
