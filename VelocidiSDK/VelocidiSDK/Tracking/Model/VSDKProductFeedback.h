#import "VSDKTrackingEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSDKProductFeedback : VSDKTrackingEvent

/**
  Rating given by the user to the product.
 */
@property float rating;

/**
  Text feedback given by the user to the product.
 */
@property NSString *feedback;

/**
  List of products associated with this product feedback
 */
@property NSMutableArray<VSDKProduct *> *products;

@end

NS_ASSUME_NONNULL_END
