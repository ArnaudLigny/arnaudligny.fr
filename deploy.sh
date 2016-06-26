#!/bin/bash
set -e

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"
SITE_DIR="_site"

if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy."
    exit 0
fi

echo -e "Starting to update gh-pages\n"

cp -R $SITE_DIR $HOME/$SITE_DIR
cd $HOME
git config --global user.name "Travis"
git config --global user.email "travis@travis-ci.org"
git clone --quiet --branch=$TARGET_BRANCH https://${GH_TOKEN}@github.com/Narno/arnaudligny.fr.git  gh-pages > /dev/null
cd gh-pages
cp -Rf $HOME/$SITE_DIR/* .
git add -f .
git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
git push -fq origin $TARGET_BRANCH > /dev/null
