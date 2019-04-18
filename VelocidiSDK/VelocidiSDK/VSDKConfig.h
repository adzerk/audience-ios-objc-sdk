#import <Foundation/Foundation.h>


@interface VSDKConfig : NSObject

/**
  URL used to make tracking requests
 */
@property NSString *trackingHost;

/**
  URL used to make match requests
 */
@property NSString *matchHost;

- (instancetype)initWithHosts: (NSString *)trackingHost :(NSString *)matchHostURLString;

@end
