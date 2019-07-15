#import "VSDKTrackingEvent.h"
@class VSDKProduct;
@class VSDKCustomization;

/**
  Tracking event model class that represents a `ProductCustomization` event
 */
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
