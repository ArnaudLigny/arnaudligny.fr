---
title: "Diffuser son podcast avec Staticast"
description: "Staticast est un site web statique, généré avec Cecil, permettant de diffuser simplement son podcast."
date: 2022-09-09
tags: [Podcast, Cecil]
image: /images/2022-09-09-staticast-v2/staticast-preview.png
image_header: false
typora-root-url: ../../assets
typora-copy-images-to: ../../assets/images/${filename}
---
Pendant le confinement j’avais entrepris la création d’[une solution simple pour diffuser son podcast](/blog/2020-08-09-diffuser-son-podcast.md).

L’objectif était de permettre la création, de manière relativement simple, d’un site web de publication d’un podcast et de son flux [RSS](https://fr.m.wikipedia.org/wiki/Podcasting#Formats).

À l’époque [Staticast](https://staticast.cecil.app) était basé sur une version modifiée du thème de blog [Garth](https://github.com/Cecilapp/theme-garth#readme) et c’était « un peu moche ».

J’ai donc créé un thème dédié, beaucoup plus orienté « Web app ».

<!-- break -->

**Première version :**

![Capture d’écran de la première version de Staticast](/images/2022-03-29-staticast-v2/staticast-preview-garth.png "Capture d’écran de la première version de Staticast")

**Nouvelle version :**

![Capture d’écran de Staticast](/images/2022-03-29-staticast-v2/staticast-preview.png "Capture d’écran de la nouvelle version de Staticast")

Cette nouvelle version m’a été inspirée par [Layout](https://layout.fm) (un podcast de créateurs Web) car j’aimais beaucoup l’aspect épuré et la navigation en 2 colonnes.

## Fonctionnalités

Concernant les fonctionnalités, on retrouve toujours :

- un lecteur audio HTML natif (donc compatible avec ensemble des navigateurs Web)
- un flux RSS respectant le standards du podcast
- la mémorisation de la position de lecture pour chaque épisode
- la possibilité de télécharger le fichier MP3 d’un épisode

Mais aussi :

- un lien « resume » sur la page liste afin de (re)lancer la lecture d’un épisode, là on l’avait stoppée, en 1 clique
- une liste des plateformes auxquelles s’abonner (en plus du flux RSS)
- une PWA afin de permettre l’installation (sur mobile) et d’accéder aux épisodes hors ligne
- un mode sombre, s’affichant selon le paramétrage de l’appareil
- un bouton afin de marquer l’épisode comme « lu » ou « non lu »
- un bouton de [partage natif](https://developer.mozilla.org/fr/docs/Web/API/Navigator/share) de l’appareil (très utile sur mobile)
- une interface en ligne de gestion des épisodes ([Netlify CMS](https://www.netlifycms.org/))

## En savoir plus

Pour en savoir plus, et surtout pour savoir comment l’installer, je vous invite à vous rendre sur le site dédié : **[staticast.cecil.app](https://staticast.cecil.app)**.
