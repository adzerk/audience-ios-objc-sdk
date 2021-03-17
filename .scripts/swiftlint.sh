#!/usr/bin/env sh


if ! command -v Pods/SwiftLint/swiftlint &> /dev/null
then
    echo "Swiftlint does not seem to be installed. You may need to run 'pod install'."
    exit
fi


if [ -z "$1" ]
then
    Pods/SwiftLint/swiftlint lint --fix && Pods/SwiftLint/swiftlint lint --strict
else
    Pods/SwiftLint/swiftlint lint "$1" --fix && Pods/SwiftLint/swiftlint lint "$1" --strict
fi
