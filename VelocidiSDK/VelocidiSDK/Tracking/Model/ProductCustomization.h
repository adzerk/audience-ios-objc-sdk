//
//  ProductCustomization.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import "TrackingEvent.h"
#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    NSString *name;
    NSString *value;
    float price;
    NSString *currency;
} Customization;

@interface ProductCustomization : TrackingEvent

@property Product *product;
@property Customization productCustomization;

@end

NS_ASSUME_NONNULL_END
