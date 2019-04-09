#import "VSDKVelocidiManager.h"
#import "VSDKConfig.h"

@implementation VSDKVelocidiManager

static VSDKConfig *_config = nil;

+ (void)setConfig:(VSDKConfig *)config {
    _config = config;
}

+ (VSDKConfig *) config{
    return _config;
}

+ (id)sharedManager {
    static VSDKVelocidiManager *sharedVelocidiManager = nil;
    static dispatch_once_t onceToken;

    NSCAssert(VSDKVelocidiManager.config != nil, @"VelocidiManager not initialized before. Make sure to call `.start` first.");

    dispatch_once(&onceToken, ^{
        sharedVelocidiManager = [[self alloc] init];
    });
    
    return sharedVelocidiManager;
}

+ (id)start:(VSDKConfig *)config {
    self.config = config;

    return [self sharedManager];
}

- (id) init{
    self = [super init];
    return self;
}

@end
