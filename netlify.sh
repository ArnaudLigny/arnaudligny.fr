echo "Switching to PHP 5.6"
echo "[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc" >> ~/.bashrc
source ~/.phpbrew/bashrc
phpbrew switch 5.6.31

echo "Downloading PHPoole"
curl -sSOL https://phpoole.org/phpoole.phar

echo "Running PHPoole"
php phpoole.phar version
php phpoole.phar build

exit 0
