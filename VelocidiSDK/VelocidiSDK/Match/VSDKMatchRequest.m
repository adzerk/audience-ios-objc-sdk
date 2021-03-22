#import <AFNetworking/AFNetworking.h>
#import "VSDKMatchRequest.h"
#import "VSDKUserId.h"

@implementation VSDKMatchRequest

- (instancetype)initWithHTTPSessionManager:(AFHTTPSessionManager *)manager
                                   withUrl: (NSURL *) url
                                   withUserIds: (NSMutableArray<VSDKUserId *> *)userIds
                                   andProviderId: (NSString *) providerId {

    if ([userIds count] < 2){
        NSException* ex = [NSException
                exceptionWithName:@"InvalidArgument"
                reason:@"At least 2 user ids must be provided!"
                userInfo:nil];
        @throw ex;
    }

    for (VSDKUserId* userId in userIds) {
        [userId validate];
    }

    if ([providerId length] <= 0){
        NSException* ex = [NSException
                exceptionWithName:@"InvalidArgument"
                reason:@"Provider must not be empty!"
                userInfo:nil];
        @throw ex;
    }

    if (self = [self initWithHTTPSessionManager:manager]) {
        self.providerId = providerId;
        self.userIds = userIds;
        self.url = url;
    }

    return self;
}

- (NSMutableURLRequest *) buildRequest {

    NSURLComponents * url = [self buildURLWithCommonParamsAndUserIds: self.userIds];

    return [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                         URLString: url.string
                                                        parameters: nil
                                                             error: nil];
}

@end
