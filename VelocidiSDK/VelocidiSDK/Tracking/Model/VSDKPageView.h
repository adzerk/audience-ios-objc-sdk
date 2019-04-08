#import "VSDKTrackingEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSDKPageView : VSDKTrackingEvent

@property NSString *location;
@property NSString *title;
@property NSString *pageType;
@property NSString *category;

@end

NS_ASSUME_NONNULL_END
