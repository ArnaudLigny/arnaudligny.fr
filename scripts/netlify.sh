#!/bin/bash -e

echo "Downloading PHPoole"
curl -sSOL https://phpoole.org/phpoole.phar
php phpoole.phar --version
if [ -z "$1" ]; then php phpoole.phar build -q; else echo "URL: $1" && php phpoole.phar build --baseurl=$1 --drafts -q; fi

exit 0
