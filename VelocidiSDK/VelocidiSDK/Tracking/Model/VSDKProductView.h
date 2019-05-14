#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKProductView : VSDKTrackingEvent

/**
  List of products viewed
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

@end
