@import Foundation;
#import "VSDKRequest.h"
#import "VSDKUtil.h"
#import <AdSupport/ASIdentifierManager.h>

@implementation VSDKRequest

static NSString *_trackingNotAllowedErrorDomain = @"VSDKTrackingNotAllowedError";

+ (NSString *) getTrackingNotAllowedErrorDomain{ return _trackingNotAllowedErrorDomain; }
+ (NSError *) getTrackingNotAllowedError {
  return [NSError errorWithDomain: self.getTrackingNotAllowedErrorDomain
                             code: 1 
                         userInfo: @{
                                     NSLocalizedDescriptionKey: NSLocalizedString(@"Operation cannot be completed. Tracking is not allowed", nil),
                                     NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The user has opted-out of ad tracking (Limited Ad Tracking is enabled in the user's device)", nil)}];
}
- (VSDKUtil *) getUtil{ return [[VSDKUtil alloc] init]; }
- (ASIdentifierManager *) getIdentifierManager{ return [ASIdentifierManager sharedManager]; }

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
        :(void (^)(NSError *error))onFailureBlock {
    if (![self.identifierManager isAdvertisingTrackingEnabled]) {
        return onFailureBlock(VSDKRequest.trackingNotAllowedError);
    }

    NSUUID * advertisingIdentifier = [self.identifierManager advertisingIdentifier];

    NSMutableURLRequest * request = [self buildRequest:[advertisingIdentifier UUIDString]];
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

- (NSURLComponents *)buildURLWithQueryParameters:(NSString *) advertisingIdentifier {
    NSURLComponents * urlComponents = [[NSURLComponents alloc] initWithURL: self.url resolvingAgainstBaseURL: true];
    NSMutableArray<NSURLQueryItem *> * queryParams = [[NSMutableArray alloc] init];

    [queryParams addObject: [[NSURLQueryItem alloc] initWithName:@"id_idfa" value:advertisingIdentifier]];
    [queryParams addObject: [[NSURLQueryItem alloc] initWithName:@"cookies" value:false]];

    urlComponents.queryItems = queryParams;
    return urlComponents;
}

- (NSMutableURLRequest *)buildRequest: (NSString *)advertisingIdentifier{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}
@end
