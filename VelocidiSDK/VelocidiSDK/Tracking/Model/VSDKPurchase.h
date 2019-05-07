#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKPurchase : VSDKTrackingEvent

/**
  Products purchased
 */
@property NSMutableArray<VSDKProduct *> *products;

@end
