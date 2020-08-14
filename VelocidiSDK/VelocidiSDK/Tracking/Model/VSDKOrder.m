#import "VSDKOrder.h"

@implementation VSDKOrder

+ (Class)classForCollectionProperty:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"promotions"])
        return [NSString class];
    return nil;
}

@end
