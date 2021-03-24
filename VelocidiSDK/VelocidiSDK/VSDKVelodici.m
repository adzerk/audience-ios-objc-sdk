#import <AFNetworking/AFNetworking.h>
#import "VSDKVelocidi.h"
#import "VSDKConfig.h"
#import "VSDKTrackingRequest.h"
#import "VSDKMatchRequest.h"
#import "VSDKUtil.h"
#import "VSDKUserId.h"

@implementation VSDKVelocidi

static VSDKConfig *_config = nil;

+ (VSDKConfig *) config{
    return _config;
}

+ (instancetype)start: (VSDKConfig *)config {
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

- (id) init {
    if(self = [super init]) {
        _sessionManager = [AFHTTPSessionManager manager];
        [VSDKUtil setAcceptAllResponses:_sessionManager];
    }
    return self;
}

- (void)track: (VSDKTrackingEvent *)trackingEvent
       userId: (VSDKUserId *) userId {
    [self
     track:trackingEvent
     userId: userId
     onSuccess: (void (^)(NSURLResponse *, id)) ^{}
     onFailure: (void (^)(NSError * error)) ^{}
     ];
}

- (void)track: (VSDKTrackingEvent *)trackingEvent
       userId: (VSDKUserId *) userId
    onSuccess: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
    onFailure: (void (^)(NSError *error))onFailureBlock {

    VSDKTrackingRequest * request = [[VSDKTrackingRequest alloc] initWithHTTPSessionManager:self.sessionManager];

    if ([userId.type length] <= 0 || [userId.userId length] <= 0) {
        NSError * error = [NSError errorWithDomain: @"com.velocidi.VSDKTrackingRequest"
                                              code: 1
                                          userInfo: @{
                                              NSLocalizedDescriptionKey : NSLocalizedString(@"InvalidArgument", nil),
                                              NSLocalizedFailureReasonErrorKey : NSLocalizedString(@"One or more arguments are not valid!", nil),
                                              @"ArgumentFailures": @[NSLocalizedString(@"User ids must have non-empty ids and types!", nil)]}];

        onFailureBlock(error);
        return;
    }

    request.userId = userId;
    request.data = trackingEvent;
    request.url = VSDKVelocidi.config.trackingUrl.URL;

    [request performRequest:onSuccessBlock :onFailureBlock];
}

- (void)match: (NSString *)providerId
      userIds: (NSMutableArray<VSDKUserId *> *)userIds {
    
    [self match: providerId
        userIds: userIds
      onSuccess: (void (^)(NSURLResponse *, id)) ^{}
      onFailure: (void (^)(NSError * error)) ^{} ];
}

- (void)match: (NSString *)providerId
      userIds: (NSMutableArray<VSDKUserId *> *)userIds
    onSuccess: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
    onFailure: (void (^)(NSError * error))onFailureBlock {

    NSMutableArray * reasons = [NSMutableArray arrayWithCapacity: 1];
    if ([providerId length] <= 0){
        [reasons addObject:NSLocalizedString(@"Provider id must not be empty!", nil)];
    }
    
    if ([userIds count] < 2) {
        [reasons addObject:NSLocalizedString(@"At least 2 user ids must be provided!", nil)];
    }

    for (VSDKUserId* userId in userIds) {
        if ([userId.type length] <= 0 || [userId.userId length] <= 0) {
            [reasons addObject: NSLocalizedString(@"User ids must have non-empty ids and types!", nil)];
            break;
        }
    }

    if ([reasons count] > 0) {
        NSError * error = [NSError errorWithDomain: @"com.velocidi.VSDKMatchRequest"
                                              code: 1
                                          userInfo: @{
                                              NSLocalizedDescriptionKey : NSLocalizedString(@"InvalidArgument", nil),
                                              NSLocalizedFailureReasonErrorKey : NSLocalizedString(@"One or more arguments are not valid!", nil),
                                              @"ArgumentFailures": reasons}];

        onFailureBlock(error);
        return;
    } else {
        VSDKMatchRequest * request = [[VSDKMatchRequest alloc] initWithHTTPSessionManager:self.sessionManager];

        request.userIds = userIds;
        request.providerId = providerId;
        request.url = VSDKVelocidi.config.matchUrl.URL;

        [request performRequest:onSuccessBlock :onFailureBlock];
    }
}

@end
