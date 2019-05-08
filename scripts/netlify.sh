#!/bin/bash -e

echo "Downloading Cecil"
curl -sSOL https://cecil.app/cecil.phar
php cecil.phar --version

echo "Add PHP Intl extensions"
php -d extension=intl

echo "Started Cecil build"
if [ -z "$1" ]; then php cecil.phar build --verbose; else echo "URL: $1" && php cecil.phar build --baseurl=$1 --drafts; fi
# build success? can deploy?
if [ $? = 0 ]
then
  echo "Finished Cecil build"
  bash scripts/deploy.sh
else
  exit 1
fi

exit 0
