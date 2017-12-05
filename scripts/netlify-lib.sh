echo "Switching to PHP 5.6"
echo "[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc" >> ~/.bashrc
source ~/.phpbrew/bashrc
phpbrew switch 5.6.31

echo "Install dependencies"
phpbrew app get composer
composer install

echo "Build with PHPoole lib"
php scripts/build.php -e=prod

exit 0
