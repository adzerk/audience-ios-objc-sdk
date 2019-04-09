#import <UIKit/UIKit.h>
@class VSDKConfig;

NS_ASSUME_NONNULL_BEGIN


@interface VSDKVelocidi: NSObject

@property (class, nonatomic) VSDKConfig *config;

+ (id)sharedInstance;

+ (id) start: (VSDKConfig *)config;
@end

NS_ASSUME_NONNULL_END
