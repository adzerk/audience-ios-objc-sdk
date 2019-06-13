#import <Foundation/Foundation.h>
#import "VSDKRequest.h"

@class VSDKTrackingEvent;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKTrackingRequest : VSDKRequest

@property VSDKTrackingEvent * data;

@end

NS_ASSUME_NONNULL_END
