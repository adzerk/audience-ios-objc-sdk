#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

//MARK: ACTIONS
- (IBAction)sendTrackingEvent:(id)sender;

@end
