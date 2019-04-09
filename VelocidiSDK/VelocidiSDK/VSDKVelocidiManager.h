#import <UIKit/UIKit.h>
@class VSDKConfig;

NS_ASSUME_NONNULL_BEGIN


@interface VSDKVelocidiManager : NSObject

@property VSDKVelocidiManager *instance;
@property (class, nonatomic) VSDKConfig *config;

+ (id) sharedManager;

+ (id) start: (VSDKConfig *)config;
@end

NS_ASSUME_NONNULL_END
