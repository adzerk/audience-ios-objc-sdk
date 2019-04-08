#import "VSDKTrackingEvent.h"
@class VSDKTransaction;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKSubscription : VSDKTrackingEvent

@property NSMutableArray *products;
@property VSDKTransaction *transaction;

@end

NS_ASSUME_NONNULL_END
