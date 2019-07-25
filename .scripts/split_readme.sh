#!/usr/bin/env sh

# abort on errors
set -e

OUTPUT_DIR=docs/docs_page
TMP=docs/tmp

# clean and copy images
rm -Rf $OUTPUT_DIR
rm -Rf $TMP
mkdir -p $OUTPUT_DIR/docs/img/
mkdir -p $TMP/docs/
mkdir -p $TMP/readme/
cp docs/img/* $OUTPUT_DIR/docs/img/

if ! [ -x "$(command -v jocasta)" ]; then
  echo 'Error: jocasta is not installed. You can install it with `gem install jocasta`.' >&2
  exit 1
fi

# split README into sections
jocasta README.md "$TMP/readme/README.md" 1 "Velocidi iOS SDK in Objective-C" --title "Velocidi iOS SDK in Objective-C"
jocasta README.md "$TMP/docs/Installation.md" 1 "Installation" --title "Installation"
jocasta README.md "$TMP/docs/Setting up the SDK.md" 1 "Setup" --title "Setting up the SDK"
jocasta README.md "$TMP/docs/Send a track event.md" 1 "Send a track event" --title "Send a track event"
jocasta README.md "$TMP/docs/Make a match.md" 1 "Make a match" --title "Make a match"
