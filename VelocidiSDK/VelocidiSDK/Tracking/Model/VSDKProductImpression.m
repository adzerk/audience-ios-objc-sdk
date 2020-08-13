#import "VSDKProduct.h"
#import "VSDKProductImpression.h"

@implementation VSDKProductImpression

- (instancetype)init {
    if(self = [super init]){
        self.type = @"productImpression";
    }
    return self;
}

+ (Class)classForCollectionProperty:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"products"])
        return [VSDKProduct class];
    return nil;
}

@end
