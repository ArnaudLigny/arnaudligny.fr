echo "Switching to PHP 5.6"
echo "[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc" >> ~/.bashrc
source ~/.phpbrew/bashrc
#phpbrew known
phpbrew switch 7.1.11

echo "Downloading PHPoole"
curl -sSOL https://phpoole.org/phpoole.phar

echo "Running PHPoole"
php phpoole.phar --version
if [ -z "$1" ]; then php phpoole.phar build; else echo "URL: $1" && php phpoole.phar build --baseurl=$1 --drafts; fi

exit 0
