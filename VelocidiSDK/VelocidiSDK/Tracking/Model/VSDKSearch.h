#import "VSDKTrackingEvent.h"

/**
  Tracking event model class that represents a `Search` event
 */
@interface VSDKSearch : VSDKTrackingEvent

/**
  Query searched by the user
 */
@property (nullable) NSString *query;

@end
