#import <Foundation/Foundation.h>

/**
 Model class with the configurations necessary for VSDKVelocidi
 */
@interface VSDKConfig : NSObject

/**
  URL endpoint to make track requests
 */
@property NSURLComponents *trackingUrl;

/**
  URL endpoint to make match requests
 */
@property NSURLComponents *matchUrl;

/**
  Initialize an instance of VSDKConfig providing the base URLs of the match and tracking endpoints.
  To each of the base URLs the respective path will be appended, `/events` for tracking and `/match`
  for match.
  Example: `https://tr.basetrackinghost.com/path` will become `https://tr.basetrackinghost.com/path/events`
  @param trackingBaseUrl Base URL used to make track requests
  @param matchBaseUrl Base URL used to make match requests
  @returns VSDKConfig instance
 */
- (instancetype)initWithTrackingBaseUrl: (NSString *)trackingBaseUrl
                                    : (NSString *)matchBaseUrl;

/**
  Initialize an instance of VSDKConfig providing the domain that will be used to make the endpoints.
  The domain will be prepended with the respective subdomain, `tr.` for tracking and `match.` for match.
  Example: `https://domain.com` will become `https://tr.domain.com/ and `https://match.domain.com`.
  NOTE: The method `initWithTrackingBaseUrl` will also be called internally, so any change made by that method also applies.
  @param domain domain where to send tracking and match requests.
  @returns VSDKConfig instance
 */
- (instancetype)initWithDomain: (NSString *)domain;

@end
