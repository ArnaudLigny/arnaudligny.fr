#!/usr/bin/env bash

set -e

if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy"
    exit 0
fi

echo "Deploy to GitHub Pages (branch: '$TARGET_BRANCH')"

cp -R $SITE_DIR $HOME/$SITE_DIR
cd $HOME
git config --global user.name "Travis"
git config --global user.email "contact@travis-ci.org"
git clone --quiet --branch=$TARGET_BRANCH https://${GH_TOKEN}@github.com/${REPO}.git gh-pages > /dev/null
cp -R gh-pages/.git $HOME/.git
rm -rf gh-pages/*
cp -R $HOME/.git gh-pages/.git
cd gh-pages
cp -Rf $HOME/$SITE_DIR/* .
git add -Af .
git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to GitHub Pages"
git push -fq origin $TARGET_BRANCH > /dev/null
