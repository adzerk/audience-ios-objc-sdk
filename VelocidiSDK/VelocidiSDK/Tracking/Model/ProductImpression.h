//
//  ProductImpression.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import "TrackingEvent.h"
#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductImpression : TrackingEvent

@property NSMutableArray *products;

@end

NS_ASSUME_NONNULL_END
