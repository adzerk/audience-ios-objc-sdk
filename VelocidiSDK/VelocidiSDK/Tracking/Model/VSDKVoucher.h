#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKVoucher : NSObject

/**
  Identifier of the VOUCHER used
 */
@property NSString *voucherId;

/**
  Transaction voucher percentage
 */
@property float percentage;

/**
  Transaction voucher absolute discount
 */
@property float value;

@end

NS_ASSUME_NONNULL_END
