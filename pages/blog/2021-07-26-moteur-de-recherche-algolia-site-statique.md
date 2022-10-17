---
title: Un moteur de recherche sur un site statique grâce à Algolia
date: 2021-07-26
updated: 2022-01-04
tags: [SSG, Recherche, Cecil]
image: /images/2021-07-26-moteur-de-recherche-algolia-site-statique/cecil.app_documentation_templates_search.png
image_header: false
typora-root-url: ../../assets
typora-copy-images-to: ../../assets/images/${filename}
draft: true
---
Quand je travaillais à enrichir la [documentation en ligne](https://cecil.app/documentation/) de [Cecil](https://cecil.app), je me suis dit qu’il serait pertinent d’offrir un moteur de recherche *[full text](https://fr.m.wikipedia.org/wiki/Recherche_plein_texte)* aux utilisateurs.

![Exemple de résultat de recherche](/images/2021-07-26-moteur-de-recherche-algolia-site-statique/cecil.app_documentation_templates_search.png "Exemple de résultat de recherche")
<!-- break -->

La documentation de Cecil est composée de moins de 10 pages : une par thématique (configuration, gestion des contenus, création de template, etc.) et chacune d’elle contenant de nombreuses sections.

Aussi, il est important que les résultats retournés par un moteur de recherche soient granulaires, c’est à dire ciblant une section sur la totalité d’une page.

![Exemple de page de documentation](/images/2021-07-26-moteur-de-recherche-algolia-site-statique/cecil.app_documentation_templates.png "Exemple de page de documentation")

## Solution retenue ?

Dans un premier temps j’ai expérimenté le [moteur de recherche personnalisé de Google](https://cse.google.com/) (CSE) qui permet de présenter les résultats indexés par Google pour un site donné (comme avec le préfixe `site:`).  
Si les résultats sont pertinents pour un site contenant de nombreuses pages, il ne semble pas possible de personnaliser les résultats en fonction des sections d’une même page, ce qui n’est donc pas pertinent dans mon cas.

*[CSE]: Custom Search Engine

Aussi, après plusieurs comparatifs, j’ai retenu la solution [Algolia](https://www.algolia.com/) pour les raisons suivantes :

* Pertinence des résultats
* [Tarifs abordables](https://www.algolia.com/pricing/) (dont un plan gratuit)
* [Documentation riche](https://www.algolia.com/doc/)
* Nombreuses bibliothèques de code [open source](https://github.com/algolia)

## Comment ?

Je souhaitais que le champ de recherche soit disponible sur chacune des pages et qu’il montre immédiatement un extrait des résultats lors de la saisie d’un ou plusieurs mots clefs, et laissant le choix à l’utilisateur de sélectionner la page / section à consulter : j’ai donc opté pour l’approche [*Autocomplete*](https://www.algolia.com/doc/ui-libraries/autocomplete/introduction/what-is-autocomplete/).

### Créer un index

Pour intégrer cette bibliothèque il est nécessaire de comprendre le principe de fonctionnement d’Algolia.

Algolia s’appuie sur un [index](https://www.algolia.com/doc/guides/sending-and-managing-data/prepare-your-data/#algolia-index), c’est à dire une collection d’enregistrements, dans laquelle la recherche va être effectuée et dont le résultat permet d’afficher un certain nombre d’informations et de pointer vers la page Web correspondante.

Cet index est une [structure JSON](https://www.algolia.com/doc/guides/sending-and-managing-data/prepare-your-data/#algolia-records) relativement libre, composée de couples clef-valeur, permettant d’avoir de la matière dans laquelle chercher et d’ajuster les critères de recherche.

### Transmettre l’index

https://www.algolia.com/doc/guides/sending-and-managing-data/send-and-update-your-data/

https://www.algolia.com/doc/guides/sending-and-managing-data/send-and-update-your-data/how-to/importing-from-the-dashboard/

https://www.algolia.com/doc/api-client/getting-started/install/php/

https://www.algolia.com/doc/api-client/getting-started/install/javascript/



### Paramétrer l’index

Le paramétrage de l’index, à savoir déterminer les attributs dans lesquels rechercher, le classement et l’ordonnancement, etc. est relativement simplement à paramétrer depuis le [dashboard](https://algolia.com/dashboard).

Je dis *relativement* car il est parfois nécessaire d’effectuer quelques tests avant de maitriser les règles de priorisation des résultats.

![Dashboard Algolia](/images/2021-07-26-moteur-de-recherche-algolia-site-statique/image-20221017142612522.png "Dashboard Algolia")













**Exemple :**

```json
[
  {
    "objectID": "documentation/quick-start#download-cecil",
    "page": "Quick Start",
    "title": "Download Cecil",
    "description": "Download cecil.phar from your terminal:",
    "content": "...",
    "date": "2020-12-19T00:00:00+00:00",
    "href": "documentation/quick-start/#download-cecil",
    "experimental": "0"
  },
  ...
]
```

Dans cet exemple nous avons :

- `objectID` : Un ID unique
- `page` : Le nom de la page de documentation
- `title` : Le titre de section
- `description` : Le premier paragraphe de la section (utilisé pour illustrer l’aperçu des résiltats)
- `content` : Le contenu de la section, dans laquelle la recherche est effectuée
- `date` : La date de la page, utilisée pour pondérer les résultats
- `href` : Le lien vers la page de la documentation, combinée à une ancre afin d’emmener l’internaute à la bonne section
- `experimental` : Attribut utilisé afin de pondérer les résultats sur les fonctionnalités expérimentale (moins de poids)



















