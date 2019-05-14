#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKProductClick : VSDKTrackingEvent

/**
  The clicked products
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
