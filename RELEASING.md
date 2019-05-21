# Releasing Velocidi Objective-C SDK

_This is still a draft of the process, it needs verification and a test run in a clean environment to verify everything is in place._

0. Make sure travis build passed and that the coverage is at an acceptable level.
1. Choose the version number. Both [CocoaPods](https://guides.cocoapods.org/making/making-a-cocoapod.html#cocoapods-versioning-specifics) and [Carthage](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#version-requirement) use a form of [Semantic Versioning](https://semver.org/).
1. Go to _VelocidiSDK_ folder.

    `$ cd VelocidiSDK`

1. Edit the version number and increment the build number using agvtool (more info [here](https://developer.apple.com/library/archive/qa/qa1827/_index.html)):
    1. __Version number__:

        `$ agvtool new-marketing-version <your_specific_version>`

    1. __Build number__:
    
        `$ agvtool next-version -all`

1. Go back to the project's root folder.

    `$ cd ..`

1. Edit the file __VelocidiSDK.podspec__ with the chosen version number:

    ```yaml
    spec.name         = ...
    spec.version      = 0.0.1 # New version number
    spec.summary      = ...
    ```

1. Edit the CHANGELOG.md
1. Commit the changes. 
1. Tag the commit.

`$ git tag 0.1.0 && git push --tags`

1. Head over to [Github Releases](https://github.com/velocidi/velocidi-ios-objc-sdk/releases), select the pushed tag, and add the copy for the new release from the Changelog to the release body. Give it the title of `vX.Y.Z` and click "Publish Release".
1. Deploy the library to CocoaPods. `$ pod trunk push VelocidiSDK.podspec`
