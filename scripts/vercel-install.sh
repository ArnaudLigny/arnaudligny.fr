#!/bin/bash
if [ -z $PHP_VERSION ]; then
  PHP_VERSION='7.4'
fi
echo "================================================================================"
echo "Installing PHP $PHP_VERSION..."
amazon-linux-extras install php$PHP_VERSION
echo "================================================================================"
echo "Installing PHP dependencies..."
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
#yum install -y gettext php-gettext
yum install php-{cli,mbstring,dom,xml,intl,gettext,gd,imagick}
php --version

if [ "$INSTALL_OPTIM" = true ]; then
  echo "================================================================================"
  echo "Installing images optim' lib..."
  yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  yum install jpegoptim
  yum install pngquant
  yum install gifsicle
  yum install libwebp-tools
fi

echo "================================================================================"
echo 'Downloading Cecil...'
if [ -z $CECIL_VERSION ]; then
  curl -sSOL https://cecil.app/cecil.phar
else
  curl -sSOL https://cecil.app/download/$CECIL_VERSION/cecil.phar
fi
php cecil.phar --version

echo "================================================================================"
echo 'Installing theme(s)...'
curl -sS https://getcomposer.org/installer | php
php composer.phar install --prefer-dist --no-dev --no-progress --no-interaction
