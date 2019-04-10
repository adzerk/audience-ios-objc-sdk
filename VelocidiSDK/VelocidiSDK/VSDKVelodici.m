#import "VSDKVelocidi.h"
#import "VSDKConfig.h"

@implementation VSDKVelocidi

static VSDKConfig *_config = nil;

+ (void)setConfig:(VSDKConfig *)config {
    _config = config;
}

+ (VSDKConfig *) config{
    return _config;
}

+ (id)start:(VSDKConfig *)config {
    self.config = config;

    return [self sharedInstance];
}

+ (id)sharedInstance {
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
    self = [super init];
    return self;
}

@end
