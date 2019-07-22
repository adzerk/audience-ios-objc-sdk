#import <Foundation/Foundation.h>
#import "VSDKRequest.h"

@class VSDKTrackingEvent;

NS_ASSUME_NONNULL_BEGIN

/**
  Class that wraps a NSURLMutableRequest with the necessary addons to make a tracking request to Velocidi's system
 */
@interface VSDKTrackingRequest : VSDKRequest

@property VSDKTrackingEvent * data;

@end

NS_ASSUME_NONNULL_END
