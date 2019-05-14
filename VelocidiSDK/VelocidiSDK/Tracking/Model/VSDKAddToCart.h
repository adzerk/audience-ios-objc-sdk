#import "VSDKTrackingEvent.h"

@class VSDKProduct;

@interface VSDKAddToCart : VSDKTrackingEvent

/**
  Products added to the cart
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
