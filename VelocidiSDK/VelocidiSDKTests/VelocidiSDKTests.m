//
//  VelocidiSDKTests.m
//  VelocidiSDKTests
//
//  Created by Duarte Pinto on 2019-03-26.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HelloWorld.h"

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
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSLog(@"%@", [[HelloWorld alloc] init].hello);
    }];
}

@end
