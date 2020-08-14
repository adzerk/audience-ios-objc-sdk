#import "VSDKProduct.h"
#import "VSDKProductCustomization.h"

@implementation VSDKProductCustomization

- (instancetype)init {
    if(self = [super init]){
        self.type = @"productCustomization";
    }
    return self;
}

+ (Class)classForCollectionProperty:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"products"])
        return [VSDKProduct class];
    return nil;
}

@end
