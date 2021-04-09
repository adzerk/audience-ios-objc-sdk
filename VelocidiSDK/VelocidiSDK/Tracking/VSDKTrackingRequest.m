#import "VSDKTrackingRequest.h"
#import "VSDKRequest.h"
#import <AFNetworking/AFNetworking.h>

@implementation VSDKTrackingRequest

- (NSMutableURLRequest *)buildRequest {
  NSMutableArray *userIds = [NSMutableArray arrayWithCapacity:1];
  [userIds addObject:self.userId];

  NSURLComponents *url = [self buildURLWithCommonParamsAndUserIds:userIds];

  NSMutableURLRequest *req =
      [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"
                                                    URLString:url.string
                                                   parameters:self.data
                                                        error:nil];
  return req;
}
@end
