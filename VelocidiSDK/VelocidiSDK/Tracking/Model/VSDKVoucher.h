@import JSONModel;

/**
  Model class that represents a Voucher.
 */
@interface VSDKVoucher : JSONModel

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
