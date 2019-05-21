#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKProductImpression : VSDKTrackingEvent

/**
  List of products associated with this Product Impression
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
