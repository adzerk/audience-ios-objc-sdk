#import <AFNetworking/AFNetworking.h>
#import "VSDKTRackingEvent.h"
#import "VSDKTrackingRequest.h"
#import "VSDKRequest.h"

@implementation VSDKTrackingRequest

- (NSMutableURLRequest *) buildRequest {
    NSMutableArray *userIds = [NSMutableArray arrayWithCapacity:1];
    [userIds addObject: self.userId];
    
    NSURLComponents * url = [self buildURLWithCommonParamsAndUserIds: userIds];

    return [[AFJSONRequestSerializer serializer] requestWithMethod: @"POST"
                                                         URLString: url.string
                                                        parameters: self.data.toDictionary
                                                             error: nil];
}
@end
