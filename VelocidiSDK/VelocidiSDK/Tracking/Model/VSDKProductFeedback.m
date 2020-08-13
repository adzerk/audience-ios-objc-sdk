#import "VSDKProduct.h"
#import "VSDKProductFeedback.h"

@implementation VSDKProductFeedback

- (instancetype)init {
    if(self = [super init]){
        self.type = @"productFeedback";
    }
    return self;
}

+ (Class)classForCollectionProperty:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"products"])
        return [VSDKProduct class];
    return nil;
}

@end
