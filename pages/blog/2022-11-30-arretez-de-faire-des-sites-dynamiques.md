---
title: Arrêtez de faire des sites dynamiques
date: 2022-11-30
draft: true
---

Aujourd'hui, la plupart des personnes souhaitant créer un site Web vont se tourner d’embler un CMS, « Content Management System » ou « Outil de gestion de contenu » en français (tel que WordPress, très populaire).

En effet, utiliser un CMS semble facile et rapide (pour peu qu’on passe la barrière initiale de l’installation logiciel, pas toujours à la portée du ou de la première venu(e)) : après avoir choisi un joli thème, trouvé un nom pour son site, quelques clics suffisent pour publier une première page de contenu.

![Code PHP](../../assets/images/2022-11-30-arretez-de-faire-des-sites-dynamiques/lavi-perchik-fSqYwKWzwhk-unsplash.jpg "Source : https://unsplash.com/photos/fSqYwKWzwhk par Lavi Perchik")

Néanmoins, une fois passé cette phase de découverte d’un outil qui semble magique on découvre les coûts cachés : la maintenance (montée de version), la complexité de personnalisation des templates, les
montées de version, les failles de sécurités, pour finalement terminer avec la perte de la
base de données et de tout leurs contenus rédigés avec amour...

Et toute cette énergie dépensée pour quoi ? Pour des contenus statiques, rédigés le plus souvent en une fois et rarement modifiés par la suite.

Si nos contenus sont statiques, alors pourquoi créer systématiquement un site statique ? Quelles sont les alternatives ?

## Sites Web dynamiques

Depuis l’avènement des langages de programmation web côté serveur (je pense notamment à ASP 3 et PHP 4 au début des années 2000), la majorité des sites Web sont devenus « dynamiques » : les contenus sont stockés dans une BDD, un script charge ces données – à la demande – et les affiche dans la Web consultée par l’internaute.

De fait, chaque consultation de chaque page d’un site Web nécessite l’exécutio nde tâches par la se serveur afin d’afficher le résultat dans le navigateur. 

Bien entendu il existe des mécanismes de mise en cache, c’est à dire la création d’une copie statique à un instant T, afin de ne pas avoir à re-réalsier les tâches peemttant d’afficher la page si celle-ci est consulter dans un contexte équivalent.

Si les sites dynamiques ont un intérêt certain dans un contexte d’interaction avec l’internaute (création de compte, formulaire de commentaire, ajout au panier d’un site e-commerce, etc.) on peut se poser la question de leur utilité, voir de leur impact, dans le cas d’un site sont ls contenus sont uniquement consulté.

## Retour aux site statiques

Depuis une dizaine d’année les outils de création de sites statiques, tels que [Jekyll](https://jekyllrb.com) ou [Hugo](https://gohugo.io), ne cessent de prendre de l'ampleur, et sont utilisés par de nombreux acteurs du Web : Google, Netflix, Mailchimp, Mapbox, etc.

Cette manière de « générer » un site Web permet aux différents intervenants de se concentrer sur ce qui est réellement important, à savoir :

1. **le contenu** : les rédacteurs peuvent rédiger dans un format simple (le plus courant étant Markdown) qui facilite la portabilité et l'autonomie

2. **une mise en forme efficace** : les graphistes et les développeurs front-end peuvent se concentrer sur le rendu HTML et CSS  sans être contraint par la technologie plus ou moins propriétaire d’un CMS

### Arguments clefs

* **Performance** : pas de tâches applicatives côté serveur ;
* **Sécurité** : pas de CMS exposée en frontal, donc un risque réduit d'intrusion ou de [défaçage](https://fr.m.wikipedia.org/wiki/D%C3%A9facement) ;
* **Découplage** : distinction entre l’outil de gestion des contenus et l’outil de création du site ;
* **Portabilité** : le contenu, rédigé en Markdown, peut-être importer et exporté à loisir

## Pour en finir avec le dynamique systématique

Aujourd'hui la plupart des sites Web sont motorisés par des CMS (ex : WordPress, Drupal) afin d'offrir à l'utilisateur une interface de gestion du contenu : écrire, mettre en forme, publier.

Ces contenus sont stockées dans une BDD qui est sollicitée à chaque fois qu'une page est consultées par un internaute (au delta d'une éventuelle solution de cache comme indiqué plus haut).

L'avantage du dynamique, à savoir la possibilité d’éditer rapidement un contenu, est devenu contre performant en embarquant un système complexe et couteux alors que dans la pratique la plupart des contenus ne sont plus jamais modifiés après la publication intiale.

De plus, la majorités des sites concernés ne sont pas/plus maintenu et exposent des failles de sécurité potentiel : c'est très souvent le cas avec des sites Wordpress qui sont transformés en espaces publicitaires par des hackeurs malveillants.

Pourquoi donc ne pas revenir sur une approche statique, simple et adaptée au besoin de la plupart des gens ?

## Créer un site statique c'est facile

Créer un site statique peut paraitre technique et accessible uniquement aux "nerds", mais en réalité c’est plutôt facile.

De nombreux webdesigners migrent de WordPress vers Jekyll ou équivalent pour publier leur blog ou leur portfolio… c'est bien une preuve que la courbe d'apprentissage n’est pas insurmontable :-)

### Le principe

Le principe est le suivant :

1. rédaction des contenus (au format [Markdown](https://www.markdownguide.org)) ;
2. création des templates ;
3. génération des pages (c’est à dire la fusion entre les contenus et els templates) ;
4. déploiement du site (soit simplement la copie des fichiers sur un serveur Web).

## Des contenus réutilisables

L'un des éléments clef de l'approche "statique" c'est le découplage des contenus et de la plateforme.

Aussi, les contenus sont gérés dans des fichiers plats, qui peuvent être ouvert dans n'importe quel éditeur de texte simple.

De plus les données structurées, les "meta données" qui vont qualifier un contenu (titre, date, catégorie, auteur, etc.) sont dans un format standard, le plus souvent [Yaml](https://fr.m.wikipedia.org/wiki/YAML) ou [Json](https://fr.m.wikipedia.org/wiki/Json).

Il est donc possible d'exploiter ces données dans un autre contexte, ou sur un autre media : Le même contenu pour un site Web, une version mobile, ou même un livre (https://jamstatic.fr/2017/01/23/produire-des-livres-avec-le-statique/) !

## Gérer son contenu via un CMS headless

Pour aller plus loin et simplifier la gestion du contenu





*[BDD]: Base De Données
*[CMS]: Content Management System