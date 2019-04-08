#import "VSDKTrackingEvent.h"
@class VSDKProduct;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKPurchase : VSDKTrackingEvent

@property VSDKProduct *product;

@end

NS_ASSUME_NONNULL_END
