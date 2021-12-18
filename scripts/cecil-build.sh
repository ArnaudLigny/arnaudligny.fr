#!/bin/bash

# Test if PHP is installed
php --version > /dev/null 2>&1
PHP_IS_INSTALLED=$?
if [[ $PHP_IS_INSTALLED -ne 0 ]]; then
  echo "PHP is not installed. Please install it before running this script."
  exit 1;
fi
PHP_OK=$(php -r 'echo (bool) version_compare(phpversion(), "7.1.3", ">=");')
if [[ $PHP_OK != "" ]]; then
  echo "PHP version is not compatible. Please install PHP 7.1.3 or higher."
  exit 1;
fi
# Force PHP version
if [ -z $PHP_VERSION ]; then
  PHP_VERSION="7.4"
fi

# Test if Cecil is installed
cecil --version > /dev/null 2>&1
CECIL_IS_INSTALLED=$?

# Test if Composer is installed
composer --version > /dev/null 2>&1
COMPOSER_IS_INSTALLED=$?

# Cecil is not installed
CECIL_CMD="cecil"
if [[ $CECIL_IS_INSTALLED -ne 0 ]]; then
  echo "Installing Cecil"
  if [ -z $CECIL_VERSION ]; then
    curl -sSOL https://cecil.app/cecil.phar
  else
    curl -sSOL https://cecil.app/download/$CECIL_VERSION/cecil.phar
  fi
  CECIL_CMD="php cecil.phar"
else
  echo "$($CECIL_CMD --version) is already installed"
fi

# Composer is not installed
COMPOSER_CMD="composer"
if [[ $COMPOSER_IS_INSTALLED -ne 0 ]]; then
  echo "Installing Composer"
  curl -sS https://getcomposer.org/installer | php
  COMPOSER_CMD="php composer.phar"
else
  echo "$($COMPOSER_CMD --version) is already installed"
fi
if [ -f "./composer.json" ]; then
  echo "Installing theme(s)"
  $COMPOSER_CMD install --prefer-dist --no-dev --no-progress --no-interaction --quiet
fi

# Running on
if [[ "NETLIFY" == "true" ]]; then
  RUNNING_ON="Netlify"
fi
if [[ "VERCEL" == "1" ]]; then
  RUNNING_ON="Vercel"
fi
case $RUNNING_ON in
  "Netlify")
    if [[ "CONTEXT" == "production" ]]; then
      URL=$URL
    else
      URL=$DEPLOY_PRIME_URL
    fi
    ;;
  "Vercel")
    URL=$VERCEL_URL
    if [[ "VERCEL_ENV" == "production" ]]; then
      CONTEXT="production"
    fi
    ;;
  "Netlify" | "Vercel")
    #
    ;;
  *)
    #
    ;;
esac

# Context
CMD_OPTIONS="-v"
if [[ "CONTEXT" == "production" ]]; then
  CMD_OPTIONS+=" --postprocess"
else
  CMD_OPTIONS+=" --drafts"
fi

# Run build
$CECIL_CMD build --baseurl=$URL $CMD_OPTIONS

# Build success? Can deploy?
if [ $? = 0 ]; then
  exit 0
fi
echo "Build fail."; exit 1
