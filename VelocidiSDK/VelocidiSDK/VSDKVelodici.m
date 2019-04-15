#import "VSDKVelocidi.h"
#import "VSDKConfig.h"
#import "VSDKRequest.h"

@implementation VSDKVelocidi

static VSDKConfig *_config = nil;

+ (VSDKConfig *) config{
    return _config;
}

+ (instancetype)start:(VSDKConfig *)config {
    _config = config;

    return [self sharedInstance];
}

+ (instancetype)sharedInstance {
    static VSDKVelocidi *sharedVelocidiManager = nil;
    static dispatch_once_t onceToken;

    if(VSDKVelocidi.config == nil) {
        NSException *e = [NSException
            exceptionWithName:NSInternalInconsistencyException
            reason: @"VelocidiManager not initialized before. Make sure to call `.start` first."
            userInfo:nil];
        @throw e;
    }

    dispatch_once(&onceToken, ^{
        sharedVelocidiManager = [[self alloc] init];
    });
    
    return sharedVelocidiManager;
}

- (id) init{
    if(self = [super init]) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void)track:(VSDKTrackingEvent *)trackingEvent {
    VSDKRequest * request = [[VSDKRequest alloc] initWithHTTPSessionManager:self.sessionManager];

    request.data = trackingEvent;
    request.url = [NSURL URLWithString:VSDKVelocidi.config.trackingHost];

    [request performRequest];
}

@end
