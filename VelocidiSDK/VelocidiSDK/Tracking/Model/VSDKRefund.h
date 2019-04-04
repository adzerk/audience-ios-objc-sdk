//
//  VSDKRefund.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import "VSDKTrackingEvent.h"
#import "VSDKTransaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSDKRefund : VSDKTrackingEvent

@property NSString *refundType;
@property NSMutableArray *products;
@property VSDKTransaction *transaction;

@end

NS_ASSUME_NONNULL_END
