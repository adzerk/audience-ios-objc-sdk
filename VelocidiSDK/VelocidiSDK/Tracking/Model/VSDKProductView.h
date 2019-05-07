#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKProductView : VSDKTrackingEvent

/**
  List of products associated with this product view
 */
@property NSMutableArray<VSDKProduct *> *products;

@end
