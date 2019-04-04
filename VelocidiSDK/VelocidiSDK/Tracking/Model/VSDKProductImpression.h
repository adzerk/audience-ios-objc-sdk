//
//  VSDKProductImpression.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import "VSDKTrackingEvent.h"
#import "VSDKProduct.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProductImpression : VSDKTrackingEvent

@property NSMutableArray *products;

@end

NS_ASSUME_NONNULL_END
