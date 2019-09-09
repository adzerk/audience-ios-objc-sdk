#import "VSDKTrackingEvent.h"
@class VSDKTransaction;
@class VSDKProduct;

/**
  Tracking event model class that represents a `Refund` event
 */
@interface VSDKRefund : VSDKTrackingEvent

/** 
  Type of refund 
  A refund can be either `partial` or `total`
 */
@property (nullable) NSString *refundType;

/**
  If it is a `partial` refund, the list of products to be refunded must be specified
 */
@property (nullable) NSMutableArray<VSDKProduct *> *products;

/**
  Transaction associated with this refund
 */
@property (nullable) VSDKTransaction *transaction;

@end
