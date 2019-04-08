#import "VSDKTrackingEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSDKPageView : VSDKTrackingEvent

/**
  Page being viewed 
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

NS_ASSUME_NONNULL_END
