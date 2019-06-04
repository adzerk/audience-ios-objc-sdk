#import <Foundation/Foundation.h>

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
  Initialize an instance of VSDKConfig.
  @param trackingHost URL used to make track requests
  @param matchHost URL used to make match requests
  @returns VSDKConfig instance
 */
- (instancetype)initWithTrackingHost: (NSString *)trackingHost
                                    : (NSString *)matchHost;

/**
  Initialize an instance of VSDKConfig.
  @param domain domain where to send tracking and match requests.
  @returns VSDKConfig instance
 */
- (instancetype)initWithDomain: (NSString *)domain;

@end
