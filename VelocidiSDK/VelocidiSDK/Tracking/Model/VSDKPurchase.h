#import "VSDKTrackingEvent.h"
@class VSDKProduct;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKPurchase : VSDKTrackingEvent

/**
  Product purchased
 */
@property NSMutableArray<VSDKProduct *> *product;

@end

NS_ASSUME_NONNULL_END
