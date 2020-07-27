#import "VSDKOrderPlace.h"

@implementation VSDKOrderPlace

- (instancetype) init {
    if(self = [super init]){
        self.type = @"orderPlace";
    }
    return self;
}

@end
