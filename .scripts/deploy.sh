#!/usr/bin/env sh

# abort on errors
set -e

DOCS_DIR=docs/docs_page

#clean and copy images
if [ -d "$DOCS_DIR" ]; then rm -Rf $DOCS_DIR; fi
mkdir -p $DOCS_DIR/docs/img/
cp docs/img/* $DOCS_DIR/docs/img/

# build docs
if ! [ -x "$(command -v jazzy)" ]; then
  echo 'Error: jazzy is not installed. You can install it with `gem install jazzy`.' >&2
  exit 1
fi

if ! jazzy -v | grep -q '0.10.0'; then
  echo "\033[0;33mWarning\033[0m: Not using recommended jazzy version. Recommended jazzy version is 0.10.0."
fi

jazzy

# navigate into the build output directory
cd $DOCS_DIR/

# if you are deploying to a custom domain
echo 'ios.developers.velocidi.com' > CNAME

git init
git add -A

git commit -m 'deploy'

# if you are deploying to https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git master

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:velocidi/velocidi-ios-objc-sdk.git master:gh-pages

cd -
