#import "VSDKTrackingEvent.h"
@class VSDKProduct;

/**
  Tracking event model class that represents a `Purchase` event
 */
@interface VSDKPurchase : VSDKTrackingEvent

/**
  Products purchased
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
