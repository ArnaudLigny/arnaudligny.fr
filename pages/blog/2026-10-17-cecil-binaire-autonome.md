---
title: Cecil disponible en binaire autonome, sans PHP
description: "Depuis la version 9.11.0, Cecil est aussi distribué sous forme
  d’un exécutable unique embarquant PHP, construit avec phpacker et StaticPHP :
  de quoi builder un site sur Cloudflare Pages ou Render."
date: 2026-10-17
tags:
  - Cecil
  - SSG
  - PHP
years:
  - 2026
published: true
typora-root-url: ../../assets
typora-copy-images-to: ../../assets/images/${filename}
---
Depuis la version 9.11.0, [Cecil est également disponible en binaire autonome](https://cecil.app/fr/actualites/2026/10/14/cecil-disponible-en-binaire-autonome/) : un unique fichier exécutable qui embarque PHP et les extensions nécessaires. Plus besoin d’installer PHP pour générer un site.

Ce chantier dormait à l’état de brouillon depuis un bon moment. Il est désormais stable, et les binaires sont construits, testés et publiés automatiquement à chaque release.

## Pourquoi un binaire ?

Cecil est écrit en PHP. Jusqu’ici, pour l’utiliser, il fallait donc disposer de PHP (8.3 minimum depuis [Cecil 9](/blog/cecil-9.0.0-sections-imbriquees/)) avec les bonnes extensions, puis récupérer le fichier `cecil.phar`, passer par Composer ou un gestionnaire de paquets.

Sur un poste de développeur, c’est rarement un problème. Ça l’est bien davantage sur les plateformes d’hébergement Jamstack, dont les environnements de build ne fournissent pas PHP, ou seulement une version obsolète :

- [Cloudflare Pages](https://pages.cloudflare.com) ne fournit pas PHP ;
- [Render](https://render.com) ne propose que PHP 7.3.

Avec le binaire, ces plateformes redeviennent utilisables : il suffit de télécharger un fichier et de l’exécuter.

## Comment l’utiliser ?

Les binaires sont attachés à chaque [release GitHub](https://github.com/Cecilapp/Cecil/releases), pour cinq plateformes :


| Plateforme          | Fichier                 |
| ------------------- | ----------------------- |
| Linux x64           | `cecil-linux-x64`       |
| Linux ARM64         | `cecil-linux-arm64`     |
| macOS Intel         | `cecil-macos-x64`       |
| macOS Apple Silicon | `cecil-macos-arm64`     |
| Windows x64         | `cecil-windows-x64.exe` |


Par exemple, sous Linux :

```bash
curl -Lo cecil https://github.com/Cecilapp/Cecil/releases/latest/download/cecil-linux-x64
chmod +x cecil
./cecil new:site mon-site
./cecil build mon-site
```

> Sous macOS, les binaires ne sont pas encore signés : il faut retirer l’attribut de quarantaine avant la première exécution avec `xattr -d com.apple.quarantine cecil`.

## phpacker et StaticPHP

Ce binaire est rendu possible par [phpacker](https://phpacker.dev), un outil qui empaquette une application PHP (ici le fichier `cecil.phar`) avec un exécutable PHP pour chaque plateforme cible.

Ces exécutables PHP sont eux-mêmes produits par [StaticPHP](https://static-php.dev), qui compile PHP de manière statique, avec ses extensions et leurs bibliothèques, pour obtenir un binaire sans aucune dépendance système.

La configuration côté Cecil tient dans un petit fichier `phpacker.json` :

```json
{
    "src": "./dist/cecil.phar",
    "dest": "./dist/build",
    "ini": "./phpacker.ini",
    "platform": "all",
    "php": "8.4",
    "repository": "Cecilapp/php-bin"
}
```

La clé `repository` pointe vers [mon propre fork](https://github.com/Cecilapp/php-bin) du dépôt de binaires PHP de phpacker. Il m’a permis d’ajouter les bibliothèques dont Cecil a besoin : l’extension `gd` avec `freetype`, `libjpeg`, `libpng`, `libwebp` et `libavif` pour le traitement des images, `intl` pour les dates localisées et les traductions, et `exif` pour les métadonnées des images.

## Un workflow GitHub dédié

La construction des binaires est intégrée au [workflow de release](https://github.com/Cecilapp/Cecil/blob/main/.github/workflows/release.yml#L143) de Cecil, déclenché à la publication d’une release :

1. le job `build` génère le fichier `cecil.phar` ;
2. le job `package` installe phpacker, construit les binaires des cinq plateformes, calcule leurs empreintes SHA-256 (`cecil-binaries.sha256`) et génère une attestation de provenance ;
3. le job `package_test` exécute chaque binaire sur un *runner* de la plateforme correspondante (Ubuntu x64 et ARM, macOS Intel et Apple Silicon, Windows) : il crée un site de démonstration, le génère, et vérifie au passage que le traitement d’images via GD est bien opérationnel ;
4. les binaires sont enfin attachés à la release.

L’attestation permet de vérifier qu’un binaire a bien été produit par ce workflow :

```bash
gh attestation verify cecil --repo Cecilapp/Cecil
```

## Déployer sur Cloudflare Pages

Le [script de build](https://cecil.app/build.sh), utilisé pour [déployer sur les plateformes Jamstack](https://cecil.app/fr/documentation/deployer/plateformes-jamstack/), en tire parti automatiquement : si PHP n’est pas installé, ou dans une version inférieure à 8.3, il télécharge le binaire correspondant à la plateforme, vérifie son empreinte, puis l’utilise pour générer le site.

Sur Cloudflare Pages, la configuration se résume donc à :

- *Framework preset* : `None`
- *Build command* : `curl -sSOL https://cecil.app/build.sh && bash ./build.sh`
- *Build output directory* : `_site`

D’ailleurs, une copie du site de Cecil est générée et hébergée sur Cloudflare Pages : [https://cloudflare.cecil.app](https://cloudflare.cecil.app).

## Quelques limitations

Le binaire couvre l’essentiel des usages, avec toutefois quelques limites :

- les images sont traitées uniquement avec GD (ni Imagick, ni libvips) ;
- la commande `self-update` n’est pas disponible : pour mettre à jour, il faut télécharger le nouveau binaire ;
- la commande `serve` s’appuie sur le serveur web intégré de PHP et nécessite donc une installation locale de PHP. Sans PHP, il suffit de lancer `build` puis de servir le dossier `_site` avec un autre serveur web.

Le fichier `cecil.phar`, Composer et les gestionnaires de paquets restent évidemment proposés.

## Pour aller plus loin

- Annonce : [https://cecil.app/fr/actualites/2026/10/14/cecil-disponible-en-binaire-autonome/](https://cecil.app/fr/actualites/2026/10/14/cecil-disponible-en-binaire-autonome/)
- Déployer sur les plateformes Jamstack : [https://cecil.app/fr/documentation/deployer/plateformes-jamstack/](https://cecil.app/fr/documentation/deployer/plateformes-jamstack/)
- phpacker : [https://phpacker.dev](https://phpacker.dev)
- StaticPHP : [https://static-php.dev](https://static-php.dev)

