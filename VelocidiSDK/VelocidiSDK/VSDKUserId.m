#import "VSDKUserId.h"

@implementation VSDKUserId

- (instancetype)init {
  @throw nil;
}

- (instancetype)initWithId:(NSString *)userId type:(NSString *)userIdType {
  if (self = [super init]) {
    self.type = userIdType;
    self.userId = userId;
  }
  return self;
}

@end
