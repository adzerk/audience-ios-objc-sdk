@import Foundation;
#import "VSDKRequest.h"
#import "VSDKUtil.h"

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
        [VSDKUtil setAcceptAllResponses:_manager];
    }
    return self;
}

- (void)performRequest: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
        :(void (^)(NSError *error))onFailureBlock {
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
                    onFailureBlock(error);
                } else {
                    onSuccessBlock(response, responseObject);
                }
            }];
    [dataTask resume];
}

- (NSString *)buildURLParameters:(NSString *) advertisingIdentifier {
    return [NSString stringWithFormat:@"?id_idfa=%@&cookies=false",
            [advertisingIdentifier stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
}

@end
