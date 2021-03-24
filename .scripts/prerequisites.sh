#!/usr/bin/env sh

if ! which xcodebuild >/dev/null; then
  echo "xcodebuild does not seem to be installed. You can install it by installing Xcode from the App Store."
  exit 1
fi

if ! which pod >/dev/null; then
  echo "Cocoapods does not seem to be installed. You may need to run 'gem install cocoapods'."
  exit 1
fi

if ! which xcpretty >/dev/null; then
  echo "xcpretty does not seem to be installed. You may need to run 'gem install xcpretty'."
  exit 1
fi

if ! command -v Pods/SwiftLint/swiftlint &> /dev/null
then
    echo "Swiftlint does not seem to be installed. You may need to run 'pod install'."
    exit 1
fi

if ! which oclint >/dev/null; then
  echo "oclint does not seem to be installed. You may need to run 'brew tap oclint/formulae && brew install oclint'."
  exit 1
fi

echo "All required dependencies are installed!"
