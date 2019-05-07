#import "VSDKTrackingEvent.h"
@class VSDKProduct;
@class VSDKCustomization;

@interface VSDKProductCustomization : VSDKTrackingEvent

/**
  Products being customized
 */
@property NSMutableArray<VSDKProduct *> *products;

/**
  Customization associated with this product customization
 */
@property VSDKCustomization *productCustomization;

@end
