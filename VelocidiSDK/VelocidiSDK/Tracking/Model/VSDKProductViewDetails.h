#import "VSDKTrackingEvent.h"
@class VSDKProduct;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProductViewDetails : VSDKTrackingEvent

/**
  List of products associated with this product view details
 */
@property NSMutableArray<VSDKProduct *> *products;

@end

NS_ASSUME_NONNULL_END
