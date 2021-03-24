XCARGS := -workspace VelocidiSDK.xcworkspace \
    -scheme VelocidiSDK \
    -destination "platform=iOS Simulator,OS=13.7,name=iPhone 11 Pro Max" \
    GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO

all: clean build test

clean:
	set -o pipefail && xcodebuild $(XCARGS) clean | xcpretty

build:
	set -o pipefail && xcodebuild $(XCARGS) build | xcpretty

test:
	set -o pipefail && xcodebuild $(XCARGS) test | xcpretty

install:
	pod install

oclint:
	source ~/.bash_profile
	set -o pipefail && \
	xcodebuild -scheme VelocidiSDK -sdk iphoneos -workspace VelocidiSDK.xcworkspace clean && \
	xcodebuild -scheme VelocidiSDK -sdk iphoneos -workspace VelocidiSDK.xcworkspace COMPILER_INDEX_STORE_ENABLE=NO | xcpretty -r json-compilation-database --output compile_commands.json && \
	oclint-json-compilation-database -exclude Pods -exclude build -- -report-type xcode -max-priority-3=15000

swiftlint:
	.scripts/swiftlint.sh
