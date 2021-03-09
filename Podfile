source 'https://cdn.cocoapods.org/'
platform :ios, '11.0'
workspace 'VelocidiSDK.xcworkspace'

use_frameworks!

target "VelocidiSDK" do
  project 'VelocidiSDK/VelocidiSDK.xcodeproj'
  pod 'AFNetworking', '~> 4.0.0'
  pod 'JSONModel', '~> 1.8.0'

  target "VelocidiSDKTests" do
    # inherit! :search_paths # Can't figure out how to use this setting, enabled in settings in other examples
    # target "VelocidiSDKTests"

    pod 'Quick', '~> 3.1.0'
    pod 'Nimble', '~> 8.0' # Nimble 9 raises the xcode version requirement to v11
    pod 'Mockingjay'
  end
end
