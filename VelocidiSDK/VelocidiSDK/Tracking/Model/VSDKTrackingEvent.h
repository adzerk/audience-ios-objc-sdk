//
//  VSDKTrackingEvent.h
//  VelocidiSDK
//
//  Created by Duarte Pinto on 04/04/2019.
//  Copyright © 2019 Velocidi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSDKTrackingEvent : NSObject

@property NSString *clientId;
@property NSString *siteId;
@property NSString *type;

@end

NS_ASSUME_NONNULL_END
