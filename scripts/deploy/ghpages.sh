#!/bin/bash -e

if [ -z "$GH_TOKEN" ]; then
  echo "'GH_TOKEN' is not defined"
  exit
fi
if [ -z "$REPO" ]; then
  REPO="ArnaudLigny/arnaudligny.fr"
fi
if [ -z "$TARGET_BRANCH" ]; then
  TARGET_BRANCH="gh-pages"
fi
if [ -z "$SITE_DIR" ]; then
  SITE_DIR="_site"
fi
MESSAGE="Deploy to GitHub Pages (branch: $TARGET_BRANCH)"

# in case of script is run by Travis CI
if [ "$TRAVIS" = "true" ]
then
  if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
      echo "Skipping deploy"
      exit 0
  fi
  git config --global user.name "Travis"
  git config --global user.email "contact@travis-ci.org"
  MESSAGE="$MESSAGE (Travis build: $TRAVIS_BUILD_NUMBER)"
fi

echo "$MESSAGE"

cd $SITE_DIR
rm -rf .git
git init
git add .
git commit -m "$MESSAGE"
git push -fq https://${GH_TOKEN}@github.com/${REPO}.git master:$TARGET_BRANCH > /dev/null
