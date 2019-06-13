#import "VSDKUserId.h"

@implementation VSDKUserId

- (instancetype)initUserId: (NSString *)userId
                          : (NSString *)type  {
    if(self = [super init]){
        self.type = type;
        self.userId = userId;
    }
    return self;
}

@end
