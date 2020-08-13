#import "VSDKProduct.h"

@implementation VSDKProduct

- (instancetype)init {
    if ( self = [super init] ) {
        self.quantity = 1;
    }
    return self;
}

+ (Class)classForCollectionProperty:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"parts"])
        return [VSDKProduct class];
    return nil;
}

@end
