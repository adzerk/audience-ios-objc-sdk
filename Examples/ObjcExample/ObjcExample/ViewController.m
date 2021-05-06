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
}

+ (void)useIDFA:(void (^)(NSString *))completionHandler {
  if (@available(iOS 14, *)) {
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(
                           ATTrackingManagerAuthorizationStatus status) {
      bool isTrackingEnabled = status == ATTrackingManagerAuthorizationStatusAuthorized;
      NSString *idfa = nil;
      if (isTrackingEnabled) {
        idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
      }
      completionHandler(idfa);
    }];
  } else {
    bool isTrackingEnabled = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    NSString *idfa = nil;
    if (isTrackingEnabled) {
      idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    completionHandler(idfa);
  }
}

static int trackingNumber = 0;
static int matchNumber = 0;

- (IBAction)sendTrackingEvent:(id)sender {
  NSDictionary *trackingEvent = @{
    @"clientId" : @"foo",
    @"siteId" : @"bar",
    @"type" : @"appView",
    @"customFields" : @{@"debug" : @"true", @"role" : @"superuser"},
    @"title" : @"Welcome Screen"
  };

  int currentTrNumber = ++trackingNumber;
  [ViewController useIDFA:^(NSString *idfa) {
    if (idfa != nil) {
      VSDKUserId *userId = [[VSDKUserId alloc] initWithId:idfa type:@"idfa"];
      [VSDKVelocidi.sharedInstance track:trackingEvent
          user:userId
          onSuccess:^(NSURLResponse *response, id responseObject) {
            self.mainLabel.text =
                [NSString stringWithFormat:@"Tracking request #%i successful!", currentTrNumber];
          }
          onFailure:^(NSError *error) {
            self.mainLabel.text =
                [NSString stringWithFormat:@"Error with tracking request #%i.\n Error: %@",
                                           currentTrNumber, [error localizedDescription]];
          }];
    } else {
      self.mainLabel.text = @"Could not retrieve IDFA identifier to send as User ID!";
    }
  }];
}

static int customTrackingNumber = 0;

- (IBAction)sendCustomTrackingEvent:(id)sender {
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

  int currCustomTrNumber = ++customTrackingNumber;

  [ViewController useIDFA:^(NSString *idfa) {
    if (idfa != nil) {
      VSDKUserId *userId = [[VSDKUserId alloc] initWithId:idfa type:@"idfa"];
      [VSDKVelocidi.sharedInstance track:trackingEvent
          userId:userId
          onSuccess:^(NSURLResponse *response, id responseObject) {
            self.mainLabel.text = [NSString
                stringWithFormat:@"Custom tracking request #%i successful!", currCustomTrNumber];
          }
          onFailure:^(NSError *error) {
            self.mainLabel.text =
                [NSString stringWithFormat:@"Error with custom tracking request #%i.\n Error: %@",
                                           currCustomTrNumber, [error localizedDescription]];
          }];
    } else {
      self.mainLabel.text = @"Could not retrieve IDFA identifier to send as User ID!";
    }
  }];
}

- (IBAction)sendMatch:(id)sender {
  [ViewController useIDFA:^(NSString *idfa) {
    if (idfa != nil) {
      VSDKUserId *userId1 = [[VSDKUserId alloc] initWithId:idfa type:@"idfa"];
      VSDKUserId *userId2 = [[VSDKUserId alloc] initWithId:@"baz" type:@"foo"];
      NSMutableArray *idsArray = [[NSMutableArray alloc] initWithObjects:userId1, userId2, nil];

      matchNumber++;

      [VSDKVelocidi.sharedInstance match:@"1234-providerId-56789"
          userIds:idsArray
          onSuccess:^(NSURLResponse *response, id responseObject) {
            self.mainLabel.text =
                [NSString stringWithFormat:@"Match request #%i successful!", matchNumber];
          }
          onFailure:^(NSError *error) {
            self.mainLabel.text =
                [NSString stringWithFormat:@"Error with match request #%i.\n Error: %@",
                                           matchNumber, [error localizedDescription]];
          }];
    } else {
      self.mainLabel.text = @"Could not retrieve IDFA identifier to send as User ID!";
    }
  }];
}
@end
