#import <Foundation/Foundation.h>


@interface VSDKConfig : NSObject

@property NSString *trackingHost;
@property NSString *matchHost;

- (instancetype)initWithHosts: (NSString *)trackingHost :(NSString *)matchHostURLString;

@end
