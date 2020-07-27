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
@property (nonnull) NSString *paymentMethod;

@property (nonnull) NSString *shippingMethod;

@property (nonnull) NSString *shippingCountry;

@property (nonnull) NSMutableArray<NSString *> *promotions;

@end
