#!/bin/bash

if [ -z $CECIL_VERSION ]; then
  echo "Downloading Cecil..."
  curl -sSOL https://cecil.app/cecil.phar
else
  echo "Downloading Cecil ${CECIL_VERSION}..."
  curl -sSOL https://cecil.app/download/$CECIL_VERSION/cecil.phar
fi

if [ -f "./composer.json" ]; then
  echo "Installing themes..."
  composer install
fi
