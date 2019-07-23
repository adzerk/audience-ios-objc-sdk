#!/usr/bin/env sh

# abort on errors
set -e

OUTPUT_DIR=docs/docs_page
TMP=docs/tmp

#clean and copy images
if [ -d "$OUTPUT_DIR" ]; then rm -Rf $OUTPUT_DIR; fi
if [ -d "$TMP" ]; then rm -Rf $TMP; fi
if [ -d "$TMP_README_DIR" ]; then rm -Rf $TMP_README_DIR; fi
mkdir -p $OUTPUT_DIR/docs/img/
mkdir -p $TMP/docs/
mkdir -p $TMP/readme/
cp docs/img/* $OUTPUT_DIR/docs/img/

#Split README into sections
.scripts/doc-preprocessor.rb README.md "$TMP/readme/README.md" --section "Velocidi iOS SDK in Objective-C" --title "Velocidi iOS SDK in Objective-C"
.scripts/doc-preprocessor.rb README.md "$TMP/docs/Installation.md" --section "Installation" --title "Installation"
.scripts/doc-preprocessor.rb README.md "$TMP/docs/Setting up the SDK.md" --section "Setup" --title "Setting up the SDK"
.scripts/doc-preprocessor.rb README.md "$TMP/docs/Send a track event.md" --section "Send a track event" --title "Send a track event"
.scripts/doc-preprocessor.rb README.md "$TMP/docs/Make a match.md" --section "Make a match" --title "Make a match"
# build docs
if ! [ -x "$(command -v jazzy)" ]; then
  echo 'Error: jazzy is not installed. You can install it with `gem install jazzy`.' >&2
  exit 1
fi

if ! jazzy -v | grep -q '0.10.0'; then
  echo "\033[0;33mWarning\033[0m: Not using recommended jazzy version. Recommended jazzy version is 0.10.0."
fi

jazzy
