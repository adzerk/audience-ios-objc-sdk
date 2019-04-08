#import "VSDKTrackingEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSDKSearch : VSDKTrackingEvent

/**
  Query searched by the user
 */
@property NSString *query;

@end

NS_ASSUME_NONNULL_END
