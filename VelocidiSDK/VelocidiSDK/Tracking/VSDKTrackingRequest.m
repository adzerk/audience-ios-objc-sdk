#import "VSDKTrackingRequest.h"
#import "VSDKRequest.h"

@implementation VSDKTrackingRequest

- (NSMutableURLRequest *) buildRequest: (NSString*) advertisingIdentifier {
    NSURLComponents * url = [self buildURLWithQueryParameters: advertisingIdentifier];

    return [[AFJSONRequestSerializer serializer] requestWithMethod: @"POST"
                                                         URLString: url.string
                                                        parameters: self.data.toDictionary
                                                             error: nil];
}
@end
