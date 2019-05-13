source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
workspace 'VelocidiSDK.xcworkspace'

use_frameworks!

target "VelocidiSDK" do
  project 'VelocidiSDK/VelocidiSDK.xcodeproj'
  pod 'AFNetworking', '~> 3.2.1'
  pod 'JSONModel', '~> 1.8'

  target "VelocidiSDKTests" do
    # inherit! :search_paths # Can't figure out how to use this setting, enabled in settings in other examples
    # target "VelocidiSDKTests"

    pod 'Quick', '~> 2.0'
    pod 'Nimble', '~> 8.0.1'
    pod 'Mockingjay'
  end
end
