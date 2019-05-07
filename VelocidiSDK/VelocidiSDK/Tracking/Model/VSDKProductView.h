#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKProductView : VSDKTrackingEvent

/**
  List of products viewed
 */
@property NSMutableArray<VSDKProduct *> *products;

@end
