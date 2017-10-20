echo "Switching to PHP 5.6"
echo "[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc" >> ~/.bashrc
source ~/.phpbrew/bashrc
phpbrew switch 5.6.31

echo "Installing Composer"
phpbrew app get composer
php composer install

echo "Running build"
php scripts/build.php -e=prod

exit 0
