#import "ViewController.h"
#import <AdSupport/ASIdentifierManager.h>
@import VelocidiSDK;
@import AppTrackingTransparency;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  self.trackingIsAllowed = false;
  if (@available(iOS 14, *)) {
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(
                           ATTrackingManagerAuthorizationStatus status) {
      self.trackingIsAllowed =
          status == ATTrackingManagerAuthorizationStatusAuthorized;
      if (self.trackingIsAllowed) {
        self.idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier]
            UUIDString];
      }
    }];
  } else {
    self.trackingIsAllowed =
        [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    if (self.trackingIsAllowed) {
      self.idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier]
          UUIDString];
    }
  }
}

static int trackingNumber = 0;
static int matchNumber = 0;

- (IBAction)sendTrackingEvent:(id)sender {
  if (self.trackingIsAllowed) {
    NSMutableDictionary *trackingEvent =
        [NSMutableDictionary dictionaryWithCapacity:1];
    trackingEvent[@"type"] = @"appView";
    trackingEvent[@"siteId"] = @"foo";
    trackingEvent[@"clientId"] = @"bar";

    NSMutableDictionary *customFields =
        [NSMutableDictionary dictionaryWithCapacity:1];
    customFields[@"debug"] = @"true";
    customFields[@"role"] = @"superuser";

    trackingEvent[@"customFields"] = customFields;
    trackingEvent[@"title"] = @"Welcome Screen";

    int currentTrNumber = ++trackingNumber;

    VSDKUserId *userId = [[VSDKUserId alloc] initWithId:self.idfa type:@"idfa"];
    [VSDKVelocidi.sharedInstance track:trackingEvent
        user:userId
        onSuccess:^(NSURLResponse *response, id responseObject) {
          self.mainLabel.text =
              [NSString stringWithFormat:@"Tracking request #%i successful!",
                                         currentTrNumber];
        }
        onFailure:^(NSError *error) {
          self.mainLabel.text = [NSString
              stringWithFormat:@"Error with tracking request #%i.\n Error: %@",
                               currentTrNumber, [error localizedDescription]];
        }];
  } else {
    self.mainLabel.text =
        @"Could not retrieve IDFA identifier to send as User ID!";
  }
}

static int customTrackingNumber = 0;

- (IBAction)sendCustomTrackingEvent:(id)sender {
  if (self.trackingIsAllowed) {
    // clang-format off
    NSString *trackingEvent = @"\
    {\
      \"clientId\": \"bar\",\
      \"siteId\": \"foo\",\
      \"type\": \"custom\",\
      \"customFields\": {\
        \"key\": \"value\"\
      },\
      \"customType\": \"custom-type\"\
    }\
    ";
    // clang-format on

    __attribute__((annotate(
        "oclint:suppress[long variable name]"))) int currentCustomTrNumber =
        ++customTrackingNumber;

    VSDKUserId *userId = [[VSDKUserId alloc] initWithId:self.idfa type:@"idfa"];
    [VSDKVelocidi.sharedInstance track:trackingEvent
        userId:userId
        onSuccess:^(NSURLResponse *response, id responseObject) {
          self.mainLabel.text = [NSString
              stringWithFormat:@"Custom tracking request #%i successful!",
                               currentCustomTrNumber];
        }
        onFailure:^(NSError *error) {
          self.mainLabel.text = [NSString
              stringWithFormat:
                  @"Error with custom tracking request #%i.\n Error: %@",
                  currentCustomTrNumber, [error localizedDescription]];
        }];
  } else {
    self.mainLabel.text =
        @"Could not retrieve IDFA identifier to send as User ID!";
  }
}
- (IBAction)sendMatch:(id)sender {
  if (self.trackingIsAllowed) {
    VSDKUserId *userId1 = [[VSDKUserId alloc] initWithId:self.idfa
                                                    type:@"idfa"];
    VSDKUserId *userId2 = [[VSDKUserId alloc] initWithId:@"baz" type:@"foo"];
    NSMutableArray *idsArray =
        [[NSMutableArray alloc] initWithObjects:userId1, userId2, nil];

    matchNumber++;

    [VSDKVelocidi.sharedInstance match:@"1234-providerId-56789"
        userIds:idsArray
        onSuccess:^(NSURLResponse *response, id responseObject) {
          self.mainLabel.text = [NSString
              stringWithFormat:@"Match request #%i successful!", matchNumber];
        }
        onFailure:^(NSError *error) {
          self.mainLabel.text = [NSString
              stringWithFormat:@"Error with match request #%i.\n Error: %@",
                               matchNumber, [error localizedDescription]];
        }];
  } else {
    self.mainLabel.text =
        @"Could not retrieve IDFA identifier to send as User ID!";
  }
}
@end
