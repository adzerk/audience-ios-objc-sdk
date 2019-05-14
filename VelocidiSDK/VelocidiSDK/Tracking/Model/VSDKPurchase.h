#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKPurchase : VSDKTrackingEvent

/**
  Products purchased
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
