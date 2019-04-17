#import <Foundation/Foundation.h>
#import <VelocidiSDK/VelocidiSDK.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VSDKUtilProto <NSObject>

- (NSString *)getVersionedUserAgent;
- (NSUUID *)getAdvertisingIdentifier;
- (bool) isTrackAllowed: (NSUUID *) advertisingIdentifier;

@end

@interface VSDKUtil : NSObject <VSDKUtilProto>

@end

NS_ASSUME_NONNULL_END
