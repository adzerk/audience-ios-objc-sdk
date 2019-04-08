#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProduct : NSObject

/**
  Product identifier (REQUIRED)
 */
@property NSString *productId;

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
  Product variante (e.g. color, size)
 */
@property NSString *variant;

/**
  Product parts or subproduct, when the product is an aggregation.
  Should contain instances of VSDKProduct.
 */
@property NSMutableArray *parts;

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
  Product position in the location (relevante when shown in a list)
 */
@property NSString *position;

/**
  Whether or not the product was suggested by a recommendation.
 */
@property NSString *recomendation;

/**
  Whether or not the product is unsafe (e.g. adult content)
 */
@property NSString *unsafe;

@end

NS_ASSUME_NONNULL_END
