#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;
@class VSDKUtil;
@class VSDKIdfaUtil;

NS_ASSUME_NONNULL_BEGIN

/**
  Class that wraps a NSURLMutableRequest with the necessary addons to make a request to Velocidi's system
 */
@interface VSDKRequest : NSObject

@property (readonly, nonatomic) AFHTTPSessionManager *manager;
@property NSURL *url;


- (NSString *) getVersionedUserAgent;

- (nullable NSString *) tryGetIDFA :(NSError **)errorPtr;

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
- (void)performRequest: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
        :(void (^)(NSError *error))onFailureBlock;

/**
  Build the parameters portion of the request URL.
  The built string contains the `cookies` parameter set to false, and the `id_idfa` parameter with the
  advertisingIdentifier of the user.
  @param advertisingIdentifier advertisingIdentifier of the user
  @returns URL parameters string
 */
- (NSURLComponents *)buildURLWithQueryParameters:(NSString *) advertisingIdentifier;

/**
  Build a NSMutableURLRequest that can be executed.
  Has to be implemented by classes inheriting this class.
  @param advertisingIdentifier advertisingIdentifier of the user
  @returns request to be executed
 */
- (NSMutableURLRequest *)buildRequest: (NSString *)advertisingIdentifier;

@end

NS_ASSUME_NONNULL_END
