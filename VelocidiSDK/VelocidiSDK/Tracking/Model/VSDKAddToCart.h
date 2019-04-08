#import "VSDKTrackingEvent.h"

@class VSDKProduct;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKAddToCart : VSDKTrackingEvent

/**
  Product added to the cart
 */
@property VSDKProduct *product;

@end

NS_ASSUME_NONNULL_END
