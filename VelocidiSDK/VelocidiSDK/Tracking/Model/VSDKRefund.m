#import "VSDKRefund.h"

@implementation VSDKRefund

- (id)init {
    if(self = [super init]){
        self.type = @"refund";
    }
    return self;
}

@end
