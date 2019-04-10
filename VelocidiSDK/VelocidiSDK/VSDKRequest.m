@import Foundation;
#import "VSDKRequest.h"

@implementation VSDKRequest

+ (NSString *)versionedUserAgent {
    UIDevice *d = [UIDevice currentDevice];
    return [NSString stringWithFormat:@"%@/%@ %@/%@ (%@ %@)",
                                      [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                                      [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"],
                                      @"VelocidiSDK",
                                      @"1.0.0",
                                      [d systemName],
                                      [d systemVersion]];
}

- (void)performRequest {
    [self doesNotRecognizeSelector:_cmd];
    return;
}

@end
