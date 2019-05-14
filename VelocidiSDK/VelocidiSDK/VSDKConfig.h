#import <Foundation/Foundation.h>

@interface VSDKConfig : NSObject

/**
  URL endpoint to make track requests
 */
@property NSURL *trackingHost;

/**
  URL endpoint to make match requests
 */
@property NSURL *matchHost;

/**
  Initialize an instance of VSDKConfig.
  @param trackingHost URL used to make track requests
  @param matchHost URL used to make match requests
  @returns VSDKConfig instance
 */
- (instancetype)initWithHosts: (NSString *)trackingHost :(NSString *)matchHost;

/**
  Initialize an instance of VSDKConfig.
  @param domain domain where to send tracking and match requests.
  @returns VSDKConfig instance
 */
- (instancetype)initWithDomain: (NSString *)domain;

@end
