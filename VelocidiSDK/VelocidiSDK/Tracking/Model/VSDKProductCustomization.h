#import "VSDKTrackingEvent.h"
@class VSDKProduct;
@class VSDKCustomization;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProductCustomization : VSDKTrackingEvent

@property VSDKProduct *product;
@property VSDKCustomization *productCustomization;

@end

NS_ASSUME_NONNULL_END
