#!/usr/bin/env sh

# abort on errors
set -e

.scripts/split_readme.sh

# build docs
if ! [ -x "$(command -v jazzy)" ]; then
  echo 'Error: jazzy is not installed. You can install it with `gem install jazzy`.' >&2
  exit 1
fi

if ! jazzy -v | grep -q '0.13.6'; then
  echo "\033[0;33mWarning\033[0m: Not using recommended jazzy version. Recommended jazzy version is 0.13.6."
fi

jazzy
