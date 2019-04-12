#import <Foundation/Foundation.h>
#import <VelocidiSDK/VelocidiSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKUtil : NSObject

+ (NSString *)getVersionedUserAgent;
+ (NSString *)getAdvertisingIdentifier;
    
@end

NS_ASSUME_NONNULL_END
