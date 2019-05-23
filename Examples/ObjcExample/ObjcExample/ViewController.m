#import "ViewController.h"
@import VelocidiSDK;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

static int trackingNumber = 0;

- (IBAction)sendTrackingEvent:(id)sender {
    
    VSDKTrackingEvent * trackingEvent =  [[VSDKPageView alloc] init];
    trackingEvent.clientId = @"foo";
    trackingEvent.siteId = @"bar";
    
    int currentTrNumber = trackingNumber++;
    
    [VSDKVelocidi.sharedInstance track: trackingEvent onSuccess: ^(NSURLResponse * response, id responseObject){
        self.mainLabel.text = [NSString stringWithFormat: @"Tracking request #%i successful!", currentTrNumber];
    } onFailure: ^(NSError * error){
        self.mainLabel.text = [NSString stringWithFormat: @"Error with tracking request #%i.\n Error: %@", currentTrNumber, [error localizedDescription]];
    }];
}
@end
