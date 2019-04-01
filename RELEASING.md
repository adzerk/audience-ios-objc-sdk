# Releasing Velocidi Objective-C SDK

_This is still a draft of the process, it needs verification and a test run in a clean environment to verify everything is in place._

0. Make sure travis build passed and that the coverage is at an acceptable level.
1. Check if the Podspec lints correctly. `$ pod lib lint VelocidiSDK.podspec`
1. Choose the version number. Both [CocoaPods](https://guides.cocoapods.org/making/making-a-cocoapod.html#cocoapods-versioning-specifics) and [Carthage](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#version-requirement) use a form of [Semantic Versioning](https://semver.org/).
1. Edit the file __VelocidiSDK.podspec__ with the choosen version number:
    ```yaml
    spec.name         = ...
    spec.version      = 0.0.1 # New version number
    spec.summary      = ...
    ```
1. Edit the CHANGELOG.md
1. Commit the changes. 
1. Tag the commit.`$ git tag 0.1.0 && git push --tags`
1. Head over to [Github Releases](https://github.com/velocidi/velocidi-ios-objc-sdk/releases), select the pushed tag, and add the copy for the new release from the Changelog to the release body. Give it the title of `vX.Y.Z` and click "Publish Release".
1. Deploy the library to CocoaPods. `$ pod trunk push VelocidiSDK.podspec`
