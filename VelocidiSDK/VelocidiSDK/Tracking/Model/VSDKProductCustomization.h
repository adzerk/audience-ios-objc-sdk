#import "VSDKTrackingEvent.h"
@class VSDKProduct;
@class VSDKCustomization;

@interface VSDKProductCustomization : VSDKTrackingEvent

/**
  Products being customized
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

/**
  Customization being applied to the products
 */
@property (nullable) VSDKCustomization *productCustomization;

@end
