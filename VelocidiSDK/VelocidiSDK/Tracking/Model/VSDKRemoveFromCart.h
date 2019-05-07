#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKRemoveFromCart : VSDKTrackingEvent

/**
  Product removed form the cart
 */
@property NSMutableArray<VSDKProduct *> *product;

@end
