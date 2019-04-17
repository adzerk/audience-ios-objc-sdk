#import "VSDKUtil.h"
#import <AdSupport/ASIdentifierManager.h>

@implementation VSDKUtil

- (NSString *)getVersionedUserAgent {
    NSString *userAgent = nil;
#if TARGET_OS_IOS
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    userAgent = [NSString stringWithFormat:@"%@/%@ %@/%@ (%@; iOS %@; Scale/%0.2f)",
                 [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey],
                 [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey],
                 @"VelocidiSDK",
                 @(VelocidiSDKVersionNumber),
                 [[UIDevice currentDevice] model],
                 [[UIDevice currentDevice] systemVersion],
                 [[UIScreen mainScreen] scale]];
#elif TARGET_OS_WATCH
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    userAgent = [NSString stringWithFormat:@"%@/%@ %@/%@ (%@; watchOS %@; Scale/%0.2f)",
                 [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey],
                 [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey],
                 @"VelocidiSDK",
                 @(VelocidiSDKVersionNumber),
                 [[WKInterfaceDevice currentDevice] model],
                 [[WKInterfaceDevice currentDevice] systemVersion],
                 [[WKInterfaceDevice currentDevice] screenScale]];
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
    userAgent = [NSString stringWithFormat:@"%@/%@ %@/%@ (Mac OS X %@)",
                 [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey],
                 [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey],
                 @"VelocidiSDK",
                 @(VelocidiSDKVersionNumber),
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

- (NSUUID *)getAdvertisingIdentifier {
    return [[ASIdentifierManager sharedManager] advertisingIdentifier];
}

- (bool)isTrackAllowed:(NSUUID *)advertisingIdentifier {
    if ([[advertisingIdentifier UUIDString] isEqualToString:@"00000000-0000-0000-0000-000000000000"]){
        return false;
    }
    return true;
}

+ (void) setAcceptAllRequests: (AFHTTPSessionManager *)sessionManager {
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = nil;
}
@end
