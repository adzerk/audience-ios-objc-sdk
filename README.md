# Velocidi iOS SDK in Objective-C 
![Cocoapods platforms](https://img.shields.io/cocoapods/p/VelocidiSDK.svg)
![Cocoapods](https://img.shields.io/cocoapods/v/VelocidiSDK.svg)
[![Build Status](https://travis-ci.com/velocidi/velocidi-ios-objc-sdk.svg?branch=master)](https://travis-ci.com/velocidi/velocidi-ios-objc-sdk)
[![codecov](https://codecov.io/gh/velocidi/velocidi-ios-objc-sdk/branch/master/graph/badge.svg)](https://codecov.io/gh/velocidi/velocidi-ios-objc-sdk)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Velocidi's Objective-C SDK to integrate with iOS apps.

_SDK development in the early stages. Not ready for production. Use it at your own risk._

## Installation
### Installation with CocoaPods
To integrate VelocidiSDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```yaml
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.1'
project 'MyProject.xcodeproj'

target "MyProject" do
  pod 'VelocidiSDK', '~> 0.0.1'
end
```

Then, run:

```bash
$ pod install
```

### Installation with Carthage

To integrate VelocidiSDK into your Xcode project using CocoaPods, specify it in your `Cartfile`:

```
github "velocidi/velocidi-ios-objc-sdk" ~> 0.0.1
```

Then, run `carthage` to build the framework and drag the built VelocidiSDK.framework into your Xcode project.

## Requirements

VelocidiSDK should work with any version of iOS equal or bigger than 11.0.

## Usage

### Setup

Initialize the VelocidiSDK with the necessary `trackingHost` and the `matchHost` URLs. Without this, VelocidiSDK will not work. We suggest doing this when the application launches.

__Swift__
```swift
import VelocidiSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let config = VSDKConfig(hosts: "https://tr.yourdomain.com", "https://match.yourdomain.com")!
        VSDKVelocidi.start(config)
        return true
    }
```

__Objective-C__
```objc
@import VelocidiSDK;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    VSDKConfig * config = [[VSDKConfig alloc] initWithHosts:@"https://tr.yourdomain.com": @"https://match.yourdomain.com"];
    [VSDKVelocidi start: config];
    return YES;
}
```

### Send a track event

In order to send a tracking event, create an instance of `VSDKTrackingEvent`. Then, call the singleton instance of `VSDKVelocidi` and use the `track` method.

__Swift__
```swift
import VelocidiSDK

...

let trackingEvent = VSDKPageView()
trackingEvent.siteId = "RandomSiteId"
trackingEvent.clientId = "RandomClientId"

VSDKVelocidi.sharedInstance().track(trackingEvent)
```

__Objective-C__
```objc
@import VelocidiSDK;

...

VSDKTrackingEvent * trackingEvent =  [[VSDKPageView alloc] init];
trackingEvent.clientId = @"RandomSiteId";
trackingEvent.siteId = @"RandomClientId";

[VSDKVelocidi.sharedInstance track: trackingEvent] 
```


You can also pass callback blocks that will be called when the request either succeeds or fails.

__Swift__
```swift
VSDKVelocidi.sharedInstance().track(trackingEvent, onSuccess:{ (response: URLResponse, responseObject: Any) in
  print("Success! Response: \(response)")
}, onFailure:{(error: Error) in
  print("Failed! Error: \(error.localizedDescription)")
})
```

__Objective-C__
```objc
[VSDKVelocidi.sharedInstance track: trackingEvent onSuccess: ^(NSURLResponse * response, id responseObject){
    NSLog(@"Success! Response: %@", trackingNumber);
} onFailure: ^(NSError * error){
    NSLog(@"Failed! Error: %@", [error localizedDescription]);
}];
```

#### Available tracking events model classes
* VSDKAddToCart
* VSDKPageView
* VSDKProductClick
* VSDKProductCustomization
* VSDKProductFeedback
* VSDKProductImpression
* VSDKProductView
* VSDKProductViewDetails
* VSDKPurchase
* VSDKRefund
* VSDKRemoveFromCart
* VSDKSearch
* VSDKSubscription

#### Create your custom tracking event
If none of the available tracking events matches your needs you can also extend `TrackingEvent` and create your own. 

__Beware!__ _Custom tracking events are not interpreted by our services and bring limited functionality other than logging and basic statistics._

_TODO_

##### Objective-C

Create a new CocoaTouch class that inherits from `VSDKTrackingEvent` (or any of the other tracking event model classes)

Example:

__CustomEvent.h__
```objc
#import <VelocidiSDK/VelocidiSDK.h>

@interface CustomEvent : VSDKTrackingEvent

// Place bellow the desired fields you want to add to the tracking event
@property (nullable) NSString *customField;

@end
```

__CustomEvent.h__
```objc
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

This new class can then be imported and used like any other tracking event

```objc
#import "CustomEvent.h";

...

CustomEvent * trackingEvent =  [[CustomEvent alloc] init];
trackingEvent.clientId = @"RandomSiteId";
trackingEvent.siteId = @"RandomClientId";
trackingEvent.customField = @"RandomCustomField";

[VSDKVelocidi.sharedInstance track: trackingEvent] 
```


