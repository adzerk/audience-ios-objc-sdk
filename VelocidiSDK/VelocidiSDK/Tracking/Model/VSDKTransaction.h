//
//  VSDKTransaction.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    NSString *voucherId;
    float percentage;
    float value;
} Voucher;

@interface VSDKTransaction : NSObject

@property NSString *transactionId;
@property float price;
@property NSString *recurrence;
@property NSString *currency;
@property float tax;
@property float shipping;
@property Voucher voucher;
@property NSString *paymentMethod;
@property NSString *paymentDetails;

@end

NS_ASSUME_NONNULL_END
