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
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let config = VSDKConfig(hosts: "http://tr.yourdomain.com", "http://match.yourdomain.com")!
        VSDKVelocidi.start(config)
        return true
    }
```

### Send a track event

In order to sent a tracking event, create an instance of TrackingEvent. Then, call the singleton instance of `VSDKVelocidi` and use the method `track`

__Swift__
```swift
let trackingEvent = VSDKPageView()
trackingEvent.siteId = "RandomSiteId"
trackingEvent.clientId = "RandomClientId"

VSDKVelocidi.sharedInstance().track(trackingEvent)
```

You can also pass callback blocks that will that will be called when the request is successful or if if fails.

__Swift__
```swift

VSDKVelocidi.sharedInstance().track(trackingEvent, onSuccess:{ (response: URLResponse, responseObject: Any) in
  print("Success! Response: \(response)")
}, onFailure:{(error: Error) in
  print("Failed! Error: \(error.localizedDescription)")
})
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

<!-- #### Create your custom tracking event -->
<!-- If you none of the available tracking events matches your needs you can also extend `TrackingEvent` and create your own.  -->

<!-- _Beware! Custom tracking events are not interpreted by our services and bring limitied functionality other than logging and basic statistics._ -->

<!-- _TODO_ -->

<!-- __Objective-C__  -->
