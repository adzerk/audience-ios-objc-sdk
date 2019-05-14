#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKRemoveFromCart : VSDKTrackingEvent

/**
  Products removed from the cart
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
