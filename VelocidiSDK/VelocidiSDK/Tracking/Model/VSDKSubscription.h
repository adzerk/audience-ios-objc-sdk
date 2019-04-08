#import "VSDKTrackingEvent.h"
@class VSDKTransaction;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKSubscription : VSDKTrackingEvent

/**
  Products associated with to the Subscription
 */
@property NSMutableArray *products;

/**
  Transaction associated with to the Subscription
 */
@property VSDKTransaction *transaction;

@end

NS_ASSUME_NONNULL_END
