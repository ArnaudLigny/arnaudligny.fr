---
title: Un moteur de recherche sur un site statique grâce à Algolia
date: 2021-07-26
tags: [SSG, Recherche, Cecil]
image: /images/2021-07-26-moteur-de-recherche-algolia-site-statique/cecil.app_documentation_templates_search.png
image_header: false
typora-root-url: "../../static"
draft: true

---
Il y a quelques mois, en travaillant sur la [documentation en ligne](https://cecil.app/documentation/) de [Cecil](https://cecil.app), je me suis dit qu’il serait pertinent d’offrir un moteur de recherche *[full text](https://fr.m.wikipedia.org/wiki/Recherche_plein_texte)* aux utilisateurs.

La documentation de Cecil est composée de moins de 10 pages, une par thématique (configuration, gestion des contenus, création de template, etc.), et chacune d’elle contient de nombreuses sections.

![Exemple de page de documentation](/images/2021-07-26-moteur-de-recherche-algolia-site-statique/cecil.app_documentation_templates.png)
<!-- break -->
Aussi, il est important que les résultats retournés soient granulaires, par section et non globaux à la page.





Dans un premier temps j’ai expérimenté le [moteur de recherche personnalisé de Google](https://cse.google.com/) (CSE) qui permet de présenter les résultats indexés par Google pour un site donnée uniquement (comme avec la commande `site:`).  
Si les résultats sont pertinents pour un site contenant de nombreuses pages, il ne semble pas possible de personnaliser les résultats par sections dans une même page, ce qui n’était pas pertinent dans mon cas.

Aussi, après plusieurs comparatifs, j’ai retenu la solution [Algolia](https://www.algolia.com/) pour les raisons suivantes :

* efficacité reconnue
* [tarifs abordables](https://www.algolia.com/pricing/) (dont un plan gratuit)
* [documentation riche](https://www.algolia.com/doc/)
* nombreuses bibliothèques de code [open source](https://github.com/algolia)




![Exemple de résultat de recherche](/images/2021-07-26-moteur-de-recherche-algolia-site-statique/cecil.app_documentation_templates_search.png)

*[CSE]: Custom Search Engine
