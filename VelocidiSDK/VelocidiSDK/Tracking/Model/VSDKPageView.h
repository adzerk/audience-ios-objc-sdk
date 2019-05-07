#import "VSDKTrackingEvent.h"

@interface VSDKPageView : VSDKTrackingEvent

/**
  Address of the page being viewed
 */
@property NSString *location;

/**
  Page title
 */
@property NSString *title;

/**
  Page type (e.g. homepage)
 */
@property NSString *pageType;

/**
  Page category
 */
@property NSString *category;

@end
