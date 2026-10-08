---
title: "Cecil : une documentation restructurée et une recherche 100 % statique"
description: "La documentation de Cecil a été réorganisée en sous-sections et sa recherche s’appuie désormais sur FlexSearch, sans aucun service tiers."
date: 2026-10-08
tags: [Cecil, SSG, recherche]
years: [2026]
#image: images/2026-10-08-cecil-documentation-recherche-flexsearch/recherche.png
typora-root-url: ../../assets
typora-copy-images-to: ../../assets/images/${filename}
published: true
---
La [documentation de Cecil](https://cecil.app/documentation/) vient d’être [entièrement restructurée](https://cecil.app/news/2026/10/07/documentation-restructured/) : fini les pages interminables, place à des pages courtes, organisées en sous-sections.

Dans la foulée, j’ai remplacé Algolia DocSearch par une recherche basée sur [FlexSearch](https://github.com/nextapps-de/flexsearch). L’index est généré par Cecil au moment du build et la recherche s’exécute entièrement dans le navigateur : plus aucune dépendance à un service en ligne.

<!-- break -->

## Pourquoi restructurer la documentation ?

Certaines pages de la documentation dépassaient les 1 500 lignes. Pratique pour un `Ctrl` + `F`, beaucoup moins pour s’y retrouver ou pour partager un lien vers un sujet précis.

Elle est désormais découpée en huit sections :

- **Prise en main** : démarrage rapide, installation, arborescence et _starter kits_ ;
- **Contenu** : pages, _front matter_, Markdown, multilingue et contenus dynamiques ;
- **Templates** : règles de sélection, variables, composants, fonctions et filtres ;
- **Assets** : images, traitements et CDN (auparavant inclus dans Templates) ;
- **Configuration** : une page par thème ;
- **Commandes** : `new:site`, `new:page`, `serve`, `build` et `doctor` ;
- **Déploiement** : plateformes Jamstack, déploiement continu et hébergement statique ;
- **Développeurs** : étendre Cecil, l’utiliser comme bibliothèque et son architecture.

## Les sections imbriquées à l’œuvre

Cette réorganisation est une mise en pratique directe des [sections imbriquées de Cecil 9](/blog/cecil-9.0.0-sections-imbriquees/) : tout dossier contenant un fichier `index.md` devient une sous-section, avec ses propres pages, son layout et son fil d’Ariane.

```text
pages/documentation/
├── index.md
├── getting-started/
├── content/
│   ├── index.md
│   ├── 1-pages.md
│   ├── 1-pages.fr.md
│   ├── 2-front-matter.md
│   └── …
├── templates/
└── …
```

Côté navigation, la barre latérale affiche maintenant l’arborescence complète (avec la position courante) et la page d’accueil de chaque section liste ses pages accompagnées d’une courte description. Le tout en anglais et en français.

## Au revoir Algolia

En 2021, j’avais [intégré Algolia](/blog/2021-07-26-moteur-de-recherche-algolia-site-statique.md) pour offrir une recherche _full text_ dans la documentation. La solution fonctionnait bien, mais au prix de nombreuses contraintes : un compte et un index hébergés chez Algolia, des clés d’API dans les variables d’environnement de Netlify, un plugin (`netlify-plugin-refresh-algolia`) pour réindexer après chaque déploiement, et un script tiers chargé à chaque recherche.

Pour un site statique, c’est beaucoup de dépendances pour une fonctionnalité qui peut parfaitement être… statique.

## Un index généré par Cecil

L’idée est simple : puisque Cecil connaît toutes les pages au moment du build, il peut produire lui-même l’index de recherche.

Pour cela, j’utilise les [formats de sortie](https://cecil.app/documentation/configuration/output/) : un format personnalisé `flexsearch` est déclaré dans `cecil.yml`, puis associé à la page d’accueil.

```yaml
output:
  formats:
    - name: flexsearch
      mediatype: 'application/json'
      filename: 'search'
      extension: 'json'
  pagetypeformats:
    homepage: ['html', 'atom', 'flexsearch']
```

Cecil génère alors un fichier `/search.json` (et `/fr/search.json` pour la version française) à partir du template `list.flexsearch.twig`. Ce template parcourt les pages des sections à indexer et découpe chacune d’elles sur ses titres `<h2>` et `<h3>` : chaque résultat pointe ainsi directement vers la bonne ancre, comme le faisait DocSearch.

Les sections indexées et leurs options sont elles aussi définies dans la configuration :

```yaml
search:
  sections:
    documentation:
      limit: 5 # nombre maximum de résultats dans le groupe
    how-to:
      limit: 3
      split: false # un seul enregistrement par page
    news:
      limit: 3
      split: false
      date: true # affiche la date à la place du fil d’Ariane
```

La recherche couvre donc désormais la documentation, mais aussi les guides pratiques et les actualités, avec des résultats regroupés par section. Chaque section dispose de son propre index FlexSearch : la documentation n’est jamais noyée sous les actualités.

## Et côté navigateur ?

Un bouton (ou le raccourci `Ctrl`/`⌘` + `K`) ouvre une fenêtre modale inspirée de DocSearch, avec navigation au clavier et affichage plein écran sur mobile. Au premier usage, le navigateur télécharge l’index JSON, puis toutes les recherches sont locales : instantanées, sans requête réseau, et même hors ligne grâce au _service worker_ du site.

Côté poids, l’index anglais pèse 322 Ko, soit environ 73 Ko compressé avec gzip : bien moins que la plupart des images d’une page web.

## Ce que j’en retiens

Ce chantier illustre bien ce que permet un générateur de site statique :

- **moins de dépendances** : pas de compte, pas de clé d’API, pas de plugin de réindexation ;
- **un index toujours à jour** : il est reconstruit à chaque build, avec le contenu ;
- **de la performance** : la recherche est instantanée une fois l’index chargé ;
- **de la souplesse** : quelques lignes de configuration et un template Twig suffisent.

## Pour aller plus loin

- Annonce de la nouvelle documentation : <https://cecil.app/news/2026/10/07/documentation-restructured/>
- Code source du site de Cecil : <https://github.com/Cecilapp/website>
- FlexSearch : <https://github.com/nextapps-de/flexsearch>
