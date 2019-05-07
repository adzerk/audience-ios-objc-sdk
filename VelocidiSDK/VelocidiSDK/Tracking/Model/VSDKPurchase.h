#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKPurchase : VSDKTrackingEvent

/**
  Product purchased
 */
@property NSMutableArray<VSDKProduct *> *product;

@end
