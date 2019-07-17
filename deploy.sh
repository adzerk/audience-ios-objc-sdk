#!/usr/bin/env sh

# abort on errors
set -e

# fetch version
if [ "$#" -le 0 ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

VERSION=$1
DOCS_DIR=docs/docs_page

#clean and copy images
if [ -d "$DOCS_DIR" ]; then rm -Rf $DOCS_DIR; fi
mkdir -p $DOCS_DIR/docs/img/
cp docs/img/* $DOCS_DIR/docs/img/

# build

jazzy \
  --objc \
  --author Velocidi \
  --author_url http://velocidi.com \
  --github_url https://github.com/velocidi/velocidi-ios-objc-sdk \
  --github-file-prefix https://github.com/velocidi/velocidi-ios-objc-sdk/tree/$VERSION \
  --module-version $VERSION \
  --umbrella-header VelocidiSDK/VelocidiSDK/VelocidiSDK.h \
  --framework-root VelocidiSDK/ \
  --module VelocidiSDK \
  --output $DOCS_DIR/ \
  --theme docs/velocidi-jazzy-theme/


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
