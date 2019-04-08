#import "VSDKTrackingEvent.h"
@class VSDKProduct;
@class VSDKCustomization;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProductCustomization : VSDKTrackingEvent

/**
  Product associated with this product customization
 */
@property VSDKProduct *product;

/**
  Customization associated with this product customization
 */
@property VSDKCustomization *productCustomization;

@end

NS_ASSUME_NONNULL_END
