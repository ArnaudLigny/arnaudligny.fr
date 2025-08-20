---
title: Déployer un site créé avec Cecil sur Cloudflare Pages
date: 2021-03-04
updated: 2023-01-12
tags:
  - Cecil
  - hébergement
years: [2021]
image: /images/2021-03-04-deployer-un-site-cree-avec-cecil-sur-cloudflare-pages/twitter-shared-link-18.png
image_header: false
typora-root-url: ../../static
published: true
---
[Cecil](https://cecil.app/) est un outil en ligne de commande permettant de générer un site statique en combinant des templates [Twig](https://twig.symfony.com) et des contenus formatés en [Markdown](https://daringfireball.net/projects/markdown/).

Dans ce guide vous allez créer un nouveau site avec Cecil et le déployer en utilisant [Cloudflare Pages](https://pages.cloudflare.com).
<!-- break -->

## Installer Cecil

Cecil est écrit en PHP, ce qui signifie que vous aurez besoin que PHP version 7+ soit installé pour exécuter l’application.

| OS      | Commande                  |
| ------- | ------------------------- |
| Linux   | `apt-get install php-cli` |
| macOS   | `brew install php`        |
| Windows | `choco install php`       |

Une fois PHP installé, vous pouvez télécharger Cecil :

```bash
curl -LO https://cecil.app/cecil.phar
```

## Créer un nouveau site

Une fois `cecil.phar` téléchargé, vous pouvez créer un nouveau site :

```bash
php cecil.phar new:site my-cecil-site
```

Vous pouvez également ajouter un thème à votre nouveau site. Il existe quelques thèmes disponibles ici : https://cecil.app/themes/.

## Créer un dépôt GitHub

Créer un nouveau dépôt GitHub via [repo.new](https://repo.new), puis « pousser » votre site local sur ce dépôt :

```bash
git remote add origin https://github.com/yourgithubusername/githubrepo
git branch -M main
git push -u origin main
```

## Déployer avec Cloudflare Pages

### Script de génération

Commencez par télécharger le script [`build.sh`](https://gist.githubusercontent.com/ArnaudLigny/6b2aa9e6b25581c96435e9296efe0c0e/raw/build.sh) et placez le à la racine de votre site.

Vous pouvez ensuite déployer votre site sur Cloudflare Pages en vous rendant sur le tableau de bord et en créant un nouveau site.

### Configuration

Sélectionnez le nouveau dépôt GitHub que vous avez créé précédemment puis, dans la section configuration, fournissez les informations suivantes.

| Configuration de version | Valeur |
| ----------------------- | ------- |
| Branche de production   | `main`  |
| Commande de génération  | `sh ./build.sh` |
| Dossier du site généré | `_site` |

| Nom de la variable | Valeur |
| ------------------ | ------ |
| `PHP_VERSION`      | `7.4`  |

### Déploiement

Une fois que vous avez configuré votre site, vous pouvez effectuer votre premier déploiement.  
Vous devriez voir Cloudflare Pages télécharger Cecil, installer les thèmes, et générer votre site, avant de le déployer.

> Pour le guide complet de déploiement de votre premier site sur Cloudflare Pages, consultez [le quide de démarrage officiel](https://developers.cloudflare.com/pages/getting-started).

Après avoir déployé votre site, vous obtiendrez un sous-domaine unique pour votre projet sur `pages.dev`. De plus, à chaque fois que vous effectuerez une modification sur votre site, Cloudflare Pages régénéra automatiquement votre site et le déploiera.

![cloudflare-pages](/images/2021-03-04-deployer-un-site-cree-avec-cecil-sur-cloudflare-pages/cloudflare-pages.png)

Enfin, à chaque nouvelle *pull request* une URL d’[aperçu](https://developers.cloudflare.com/pages/platform/preview-deployments) vous sera fourni afin de prévisualiser les changements effectués avant de les déployer en production.
