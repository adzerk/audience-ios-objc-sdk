#import <Foundation/Foundation.h>


@interface VSDKConfig : NSObject

@property NSString *trackingHost;
@property NSString *matchHost;

- (id)initWithHosts: (NSString *)trackingHost :(NSString *)matchHost;

@end
