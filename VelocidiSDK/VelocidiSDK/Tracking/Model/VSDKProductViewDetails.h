#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKProductViewDetails : VSDKTrackingEvent

/**
  List of products whose details have been viewed
 */
@property NSMutableArray<VSDKProduct *> *products;

@end
