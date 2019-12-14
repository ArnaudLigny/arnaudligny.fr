echo "Downloading Cecil"
if [ -n $CECIL_VERSION ]
then
  curl -LO https://cecil.app/download/$CECIL_VERSION/cecil.phar
else
  curl -LO https://cecil.app/cecil.phar
fi
php cecil.phar --version

if [ -f "./composer.json" ]; then
  echo "Installing theme(s)"
  composer install
fi
