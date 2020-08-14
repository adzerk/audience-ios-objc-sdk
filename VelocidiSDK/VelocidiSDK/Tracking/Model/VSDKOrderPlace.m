#import "VSDKLineItem.h"
#import "VSDKOrderPlace.h"

@implementation VSDKOrderPlace

- (instancetype) init {
    if(self = [super init]){
        self.type = @"orderPlace";
    }
    return self;
}

+ (Class)classForCollectionProperty:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"lineItems"])
        return [VSDKLineItem class];
    return nil;
}

@end
