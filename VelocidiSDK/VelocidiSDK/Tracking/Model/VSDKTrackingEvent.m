#import "VSDKTrackingEvent.h"

@implementation VSDKTrackingEvent

static NSString * _defaultClientId;
static NSString * _defaultSiteId;


+ (void) setDefaultIds:(NSString * __nonnull)clientId :(NSString * __nonnull)siteId {
    _defaultClientId = clientId;
    _defaultSiteId = siteId;
}

- (nonnull instancetype) initWithDefaultIds{
    if(self = [self init]){
        self.clientId = _defaultClientId;
        self.siteId = _defaultSiteId;
    }
    return self;
}

@end
