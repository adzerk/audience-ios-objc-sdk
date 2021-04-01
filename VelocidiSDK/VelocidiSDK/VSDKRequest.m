#import <AFNetworking/AFNetworking.h>
#import "VSDKRequest.h"
#import "VSDKUtil.h"
#import "VSDKUserId.h"

@implementation VSDKRequest

- (NSString *) getVersionedUserAgent {return [VSDKUtil getVersionedUserAgent]; }

- (instancetype)initWithHTTPSessionManager:(AFHTTPSessionManager *)manager{
    if (self = [self init]) {
        _manager = manager;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        [VSDKUtil setAcceptAllResponses:_manager];
    }
    return self;
}

- (void)performRequest: (void (^)(NSURLResponse *, id))onSuccessBlock
                      : (void (^)(NSError *))onFailureBlock {

    NSMutableURLRequest * request = [self buildRequest];
    [request setValue:[self getVersionedUserAgent] forHTTPHeaderField:@"User-Agent"];
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

- (NSURLComponents *)buildURLWithCommonParamsAndUserIds: (NSMutableArray<VSDKUserId *> *) userIds {
    NSURLComponents * urlComponents = [[NSURLComponents alloc] initWithURL: self.url resolvingAgainstBaseURL: true];
    NSMutableArray<NSURLQueryItem *> * queryParams = [[NSMutableArray alloc] init];

    for(VSDKUserId* userId in userIds) {
        [queryParams addObject: [[NSURLQueryItem alloc] initWithName: [[NSString alloc] initWithFormat:@"id_%@", userId.type]
                                                              value: userId.userId]];
    }
    [queryParams addObject: [[NSURLQueryItem alloc] initWithName:@"cookies" value:@"false"]];

    urlComponents.queryItems = queryParams;
    return urlComponents;
}

- (NSMutableURLRequest *)buildRequest {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}
@end
