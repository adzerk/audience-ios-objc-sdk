@import JSONModel;
@class VSDKDiscount;

@interface VSDKOrder : JSONModel

/**
  Order identifier 
 */
@property (nonnull) NSString *id;

/**
  Transaction currency
 */
@property (nonnull) NSString *currency;

/**
  Order total price (after taxes and shipping)
 */
@property float total;

/**
  Subtotal product price
 */
@property float subtotal;

/**
  Applied tax
 */
@property float tax;

/**
  Order shipping cost
 */
@property float shipping;

/**
  Applied discount
 */
@property (nullable) VSDKDiscount *discount;

/**
  Applied refund
 */
@property float refund;

/**
  Payment type (e.g. credit card, debit card, Paypal)
 */
@property (nullable) NSString *paymentMethod;

/**
  The shipping method
 */
@property (nullable) NSString *shippingMethod;

/**
  The destination country
 */
@property (nullable) NSString *shippingCountry;

/**
  Vouchers applied in the purchase
 */
@property (nullable) NSMutableArray<NSString *> *promotions;

@end
