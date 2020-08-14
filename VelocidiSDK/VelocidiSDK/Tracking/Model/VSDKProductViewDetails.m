#import "VSDKProduct.h"
#import "VSDKProductViewDetails.h"

@implementation VSDKProductViewDetails

- (instancetype)init {
    if(self = [super init]){
        self.type = @"productViewDetails";
    }
    return self;
}

+ (Class)classForCollectionProperty:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"products"])
        return [VSDKProduct class];
    return nil;
}

@end
