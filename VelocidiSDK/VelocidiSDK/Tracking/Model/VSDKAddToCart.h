#import "VSDKTrackingEvent.h"

@class VSDKProduct;

@interface VSDKAddToCart : VSDKTrackingEvent

/**
  Products added to the cart
 */
@property NSMutableArray<VSDKProduct *> *products;

@end
