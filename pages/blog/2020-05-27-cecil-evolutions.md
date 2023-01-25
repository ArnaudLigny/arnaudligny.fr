---
title: "Évolutions de Cecil (mai 2020)"
date: 2020-05-27
tags:
  - Cecil
  - SSG
image: /images/cecil-card.png
image_header: false
published: true
---
Depuis mon [billet de présentation de Cecil](/blog/cecil-mon-generateur-de-site-statique/), datant de juin 2019, j’ai apporté de nombreuses améliorations à [mon générateur de site statique](https://cecil.app/).

Voici le journal des modifications.
<!-- break -->
[4.18.0](https://github.com/Cecilapp/Cecil/releases/tag/4.18.0)

- Découplage de la logique de création des taxonomies et des pages correspondantes
- Ajout de la variable [`site.taxonomies`](https://cecil.app/documentation/templates/#site)

[4.19.0](https://github.com/Cecilapp/Cecil/releases/tag/4.19.0)

- Ajout de la variable [`site.language`](https://cecil.app/documentation/templates/#site-language) : `language.name`, `language.locale` et `language.weight`

[4.20.0](https://github.com/Cecilapp/Cecil/releases/tag/4.20.0)

- Le squelette d’un nouveau site est maintenant basé sur [Primer CSS](https://primer.style/css/)

[4.21.0](https://github.com/Cecilapp/Cecil/releases/tag/4.21.0)

- Support de l’[internationalisation](https://cecil.app/documentation/templates/#internationalization) ([i18n](https://fr.m.wikipedia.org/wiki/Internationalisation_(informatique)))

[4.22.0](https://github.com/Cecilapp/Cecil/releases/tag/4.22.0)

- Testé avec PHP 7.3

[4.23.0](https://github.com/Cecilapp/Cecil/releases/tag/4.23.0)

- Amélioration des performances de rendu

[4.24.0](https://github.com/Cecilapp/Cecil/releases/tag/4.24.0)

- Ajout du numéro de version dans la métadonnée [`generator`](https://github.com/Cecilapp/Cecil/blob/60b248c1b1d78f4d23836934bd0c539e1817e211/src/Renderer/Twig.php#L78)

[4.25.0](https://github.com/Cecilapp/Cecil/releases/tag/4.25.0)

- Création d’un template dédié aux métadonnées [`partials/metatags.html.twig`](https://github.com/Cecilapp/Cecil/blob/master/resources/layouts/partials/metatags.html.twig)

[4.26.0](https://github.com/Cecilapp/Cecil/releases/tag/4.26.0)

- Ajout de l’option `verbose` (verbeux) à la commande `serve`

[4.27.0](https://github.com/Cecilapp/Cecil/releases/tag/4.27.0)

- Amélioration de l’internationalisation

[4.28.0](https://github.com/Cecilapp/Cecil/releases/tag/4.28.0)

- Remplacement automatique des liens vers des fichiers Markdown (`*.md`) par une URL web valide

[4.29.0](https://github.com/Cecilapp/Cecil/releases/tag/4.29.0)

- Amélioration de la [pagination](https://cecil.app/documentation/templates/#page-pagination)

[4.30.0](https://github.com/Cecilapp/Cecil/releases/tag/4.30.0)

- Amélioration de la mécanique de rechargement automatique : n’est active que si la date de la dernière modification est postérieur au dernier rechargement

[4.31.0](https://github.com/Cecilapp/Cecil/releases/tag/4.31.0)

- Ajout de la possibilité de créer une nouvelle page avec la date courante en tant que préfixe via l’option `--prefix`

[5.0.0](https://github.com/Cecilapp/Cecil/releases/tag/5.0.0)

- Abandon de [ZF\Console](https://github.com/zfcampus/zf-console) au profit de [Symfony Console Component](https://symfony.com/doc/current/components/console.html)

[5.1.0](https://github.com/Cecilapp/Cecil/releases/tag/5.1.0)

- Ajout de la possibilité de créer une nouvelle page avec la date courante en tant que préfixe via l’option `--prefix`

[5.2.0](https://github.com/Cecilapp/Cecil/releases/tag/5.2.0)

- Ajout de la possibilité de charger les données de fichiers [YAML](https://fr.m.wikipedia.org/wiki/YAML), depuis le dossier [`data`](https://cecil.app/documentation/configuration/#data)

[5.3.0](https://github.com/Cecilapp/Cecil/releases/tag/5.3.0)

- Ajout d’une étape d’[optimisation](https://cecil.app/documentation/configuration/#postprocess) (compression) des images

[5.4.0](https://github.com/Cecilapp/Cecil/releases/tag/5.4.0)

- Ajout d’une étape d’[optimisation](https://cecil.app/documentation/configuration/#postprocess) (compression) des fichiers (HTML, CSS et JavaScript)

[5.5.0](https://github.com/Cecilapp/Cecil/releases/tag/5.5.0)

- La mécanique de chargement des données supporte également les formats JSON, XML et JSON

[5.6.0](https://github.com/Cecilapp/Cecil/releases/tag/5.6.0)

- Nouveau format de définition des [menus](https://cecil.app/documentation/configuration/#menus)

  ```yaml
  menus:
    main:
      - id: example
        name: "Example"
        url: https://example.com
        weight: 999
      - id: about
        enabled: false
  ```

[5.7.0](https://github.com/Cecilapp/Cecil/releases/tag/5.7.0)

- Nouvelle structure de définition des [langues](https://cecil.app/documentation/configuration/#languages) :

  ```
  language: fr
  languages:
    - code: fr
      name: Français
      locale: fr_FR
      config:
        title: 'Cecil en français !'
  ```

[5.8.0](https://github.com/Cecilapp/Cecil/releases/tag/5.8.0)

- Redéfinition de la structure de configuration des [pages virtuelles](https://cecil.app/documentation/configuration/#virtualpages)

[5.9.0](https://github.com/Cecilapp/Cecil/releases/tag/5.9.0)

- Redéfinition de la structure de configuration des [formats de sortie](https://cecil.app/documentation/configuration/#output)

[5.10.0](https://github.com/Cecilapp/Cecil/releases/tag/5.10.0)

- La clef de configuration [`static: exclude`](https://cecil.app/documentation/configuration/#static) supporte les formats `globs`, `strings` et `regexes`

[5.11.0](https://github.com/Cecilapp/Cecil/releases/tag/5.11.0)

- Ajout de la fonctionnalité de [redimensionnement des images](https://cecil.app/documentation/content/#images) au sein d’un contenu Markdown

[5.12.0](https://github.com/Cecilapp/Cecil/releases/tag/5.12.0)

- Ajout de la fonctionnalité de [redimensionnement des images](https://cecil.app/documentation/templates/#resize) au sein d’un template

[5.13.0](https://github.com/Cecilapp/Cecil/releases/tag/5.13.0)

- Ajout d’une fonction de création d’un [asset](https://cecil.app/documentation/templates/#asset)

[5.14.0](https://github.com/Cecilapp/Cecil/releases/tag/5.14.0)

- Ajout de la fonctionnalité de [création d’une image responsive](https://cecil.app/documentation/content/#images) au sein d’un contenu Markdown

[5.15.0](https://github.com/Cecilapp/Cecil/releases/tag/5.15.0)

- Ajout d’une variable permettant d’[exclure la page d’une section](https://cecil.app/documentation/content/#exclude)

[5.16.0](https://github.com/Cecilapp/Cecil/releases/tag/5.16.0)

- Ajout d’une fonctionnalité de [chargement des fichiers statiques](https://cecil.app/documentation/configuration/#static) dans un tableau de données exploitables au sein des [templates](https://cecil.app/documentation/templates/#site-static)

[5.17.0](https://github.com/Cecilapp/Cecil/releases/tag/5.17.0)

- Ajout de la possibilité de charger des [générateurs locaux](https://github.com/Cecilapp/Cecil/blob/fd1e5712930eb311e2a02ea5ffd45f92a84aa1d1/src/Step/PagesGenerate.php#L38) (présents dans le dossier `/generators/`)

[5.18.0](https://github.com/Cecilapp/Cecil/releases/tag/5.18.0)

- La page d’accueil ([*index*](https://github.com/Cecilapp/Cecil/blob/88d9df724a02bdc301a5dccaac8456bf0a07ffac/config/default.php#L115)) est maintenant une page par défaut

[5.19.0](https://github.com/Cecilapp/Cecil/releases/tag/5.19.0)

- Les *Optimizers* sont maintenant des *Post-processors*

[5.20.0](https://github.com/Cecilapp/Cecil/releases/tag/5.20.0)

- Message d’erreur plus clair dans l’interface en ligne de commande

[5.21.0](https://github.com/Cecilapp/Cecil/releases/tag/5.21.0)

- Clarification des messages et sorties de la console

[5.22.0](https://github.com/Cecilapp/Cecil/releases/tag/5.22.0)

- Quelques améliorations du code

[5.23.0](https://github.com/Cecilapp/Cecil/releases/tag/5.23.0)

- Passage de la gestion des messages de log à [PSR/Log](PSR/Log)

[5.24.0](https://github.com/Cecilapp/Cecil/releases/tag/5.24.0)

- Implémentation de *SimpleCache* ([PSR-16](https://www.php-fig.org/psr/psr-16/))

[5.25.0](https://github.com/Cecilapp/Cecil/releases/tag/5.25.0)

- Reconstruction de la mécanique de gestion des assets et du cache

[5.26.0](https://github.com/Cecilapp/Cecil/releases/tag/5.26.0)

- Amélioration des extensions Twig

[5.27.0](https://github.com/Cecilapp/Cecil/releases/tag/5.27.0)

- [Changements](https://github.com/Cecilapp/Cecil/pull/786) des fonctions et des filtres Twig

[5.28.0](https://github.com/Cecilapp/Cecil/releases/tag/5.28.0)

- Nouvelle fonctionnalité : [_bundle assets_](https://cecil.app/documentation/templates/#asset)

[5.29.0](https://github.com/Cecilapp/Cecil/releases/tag/5.29.0)

- Ajout d’une option de choix du fichier de configuration : `--config=cecil.yml`

[5.30.0](https://github.com/Cecilapp/Cecil/releases/tag/5.30.0)

- Possibilité de personnaliser le [`path`](https://cecil.app/documentation/configuration/#paths) des pages d’une section via la configuration

[5.31.0](https://github.com/Cecilapp/Cecil/releases/tag/5.31.0)

- Un *asset* peut retourner la taille du fichier

[5.32.0](https://github.com/Cecilapp/Cecil/releases/tag/5.32.0)

- Un *asset* peut retourner la largeur et la hauteur d’une image, ainsi que les informations d’un fichier MP3

Pour en savoir plus : [Cecil/Releases](https://github.com/cecilapp/cecil/releases).
