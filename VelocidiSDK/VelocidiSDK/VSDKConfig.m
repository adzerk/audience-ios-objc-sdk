#import "VSDKConfig.h"
#import "AFHTTPSessionManager.h"


@implementation VSDKConfig

- (NSString *)getTrackPath {
    return self.trackingUrl.path;
}

- (void)setTrackPath: (NSString *)trackingPath {
    NSURLComponents * mutableTrackingHost = [[NSURLComponents alloc] initWithURL:self.trackingUrl resolvingAgainstBaseURL:false] ;
    mutableTrackingHost.path = trackingPath;
    
    self.trackingUrl = mutableTrackingHost.URL;
}

- (NSString *)getMatchPath {
    return self.trackingUrl.path;
}

- (void)setMatchPath: (NSString *)trackingPath {
    NSURLComponents * mutableMatchHost = [[NSURLComponents alloc] initWithURL:self.matchUrl resolvingAgainstBaseURL:false] ;
    mutableMatchHost.path = trackingPath;
    
    self.matchUrl = mutableMatchHost.URL;
}

- (instancetype)initWithTrackingHost: (NSString *)trackingHost
                                    : (NSString *)matchHost {
    if(self = [super init]) {
        self.trackingUrl = [[NSURL alloc] initWithString:trackingHost];
        self.matchUrl = [[NSURL alloc] initWithString:matchHost];
        self.trackingPath = @"events";
        self.matchPath = @"match";
        
    }
    return self;
}

- (instancetype)initWithDomain: (NSString *)domain{
    if(self = [self initWithTrackingHost:domain:domain]) {
        NSURLComponents * mutableTrackingHost = [[NSURLComponents alloc] initWithURL:self.trackingUrl resolvingAgainstBaseURL:false] ;
        NSURLComponents * mutableMatchHost = [[NSURLComponents alloc] initWithURL:self.matchUrl resolvingAgainstBaseURL:false] ;
        
        mutableTrackingHost.host = [@"tr." stringByAppendingString:mutableTrackingHost.host];
        mutableMatchHost.host = [@"match." stringByAppendingString:mutableMatchHost.host];
        
        self.trackingUrl = mutableTrackingHost.URL;
        self.matchUrl = mutableMatchHost.URL;
    }
    return self;
}

@end
