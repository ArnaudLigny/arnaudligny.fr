## Build

```bash
php scripts/build.php -e=prod
```

## Deploy

### Netlify
```bash
cd _site
npm install netlify-cli -g
netlify init
netlify deploy
```

### GitHub Pages
```bash
export GH_TOKEN=github_token
sh scripts/deploy/ghpages.sh
```
([Create a GitHub token](https://github.com/settings/tokens/new?scopes=repo&description=PHPoole+deploy))

#### Purge Cloudflare cache
```bash
export CLOUDFLARE_API=cloudflare_api
export CLOUDFLARE_EMAIL=cloudflare_email
export CLOUDFLARE_ZONE=cloudflare_zone
sh scripts/deploy/cloudflare.sh
```
