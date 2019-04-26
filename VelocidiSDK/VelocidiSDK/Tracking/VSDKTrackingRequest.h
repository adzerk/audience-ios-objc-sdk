#import <Foundation/Foundation.h>
#import "VSDKRequest.h"
#import "VSDKTrackingEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSDKTrackingRequest : VSDKRequest<VSDKTrackingEvent *>

@property VSDKTrackingEvent * data;

@end

NS_ASSUME_NONNULL_END
