#import "VSDKTrackingEvent.h"

@class VSDKProduct;

@interface VSDKAddToCart : VSDKTrackingEvent

/**
  Product added to the cart
 */
@property NSMutableArray<VSDKProduct *> *product;

@end
