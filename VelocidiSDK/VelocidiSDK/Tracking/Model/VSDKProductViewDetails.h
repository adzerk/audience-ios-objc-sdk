//
//  VSDKProductViewDetails.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import "VSDKTrackingEvent.h"
@class VSDKProduct;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProductViewDetails : VSDKTrackingEvent

@property VSDKProduct *product;

@end

NS_ASSUME_NONNULL_END
