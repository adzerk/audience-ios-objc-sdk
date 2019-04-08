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
