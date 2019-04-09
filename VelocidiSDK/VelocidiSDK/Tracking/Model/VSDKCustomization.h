@import JSONModel;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKCustomization : JSONModel

/**
  Product customization name
 */
@property NSString *name;

/**
  Product customization
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

NS_ASSUME_NONNULL_END
