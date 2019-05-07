#import "VSDKConfig.h"
#import "AFHTTPSessionManager.h"


@implementation VSDKConfig

- (instancetype)initWithHosts: (NSString *)trackingHost :(NSString *)matchHost {
    if(self = [super init]) {
        self.trackingHost = [[NSURL alloc] initWithString:trackingHost];
        self.matchHost = [[NSURL alloc] initWithString:matchHost];
    }
    return self;
}

@end
