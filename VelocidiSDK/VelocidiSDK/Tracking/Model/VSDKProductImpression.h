#import "VSDKTrackingEvent.h"
@class VSDKProduct;

/**
  Tracking event model class that represents a `ProductImpression` event
 */
@interface VSDKProductImpression : VSDKTrackingEvent

/**
  List of products associated with this Product Impression
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
