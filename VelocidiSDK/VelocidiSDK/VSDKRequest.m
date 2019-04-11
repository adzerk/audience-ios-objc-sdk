@import Foundation;
#import "VSDKRequest.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@implementation VSDKRequest

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
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];


    NSURLRequest * request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:self.url.absoluteString parameters:self.data.toDictionary error:nil];
    NSURLSessionDataTask *dataTask = [manager
            dataTaskWithRequest:request
            uploadProgress:nil
            downloadProgress:nil
            completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                if (error) {
                    NSLog(@"Error: %@", error);
                } else {
                    NSLog(@"%@ %@", response, responseObject);
                }
            }];
    [dataTask resume];

}

@end
