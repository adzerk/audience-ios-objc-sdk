@import Foundation;
#import "VSDKRequest.h"
#import <sys/utsname.h> // import it in your header or implementation file.
#import <UIKit/UIKit.h> // import it in your header or implementation file.

@implementation VSDKRequest

+ (NSString *) deviceName{
    struct utsname systemInfo;
    uname(&systemInfo);

    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

+ (NSString *)versionedUserAgent {
    UIDevice *d = [UIDevice currentDevice];
    return [NSString stringWithFormat:@"%@/%@ %@/%@ (%@; %@/%@)",
                                      [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                                      [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"],
                                      @"VelocidiSDK",
                                      @(VelocidiSDKVersionNumber),
                                      [d model],
                                      [d systemName],
                                      [d systemVersion]];
}

- (void)performRequest {
    [self doesNotRecognizeSelector:_cmd];
    return;
}

@end
