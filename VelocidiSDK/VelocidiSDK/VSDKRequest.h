#import <VelocidiSDK/VelocidiSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKRequest<T> : NSObject

@property NSURL * url;
@property T data;

+ (NSString *) versionedUserAgent;
- (void) performRequest;

@end

NS_ASSUME_NONNULL_END
