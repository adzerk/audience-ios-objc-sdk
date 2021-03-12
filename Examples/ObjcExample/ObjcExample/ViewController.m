#import "ViewController.h"
#import "CustomEvent.h"
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
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            self.trackingIsAllowed = status == ATTrackingManagerAuthorizationStatusAuthorized;
        }];
    } else {
        self.trackingIsAllowed = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    }
    
    if (self.trackingIsAllowed) {
        self.idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
}

static int trackingNumber = 0;
static int matchNumber = 0;

- (IBAction)sendTrackingEvent:(id)sender {
    if (self.trackingIsAllowed) {
        VSDKTrackingEvent * trackingEvent =  [[VSDKPageView alloc] init];
        trackingEvent.clientId = @"foo";
        trackingEvent.siteId = @"bar";

        int currentTrNumber = ++trackingNumber;

        VSDKUserId * userId = [[VSDKUserId alloc] initWithId:self.idfa type: @"idfa"];
        [VSDKVelocidi.sharedInstance track: trackingEvent userId: userId onSuccess: ^(NSURLResponse * response, id responseObject) {
            self.mainLabel.text = [NSString stringWithFormat: @"Tracking request #%i successful!", currentTrNumber];
        } onFailure: ^(NSError * error){
            self.mainLabel.text = [NSString stringWithFormat: @"Error with tracking request #%i.\n Error: %@", currentTrNumber, [error localizedDescription]];
        }];
    } else {
        self.mainLabel.text = @"Could not retrieve IDFA identifier to send as User ID!";
    }
}

static int customTrackingNumber = 0;

- (IBAction)sendCustomTrackingEvent:(id)sender {
    if (self.trackingIsAllowed) {
        CustomEvent * trackingEvent =  [[CustomEvent alloc] init];
        trackingEvent.clientId = @"foo";
        trackingEvent.siteId = @"bar";
        trackingEvent.customField = @"baz";

        int currentCustomTrNumber = ++customTrackingNumber;

        VSDKUserId * userId = [[VSDKUserId alloc] initWithId:self.idfa type: @"idfa"];
        [VSDKVelocidi.sharedInstance track: trackingEvent userId: userId onSuccess: ^(NSURLResponse * response, id responseObject) {
            self.mainLabel.text = [NSString stringWithFormat: @"Custom tracking request #%i successful!", currentCustomTrNumber];
        } onFailure: ^(NSError * error){
            self.mainLabel.text = [NSString stringWithFormat: @"Error with custom tracking request #%i.\n Error: %@", currentCustomTrNumber, [error localizedDescription]];
        }];
    } else {
        self.mainLabel.text = @"Could not retrieve IDFA identifier to send as User ID!";
    }
}
- (IBAction)sendMatch:(id)sender {
    if (self.trackingIsAllowed) {
        VSDKUserId * userId1 =  [[VSDKUserId alloc] initWithId:self.idfa type:@"idfa"];
        VSDKUserId * userId2 =  [[VSDKUserId alloc] initWithId: @"baz" type:@"foo"];
        NSMutableArray * idsArray = [[NSMutableArray alloc] initWithObjects: userId1, userId2, nil];

        matchNumber++;
        
        [VSDKVelocidi.sharedInstance match: @"1234-providerId-56789"
                                   userIds: idsArray
                                 onSuccess: ^(NSURLResponse * response, id responseObject){
            self.mainLabel.text = [NSString stringWithFormat: @"Match request #%i successful!",
                                   matchNumber];
        } onFailure: ^(NSError * error){
            self.mainLabel.text = [NSString stringWithFormat: @"Error with match request #%i.\n Error: %@", matchNumber, [error localizedDescription]];
        }];
    } else {
        self.mainLabel.text = @"Could not retrieve IDFA identifier to send as User ID!";
    }
}
@end
