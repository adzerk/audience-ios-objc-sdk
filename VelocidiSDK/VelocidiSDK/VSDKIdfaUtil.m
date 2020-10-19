#import <Foundation/Foundation.h>
#import <VSDKIdfaUtil.h>
#import <AdSupport/ASIdentifierManager.h>

@implementation VSDKIdfaUtil

- (ASIdentifierManager *) getIdentifierManager{ return [ASIdentifierManager sharedManager]; }

+ (VSDKIdfaUtil *)sharedInstance {
    static VSDKIdfaUtil *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
     
    return _sharedInstance;
}

- (NSString *) tryGetIDFA :(NSError **)errorPtr {
    if ([self.identifierManager isAdvertisingTrackingEnabled]) {
        return [[self.identifierManager advertisingIdentifier] UUIDString];
        
    } else if (errorPtr) {
        NSString *trackingNotAllowedErrordomain = @"com.velocidi.VSDKTrackingNotAllowedError";
        NSString *trackingNotAllowedDescKey = NSLocalizedString(@"Operation cannot be completed. Tracking is not allowed", nil);
        NSString *trackingNotAllowedReasonKey = NSLocalizedString(@"The user has opted-out of ad tracking (Limited Ad Tracking is enabled in the user's device)", nil);
        *errorPtr = [NSError errorWithDomain: trackingNotAllowedErrordomain
                                        code: 1
                                    userInfo: @{
                                                NSLocalizedDescriptionKey: trackingNotAllowedDescKey,
                                                NSLocalizedFailureReasonErrorKey: trackingNotAllowedReasonKey}];
        return nil;
    } else {
        return nil;
    }
}

@end

