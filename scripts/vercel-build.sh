#!/bin/bash

echo "================================================================================"
if [[ $VERCEL_ENV == "production" ]]; then
  $cmd="cecil.phar build -v --config=config_prod.yml --postprocess"
else
  $cmd="cecil.phar build -v --drafts"
fi

if [ -z $VERCEL_URL ]; then
    php $cmd
  else
    php $cmd --baseurl=https://$VERCEL_URL
    echo "URL: https://$VERCEL_URL"
  fi

# build success? can deploy?
if [ $? = 0 ]; then
  exit 0
fi
echo "Build fail."; exit 1
