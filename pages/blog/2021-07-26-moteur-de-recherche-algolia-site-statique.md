---
title: Un moteur de recherche sur un site statique grâce à Algolia
date: 2021-07-26
updated: 2022-10-17
tags: [SSG, Recherche, Cecil]
image: /images/2021-07-26-moteur-de-recherche-algolia-site-statique/cecil.app_documentation_templates_search.png
image_header: false
typora-root-url: ../../assets
typora-copy-images-to: ../../assets/images/${filename}
draft: true
---
Quand je travaillais à enrichir la [documentation](https://cecil.app/documentation/) de [Cecil](https://cecil.app), je me suis dit qu’il serait pertinent d’offrir un moteur de recherche *[full text](https://fr.m.wikipedia.org/wiki/Recherche_plein_texte)* aux utilisateurs.

![Exemple de résultat de recherche](/images/2021-07-26-moteur-de-recherche-algolia-site-statique/cecil.app_documentation_templates_search.png "Exemple de résultat de recherche")
<!-- break -->

La documentation de Cecil est composée de moins de 10 pages : une par thématique (configuration, gestion des contenus, création des templates, etc.) et chacune d’elle contient de nombreuses sections, accessibles par des ancres.

Aussi, il est important que les résultats retournés par un moteur de recherche soient granulaires, c’est à dire qu’ils ciblent ces sections au sein d’une page.

![Exemple de page de documentation](/images/2021-07-26-moteur-de-recherche-algolia-site-statique/cecil.app_documentation_templates.png "Exemple de page de documentation")

## Quelle solution technique ?

Dans un premier temps j’ai expérimenté le [moteur de recherche personnalisé de Google](https://cse.google.com/) (CSE) qui permet de présenter les résultats indexés par Google pour un site donné (comme avec le préfixe `site:`).  
Si les résultats sont pertinents pour un site contenant de nombreuses pages, il ne semble pas possible de personnaliser les résultats en fonction de sections au sein d’une même page, ce qui ne correspondant pas à mon besoin.

*[CSE]: Custom Search Engine

Aussi, après plusieurs comparatifs, j’ai retenu la solution [Algolia](https://www.algolia.com/) pour les raisons suivantes :

* Pertinence des résultats
* [Tarifs abordables](https://www.algolia.com/pricing/) (dont un plan gratuit)
* [Documentation riche](https://www.algolia.com/doc/)
* Nombreuses bibliothèques de code [open source](https://github.com/algolia)

## Comment ?

Je souhaitais que le champ de recherche soit disponible sur chacune des pages et qu’il montre immédiatement un extrait des résultats lors de la saisie d’un ou plusieurs mots clefs, et laissant le choix à l’utilisateur de sélectionner la section à consulter : j’ai donc opté pour l’approche [*Autocomplete*](https://www.algolia.com/doc/ui-libraries/autocomplete/introduction/what-is-autocomplete/) (c.f. la capture d’écran en début de billet).

### Créer un index

Pour intégrer cette bibliothèque il est nécessaire de comprendre le principe de fonctionnement d’Algolia.

Algolia s’appuie sur un [index](https://www.algolia.com/doc/guides/sending-and-managing-data/prepare-your-data/#algolia-index), c’est à dire une collection d’enregistrements, dans laquelle la recherche va être effectuée et dont le résultat permet d’afficher un certain nombre d’informations et de pointer vers la page Web correspondante.

Cet index est une [structure JSON](https://www.algolia.com/doc/guides/sending-and-managing-data/prepare-your-data/#algolia-records) relativement libre, composée de couples clef-valeur, permettant d’avoir de la matière dans laquelle chercher et d’ajuster les critères de recherche.

### Transmettre l’index

Algolia propose [plusieurs méthodes](https://www.algolia.com/doc/guides/sending-and-managing-data/send-and-update-your-data/) afin de transmettre ou de mettre à jour à index :

- à la main, [via le dashboard](https://www.algolia.com/doc/guides/sending-and-managing-data/send-and-update-your-data/how-to/importing-from-the-dashboard/), en important le fichier JSON
- en ligne de command, via [Algolia CLI](https://www.algolia.com/doc/tools/cli/get-started/overview/)
- programmatiquement, en [PHP](https://www.algolia.com/doc/api-client/getting-started/install/php/), en [JavaScript](https://www.algolia.com/doc/api-client/getting-started/install/javascript/), etc.

### Paramétrer l’index

Le paramétrage de l’index, à savoir déterminer les attributs dans lesquels rechercher, le classement et l’ordonnancement, etc. est relativement simplement à paramétrer depuis le [dashboard](https://algolia.com/dashboard).

Je dis *relativement* car il est parfois nécessaire d’effectuer quelques tests avant de maitriser les règles de priorisation des résultats.

![Dashboard Algolia](/images/2021-07-26-moteur-de-recherche-algolia-site-statique/image-20221017142612522.png "Dashboard Algolia")

## En pratique

Dans le cas de la documentation de [Cecil](/tags/cecil), je devais donc :

1. créer un fichier index au format JSON
2. le transmettre à application Algolia
3. afficher un champs de recherche avec auto-complétion

### Création de l’index

Avec [Cecil](/tags/cecil) il est plutôt aisé de créer un fichier JSON puisque, par définition, c’est son job de générer des fichiers statiques 😊

Ainsi, l’objectif est de :

1. collecter le contenu des pages de la documentation (dans `pages/documentation`), converti en HTML
2. découper ce contenu de manière cohérente (l'objectif n’est pas de pointer sur la page, mais bien sur une section de la page), via un [template Twig](https://cecil.app/documentation/templates) spécifique
3. générer un fichier `algolia.json` grâce aux [formats de sortie](https://cecil.app/documentation/configuration#formats)

#### Résultat cible

Le fichier d’index va ressembler à ça :

```json
[
  {
    "objectID": "documentation/quick-start#download-cecil",
    "page": "Quick Start",
    "title": "Download Cecil",
    "description": "Download cecil.phar from your terminal:",
    "content": "...",
    "date": "2020-12-19T00:00:00+00:00",
    "href": "documentation/quick-start/#download-cecil"
  },
  ...
]
```

#### Création du template

Comme indiqué précédemment, dans le contexte de Cecil, pour créer ce fichier il est nécessaire de créer un template Twig qui va collecter les donner et les rendre au format JSON.

S’agissant de rechercher dans la documentation, j’aurais pu créer ce template dans la section « documentation » (`layouts/documentation/list.algolia.twig`).  
Mais comme je souhaitais potentiellement étendre la recherche à plusieurs types de contenus (tels que les « news ») j’ai préféré créer un template applicable à l’ensemble des contenus du site, donc via `layouts/_default/list.algolia.twig`.

Ainsi, au sein du template, il suffit de boucler sur les contenus de la section « documentation », avec une boucle for :

```twig
{% for p in site.pages|filter(p => p.section == 'documentation')|sort_by_weight %}
...
{% endfor %}
```

Ensuite, toute l’astuce consiste à « jouer » sur les header HTML, en l’occurence le « H3 » afin de découper le contenu d’une page de documentation en sous sections :

```twig
{% set sections = p.content|preg_split('/<h3[^>]*>/') %}
```

> Le filtre Twig [`preg_split`](https://cecil.app/documentation/templates/#preg-split) à été créer pour l’occasion afin de permettre le découpage d’une chaine de caractère en un tableau, selon une expression régulière.

De là, il suffit ensuite d’extraire les contenus cibles de chaque section, via de la manipulation de chaines de caractères, pour alimenter le « dataset » :

```json
{
    "objectID": "Un ID unique",
    "page": "Le nom de la page de documentation",
    "title": "Le titre de section",
    "description": "Le premier paragraphe de la section (utilisé pour illustrer l’aperçu des résiltats)",
    "content": "Le contenu de la section, dans laquelle la recherche est effectuée",
    "date": "La date de la page, utilisée pour pondérer les résultats",
    "href": "Le lien vers la page de la documentation, combinée à une ancre afin d’emmener l’internaute à la bonne section",
  }
```

> Voir le [template complet](https://github.com/Cecilapp/website/blob/master/layouts/_default/list.algolia.twig).

#### Associer ce template à un format de sortie

En l’état, Cecil ne sait pas qu’il faut utiliser ce template et surtout à quel type de contenu il doit être associer. C’est embêtant 😅

Pour régler ce soucis il suffit de compléter la configuration de la manière suivante :

```yaml
output:
  formats:
    - name: algolia
      mediatype: 'application/json'
      filename: 'algolia'
      extension: 'json'
  pagetypeformats:
    homepage: ['html', 'atom', 'algolia']
```

Maintenant Cecil sait que :

1. Les pages dont la variable `format` a pour valeur « algolia » doivent utiliser un template de la forme `<layout>.algolia.twig`
2. Enregistrer le fichier sous `algolia.json`
3. La page de type `homepage` (listant toutes les pages du site) est maintenant au format « algolia » (en plus de « html » et « atom »)

Et voilà, l’index est maintenant généré et disponible à la racine du site généré : <https://cecil.app/algolia.json>.

#### Transmission de l’index

to do

#### Formulaire de recherche

to do
