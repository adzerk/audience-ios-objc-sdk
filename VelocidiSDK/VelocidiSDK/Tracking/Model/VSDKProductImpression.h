#import "VSDKTrackingEvent.h"
@class VSDKProduct;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProductImpression : VSDKTrackingEvent

/**
  List of products associated with this Product Impression
 */
@property NSMutableArray<VSDKProduct *> *products;

@end

NS_ASSUME_NONNULL_END
