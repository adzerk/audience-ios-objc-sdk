#!/usr/bin/env sh

FAILED=false

if ! which xcodebuild >/dev/null; then
  echo "xcodebuild does not seem to be installed. You can install it by installing Xcode from the App Store."
  FAILED=true
fi

if ! which pod >/dev/null; then
  echo "Cocoapods does not seem to be installed. You may need to run 'gem install cocoapods'."
  FAILED=true
fi

if ! which xcpretty >/dev/null; then
  echo "xcpretty does not seem to be installed. You may need to run 'gem install xcpretty'."
  FAILED=true
fi

if ! which clang-format >/dev/null; then
  echo "clang-format does not seem to be installed. You may need to run 'brew install clang-format'."
  FAILED=true
fi

if ! command -v Pods/SwiftLint/swiftlint &> /dev/null; then
  echo "Swiftlint does not seem to be installed. You may need to run 'pod install'."
  FAILED=true
fi

if ! which oclint >/dev/null; then
  echo "oclint does not seem to be installed. You may need to run 'brew tap oclint/formulae && brew install oclint'."
  FAILED=true
fi

if $FAILED; then
  exit 1
fi

echo "All required dependencies are installed!"
