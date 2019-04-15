#import "VSDKRemoveFromCart.h"

@implementation VSDKRemoveFromCart

- (instancetype)init {
    if(self = [super init]){
        self.type = @"removeFromCart";
    }
    return self;
}

@end
