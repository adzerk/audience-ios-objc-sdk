#import "VSDKConfig.h"
#import "AFHTTPSessionManager.h"


@implementation VSDKConfig

- (instancetype)initWithTrackingHost: (NSString *)trackingHost
                                    : (NSString *)matchHost {
    if(self = [super init]) {
        self.trackingHost = [[NSURL alloc] initWithString:trackingHost];
        self.matchHost = [[NSURL alloc] initWithString:matchHost];
        
    }
    return self;
}

- (instancetype)initWithDomain: (NSString *)domain{
    if(self = [self initWithTrackingHost:domain:domain]) {
        NSURLComponents * mutableTrackingHost = [[NSURLComponents alloc] initWithURL:self.trackingHost resolvingAgainstBaseURL:false] ;
        NSURLComponents * mutableMatchHost = [[NSURLComponents alloc] initWithURL:self.matchHost resolvingAgainstBaseURL:false] ;
        
        mutableTrackingHost.host = [@"tr." stringByAppendingString:mutableTrackingHost.host];
        mutableMatchHost.host = [@"match." stringByAppendingString:mutableMatchHost.host];
        
        self.trackingHost = mutableTrackingHost.URL;
        self.matchHost = mutableMatchHost.URL;
    }
    return self;
}

@end
