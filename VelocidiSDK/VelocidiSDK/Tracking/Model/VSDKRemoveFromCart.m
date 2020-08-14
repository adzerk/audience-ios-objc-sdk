#import "VSDKProduct.h"
#import "VSDKRemoveFromCart.h"

@implementation VSDKRemoveFromCart

- (instancetype)init {
    if(self = [super init]){
        self.type = @"removeFromCart";
    }
    return self;
}

+ (Class)classForCollectionProperty:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"products"])
        return [VSDKProduct class];
    return nil;
}

@end
