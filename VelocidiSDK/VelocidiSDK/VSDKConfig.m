#import "VSDKConfig.h"
#import "AFHTTPSessionManager.h"


@implementation VSDKConfig

- (instancetype)initWithTrackingHost: (NSString *)trackingHost
                                    : (NSString *)matchHost {
    if(self = [super init]) {
        self.trackingUrl = [[NSURLComponents alloc] initWithString:trackingHost];
        self.matchUrl = [[NSURLComponents alloc] initWithString:matchHost];
        self.trackingUrl.path = @"/events";
        self.matchUrl.path = @"/match";

    }
    return self;
}

- (instancetype)initWithDomain: (NSString *)domain{
    if(self = [self initWithTrackingHost:domain:domain]) {
        self.trackingUrl.host = [@"tr." stringByAppendingString:self.trackingUrl.host];
        self.matchUrl.host = [@"match." stringByAppendingString:self.matchUrl.host];
        
    }
    return self;
}

@end
