#import "VSDKTrackingEvent.h"
@class VSDKProduct;
@class VSDKCustomization;

@interface VSDKProductCustomization : VSDKTrackingEvent

/**
  Product associated with this product customization
 */
@property NSMutableArray<VSDKProduct *> *product;

/**
  Customization associated with this product customization
 */
@property VSDKCustomization *productCustomization;

@end
