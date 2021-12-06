#!/bin/bash

echo "================================================================================"
if [[ $VERCEL_ENV == "production" ]]; then
  if [ -z $VERCEL_URL ]; then
    php cecil.phar build -v --config=config_prod.yml --postprocess
  else
    php cecil.phar build -v --baseurl=https://$VERCEL_URL --config=config_prod.yml --postprocess
    echo "URL: https://$VERCEL_URL"
  fi
else
  if [ -z $VERCEL_URL ]; then
    php cecil.phar build -v --drafts
  else
    php cecil.phar build -v --baseurl=https://$VERCEL_URL --drafts
    echo "URL: https://$VERCEL_URL"
  fi
fi

# build success? can deploy?
if [ $? = 0 ]; then
  exit 0
fi
echo "Build fail."; exit 1
