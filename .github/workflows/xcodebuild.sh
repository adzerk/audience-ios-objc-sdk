#!/usr/bin/env sh

xcodebuild -showsdks

set -o pipefail && xcodebuild \
-workspace $WORKSPACE \
-scheme $SCHEME \
-sdk "iphonesimulator$TEST_SDK" \
-destination "platform=iOS Simulator,OS=${TEST_SDK},name=${TEST_DEVICE}" \
GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
GCC_GENERATE_TEST_COVERAGE_FILES=YES \
CODE_SIGN_IDENTITY="" \
CODE_SIGNING_REQUIRED=NO \
"$@" | xcpretty --color
