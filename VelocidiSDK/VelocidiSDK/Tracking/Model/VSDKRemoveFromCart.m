#import "VSDKRemoveFromCart.h"

@implementation VSDKRemoveFromCart

- (id)init {
    if(self = [super init]){
        self.type = @"removeFromCart";
    }
    return self;
}

@end
