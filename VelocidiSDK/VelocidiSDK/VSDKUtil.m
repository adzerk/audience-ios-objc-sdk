#import "VSDKUtil.h"
#import <AdSupport/ASIdentifierManager.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@implementation VSDKUtil

+ (NSString *)getVersionedUserAgent {
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

// FIXME - Instead of verifying here, only fetch the id and have the entity that called this function verify if it's equal to 0's.
// This is because the advertisingIdentifier can be nil if the device just booted, which requires the app to try sending the request later.
// See https://developer.apple.com/documentation/adsupport/asidentifiermanager/1614151-advertisingidentifier
+ (NSUUID *)getAdvertisingIdentifier {
    NSUUID *adId = [[ASIdentifierManager sharedManager] advertisingIdentifier];
    if ([[adId UUIDString] isEqualToString:@"00000000-0000-0000-0000-000000000000"])
        return nil;
    return adId;
}

@end