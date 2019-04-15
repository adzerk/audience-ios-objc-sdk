#import "VSDKPurchase.h"

@implementation VSDKPurchase

- (instancetype)init {
    if(self = [super init]){
        self.type = @"purchase";
    }
    return self;
}

@end
