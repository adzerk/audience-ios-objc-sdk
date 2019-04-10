#import "VSDKSubscription.h"

@implementation VSDKSubscription

- (id)init {
    if(self = [super init]){
        self.type = @"subscription";
    }
    return self;
}

@end
