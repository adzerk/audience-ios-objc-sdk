# Velocidi iOS SDK in Objective-C
![Cocoapods platforms](https://img.shields.io/cocoapods/p/VelocidiSDK.svg)
![Cocoapods](https://img.shields.io/cocoapods/v/VelocidiSDK.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

VelocidiSDK is Velocidi's Objective-C SDK to integrate with iOS apps.

# Installation
## Installation with CocoaPods
To integrate VelocidiSDK into your Xcode project using [CocoaPods](https://cocoapods.org/), specify it in your `Podfile`:

```yaml
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.1'
project 'MyProject.xcodeproj'

target "MyProject" do
  pod 'VelocidiSDK', '~> 0.3.2'
end
```

Then, run:

```bash
$ pod install
```

## Installation with Carthage

To integrate VelocidiSDK into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "velocidi/velocidi-ios-objc-sdk" ~> 0.3.2
```

Then, run `carthage` to build the framework and drag the built VelocidiSDK.framework into your Xcode project.

## Requirements

VelocidiSDK should work with any version of iOS equal or bigger than 11.0.

# Setup

Initialize the VelocidiSDK with the necessary `trackingBaseUrl` and the `matchBaseUrl` URLs. Without this, VelocidiSDK will not work. We suggest doing this when the application launches.

__Swift__
```swift
import VelocidiSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let config = VSDKConfig(trackingBaseUrl: "https://tr.yourdomain.com", matchBaseUrl:"https://match.yourdomain.com")!
        VSDKVelocidi.start(config)
        return true
    }
```

__Objective-C__
```objectivec
@import VelocidiSDK;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    VSDKConfig * config = [[VSDKConfig alloc] initWithTrackingBaseUrl:@"https://tr.yourdomain.com" matchBaseUrl: @"https://match.yourdomain.com"];
    [VSDKVelocidi start: config];
    return YES;
}
```

# Send a track event

A tracking event will log a user action in Velocidi's CDP.

In order to send a tracking event, create a JSON string representation of the event type you wish to send (or a equivalent `NSDictionary` representation) and call the `track` method.

__Swift__
```swift
import VelocidiSDK

...

let trackingEvent =
"""
{
  "clientId": "bar",
  "siteId": "foo",
  "type": "appView",
  "customFields": {
    "debug": "true",
    "role": "superuser"
  },
  "title": "Welcome Screen"
}
"""

// OR

var trackingEvent = [String: Any]()
trackingEvent["type"] = "appView"
trackingEvent["siteId"] = "foo"
trackingEvent["clientId"] = "bar"

var customFields = [String: Any]()
customFields["debug"] = "true"
customFields["role"] = "superuser"

trackingEvent["customFields"] = customFields
trackingEvent["title"] = "Welcome Screen"

let userId = VSDKUserId(id: "user-idfa", type: "idfa")
VSDKVelocidi.sharedInstance().track(trackingEvent, userId: userId)
```

__Objective-C__
```objectivec
@import VelocidiSDK;

...

NSString * trackingEvent =  @"\
{\
  \"clientId\": \"bar\",\
  \"siteId\": \"foo\",\
  \"type\": \"appView\",\
  \"customFields\": {\
    \"debug\": \"true\",\
    \"role\": \"superuser\"\
  },\
  \"title\": \"Welcome Screen\"\
}\
";

// OR

NSMutableDictionary *trackingEvent =  [NSMutableDictionary dictionaryWithCapacity:1];
trackingEvent[@"type"] = @"appView";
trackingEvent[@"siteId"] = @"foo";
trackingEvent[@"clientId"] = @"bar";

NSMutableDictionary *customFields =  [NSMutableDictionary dictionaryWithCapacity:1];
customFields[@"debug"] = @"true";
customFields[@"role"] = @"superuser";

trackingEvent[@"customFields"] = customFields;
trackingEvent[@"title"] = @"Welcome Screen";

VSDKUserId * userId = [[VSDKUserId alloc] initWithId:@"user-idfa" type: @"idfa"];
[VSDKVelocidi.sharedInstance track: trackingEvent userId: userId]
```

Please refer to https://docs.velocidi.com/collect/events to discover which event types and schemas are supported.

You can also pass callback blocks that will be called when the request either succeeds or fails.

__Swift__
```swift
VSDKVelocidi.sharedInstance().track(trackingEvent, userId: userId, onSuccess:{ (response: URLResponse, responseObject: Any) in
  print("Success! Response: \(response)")
}, onFailure:{(error: Error) in
  print("Failed! Error: \(error.localizedDescription)")
})
```

__Objective-C__
```objectivec
[VSDKVelocidi.sharedInstance track: trackingEvent userId: userId onSuccess: ^(NSURLResponse * response, id responseObject){
    NSLog(@"Success! Response: %@", trackingNumber);
} onFailure: ^(NSError * error){
    NSLog(@"Failed! Error: %@", [error localizedDescription]);
}];
```

There is a big list of [tracking event classes](https://developers.velocidi.com/ios-sdk/tracking-model-classes-list.html) to choose from. If none of them fits the desired action, you can also create your own [custom tracking event](https://developers.velocidi.com/ios-sdk/custom-tracking-events.html)

# Make a match

Match requests are used to link multiple identifiers in Velocidi's CDP. This way, any action made with any of the identifiers, across multiple channels (Browser, Mobile App, ...), can be associated to the same user.

In VelocidiSDK, a match request will link together all the provided user ids:

__Swift__
```swift
@IBAction func sendMatchEvent(_ sender: Any) {
    let userId1 = VSDKUserId(userId: "bar", "fooType")
    let userId2 = VSDKUserId(userId: "baz", "fooType")
    let idsArray = NSMutableArray(array: [userId1, userId2])

    VSDKVelocidi.sharedInstance().match("1234-providerId-56789", userIds: idsArray, onSuccess:{ (response: URLResponse, responseObject: Any) in
        print("Success! Response: \(response)")
    }, onFailure:{(error: Error) in
        print("Failed! Error: \(error.localizedDescription)")
    })
}
```

__Objective-C__
```objectivec
- (IBAction)sendMatch:(id)sender {
    VSDKUserId * userId1 =  [[VSDKUserId alloc] initUserId:@"bar":@"fooType"];
    VSDKUserId * userId2 =  [[VSDKUserId alloc] initUserId:@"baz":@"fooType"];
    NSMutableArray * idsArray = [[NSMutableArray alloc] initWithObjects: userId1, userId2, nil];

    [VSDKVelocidi.sharedInstance match: @"1234-providerId-56789"
                               userIds: idsArray
                             onSuccess: ^(NSURLResponse * response, id responseObject){
        NSLog(@"Success! Response: %@", trackingNumber);
    } onFailure: ^(NSError * error){
        NSLog(@"Failed! Error: %@", [error localizedDescription]);
    }];
```

# iOS 14 and collecting IDs

In iOS 14, Apple changed their privacy guidelines and APIs. We recommend reading Apple's
instructions on [User Privacy and Data Use](https://developer.apple.com/app-store/user-privacy-and-data-use/).

Due to those changes the VelocidiSDK no longer uses the IDFA by default and instead requires the developer to explicitly define an ID to 
identify the user. It is up to the developer to choose which user IDs to use, taking in consideration that the ID type should be supported by 
the CDP system. Refer to https://docs.velocidi.com/collect/user-ids/#default-id-types for currently supported IDs.

## Using your own first-party ID
You can use any first-party ID with [VSDKUserId](https://ios.developers.velocidi.com/Classes/VSDKUtil.html), as exemplified in
[Make a Match](#Make-a-match) and [Send a tracking event](#Send-a-tracking-event).

## Using the IDFV
The [Identifier for Vendor (IDFV)](https://developer.apple.com/documentation/uikit/uidevice/1620059-identifierforvendor) is an ID that is shared amongst apps from
the same vendor in the same device. It allows a vendor to uniquely identify a user's device, without relying on the device-wide IDFA, and its respective limitations.

__Swift__
```swift
let idfv = UIDevice.current.identifierForVendor!.uuidString
let userId = VSDKUserId(id: idfv, type: "idfv")
```

__Objective-C__
```objectivec
NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
VSDKUserId *userId = [[VSDKUserId alloc] initWithId:idfv type:@"idfv"];
```

## Using the IDFA
If you are using the Identifier for Advertisers (IDFA) to identify the user, please make sure to read Apple's instructions on
[User Privacy and Data Use](https://developer.apple.com/app-store/user-privacy-and-data-use/) and be sure that your use case is compliant with Apple's guidelines.

The following examples should provide a general approach on retrieving the IDFA, but we recommend reading Apple's documentation on how to use the [App Tracking Transparency framework](https://developer.apple.com/documentation/apptrackingtransparency?language=objc).

Using the IDFA requires explicit authorization from the user for each application. To do so, start by establishing the message that will be presented to the user in the permission dialog. This can be done by adding the __NSUserTrackingUsageDescription__ key to the Info.plist file of the application. The value of this key will be the message presented.

![tracking usage description entry](./docs/ios14_prompt_message.png)

Before starting to send events, we have to request access to the IDFA, and only if that permission is granted, can we send events with
the IDFA. If the user has not given permission yet, this might show the permission dialog box with the message previously set.

__Swift__
```swift
import AppTrackingTransparency
import AdSupport

func useIDFA(completionHandler: (Bool, String) -> Void) {
  if #available(iOS 14, *) { // After iOS 14, we request the IDFA to the AppTrackingTransparency framework
    ATTrackingManager.requestTrackingAuthorization { status in
      let isTrackingEnabled = status == .authorized
      var idfa: String? = nil
      if isTrackingEnabled {
        idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
      }
      completionHandler(idfa)
    }
  } else { // On older devices, we can access the IDFA directly
    let isTrackingEnabled = ASIdentifierManager.shared().isAdvertisingTrackingEnabled
    var idfa: String? = nil

    if isTrackingEnabled {
      idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    completionHandler(idfa)
  }
}
```

__Objective-C__
```objectivec
#import <AdSupport/ASIdentifierManager.h>
@import AppTrackingTransparency;

- (void)useIDFA:(void (^)(NSString *))completionHandler {
  if (@available(iOS 14, *)) { // After iOS 14, we request the IDFA to the AppTrackingTransparency framework
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(
                           ATTrackingManagerAuthorizationStatus status) {
      bool isTrackingEnabled = status == ATTrackingManagerAuthorizationStatusAuthorized;
      NSString *idfa = nil;
      if (isTrackingEnabled) {
        idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
      }
      completionHandler(idfa);
    }];
  } else { // On older devices, we can access the IDFA directly
    bool isTrackingEnabled = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    NSString *idfa = nil;
    if (isTrackingEnabled) {
      idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    completionHandler(idfa);
  }
}
```

Once we established a method of requesting permission for using the IDFA, we just have to call it and provide a completion handler where we are creating the event.

__Swift__
```swift
useIDFA(completionHandler: { (idfaOpt) in
  if let idfa = idfaOpt {
    let userId = VSDKUserId(id: idfa, type: "idfa")
    // ...
  }
})
```

__Objective-C__
```objectivec
[self useIDFA:^(NSString *idfa) {
  if (idfa != nil) {
    VSDKUserId *userId = [[VSDKUserId alloc] initWithId:idfa type:@"idfa"];
    // ...
  }
}];
```

# Need Help?

You can find more information about Velocidi's Private CDP at https://docs.velocidi.com.

Please report bugs or issues to https://github.com/velocidi/velocidi-ios-objc-sdk/issues or send us an email to engineering@velocidi.com.
