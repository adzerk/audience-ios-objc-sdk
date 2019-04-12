#import <VelocidiSDK/VelocidiSDK.h>
#import <AFNetworking/AFHTTPSessionManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKRequest<__covariant T:JSONModel *> : NSObject

@property (readonly, nonatomic) AFHTTPSessionManager *manager;
@property NSURL *url;
@property T data;

- (id)initWithHTTPSessionManager:(AFHTTPSessionManager *)manager;
- (void) performRequest;
- (NSString *)buildURLParameters:(NSString *) advertisingId;

@end

NS_ASSUME_NONNULL_END
