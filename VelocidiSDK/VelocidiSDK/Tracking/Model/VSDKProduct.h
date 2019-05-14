@import JSONModel;

@interface VSDKProduct : JSONModel

/**
  Product identifier 
 */
@property (nonnull) NSString *productId;

/**
  Product name
 */
@property NSString *name;

/**
  Product brand
 */
@property NSString *brand;

/**
  Product category
 */
@property NSString *category;

/**
  Product variant (e.g. color, size)
 */
@property NSString *variant;

/**
  Product parts or subproduct, when the product is an aggregation.
  Should contain instances of VSDKProduct.
 */
@property NSMutableArray<VSDKProduct *> *parts;

/**
  Product price
 */
@property float price;

/**
  Product currency
 */
@property NSString *currency;

/**
  Location in the app where the product was seen (e.g. search results, favorites, related products)
 */
@property NSString *location;

/**
  Product position in the location (relevant when shown in a list)
 */
@property NSString *position;

/**
  Quantity of the product 
  Default is 1
 */
@property int quantity;

/**
  Whether or not the product was suggested by a recommendation.
 */
@property bool *recomendation;

/**
  Whether or not the product is unsafe (e.g. adult content)
 */
@property bool *unsafe;

@end
