#import <AFNetworking/AFNetworking.h>
#import "VSDKMatchRequest.h"
#import "VSDKUserId.h"

@implementation VSDKMatchRequest

- (NSMutableURLRequest *) buildRequest {
    NSURLComponents * url = [self buildURLWithCommonParamsAndUserIds: self.userIds];

    return [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                         URLString: url.string
                                                        parameters: nil
                                                             error: nil];
}

@end
