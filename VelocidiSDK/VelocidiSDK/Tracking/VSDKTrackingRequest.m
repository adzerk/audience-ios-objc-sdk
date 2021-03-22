#import <AFNetworking/AFNetworking.h>
#import "VSDKTRackingEvent.h"
#import "VSDKTrackingRequest.h"
#import "VSDKRequest.h"

@implementation VSDKTrackingRequest

- (instancetype)initWithHTTPSessionManager:(AFHTTPSessionManager *) manager
                                   withUrl: (NSURL *) url
                                   withEvent: (VSDKTrackingEvent *) event
                                 andUserId: (VSDKUserId *) userId {
    [userId validate];

    if (self = [self initWithHTTPSessionManager:manager]) {
        self.url = url;
        self.data = event;
        self.userId = userId;
    }

    return self;
}

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
