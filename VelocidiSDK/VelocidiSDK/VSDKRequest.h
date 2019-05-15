#import <VelocidiSDK/VelocidiSDK.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@class ASIdentifierManager;
@class VSDKUtil;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKRequest<__covariant T:JSONModel *> : NSObject

@property (readonly, nonatomic) AFHTTPSessionManager *manager;
@property NSURL *url;
@property (readonly, getter=getUtil, nonatomic) VSDKUtil *util;
@property (readonly, getter=getIdentifierManager) ASIdentifierManager *identifierManager;
@property T data;
@property (class, readonly, getter=getTrackingNotAllowed) NSString *trackingNotAllowedError;

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
- (NSURLComponents *)buildURLWithQueryParameters:(NSString *) advertisingIdentifier;

@end

NS_ASSUME_NONNULL_END
