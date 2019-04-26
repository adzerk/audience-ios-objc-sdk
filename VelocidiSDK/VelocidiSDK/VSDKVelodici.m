#import "VSDKVelocidi.h"
#import "VSDKConfig.h"
#import "VSDKRequest.h"
#import "VSDKTrackingRequest.h"
#import "VSDKMatchRequest.h"
#import "VSDKUtil.h"

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
        [VSDKUtil setAcceptAllResponses:_sessionManager];
    }
    return self;
}

- (void)track: (VSDKTrackingEvent *)trackingEvent {
    [self track:trackingEvent onSuccess: (void (^)(NSURLResponse *, id)) ^{} onFailure: (void (^)(NSError * error)) ^{}];
}

- (void)track: (VSDKTrackingEvent *)trackingEvent
    onSuccess: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
    onFailure: (void (^)(NSError *error))onFailureBlock {

    VSDKTrackingRequest * request = [[VSDKTrackingRequest alloc] initWithHTTPSessionManager:self.sessionManager];

    request.data = trackingEvent;
    request.url = VSDKVelocidi.config.trackingHost;

    [request performRequest:onSuccessBlock :onFailureBlock];
}

- (void)match: (NSString *) providerId
      userIds: (NSMutableArray<VSDKUserId *> *) userIds {
    [self match: providerId
        userIds: userIds
      onSuccess: (void (^)(NSURLResponse *, id)) ^{}
      onFailure: (void (^)(NSError * error)) ^{} ];
}

- (void)match: (NSString *) providerId
      userIds: (NSMutableArray<VSDKUserId *> *) userIds
    onSuccess: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
    onFailure: (void (^)(NSError * error)) onFailureBlock {
    
    VSDKMatchRequest * request = [[VSDKMatchRequest alloc] initWithHTTPSessionManager:self.sessionManager];
    
    request.userIds = userIds;
    request.providerId = providerId;
    request.url = VSDKVelocidi.config.matchHost;
    
    [request performRequest:onSuccessBlock :onFailureBlock];
}
@end
