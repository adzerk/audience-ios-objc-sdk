#import "VSDKTrackingEvent.h"

@class VSDKProduct;

/**
  Tracking event model class that represents an `AddToCart` event
 */
@interface VSDKAddToCart : VSDKTrackingEvent

/**
  Products added to the cart
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
