#import "VSDKTrackingEvent.h"

/**
  Tracking event model class that represents a `AppView` event
 */
@interface VSDKAppView : VSDKTrackingEvent

/**
  Title of the page being viewed
 */
@property (nonnull) NSString *title;

@end
