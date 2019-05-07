@import JSONModel;

@interface VSDKCustomization : JSONModel

/**
  Product customization name
 */
@property NSString *name;

/**
  Custom property to add extra information about the customization
 */
@property NSString *value;

/**
  Customization price
 */
@property float price;

/**
  Customization currency
 */
@property NSString *currency;

@end
