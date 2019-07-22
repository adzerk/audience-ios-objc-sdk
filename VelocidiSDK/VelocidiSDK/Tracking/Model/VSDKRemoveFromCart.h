#import "VSDKTrackingEvent.h"
@class VSDKProduct;

/**
  Tracking event model class that represents a `RemoveFromCart` event
 */
@interface VSDKRemoveFromCart : VSDKTrackingEvent

/**
  Products removed from the cart
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
