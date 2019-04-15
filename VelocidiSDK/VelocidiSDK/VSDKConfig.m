#import "VSDKConfig.h"
#import "AFHTTPSessionManager.h"


@implementation VSDKConfig

- (instancetype)initWithHosts: (NSString *)trackingHost :(NSString *)matchHost {
    if(self = [super init]) {
        self.trackingHost = trackingHost;
        self.matchHost = matchHost;
    }
    return self;
}

@end
