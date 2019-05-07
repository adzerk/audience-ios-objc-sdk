#import "VSDKTrackingEvent.h"
@class VSDKProduct;
@class VSDKCustomization;

@interface VSDKProductCustomization : VSDKTrackingEvent

/**
  Products being customized
 */
@property NSMutableArray<VSDKProduct *> *products;

/**
  Customization being applied to the products
 */
@property VSDKCustomization *productCustomization;

@end
