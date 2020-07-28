#import "VSDKTrackingEvent.h"
@class VSDKLineItem;
@class VSDKOrder;

@interface VSDKOrderPlace : VSDKTrackingEvent

/**
  Order line items
 */
@property (nullable) NSMutableArray<VSDKLineItem *> *lineItems;

/**
  Order details
 */
@property (nonnull) VSDKOrder *order;

@end
