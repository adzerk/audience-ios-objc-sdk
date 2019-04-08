#import <Foundation/Foundation.h>
@class VSDKConfig;

NS_ASSUME_NONNULL_BEGIN


@interface VSDKInstance : NSObject

@property VSDKInstance *instance;
@property VSDKConfig *config;

//- (void)getInstance;

@end

NS_ASSUME_NONNULL_END
