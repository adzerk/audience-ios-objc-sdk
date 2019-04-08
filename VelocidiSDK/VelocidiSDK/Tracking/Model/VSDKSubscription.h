//
//  VSDKSubscription.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import "VSDKTrackingEvent.h"
@class VSDKTransaction;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKSubscription : VSDKTrackingEvent

@property NSMutableArray *products;
@property VSDKTransaction *transaction;

@end

NS_ASSUME_NONNULL_END
