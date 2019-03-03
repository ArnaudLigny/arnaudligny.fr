#!/bin/bash -e

echo "Downloading Cecil"
curl -SOL https://www.dropbox.com/s/tn0240fh4axpdg7/cecil.phar?dl=1
php cecil.phar --version

echo "Started Cecil build"
if [ -z "$1" ]; then php cecil.phar build --quiet; else echo "URL: $1" && php cecil.phar build --baseurl=$1 --drafts; fi
echo "Finished Cecil build"

exit 0
