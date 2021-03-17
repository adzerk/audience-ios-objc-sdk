#import <AdSupport/ASIdentifierManager.h>
#import <AFNetworking/AFNetworking.h>
#import "VSDKGlobalVariables.h"
#import "VSDKUtil.h"

@implementation VSDKUtil

NSString * const trackingNotAllowedErrordomain = @"com.velocidi.VSDKTrackingNotAllowedError";
NSString * const trackingNotAllowedDescKey = @"Operation cannot be completed. Tracking is not allowed";

+ (NSString *)getVersionedUserAgent {
    NSString *userAgentPrefix = [NSString stringWithFormat:@"%@/%@ %@/%@",
                                 [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey],
                                 [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey],
                                 @"VelocidiSDK",
                                 [[NSBundle bundleWithIdentifier: @"com.velocidi.VelocidiSDK"] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle bundleWithIdentifier: @"com.velocidi.VelocidiSDK"] infoDictionary][(__bridge NSString *)kCFBundleVersionKey]];
    NSString *userAgent = nil;
#if TARGET_OS_IOS
    userAgent = [userAgentPrefix stringByAppendingFormat:@" (%@; iOS %@; Scale/%0.2f)",
                 [[UIDevice currentDevice] model],
                 [[UIDevice currentDevice] systemVersion],
                 [[UIScreen mainScreen] scale]];
#elif TARGET_OS_WATCH
    userAgent = [userAgentPrefix stringByAppendingFormat:@" (%@; watchOS %@; Scale/%0.2f)",
                 [[WKInterfaceDevice currentDevice] model],
                 [[WKInterfaceDevice currentDevice] systemVersion],
                 [[WKInterfaceDevice currentDevice] screenScale]];
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
    userAgent = [userAgentPrefix stringByAppendingFormat:@" (Mac OS X %@)",
                 [[NSProcessInfo processInfo] operatingSystemVersionString]];
#endif
    if (userAgent) {
        if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            NSMutableString *mutableUserAgent = [userAgent mutableCopy];
            if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                userAgent = mutableUserAgent;
            }
        }
    }
    return userAgent;

}

+ (void) setAcceptAllResponses: (AFHTTPSessionManager *)sessionManager {
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = nil;
}

+ (nullable NSDictionary *) tryParseJsonEventString :(NSString* )jsonStr :(NSError **)error {
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
}

@end
