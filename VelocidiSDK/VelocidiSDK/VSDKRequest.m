@import Foundation;
#import "VSDKRequest.h"
#import "VSDKUtil.h"

@implementation VSDKRequest

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
    NSUUID * advertisingIdentifier = VSDKUtil.getAdvertisingIdentifier;
    
    if (!advertisingIdentifier) { // If advertisinIdentifier is nil, the user does not want to be tracked
        return;
    }
    NSString * urlParameters = [self buildURLParameters:[advertisingIdentifier UUIDString]];
    NSString * url = [NSString stringWithFormat:@"%@%@", self.url.absoluteString, urlParameters];

    NSMutableURLRequest * request = [[AFJSONRequestSerializer serializer]
            requestWithMethod:@"POST"
            URLString:url
                   parameters:self.data.toDictionary error:nil];
    [request setValue:VSDKUtil.getVersionedUserAgent forHTTPHeaderField:@"User-Agent"];
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

- (NSString *)buildURLParameters:(NSString *) advertisingId {
    return [NSString stringWithFormat:@"?id_idfa=%@&cookies=false",
            [advertisingId stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
}

@end
