#import "VSDKTrackingEvent.h"
@class VSDKProduct;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProductClick : VSDKTrackingEvent

/**
  Product associated with this product click
 */
@property VSDKProduct *product;

@end

NS_ASSUME_NONNULL_END
