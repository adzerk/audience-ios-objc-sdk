source 'https://cdn.cocoapods.org/'
platform :ios, '10.0'
workspace 'VelocidiSDK.xcworkspace'

use_frameworks!

target "VelocidiSDK" do
  project 'VelocidiSDK/VelocidiSDK.xcodeproj'
  pod 'AFNetworking', '~> 4.0.0', :inhibit_warnings => true
  pod 'JSONModel', '~> 1.8.0', :inhibit_warnings => true

  target "VelocidiSDKTests" do
    inherit! :complete

    pod 'SwiftLint'
    pod 'Quick', '~> 2.0', :inhibit_warnings => true # Quick 3 raises the xcode version requirement to v11
    pod 'Nimble', '~> 8.0' # Nimble 9 raises the xcode version requirement to v11
    pod 'Mockingjay'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
