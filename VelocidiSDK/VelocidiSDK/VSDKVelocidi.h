#import <Foundation/Foundation.h>

@class VSDKConfig;
@class VSDKTrackingEvent;
@class VSDKUserId;
@class AFHTTPSessionManager;

NS_ASSUME_NONNULL_BEGIN

/**
  VelocidiSDK main class responsible for orchestrating all the logic
 */
@interface VSDKVelocidi: NSObject

/**
  Configuration of the SDK
 */
@property (class, readonly, nonatomic) VSDKConfig *config;

/**
  Manages all HTTP requests made by the SDK
 */
@property (readonly, nonatomic) AFHTTPSessionManager *sessionManager;

/**
  Method to retrieve the shared instance of the class VSDKVelocidi.
  This method assumes that the function `.start` as been called before calling this method.
  Otherwise, it will throw a NSInternalInconsistencyException.
  @returns shared single instance of the class VSDKVelocidi
 */
+ (instancetype)sharedInstance;

/**
  Method that takes the provided configuration and properly initializes the Velocidi SDK according
  to the settings of said configuration.
  @param config necessary configuration to properly start the VSDKVelocidi
  @returns shared single instance of the class VSDKVelocidi
 */
+ (instancetype)start: (VSDKConfig *)config;

/**
  Send a request to Velocidi's CDP with a tracking event
  @param trackingEvent tracking event to be sent.
  @param userId the user id to associate with the event.
 */
- (void)track: (VSDKTrackingEvent *)trackingEvent
       userId: (VSDKUserId *) userId;

/**
  Send a request to Velocidi's CDP with a tracking event
  @param trackingEvent tracking event to be sent.
  @param userId the user id to associate with the event.
  @param onSuccessBlock Block to be called if the request is successful
  @param onFailureBlock Block to be called if the request is unsuccessful
 */
- (void)track: (VSDKTrackingEvent *)trackingEvent
       userId: (VSDKUserId *) userId
    onSuccess: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
    onFailure: (void (^)(NSError * error))onFailureBlock;

/**
  Match Apple's advertisingIdentifier with the list of provided user ids
  @param providerId Id of the match provider
  @param userIds List of user ids to be linked along with Advertising Id
  @param onSuccessBlock Block to be called if the request is successful
  @param onFailureBlock Block to be called if the request is unsuccessful
 */
- (void)match: (NSString *)providerId
      userIds: (NSMutableArray<VSDKUserId *> *)userIds
    onSuccess: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
    onFailure: (void (^)(NSError * error))onFailureBlock;

/**
  Match Apple's advertisingIdentifier with the list of provided user ids
  @param providerId Id of the match provider
  @param userIds List of user ids to be linked along with Advertising Id
 */
- (void)match: (NSString *)providerId
      userIds: (NSMutableArray<VSDKUserId *> *)userIds;
@end

NS_ASSUME_NONNULL_END
