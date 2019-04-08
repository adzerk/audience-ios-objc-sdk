//
//  VSDKTransaction.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VSDKVoucher;


NS_ASSUME_NONNULL_BEGIN

@interface VSDKTransaction : NSObject

@property NSString *transactionId;
@property float price;
@property NSString *recurrence;
@property NSString *currency;
@property float tax;
@property float shipping;
@property VSDKVoucher *voucher;
@property NSString *paymentMethod;
@property NSString *paymentDetails;

@end

NS_ASSUME_NONNULL_END
