@import Foundation;
#import "VSDKRequest.h"

@implementation VSDKRequest

- (instancetype)initWithHTTPSessionManager:(AFHTTPSessionManager *)manager{

    NSParameterAssert(manager != nil);
    if (self = [super init]) {
        _manager = manager;
        [self setAcceptAllRequests];
    }
    return self;
}

- (void) setAcceptAllRequests {
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = nil;
}

- (instancetype)init {
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];

        [self setAcceptAllRequests];
    }
    return self;
}

- (void)performRequest: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
        :(void (^)(NSError *error))onErrorBlock {
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
