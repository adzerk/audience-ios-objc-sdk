@import JSONModel;

/**
  Model class that represents a customization.
 */
@interface VSDKCustomization : JSONModel

/**
  Product customization name
 */
@property (nullable) NSString *name;

/**
  Custom property to add extra information about the customization
 */
@property (nullable) NSString *value;

/**
  Customization price
 */
@property float price;

/**
  Customization currency
 */
@property (nullable) NSString *currency;

@end
