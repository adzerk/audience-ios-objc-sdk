#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
  A User identifier, composed by and id and a type.
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

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithId: (NSString *)userId
                      type: (NSString *)userIdType NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
