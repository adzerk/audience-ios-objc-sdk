#import "VSDKTrackingEvent.h"
@class VSDKTransaction;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKRefund : VSDKTrackingEvent

@property NSString *refundType;
@property NSMutableArray *products;
@property VSDKTransaction *transaction;

@end

NS_ASSUME_NONNULL_END
