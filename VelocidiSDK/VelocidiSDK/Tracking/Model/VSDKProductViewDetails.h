#import "VSDKTrackingEvent.h"
@class VSDKProduct;

@interface VSDKProductViewDetails : VSDKTrackingEvent

/**
  List of products associated with this product view details
 */
@property NSMutableArray<VSDKProduct *> *products;

@end
