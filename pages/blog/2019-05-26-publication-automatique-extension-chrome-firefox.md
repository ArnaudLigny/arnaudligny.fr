---
title: "Publication automatique d’une extension Chrome ou Firefox"
description: "Comment automatiser la publication d’une extension Chrome et Firefox sur les stores, depuis une chaîne d’intégration continue."
date: 2019-05-26
updated: 2021-09-06
tags:
  - développement
years: [2019]
image: /images/2019-05-26-publication-automatique-extension-chrome-firefox/store_developer_dashboard.png
typora-root-url: ../../static
_display:
  reader: ['https://latribu.dev']
published: true
---
**Mis à jour le 06/09/21**

Dans cet article je fais référence à **Travis CI** en tant qu’outil de CI/CD, mais depuis j’ai migré vers [**GitHub Actions**](https://arnaudligny.fr/blog/generer-et-heberger-un-site-statique-avec-github/#qu-est-ce-que-github-actions).  
Voici un exemple complet de workflow : [`release.yml`](https://github.com/ArnaudLigny/F-Notifier/blob/2.7.4/.github/workflows/release.yml).

----

Ces dernières années j’ai développé quelques extensions pour navigateur web, d'abord pour [Chrome](https://chrome.google.com/webstore/search/ligny?_category=extensions), puis pour [Firefox](https://addons.mozilla.org/fr/firefox/user/77216/) (avec la standardisation de l'API [*WebExtensions*](https://developer.mozilla.org/fr/docs/Mozilla/Add-ons/WebExtensions)).

Initialement conçues et développées pour mon usage personnelle, j’ai ensuite décidé de les partager, non seulement sur [GitHub](https://github.com/ArnaudLigny?tab=repositories&q=topic%3Aweb-extension&type=source) (sous licence open-source) mais aussi, sur les *stores* officiels afin d’en simplifier l'installation.

<!-- break-->

Néanmoins, au fil des mises à jour il devenait pénible :

1. de mettre à disposition l’extension / l’add-on sous forme d’archive ZIP dans la section *Releases* du dépôt GitHub ;
2. de créer une nouvelle version et de l’uploader depuis la page de gestion de chacun des *stores*.

Aussi, j’ai cherché à automatiser ces étapes via l’[**intégration continue**](https://fr.m.wikipedia.org/wiki/Int%C3%A9gration_continue) et le [**déploiement continu**](https://fr.m.wikipedia.org/wiki/Livraison_continue).

## Intégration continue {#integration-continue}

[Tableau de bord de Travis CI](/images/2019-05-26-publication-automatique-extension-chrome-firefox/f-notifier-travis-ci.png)

Le principe de l’intégration continue vise à automatiser l‘exécution des [*tests*](#tests) et le [*build*](#build) du programme (ici l’extension programmée en JavaScript) à chaque livraison de code (sur le dépôt) afin de s’assurer de la qualité du code et de prévenir les risques de régression.

Dans le cas d’une distribution open-source je recommanderais la solution [**Travis CI**](https://travis-ci.com/) qui est gratuite pour les petits projets, très simple à paramétrer, et qui propose également de l’outillage permettant le [déploiement continu](#deploiement-continu).

### Tests {#tests}

Pour la plupart de mes extensions, qui sont sommes toute très simple, je me suis concentré sur la qualité du code JavaScript via [ESLint](https://eslint.org/) en utilisant la bibliothèque [**xo**](https://github.com/xojs/xo).

**Exemple :** [`package.json`](https://github.com/ArnaudLigny/F-Notifier/blob/2.3.1/package.json#L38).

### *Build* {#build}

Dans le cas d’une extension web, la phase de *build* consiste à :

1. combiner les différents scripts en un unique fichier (ex : `background.js`)
2. copier les ressources requises (images, fichiers CSS, etc.)
3. créer une archive ZIP : c’est elle qui sera chargée par le navigateur web

Pour réaliser ces étapes répétitives j’ai opté pour la boîte à outils [**Gulp**](https://gulpjs.com/) qui se paramètre via quelques lignes de JavaScript.

**Exemple :** [`gulpfile.js`](https://github.com/ArnaudLigny/F-Notifier/blob/2.3.1/gulpfile.js).

## Déploiement continu {#deploiement-continu}

Détaillons maintenant l’objet de cet article, à savoir :

> ***Comment automatiser la publication d’une extension Google Chrome sur le Chrome Web Store et une extension Mozilla Firefox sur Firefox Add-ons ?***

La publication est la dernière étape de l’intégration continue, exécutée si et seulement si le *build* est un succès (de manière automatique via une ligne de commande).

### *Release* GitHub {#release-github}

[![GitHub release](/images/2019-05-26-publication-automatique-extension-chrome-firefox/f-notifier-github-release.png)](https://github.com/ArnaudLigny/F-Notifier/releases)

Comme indiqué plus haut Travis CI offre une option simple, via la [configuration](https://docs.travis-ci.com/user/deployment/releases/), de déploiement du résultat du *build* en tant qu’*asset* attaché à une nouvelle release.

Il suffit d’indiquer le *provider* `releases`, de fournir le token de l’API GitHub et de préciser le fichier.

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

> Note : la variable d’environnement `GH_TOKEN` doit être ajoutée à la configuration du projet Travis CI.

### *Chrome Web Store* {#chrome-web-store}

Le *Chrome Web Store* offre la possibilité de publier une extension (ou plutôt une nouvelle version d’une extension) via son [API](https://developer.chrome.com/webstore/using_webstore_api).

Et bien entendu il existe un module *Node.js* (et son *wrapper* en ligne de commande) pour effectuer l’opération sans écrire une seule ligne de code : [***Web Store Upload CLI***](https://github.com/DrewML/chrome-webstore-upload-cli).

Cet outil est très efficace même si le paramétrage reste pénible la première fois. L’objectif est de :

1. [générer les clefs de l’API](https://github.com/DrewML/chrome-webstore-upload/blob/master/How%20to%20generate%20Google%20API%20keys.md) ;
2. enregistrer les variables d’environnement correspondantes dans la configuration du projet Travis CI : `CLIENT_ID`, `CLIENT_SECRET` et `REFRESH_TOKEN` ;
3. exécuter la commande `webstore upload --auto-publish`.

**Exemple de configuration Travis CI :**

![Travis CI Environment Variables](/images/2019-05-26-publication-automatique-extension-chrome-firefox/f-notifier-env-variables.png)

### *Firefox Add-ons* {#firefox-add-ons}

Il existe également un outil en ligne de commande pour Firefox : [***web-ext***](https://developer.mozilla.org/docs/Mozilla/Add-ons/WebExtensions/web-ext_command_reference).

Néanmoins j’ai rencontré un soucis avec la commande `web-ext sign` : la soumission est effective mais retourne systématiquement le message d'erreur « it could not be signed », ce qui est bloquant dans le cadre de son utilisation dans une étape d’intégration continue puisqu‘une commande qui ne retourne pas ”0” met en erreur tout le traitement.

Pour palier à ce soucis j’utilise le *wrapper* [***web-ext-submit***](https://github.com/bfred-it/web-ext-submit) de [Federico Brigante](https://github.com/fregante).

Son utilisation est similaire à celle de *Web Store Upload CLI* :

1. [générer les clefs d’API](https://addons.mozilla.org/developers/addon/api/key/) ;
2. enregistrer les variables d’environnement correspondantes dans la configuration du projet Travis CI : `WEB_EXT_API_KEY` et `WEB_EXT_API_SECRET`;
3. exécuter la commande `webext submit`.

## Conclusion

Comme vous avez pu le lire, en combinant les outils adaptés, il est relativement simple d’automatiser la publication d’une extension pour navigateur.

Néanmoins ça prend toujours un peu de temps la première fois, aussi je vous invite à vous inspirer d’un de mes projets — [***F-Notifier*** (~ 400 utilisateurs)](https://github.com/ArnaudLigny/F-Notifier) — et plus particulièrement des fichiers [`package.json`](https://github.com/ArnaudLigny/F-Notifier/blob/2.3.1/package.json) et [`.travis.yml`](https://github.com/ArnaudLigny/F-Notifier/blob/2.3.1/.travis.yml).

Et voilà ! 😃
