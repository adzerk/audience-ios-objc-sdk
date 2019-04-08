#import "VSDKTrackingEvent.h"
@class VSDKProduct;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProductView : VSDKTrackingEvent

/**
  Product associated with this product view
 */
@property NSMutableArray<VSDKProduct *> *products;

@end

NS_ASSUME_NONNULL_END
