//
//  VSDKProductCustomization.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import "VSDKTrackingEvent.h"
@class VSDKProduct;
@class VSDKCustomization;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProductCustomization : VSDKTrackingEvent

@property VSDKProduct *product;
@property VSDKCustomization *productCustomization;

@end

NS_ASSUME_NONNULL_END
