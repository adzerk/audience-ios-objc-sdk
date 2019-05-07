#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKPurchase : VSDKTrackingEvent

/**
  Products purchased
 */
@property NSMutableArray<VSDKProduct *> *product;

@end
