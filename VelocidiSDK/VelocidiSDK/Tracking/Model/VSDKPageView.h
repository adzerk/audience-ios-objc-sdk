#import "VSDKTrackingEvent.h"

/**
  Tracking event model class that represents a `PageView` event
 */
@interface VSDKPageView : VSDKTrackingEvent

/**
  Address of the page being viewed
 */
@property (nullable) NSString *location;

/**
  Page title
 */
@property (nullable) NSString *title;

/**
  Page type (e.g. homepage)
 */
@property (nullable) NSString *pageType;

/**
  Page category
 */
@property (nullable) NSString *category;

@end
