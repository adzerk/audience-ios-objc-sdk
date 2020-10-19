#import <Foundation/Foundation.h>

@class ASIdentifierManager;

NS_ASSUME_NONNULL_BEGIN

@interface VSDKIdfaUtil : NSObject

@property (readonly, getter=getIdentifierManager) ASIdentifierManager *identifierManager;

+ (VSDKIdfaUtil *)sharedInstance;

- (NSString *) tryGetIDFA :(NSError **)anError;

@end


NS_ASSUME_NONNULL_END
