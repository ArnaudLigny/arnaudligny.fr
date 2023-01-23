---
title: Arrêtez de faire des sites dynamiques
description: "Plaidoyer pour inviter les créateurs de sites web à considérer la création d'un site statique plutôt que dynamique."
#date: 2022-11-30
date: 2022-12-23
tags: SSG
#image: /images/2022-11-30-arretez-de-faire-des-sites-dynamiques/what-is-a-static-site.png
image: /images/blog/what-is-a-static-site.png
image_header: false
canonical:
  url: https://www.24joursdeweb.fr/2022/arretez-de-faire-des-sites-dynamiques/
  title: "24 jours de web"
#typora-copy-images-to: ../../assets/images/${filename}
typora-copy-images-to: ../../assets/images/blog
_display:
  reader: ['https://latribu.dev']
published: true
---
> Article rédigé à l'occasion des [24 jours de web 2022](https://www.24joursdeweb.fr/2022/arretez-de-faire-des-sites-dynamiques/).

La plupart des personnes souhaitant créer un site Web vont se tourner d’embler vers un CMS (« Content Management System » ou « Outil de gestion de contenu » en français).

En effet, utiliser un CMS est facile et relativement rapide (pour peu qu’on passe la barrière initiale de l’installation, pas toujours à la portée du ou de la première venu(e)) : après avoir choisi un joli thème, trouvé un nom pour son site, quelques clics suffisent pour publier une première page.

![Écran d’ordinateur affichant du code PHP (WordPress)](../../assets/images/blog/lavi-perchik-fSqYwKWzwhk-unsplash.jpg "Illustration de [Lavi Perchik](https://unsplash.com/photos/fSqYwKWzwhk)")

