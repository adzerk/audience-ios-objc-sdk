#import "VSDKTrackingEvent.h"
@class VSDKProduct;

/**
  Tracking event model class that represents a `ProductViewDetails` event
 */
@interface VSDKProductViewDetails : VSDKTrackingEvent

/**
  List of products whose details have been viewed
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
