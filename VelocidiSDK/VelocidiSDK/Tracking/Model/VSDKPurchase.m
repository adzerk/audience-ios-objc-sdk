#import "VSDKPurchase.h"

@implementation VSDKPurchase

- (id)init {
    if(self = [super init]){
        self.type = @"purchase";
    }
    return self;
}

@end
