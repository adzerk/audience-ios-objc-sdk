#import "VSDKTotalRefund.h"

@implementation VSDKTotalRefund

- (instancetype)init {
    if(self = [super init]){
        self.refundType = @"total";
    }
    return self;
}

@end