Néanmoins, une fois passé cette phase de découverte d’un outil qui semble magique on découvre les coûts cachés (maintenance, complexité de personnalisation des templates, failles de sécurités, etc. pour finalement terminer avec la perte de la base de données et de tout ses contenus rédigés avec amour…

<!-- break -->

## C’est quoi un site dynamique ?

Depuis l’avènement des langages de programmation web côté serveur (je pense notamment à ASP 3 et PHP 4 au début des années 2000), la majorité des sites sont devenus « dynamiques » : les contenus sont stockés dans une base de données (BDD), un script charge ces données – à la demande – et les affiche dans la Web consultée par l’internaute.

![Schéma illustrant le principe d'une page web dynamique](../../assets/images/blog/what-is-a-dynamic-site.png "Schéma illustrant le principe d'une page web dynamique, par [teleport](https://teleporthq.io)")

De fait, la consultation de chaque page d’un site nécessite l’exécution de tâches par le serveur afin d’afficher le résultat dans le navigateur.

Bien entendu il existe des mécanismes de mise en cache, c’est à dire la création d’une copie statique à un instant T, afin de ne pas avoir à re-réaliser les tâches permettant d’afficher la page si celle-ci est consultée dans un contexte équivalent par un autre visiteur.

Si les sites dynamiques ont un intérêt certain dans un objectif d’interaction avec l’internaute (création de compte, formulaire de saisie de commentaire, ajout au panier d’un site e-commerce, etc.) on peut se poser la question de leur utilité, voir de leur impact, dans le cas d’un site dont les contenus sont uniquement disponible pour consultation, ce qui est le cas de la majorité des contenus sur le Web.

Mais alors, quelle serait l’alternative ?

## Un site statique en 2022 ?

Depuis une dizaine d’année les outils de création de sites statiques, tels que [Jekyll](https://jekyllrb.com) ou [Hugo](https://gohugo.io), ne cessent de prendre de l'ampleur, et sont utilisés par de nombreux acteurs du Web : Google, Netflix, Mailchimp, Mapbox, etc.

![Schéma illustrant le principe d'un site web statique](../../assets/images/blog/what-is-a-static-site.png "Schéma illustrant le principe d'un site web statique, par [teleport](https://teleporthq.io)")

Cette manière de « générer » un site Web permet aux différents intervenants de se concentrer sur ce qui est réellement important, à savoir :

1. **le contenu** : les rédacteurs peuvent rédiger dans un format simple (le plus courant étant Markdown) qui facilite la portabilité et l'autonomie

2. **une mise en forme efficace** : les graphistes et les développeurs front-end peuvent se concentrer sur le rendu HTML et CSS  sans être contraint par la technologie plus ou moins propriétaire d’un CMS

### Avantages

* **Performance** : pas de tâches applicatives côté serveur ;
* **Sécurité** : pas de CMS exposée en frontal, donc un risque réduit d'intrusion ou de [défaçage](https://fr.m.wikipedia.org/wiki/D%C3%A9facement) ;
* **Découplage** : distinction entre l’outil de gestion des contenus et l’outil de création du site ;
* **Portabilité** : le contenu, rédigé en Markdown, peut-être importer et exporté à loisir

## En finir avec le dynamique systématique

Pourtant aujourd'hui la plupart des sites Web sont motorisés par des CMS (WordPress, Drupal, etc.) afin d'offrir à l'utilisateur une interface de gestion du contenu : écrire, mettre en forme, publier.

Néanmoins, l'avantage du dynamique, à savoir la possibilité d’éditer rapidement un contenu, est devenu contre performant en embarquant un système complexe et couteux alors que dans la pratique la plupart des contenus ne sont plus jamais modifiés après la publication initiale.

De plus, la majorités des sites concernés ne sont pas ou plus maintenu et exposent des failles de sécurité potentiel : c'est très souvent le cas avec des sites WordPress qui sont transformés en espaces publicitaires par des hackeurs malveillants.

Alors pourquoi ne pas revenir sur une approche statique, simple et adaptée au besoin de la plupart des gens ?

## Créer un site statique n’est pas si difficile

Si créer un site statique peut paraitre technique et accessible uniquement aux "nerds", c’est en réalité plutôt simple pour peu qu’on n’est pas peur de lancer une ligne de commande.

J’en veux pour preuve le nombre important de webdesigners qui migrent vers [Jekyll](https://jekyllrb.com/) ou [Eleventy](https://www.11ty.dev/) afin de publier leur blog ou leur portfolio.

### En pratique

Créer un site statique « moderne » tiens en 4 étapes :

1. rédiger le contenu dans éditeur de texte, idéalement au format [Markdown](https://www.markdownguide.org) pour plus de liberté ;
2. créer un template, c’est à dire une page [HTML](https://developer.mozilla.org/fr/docs/Learn/HTML/Introduction_to_HTML/Getting_started) contenant des balises dynamiques ;
3. exécuter une commande qui va s’occuper de fusionner le contenu et le template ;
4. déployer le site ainsi généré, c’est à dire copier les fichiers sur un serveur Web).

## Des contenus réutilisables

L'un des éléments clef de l'approche statique est certainement le découplage entre les contenus et la mise en forme : nous avons d’un côté des fichiers plats, éditables via n’importe quel éditeur de texte et de l’autre des templates.

D’autre part, les données structurées (ou "méta données") qui permettent de qualifier une page de contenu (titre, date, catégorie, auteur, etc.) sont dans un format répondant à un standard, le plus souvent [YAML](https://fr.m.wikipedia.org/wiki/YAML) ou [JSON](https://fr.m.wikipedia.org/wiki/Json), donc réutilisables.

Il est donc possible d'exploiter ces données dans un autre contexte, ou via un autre support de diffusion : Un même contenu peut ainsi être diffusé via un site Web, une application mobile, un web service (statique) ou encore [un livre imprimé](https://jamstatic.fr/2017/01/23/produire-des-livres-avec-le-statique/) !

## Sautez le pas !

Depuis la sortie de la version 1 de [Jekyll](https://jekyllrb.com) et de [Hugo](https://gohugo.io) en 2013, de très nombreux générateurs de site statique ont vu le jour, chacun avec ses avantages et ses inconvénients, à choisir selon ses besoins et ses contraintes.

Aussi je vous invite à sautez pas, en essayant par vous même via un vaste choix : <https://jamstack.org/generators/>.

*[BDD]: Base De Données
*[CMS]: Content Management System
