---
title: "Publication automatique d’une extension Chrome ou Firefox"
date: 2019-05-26
tags: Développement
image: /images/store_developer_dashboard.png
published: false
typora-root-url: ../../static
---

Ces dernières années j’ai développé quelques extensions pour navigateur Web, d'abord pour [Chrome](https://chrome.google.com/webstore/search/ligny?_category=extensions), puis pour [Firefox](https://addons.mozilla.org/fr/firefox/user/77216/) (avec la standardisation de l'API [*WebExtensions*](https://developer.mozilla.org/fr/docs/Mozilla/Add-ons/WebExtensions)).

Initialement conçues et développées pour mon usage personnelle, j’ai ensuite décider de les partager, non seulement sur GitHub (en open-source) mais aussi, sur les *stores* officiels afin d’en simplifier l'installation.

Néanmoins, au fil des mises à jour il devenait pénible :

1. de mettre à disposition l’extension / l'addon sous forme d’archive dans la section *Releases* du dépôt GitHub ;
2. de créer une nouvelle version et de l’uploader depuis la page de gestion de chacun des *stores*.

Aussi, j’ai cherché à automatiser ces étapes via l’[intégration continue](https://fr.m.wikipedia.org/wiki/Int%C3%A9gration_continue) et le déploiement continu (ou [livraison continue](https://fr.m.wikipedia.org/wiki/Livraison_continue)).

<!-- break-->

## Intégration continue {#ic}

[![Tableau de bord de Travis CI](/images/f-notifier-travis-ci.png)](https://travis-ci.com/)

Le principe de l’intégration continue vise à automatiser les **tests** et le ***build*** du programme (ici l’extension) à chaque livraison de code afin de s’assurer de la qualité du code et de prévenir les risques de regression.

Dans le cas d’une distribition open-source je recommanderais la solution [**Travis CI**](https://travis-ci.com/) qui est gratuit pour les petits projets, très simple à paramétrer, et qui propose également de l’outillage permettant le déploiement continue (voir plus bas).

### Test {#test}

Pour la plupart de mes extensions, qui sont sommes toute très simple, je me suis concentré sur la qualité du code JavaScript via [ESLint](https://eslint.org/) en utilisant la blitiothèque [**xo**](https://github.com/xojs/xo).

**Exemple :**

```json
"xo": {
  "space": true,
  "envs": [
    "browser",
    "webextensions"
  ],
  "rules": {
    "import/no-unassigned-import": 0,
    "no-lonely-if": "off"
  },
  "ignores": [
    "build/**"
  ]
}
```

[*Source*](https://github.com/Narno/F-Notifier/blob/master/package.json#L38)

### *Build* {#build}

Conernant la solution de *build* j’ai opté pour la bliothèque [**Gulp**](https://gulpjs.com/) qui permet d’automatiser simplement les tâches répétitives (copie des fichiers, création de l’archive ZIP, etc.) en écrivant quelques lignes de JavaScript.

**Exemple :**

```bash
gulp dist
```

```javascript
'use strict';

const extensionName = 'F-Notifier';

const fs = require('fs');
const cleancss = require('gulp-clean-css');
const cleanhtml = require('gulp-cleanhtml');
const del = require('del');
const gulp = require('gulp');
const log = require('fancy-log');
const vinylpaths = require('vinyl-paths');
const zip = require('gulp-zip');

// Clean build directory
gulp.task('clean', () => {
  return gulp.src('build/*')
    .pipe(vinylpaths(del));
});

// Copy and compress HTML files
gulp.task('html', () => {
  return gulp.src('src/*.html')
    .pipe(cleanhtml())
    .pipe(gulp.dest('build'));
});

// Copy scripts
gulp.task('scripts', () => {
  return gulp.src('src/*.js')
    .pipe(gulp.dest('build'));
});

// Copy and minify CSS
gulp.task('styles', () => {
  gulp.src('src/**/*.min.css')
    .pipe(gulp.dest('build'));
  return gulp.src(['src/*.css', '!src/vendor/**/*.css'])
    .pipe(cleancss({root: 'src', keepSpecialComments: 0}))
    .pipe(gulp.dest('build'));
});

// Copy static files
gulp.task('copy', () => {
  gulp.src('src/*.png')
    .pipe(gulp.dest('build'));
  gulp.src('src/*.mp3')
    .pipe(gulp.dest('build'));
  gulp.src('src/_locales/**')
    .pipe(gulp.dest('build/_locales'));
  return gulp.src('src/manifest.json')
    .pipe(gulp.dest('build'));
});

// Build
gulp.task('build', ['clean', 'html', 'scripts', 'styles', 'copy']);

// Build ditributable (ZIP)
gulp.task('zip', ['build'], () => {
  const manifest = require('./src/manifest.json');
  const distFileName = extensionName + '_v' + manifest.version + '.zip';
  return gulp.src(['build/**'])
    .pipe(zip(distFileName))
    .pipe(gulp.dest('dist'));
});

// Build distributable
gulp.task('dist', ['zip']);

// Run build task by default
gulp.task('default', ['clean'], () => {
  gulp.start('build');
});
```

[*Source*](https://github.com/Narno/F-Notifier/blob/master/gulpfile.js)

## Déploiement continue {#cd}

Détaillons maintenant l’objet de cet article, à savoir : Comment automatiser la publication d’une extension Google Chrome sur le *Chrome Web Store* et une extension Mozilla Firefox sur *Firefox Add-ons*.

La publication est réalisée dans le cadre de l’intégation continue, à la condition que le *build* soit un succès et de manière automatique via l’exécution d’une ligne de commande.

### *Release* GitHub

![GitHub release](/images/f-notifier-github-release.png)

Comme indiqué plus haut Travis CI offre une option simple, via la [configuration](https://docs.travis-ci.com/user/deployment/releases/), de déploiement du résultat du *build* en tant qu’*asset* attaché à une nouvelle release.

Il suffit d’indiquer le provider `releases`, de fournir le token de l’API GitHub et de préciser le fichier.

**Exemple :**

```yaml
deploy:
  - provider: releases
    skip_cleanup: true
    overwrite: true
    api_key: $GH_TOKEN
    file_glob: true
    file: "dist/*"
```

[*Source*](https://github.com/Narno/F-Notifier/blob/master/.travis.yml#L14)

### *Chrome Web Store*

Le *Chrome Web Store* offre la possibilité de publier une extension (ou plutôt une nouvelle version d’une extension) via son API.

Et bien entendu il existe un module *Node.js* (et son *wrapper* en ligne de commande) pour effectuer l’opération sans écrire une seule ligne de code : [**Web Store Upload CLI**](https://github.com/DrewML/chrome-webstore-upload-cli).

```bash
webstore upload --auto-publish
```

Ce module est très efficace mais reste pénible à paramétrer la première fois.

L’objectif est de :

1. [générer les clefs de l’API](https://github.com/DrewML/chrome-webstore-upload/blob/master/How%20to%20generate%20Google%20API%20keys.md) (`CLIENT_ID`, `CLIENT_SECRET`, et `REFRESH_TOKEN`) ;
2. enregistrer les variables d’environnement correpondantes dans la configuration du projet Travis CI.

![Travis CI Environment Variables](/images/f-notifier-env-variables.png)

?

### *Firefox Add-ons*

to do