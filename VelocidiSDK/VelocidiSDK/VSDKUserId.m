#import "VSDKUserId.h"

@implementation VSDKUserId

- (instancetype)init {
    @throw nil;
}

- (instancetype)initWithId: (NSString *)userId
                      type: (NSString *)userIdType {
    
    if ([userId length] <= 0) {
        NSException* ex = [NSException
                exceptionWithName:@"InvalidArgument"
                reason:@"id must not be empty!"
                userInfo:nil];
        @throw ex;
    }
    
    if ([userIdType length] <= 0) {
        NSException* ex = [NSException
                exceptionWithName:@"InvalidArgument"
                reason:@"type must not be empty!"
                userInfo:nil];
        @throw ex;
    }
    
    if (self = [super init]) {
        self.type = userIdType;
        self.userId = userId;
    }
    return self;
}

@end
