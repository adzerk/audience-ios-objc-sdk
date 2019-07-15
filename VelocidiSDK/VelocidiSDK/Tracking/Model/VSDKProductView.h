#import "VSDKTrackingEvent.h"
@class VSDKProduct;

/**
  Tracking event model class that represents a `ProductView` event
 */
@interface VSDKProductView : VSDKTrackingEvent

/**
  List of products viewed
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
