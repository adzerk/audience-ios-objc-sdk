#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKUserId : NSObject

@property NSString * type;
@property NSString * userId;

- (instancetype)initUserId: (NSString *)userId
                          : (NSString *)type;

@end

NS_ASSUME_NONNULL_END
