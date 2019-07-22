#import "VSDKTrackingEvent.h"
@class VSDKProduct;

/**
  Tracking event model class that represents a `ProductClick` event
 */
@interface VSDKProductClick : VSDKTrackingEvent

/**
  The clicked products
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
