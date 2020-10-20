#import <Foundation/Foundation.h>
#import <VSDKIdfaUtil.h>
#import <AdSupport/ASIdentifierManager.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

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
    
    bool trackingIsAllowed = false;
    if (@available(iOS 14, *)) {
        trackingIsAllowed = [ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusAuthorized;
    } else {
        trackingIsAllowed = [self.identifierManager isAdvertisingTrackingEnabled];
    }
    
    
    if (trackingIsAllowed) {
        return [[self.identifierManager advertisingIdentifier] UUIDString];
        
    } else if (errorPtr) {
        NSString *trackingNotAllowedErrordomain = @"com.velocidi.VSDKTrackingNotAllowedError";
        NSString *trackingNotAllowedDescKey = NSLocalizedString(@"Operation cannot be completed. Tracking is not allowed", nil);
        NSString *trackingNotAllowedReasonKey = nil;
        if (@available(iOS 14, *)) {
            trackingNotAllowedReasonKey = NSLocalizedString(@"The user has not opted-in to tracking or it has not yet been prompted.)", nil);
        } else {
            trackingNotAllowedReasonKey = NSLocalizedString(@"The user has opted-out of tracking (Limited Ad Tracking is enabled in the user's device)", nil);
        }
        
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

