@import JSONModel;
@class VSDKVoucher;

/**
  Model class that represents a transaction.
 */
@interface VSDKTransaction : JSONModel

/**
  Transaction identifier 
 */
@property (nonnull) NSString *transactionId;

/**
  Transaction total price (after taxes and shipping)
 */
@property float price;

/**
  Transaction currency
 */
@property (nullable) NSString *currency;

/**
  Transaction tax
 */
@property float tax;

/**
  Transaciton shipping cost
 */
@property float shipping;

/**
  Voucher used in this transaction 
 */
@property (nullable) VSDKVoucher *voucher;

/**
  Payment type (e.g. credit card, debit card, Paypal)
 */
@property (nullable) NSString *paymentMethod;

/**
  Additional information about the payment
 */
@property (nullable) NSString *paymentDetails;

@end
