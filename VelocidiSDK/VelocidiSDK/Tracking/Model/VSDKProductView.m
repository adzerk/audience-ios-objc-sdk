#import "VSDKProduct.h"
#import "VSDKProductView.h"

@implementation VSDKProductView

- (instancetype)init {
    if(self = [super init]){
        self.type = @"productView";
    }
    return self;
}

+ (Class)classForCollectionProperty:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"products"])
        return [VSDKProduct class];
    return nil;
}

@end
