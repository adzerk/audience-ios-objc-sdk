#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKProductClick : VSDKTrackingEvent

/**
  Product associated with this product click
 */
@property NSMutableArray<VSDKProduct *> *product;

@end
