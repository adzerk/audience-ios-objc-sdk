//
//  VSDKInstance.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 03/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSDKConfig.h";

NS_ASSUME_NONNULL_BEGIN


@interface VSDKInstance : NSObject

@property VSDKInstance *instance;
@property VSDKConfig *config;

//- (void)getInstance;

@end

NS_ASSUME_NONNULL_END
