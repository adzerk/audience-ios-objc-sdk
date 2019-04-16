#import <UIKit/UIKit.h>
@class VSDKConfig;
@class VSDKTrackingEvent;
@class AFHTTPSessionManager;

NS_ASSUME_NONNULL_BEGIN


@interface VSDKVelocidi: NSObject

@property (class, readonly, nonatomic) VSDKConfig *config;
@property (readonly, nonatomic) AFHTTPSessionManager *sessionManager;

+ (instancetype)sharedInstance;

+ (instancetype) start: (VSDKConfig *)config;

- (void)track: (VSDKTrackingEvent *) trackingEvent;
- (void)track: (VSDKTrackingEvent *) trackingEvent
        onSuccess:(void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
        onFailure:(void (^)(NSError * error)) onErrorBlock;
@end

NS_ASSUME_NONNULL_END
