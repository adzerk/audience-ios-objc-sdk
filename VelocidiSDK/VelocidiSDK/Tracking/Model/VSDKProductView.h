#import "VSDKTrackingEvent.h"
@class VSDKProduct;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProductView : VSDKTrackingEvent

/**
  Product associated with this product view
 */
@property VSDKProduct *product;

@end

NS_ASSUME_NONNULL_END
