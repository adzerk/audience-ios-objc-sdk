#import <Foundation/Foundation.h>
#import "VSDKRequest.h"
#import "VSDKTrackingEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSDKTrackingRequest : VSDKRequest

@property VSDKTrackingEvent * data;

@end

NS_ASSUME_NONNULL_END
