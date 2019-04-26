#import <VelocidiSDK/VelocidiSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKMatchRequest : VSDKRequest

@property NSMutableArray<VSDKUserId *>* userIds;
@property NSString * providerId;

@end

NS_ASSUME_NONNULL_END
