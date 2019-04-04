//
//  Subscription.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import "TrackingEvent.h"
#import "Transaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface Subscription : TrackingEvent

@property NSMutableArray *products;
@property Transaction *transaction;

@end

NS_ASSUME_NONNULL_END
