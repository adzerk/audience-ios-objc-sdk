#import <UIKit/UIKit.h>
@class VSDKConfig;
@class VSDKTrackingEvent;
@class AFHTTPSessionManager;

NS_ASSUME_NONNULL_BEGIN


@interface VSDKVelocidi: NSObject

@property (class, readonly, nonatomic) VSDKConfig *config;
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
  @param necessary configuration to properly start the VSDKVelocidi
  @returns shared single instance of the class VSDKVelocidi
 */
+ (instancetype) start: (VSDKConfig *)config;

/**
  Send a request to Velocidi's CDP with a tracking event 
  @param tracking event to be sent.
 */
- (void)track: (VSDKTrackingEvent *) trackingEvent;

/**
  Send a request to Velocidi's CDP with a tracking event 
  @param tracking event to be sent.
  @param Block to be called if the request is successful
  @param Block to be called if the request is unsuccessful
 */
- (void)track: (VSDKTrackingEvent *) trackingEvent
        onSuccess:(void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
        onFailure:(void (^)(NSError * error)) onErrorBlock;
@end

NS_ASSUME_NONNULL_END
