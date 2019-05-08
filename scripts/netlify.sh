#!/bin/bash -e

echo "Downloading Cecil"
curl -sSOL https://cecil.app/cecil.phar
php cecil.phar --version

echo "Enabling PHP Intl extension"
php -d extension=intl

echo "Started Cecil build"
if [ -z "$1" ]; then php cecil.phar build --quiet; else echo "URL: $1" && php cecil.phar build --verbose --baseurl=$1 --drafts || { sleep 120; false; }; fi

# build success? can deploy?
if [ $? = 0 ]
then
  echo "Finished Cecil build"
  exit 0
fi

echo "Interrupted Cecil build"
exit 1
