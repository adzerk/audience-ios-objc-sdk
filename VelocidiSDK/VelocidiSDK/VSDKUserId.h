#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
  User identifier used to match the user to an external identifier.
  More info: https://docs.velocidi.com/collection/user-identifiers/
 */
@interface VSDKUserId : NSObject

/**
  Type of user identifier.
 */
@property NSString * type;

/**
  User identifier.
 */
@property NSString * userId;

- (instancetype)initUserId: (NSString *)userId
                          : (NSString *)type;

@end

NS_ASSUME_NONNULL_END
