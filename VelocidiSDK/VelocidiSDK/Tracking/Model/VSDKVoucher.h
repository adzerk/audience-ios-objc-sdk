//
//  VSDKTransaction.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKVoucher : NSObject

@property NSString *voucherId;
@property float percentage;
@property float value;

@end

NS_ASSUME_NONNULL_END
