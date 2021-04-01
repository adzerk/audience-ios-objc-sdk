#import "VSDKConfig.h"
#import "AFHTTPSessionManager.h"

@implementation VSDKConfig

- (instancetype)initWithTrackingBaseUrl:(NSString *)trackingBaseUrl
                           matchBaseUrl:(NSString *)matchBaseUrl {
  if (self = [super init]) {
    self.trackingUrl = [[NSURLComponents alloc] initWithString:trackingBaseUrl];
    self.matchUrl = [[NSURLComponents alloc] initWithString:matchBaseUrl];
    self.trackingUrl.path =
        [self.trackingUrl.path stringByAppendingString:@"/events"];
    self.matchUrl.path = [self.matchUrl.path stringByAppendingString:@"/match"];
  }
  return self;
}

- (instancetype)initWithDomain:(NSString *)domain {
  if (self = [self initWithTrackingBaseUrl:domain matchBaseUrl:domain]) {
    self.trackingUrl.host =
        [@"tr." stringByAppendingString:self.trackingUrl.host];
    self.matchUrl.host = [@"match." stringByAppendingString:self.matchUrl.host];
  }
  return self;
}

@end
