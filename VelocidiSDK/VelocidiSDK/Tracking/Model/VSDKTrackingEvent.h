#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKTrackingEvent : NSObject

/**
  Client identifier (REQUIRED)
 */
@property NSString *clientId;

/**
  Client's site identifier (REQUIRED)
 */
@property NSString *siteId;

/**
  Event type (REQUIRED)
 */
@property NSString *type;

@end

NS_ASSUME_NONNULL_END
