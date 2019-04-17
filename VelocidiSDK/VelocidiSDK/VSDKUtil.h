#import <Foundation/Foundation.h>
#import <VelocidiSDK/VelocidiSDK.h>
@class AFHTTPSessionManager;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKUtil : NSObject
- (NSString *)getVersionedUserAgent;
- (NSUUID *)getAdvertisingIdentifier;
- (bool) isTrackAllowed: (NSUUID *) advertisingIdentifier;

+ (void) setAcceptAllRequests: (AFHTTPSessionManager *) sessionManager;
@end

NS_ASSUME_NONNULL_END
