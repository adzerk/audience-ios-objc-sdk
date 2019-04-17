#import <VelocidiSDK/VelocidiSDK.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@protocol VSDKUtilProto;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKRequest<__covariant T:JSONModel *> : NSObject

@property (readonly, nonatomic) AFHTTPSessionManager *manager;
@property NSURL *url;
@property (readonly, nonatomic) id <VSDKUtilProto> util;
@property T data;

- (instancetype)initWithHTTPSessionManager:(AFHTTPSessionManager *)manager;
- (void) performRequest: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
        :(void (^)(NSError *error))onErrorBlock ;
- (NSString *)buildURLParameters:(NSString *) advertisingId;

@end

NS_ASSUME_NONNULL_END
