#import "VSDKTrackingEvent.h"
@class VSDKProduct;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProductViewDetails : VSDKTrackingEvent

/**
  Product associated with this product view details
 */
@property VSDKProduct *product;

@end

NS_ASSUME_NONNULL_END
