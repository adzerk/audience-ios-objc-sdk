@import Foundation;
#import "VSDKRequest.h"

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

- (id)initWithHTTPSessionManager:(AFHTTPSessionManager *)manager{

    NSParameterAssert(manager != nil);
    if (self = [super init]) {
        _manager = manager;
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void)performRequest {

    NSURLRequest * request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:self.url.absoluteString parameters:self.data.toDictionary error:nil];
    NSURLSessionDataTask *dataTask = [self.manager
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
