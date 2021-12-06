#!/bin/bash

echo "================================================================================"
# prod
if [ -z $VERCEL_URL ]; then
  php cecil.phar build -v --config=config_prod.yml
# preview
else
  php cecil.phar build -vv --baseurl=https://$VERCEL_URL
  echo "URL: https://$VERCEL_URL"
fi

# build success? can deploy?
if [ $? = 0 ]; then
  exit 0
fi
echo "Build fail."; exit 1
