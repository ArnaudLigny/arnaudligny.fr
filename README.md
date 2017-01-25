Source code of https://arnaudligny.fr.

The website is automatically built and deployed through [Travis CI](https://travis-ci.org/Narno/arnaudligny.fr/).

[![Build Status](https://travis-ci.org/Narno/arnaudligny.fr.svg?branch=master)](https://travis-ci.org/Narno/arnaudligny.fr)

## Install, build & deploy
```
$ composer install
$ php build.php -e=prod
$ export GH_TOKEN=your_github_token
$ sh deploy.sh
```

## Test locally
```
$ php build.php -e=dev
```
