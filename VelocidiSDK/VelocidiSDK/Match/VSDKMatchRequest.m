#import <AFNetworking/AFNetworking.h>
#import "VSDKMatchRequest.h"
#import "VSDKUserId.h"

@implementation VSDKMatchRequest

- (NSURLComponents *) buildMatchURLParameters:(NSString *)advertisingIdentifier{

    NSURLComponents * url = [self buildURLWithQueryParameters:advertisingIdentifier];
    NSMutableArray<NSURLQueryItem *> * queryItems = [[NSMutableArray alloc] initWithArray: url.queryItems];
    
    for(VSDKUserId* userId in self.userIds) {
        [queryItems addObject: [[NSURLQueryItem alloc] initWithName: [[NSString alloc] initWithFormat:@"id_%@", userId.type]
                                                             value: userId.userId]];
    }
    [queryItems addObject: [[NSURLQueryItem alloc] initWithName: @"providerId" value: self.providerId]];
    
    url.queryItems = queryItems;
    return url;
}

- (NSMutableURLRequest *) buildRequest: (NSString *) advertisingIdentifier{
    NSURLComponents * url = [self buildMatchURLParameters: advertisingIdentifier];

    return [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                         URLString: url.string
                                                        parameters: nil
                                                             error: nil];
}

@end
