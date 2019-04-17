@import Foundation;
#import "VSDKRequest.h"
@implementation VSDKRequest

- (instancetype)initWithHTTPSessionManager:(AFHTTPSessionManager *)manager{

    NSParameterAssert(manager != nil);
    if (self = [self init]) {
        _manager = manager;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        _util = [[VSDKUtil alloc] init] ;
    }
    return self;
}

- (void)performRequest: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
        :(void (^)(NSError *error))onErrorBlock {
    NSUUID * advertisingIdentifier = [self.util getAdvertisingIdentifier];

    if (![self.util isTrackAllowed:advertisingIdentifier]) {
        return;
    }

    NSString * urlParameters = [self buildURLParameters:[advertisingIdentifier UUIDString]];
    NSString * url = [NSString stringWithFormat:@"%@%@", self.url.absoluteString, urlParameters];

    NSMutableURLRequest * request = [[AFJSONRequestSerializer serializer]
            requestWithMethod:@"POST"
            URLString:url
                   parameters:self.data.toDictionary error:nil];
    [request setValue:[self.util getVersionedUserAgent] forHTTPHeaderField:@"User-Agent"];
    NSURLSessionDataTask *dataTask = [self.manager
            dataTaskWithRequest:request
            uploadProgress:nil
            downloadProgress:nil
            completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                if (error) {
                    onErrorBlock(error);
                } else {
                    onSuccessBlock(response, responseObject);
                }
            }];
    [dataTask resume];
}

- (NSString *)buildURLParameters:(NSString *) advertisingId {
    return [NSString stringWithFormat:@"?id_idfa=%@&cookies=false",
            [advertisingId stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
}

@end
