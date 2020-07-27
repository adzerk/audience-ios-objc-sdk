@import JSONModel;
@class VSDKDiscount;

@interface VSDKLineItem : JSONModel

/**
  Line item identifier 
 */
@property (nonnull) NSString *id;

/**
  The product SKU. Can be the same as the identifier
 */
@property (nullable) NSString *sku;

/**
  An identifier for the product group
 */
@property (nullable) NSString *itemGroupId;

/**
  If the purchase relates to a subscription, this attribute captures the subscription duration, in days (Optional)
 */
@property int subscritpionDuration;

/**
  Product name
 */
@property (nullable) NSString *name;

/**
  Product brand
 */
@property (nullable) NSString *brand;

/**
  Category for the product
 */
@property (nullable) NSString *category;

/**
  Whether or not the product is unsafe (e.g. adult content)
 */
@property bool unsafe;

/**
  Quantity of the product 
  Default is 1
 */
@property int quantity;

/**
  Transaction currency
 */
@property (nonnull) NSString *currency;

/**
  Order total price (after taxes and shipping)
 */
@property float total;

/**
  Subtotal order price
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

@property (nonnull) NSMutableArray<NSString *> *promotions;

@end
