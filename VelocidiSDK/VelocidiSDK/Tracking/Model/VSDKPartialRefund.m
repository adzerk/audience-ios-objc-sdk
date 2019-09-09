#import "VSDKPartialRefund.h"

@implementation VSDKPartialRefund

- (instancetype)init {
    if(self = [super init]){
        self.refundType = @"partial";
    }
    return self;
}

@end
