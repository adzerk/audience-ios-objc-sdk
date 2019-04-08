#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKTrackingEvent : NSObject

/**
  Client identifier (REQUIRED)
 */
@property (nonnull) NSString *clientId;

/**
  Client's site identifier (REQUIRED)
 */
@property (nonnull) NSString *siteId;

/**
  Event type (REQUIRED)
 */
@property (class, nonnull, readonly) NSString *type;

@end

NS_ASSUME_NONNULL_END
