#import "VSDKRequest.h"

@class VSDKUserId;

NS_ASSUME_NONNULL_BEGIN

/**
  Class that wraps a NSURLMutableRequest with the necessary addons to make a match request to Velocidi's system
 */
@interface VSDKMatchRequest : VSDKRequest

@property NSMutableArray<VSDKUserId *>* userIds;
@property NSString * providerId;

- (instancetype)initWithHTTPSessionManager:(AFHTTPSessionManager *)manager
                                   withUrl: (NSURL *) url
                                   withUserIds: (NSMutableArray<VSDKUserId *> *)userIds
                                   andProviderId: (NSString *) providerId;

@end

NS_ASSUME_NONNULL_END
