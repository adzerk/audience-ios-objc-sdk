#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKProductClick : VSDKTrackingEvent

/**
  The clicked products
 */
@property NSMutableArray<VSDKProduct *> *products;

@end
