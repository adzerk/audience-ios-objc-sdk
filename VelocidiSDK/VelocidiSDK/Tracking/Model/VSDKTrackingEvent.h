@import JSONModel;

@interface VSDKTrackingEvent : JSONModel

/**
  Client identifier 
 */
@property (nonnull) NSString *clientId;

/**
  Client's site identifier 
 */
@property (nonnull) NSString *siteId;

/**
  Event type 
 */
@property (nonnull) NSString *type;

/**
  Set default values for `clientId` and `siteId`.
  The values will be applied to any VSDKTrackingEvent initialized with the `initWithDefaultIds`
  @param clientId Client identifier
  @param siteId Client's site identifier
 */
+ (void) setDefaultIds: (NSString * __nonnull)clientId : (NSString * __nonnull)siteId;

/**
  Initialize an instance of VSDKTrackingEvent with the default values for `siteId` and `clientId`.
  The default values are set using the method `setDefaultIds`
  @returns instance of VSDKTrackingEvent
 */
- (nonnull instancetype) initWithDefaultIds;
@end
