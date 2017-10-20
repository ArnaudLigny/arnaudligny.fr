echo "Switching to PHP 5.6"
echo "[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc" >> ~/.bashrc
source ~/.phpbrew/bashrc
phpbrew switch 5.6.31

echo "Downloading PHPoole"
#curl -sSOL https://phpoole.org/phpoole.phar
phpbrew app get composer
composer install

echo "Running PHPoole"
#php phpoole.phar --version
#php phpoole.phar build
php scripts/build.php -e=prod

exit 0
