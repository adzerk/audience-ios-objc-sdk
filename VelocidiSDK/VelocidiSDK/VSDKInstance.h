//
//  VSDKInstance.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 03/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct Config{
    NSString *trackingHost;
    NSString *matchHost;
} CDPConfig ;

@interface VSDKInstance : NSObject

@property this instance;
@property config;

-
- (VSDKInstance) getInstance;

@end

NS_ASSUME_NONNULL_END
