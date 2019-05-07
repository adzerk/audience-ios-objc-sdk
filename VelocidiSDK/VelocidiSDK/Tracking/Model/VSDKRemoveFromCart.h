#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKRemoveFromCart : VSDKTrackingEvent

/**
  Products removed from the cart
 */
@property NSMutableArray<VSDKProduct *> *product;

@end
