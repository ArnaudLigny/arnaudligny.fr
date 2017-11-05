echo "Switching to PHP 5.6"
echo "[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc" >> ~/.bashrc
source ~/.phpbrew/bashrc
phpbrew switch 5.6.31

echo "Downloading PHPoole"
curl -sSOL https://phpoole.org/phpoole.phar
# use lib
#phpbrew app get composer
#composer install

echo "Running PHPoole"
php phpoole.phar --version
if [ -z "$1" ]; then php phpoole.phar build; else php phpoole.phar build --baseurl=$1; fi
# use script
#php scripts/build.php -e=prod

exit 0
