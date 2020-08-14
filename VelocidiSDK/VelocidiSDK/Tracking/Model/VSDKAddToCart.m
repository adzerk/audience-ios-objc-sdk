#import "VSDKAddToCart.h"
#import "VSDKProduct.h"

@implementation VSDKAddToCart

- (instancetype)init {
    if(self = [super init]){
        self.type = @"addToCart";
    }
    return self;
}

+ (Class)classForCollectionProperty:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"products"])
        return [VSDKProduct class];
    return nil;
}

@end
