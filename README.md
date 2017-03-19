Source of https://arnaudligny.fr, automatically built by [PHPoole](https://phpoole.org) and deployed to [GitHub Pages](https://pages.github.com) through [Travis CI](https://travis-ci.org).

[![Build Status](https://travis-ci.org/Narno/arnaudligny.fr.svg?branch=master)](https://travis-ci.org/Narno/arnaudligny.fr)

## Install & build locally
```bash
composer install
php scripts/build.php -e=dev
```

## HTML code analysis
```bash
npm install htmlhint -g
htmlhint _site
```

## Build & deploy to GitHub Pages
```bash
php scripts/build.php -e=prod
export GH_TOKEN=github_token
sh scripts/deploy/ghpages.sh
```
(Generate a GitHub token: https://github.com/settings/tokens/new)

## Purge Cloudflare cache
```bash
export CLOUDFLARE_API=cloudflare_api
export CLOUDFLARE_EMAIL=cloudflare_email
export CLOUDFLARE_ZONE=cloudflare_zone
sh scripts/deploy/cloudflare.sh
```

## License

Source code is provided under the [MIT License](LICENSE) and [content](content) under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).
