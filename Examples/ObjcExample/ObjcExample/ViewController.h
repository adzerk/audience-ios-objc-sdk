#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property NSString * idfa;
@property Boolean trackingIsAllowed;

//MARK: ACTIONS
- (IBAction)sendTrackingEvent:(id)sender;
- (IBAction)sendCustomTrackingEvent:(id)sender;
- (IBAction)sendMatch:(id)sender;

@end
