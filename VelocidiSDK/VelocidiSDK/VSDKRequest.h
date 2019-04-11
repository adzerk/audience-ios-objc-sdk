#import <VelocidiSDK/VelocidiSDK.h>
#import <AFNetworking/AFHTTPSessionManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKRequest<__covariant T:JSONModel *> : NSObject

@property (readonly, strong, nonatomic) AFHTTPSessionManager *manager;
@property NSURL *url;
@property T data;

+ (NSString *) versionedUserAgent;
- (id)initWithHTTPSessionManager:(AFHTTPSessionManager *)manager;
- (void) performRequest;

@end

NS_ASSUME_NONNULL_END
