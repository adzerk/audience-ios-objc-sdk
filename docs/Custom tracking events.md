# Create your custom tracking event
If none of the available tracking events matches your needs you can also extend `VSDKTrackingEvent` and create your own. 

__Beware!__ _Custom tracking events might not be interpreted by our services and will have limited functionality (logging and basic statistics). Please try to use one of the existing tracking events model classes or at least inherit from one of those classes when creating a custom event to ensure you make the most out of Velocidi's CDP._

## Objective-C

Create a new Cocoa Touch class that inherits from `VSDKTrackingEvent` (or any of the other tracking event model classes).

Example:

__CustomEvent.h__
```objectivec
#import <VelocidiSDK/VelocidiSDK.h>

@interface CustomEvent : VSDKTrackingEvent

// Place below the desired fields you want to add to the tracking event
@property (nullable) NSString *customField;

@end
```

__CustomEvent.m__
```objectivec
#import "CustomEvent.h"

@implementation CustomEvent

- (instancetype) init {
    if(self = [super init]){
        self.type = @"customEvent"; // Only necessary when inheriting directly from VSDKTrackingEvent
    }
    return self;
}

@end
```

This new class can then be imported and used like any other tracking event:

```objectivec
#import "CustomEvent.h";

...

CustomEvent * trackingEvent =  [[CustomEvent alloc] init];
trackingEvent.clientId = @"RandomSiteId";
trackingEvent.siteId = @"RandomClientId";
trackingEvent.customField = @"RandomCustomField";

[VSDKVelocidi.sharedInstance track: trackingEvent] 
```

## Swift
Due to limitations of the framework we use to serialize classes to JSON ([JSONModel](https://github.com/jsonmodel/jsonmodel)), a Swift class that inherits from `VSDKTrackingEvent` or any tracking event model class won't have its properties serialized when sending the event. To have this functionality you will have to create your custom event in Objective-C and import it into Swift:

1. Create a new Cocoa Touch class.
1. When prompted with the desired language, make sure to choose Objective-C. Press _Next_.

![Xcode Cocoa Touch Modal](./docs/img/xcode-cocoa-touch-modal.png)

1. After creating the class you'll be asked if you want to configure an Objective-C bridging header. Press _Create Bridging Header_.

![Xcode Bridging Header Modal](./docs/img/xcode-bridging-header-warning.png)

4. Three new files should have been created.

![New files created](./docs/img/xcode-bridging-files.png)

5. Import the created custom event class in the bridging header file (_AppName-Bridging-Header.h_):

```objectivec
//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import "CustomEvent.h"
```
6. Add the desired fields to the custom event (see Objective-C instructions for custom events)

1. Use the newly created class as any other tracking event model class:
```swift
let trackingEvent = CustomEvent()
trackingEvent.siteId = "RandomSiteId"
trackingEvent.clientId = "RandomClientId"
trackingEvent.customField = "RandomCustomField"
```

If you had any problem with importing the Objective-C class into Swift, please take a look at Apple's guide on [Importing Objective-C into Swift](https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/importing_objective-c_into_swift).


