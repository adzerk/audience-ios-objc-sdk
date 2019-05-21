#import "VSDKTrackingEvent.h"
@class VSDKTransaction;
@class VSDKProduct;

@interface VSDKSubscription : VSDKTrackingEvent

/**
  Products associated with the Subscription
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

/**
  Transaction associated with the Subscription
 */
@property (nullable) VSDKTransaction *transaction;

@end
