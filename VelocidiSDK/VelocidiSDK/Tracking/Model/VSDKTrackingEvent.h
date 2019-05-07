@import JSONModel;

@interface VSDKTrackingEvent : JSONModel

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
@property (nonnull) NSString *type;

@end
