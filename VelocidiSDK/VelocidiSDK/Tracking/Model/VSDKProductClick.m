#import "VSDKProduct.h"
#import "VSDKProductClick.h"

@implementation VSDKProductClick

- (instancetype)init {
    if(self = [super init]){
        self.type = @"productClick";
    }
    return self;
}

+ (Class)classForCollectionProperty:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"products"])
        return [VSDKProduct class];
    return nil;
}

@end
