#import "VSDKRefund.h"

@implementation VSDKRefund

- (instancetype)init {
    if(self = [super init]){
        self.type = @"refund";
    }
    return self;
}

@end
