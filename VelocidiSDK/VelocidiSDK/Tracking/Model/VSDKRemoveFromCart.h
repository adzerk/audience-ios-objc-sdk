#import "VSDKTrackingEvent.h"
@class VSDKProduct;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKRemoveFromCart : VSDKTrackingEvent

/**
  Product removed form the cart
 */
@property VSDKProduct *product;

@end

NS_ASSUME_NONNULL_END
