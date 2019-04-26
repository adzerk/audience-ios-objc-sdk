#import "VSDKTrackingRequest.h"
#import "VSDKRequest.h"

@implementation VSDKTrackingRequest

- (NSString *) getURLParameters:(NSString *) advertisingIdentifier {
    return [self buildURLParameters:advertisingIdentifier];
}

- (NSDictionary *)getData{
    return self.data.toDictionary;
}
@end
