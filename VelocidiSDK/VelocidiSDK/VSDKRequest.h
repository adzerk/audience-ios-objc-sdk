#import <VelocidiSDK/VelocidiSDK.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@class VSDKUtil;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKRequest<__covariant T:JSONModel *> : NSObject

@property (readonly, nonatomic) AFHTTPSessionManager *manager;
@property NSURL *url;
@property (nonatomic) VSDKUtil *util;
@property T data;

/**
  Initialize an instance of VSDKRequest with a custom AFHTTPSessionManager.
  @param manager AFHTTPSessionManager to be used to manage the request.
  @returns VSDKRequest instance
 */
- (instancetype)initWithHTTPSessionManager:(AFHTTPSessionManager *)manager;

/**
  Execute the request.
  @param onSuccessBlock block executed if the request is successful
  @param onFailureBlock block executed if the request fails
 */
- (void) performRequest: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
        :(void (^)(NSError *error))onFailureBlock;

/**
  Build the parameters portion of the request URL.
  The built string contains the `cookies` parameter set to false, and the `id_idfa` parameter with the
  advertisingIdentifier of the user.
  @param advertisingIdentifier advertisingIdentifier of the user
  @returns URL parameters string
 */
- (NSString *)buildURLParameters:(NSString *) advertisingIdentifier;

@end

NS_ASSUME_NONNULL_END
