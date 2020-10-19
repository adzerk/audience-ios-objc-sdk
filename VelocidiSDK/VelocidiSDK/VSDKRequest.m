#import <AFNetworking/AFNetworking.h>
#import "VSDKRequest.h"
#import "VSDKUtil.h"
#import "VSDKIdfaUtil.h"

@implementation VSDKRequest

- (VSDKUtil *) getUtil{ return [[VSDKUtil alloc] init]; }
- (VSDKIdfaUtil *) getIDFAUtil{ return [VSDKIdfaUtil sharedInstance]; }

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

- (void)performRequest: (void (^)(NSURLResponse *response, id responseObject))onSuccessBlock
                      : (void (^)(NSError *error))onFailureBlock {
    
    NSError *error = nil;
    NSString *advertisingIdentifier = [self.IdfaUtil tryGetIDFA: &error];
    
    if (error) {
        return onFailureBlock(error);
    } else {
        NSMutableURLRequest * request = [self buildRequest:advertisingIdentifier];
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
}

- (NSURLComponents *)buildURLWithQueryParameters:(NSString *) advertisingIdentifier {
    NSURLComponents * urlComponents = [[NSURLComponents alloc] initWithURL: self.url resolvingAgainstBaseURL: true];
    NSMutableArray<NSURLQueryItem *> * queryParams = [[NSMutableArray alloc] init];

    [queryParams addObject: [[NSURLQueryItem alloc] initWithName:@"id_idfa" value:advertisingIdentifier]];
    [queryParams addObject: [[NSURLQueryItem alloc] initWithName:@"cookies" value:@"false"]];

    urlComponents.queryItems = queryParams;
    return urlComponents;
}

- (NSMutableURLRequest *)buildRequest: (NSString *)advertisingIdentifier{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}
@end
