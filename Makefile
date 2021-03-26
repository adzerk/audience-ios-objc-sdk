XCARGS := -workspace VelocidiSDK.xcworkspace \
		-sdk "iphonesimulator" \
    -destination "platform=iOS Simulator,OS=14.4,name=iPhone 11 Pro Max" \
    GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO

all: clean build

clean:
	set -o pipefail && xcodebuild $(XCARGS) -scheme VelocidiSDK  clean | xcpretty

build:
	set -o pipefail && xcodebuild $(XCARGS) -scheme VelocidiSDK build | xcpretty

test:
	set -o pipefail && xcodebuild $(XCARGS) -scheme VelocidiSDK test | xcpretty

examples: install-examples build-objc-example build-swift-example

install-examples:
	pod install --project-directory=Examples/

build-objc-example:
	set -o pipefail && xcodebuild $(XCARGS) -scheme ObjcExample clean build | xcpretty

build-swift-example:
	set -o pipefail && xcodebuild $(XCARGS) -scheme SwiftExample clean build | xcpretty

install:
	pod install

prerequisites:
	.scripts/prerequisites.sh

oclint:
	set -o pipefail && \
	xcodebuild -scheme VelocidiSDK -sdk iphoneos -workspace VelocidiSDK.xcworkspace clean && \
	xcodebuild -scheme VelocidiSDK -sdk iphoneos -workspace VelocidiSDK.xcworkspace COMPILER_INDEX_STORE_ENABLE=NO | xcpretty -r json-compilation-database --output compile_commands.json && \
	oclint-json-compilation-database -exclude Pods -exclude build -- -report-type xcode -max-priority-3=15000

swiftlint:
	Pods/SwiftLint/swiftlint lint --fix && Pods/SwiftLint/swiftlint lint --strict

podlint:
	pod lib lint --verbose
