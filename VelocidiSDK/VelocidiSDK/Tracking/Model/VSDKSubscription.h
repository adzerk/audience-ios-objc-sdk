#import "VSDKTrackingEvent.h"
@class VSDKTransaction;
@class VSDKProduct;

@interface VSDKSubscription : VSDKTrackingEvent

/**
  Products associated with the Subscription
 */
@property NSMutableArray<VSDKProduct *> *products;

/**
  Transaction associated with the Subscription
 */
@property VSDKTransaction *transaction;

@end
