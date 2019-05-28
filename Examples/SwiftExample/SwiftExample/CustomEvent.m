#import "CustomEvent.h"

@implementation CustomEvent

- (instancetype) init {
    if(self = [super init]){
        self.type = @"customEvent";
    }
    return self;
}

@end
