#!/usr/bin/env sh

# abort on errors
set -e

# build docs website
.scripts/build_docs.sh

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
