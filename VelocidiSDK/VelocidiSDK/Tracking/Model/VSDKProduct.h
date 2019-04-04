//
//  VSDKProduct.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProduct : NSObject

@property NSString *productId; //Required
@property NSString *name;
@property NSString *brand;
@property NSString *category;
@property NSString *variant;
@property NSMutableArray *parts;
@property float price;
@property NSString *currency;
@property NSString *location;
@property NSString *position;
@property NSString *recomendation;
@property NSString *unsafe;

@end

NS_ASSUME_NONNULL_END
