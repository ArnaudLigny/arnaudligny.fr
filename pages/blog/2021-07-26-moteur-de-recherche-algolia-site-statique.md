---
title: Un moteur de recherche sur un site statique grâce à Algolia
date: 2021-07-26
updated: 2022-01-04
tags: [SSG, Recherche, Cecil]
image: /images/2021-07-26-moteur-de-recherche-algolia-site-statique/cecil.app_documentation_templates_search.png
image_header: false
typora-root-url: ../../static
draft: true
---
Il y a quelques mois, en travaillant sur la [documentation en ligne](https://cecil.app/documentation/) de [Cecil](https://cecil.app), je me suis dit qu’il serait pertinent d’offrir un moteur de recherche *[full text](https://fr.m.wikipedia.org/wiki/Recherche_plein_texte)* aux utilisateurs.

![Exemple de résultat de recherche](/images/2021-07-26-moteur-de-recherche-algolia-site-statique/cecil.app_documentation_templates_search.png)
<!-- break -->

La documentation de Cecil est composée de moins de 10 pages, une par thématique (configuration, gestion des contenus, création de template, etc.), et chacune d’elle contient de nombreuses sections.

Aussi, il est important que les résultats retournés soient granulaires, c’est à dire par section et sur la totalité de chaque page.

![Exemple de page de documentation](/images/2021-07-26-moteur-de-recherche-algolia-site-statique/cecil.app_documentation_templates.png)

Dans un premier temps j’ai expérimenté le [moteur de recherche personnalisé de Google](https://cse.google.com/) (CSE) qui permet de présenter les résultats indexés par Google pour un site donné (comme avec le préfixe `site:`).  
Si les résultats sont pertinents pour un site contenant de nombreuses pages, il ne semble pas possible de personnaliser les résultats en fonction des sections d’une même page, ce qui n’est donc pas pertinent dans mon cas.

*[CSE]: Custom Search Engine

Aussi, après plusieurs comparatifs, j’ai retenu la solution [Algolia](https://www.algolia.com/) pour les raisons suivantes :

* Pertinence des résultats
* [Tarifs abordables](https://www.algolia.com/pricing/) (dont un plan gratuit)
* [Documentation riche](https://www.algolia.com/doc/)
* Nombreuses bibliothèques de code [open source](https://github.com/algolia)

## Principe de fonctionnement

Dans le cas de la [documentation de Cecil](https://cecil.app/documentation/) je souhaitais afficher un champ de recherche disponible sur chacune des pages et montrant immédiatement un extrait des résultats lors de la saisie d’un ou plusieurs mots clefs, et laissant le choix à l’utilisateur de sélectionner la page / section à consulter : j’ai donc opté pour l’option [*Autocomplete*](https://www.algolia.com/doc/ui-libraries/autocomplete/introduction/what-is-autocomplete/).

Pour intégrer cette bibliothèque il est nécessaire de comprendre le principe de fonctionnement d’Algolia.

En effet, afin d’afficher des résultats, il est nécessaire de nourrir un référentiel