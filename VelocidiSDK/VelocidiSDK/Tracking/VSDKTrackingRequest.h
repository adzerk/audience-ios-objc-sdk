#import <Foundation/Foundation.h>
#import "VSDKRequest.h"
#import "VSDKUserId.h"

@class VSDKTrackingEvent;

NS_ASSUME_NONNULL_BEGIN

/**
  Class that wraps a NSURLMutableRequest with the necessary addons to make a tracking request to Velocidi's system
 */
@interface VSDKTrackingRequest : VSDKRequest

@property VSDKUserId * userId;

@property VSDKTrackingEvent * data;

- (instancetype)initWithHTTPSessionManager:(AFHTTPSessionManager *)manager
                                   withUrl: (NSURL *) url
                                   withEvent: (VSDKTrackingEvent *) event
                                 andUserId: (VSDKUserId *) userId;

@end

NS_ASSUME_NONNULL_END
