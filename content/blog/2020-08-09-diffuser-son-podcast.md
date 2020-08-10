---
title: Diffuser son podcast avec Staticast
date: 2020-08-09
tags: [Podcast, SSG, Cecil]
#image: /images/staticast/staticast-preview.png
draft: true
typora-root-url: ../../static
---

Pendant le confinement j’ai écouté de nombreux podcasts divers et variés, depuis mon ordinateur, et j’ai constaté que la plupart des podcasteurs diffusaient leurs épisodes selon les 2 manières suivantes :

1. de manière auto-hébergé via un site [WordPress](https://fr.wordpress.com) équipé d’un plugin dédié (tel que [PowerPress](https://wordpress.org/plugins/powerpress/) ou [Seriously Simple Podcast](https://wordpress.org/plugins/seriously-simple-podcasting/)) : type de contenu dédié + player « amélioré »
2. via une plateforme de diffusion/hébergement dédiée ([Ausha](https://fr.ausha.co), [podCloud](https://podcloud.fr/pricing), etc.) : facilité d’utilisation, nombreux services, mais captif.

## L'idée

Aussi, je me suis dis que ça pourrait être intéressant de proposer une solution alternative, auto-hébergeable (ou plutôt : que l’on peut héberger sur n’importe quel serveur Web et migrer sans effort), simple à contribuer (déposer le fichier audio de l’épisode + rédiger la description) et qui génère automatique un flux [RSS](https://fr.m.wikipedia.org/wiki/RSS) contenant les balises spécifiques au [podcasting](https://fr.m.wikipedia.org/wiki/Podcasting).

Étant moi-même intéressé par les solutions « [statiques](https://arnaudligny.fr/talks/le-statique-c-est-fantastique/) », en particulier via [Cecil](https://arnaudligny.fr/tags/cecil/) ([mon générateur de site statique](https://arnaudligny.fr/blog/cecil-mon-generateur-de-site-statique/)) j’ai entrepris pendant le confinement de créer un template — clef en main — permettant de créer rapidement un site de diffusion de son podcast : [***Staticast***](https://github.com/Cecilapp/staticast).

<video autoplay loop muted>
  <source src="/images/staticast/staticast-demo.mp4" type="video/mp4">
</video>

## Le principe

Le principe est très simple : il s’agit d’un ensemble de templates [Twig](https://twig.symfony.com/) (basés sur le thème [Garth](https://github.com/daviddarnes/garth) de [David Darnes](https://darn.es/)) qui sont manipulés par [Cecil](https://cecil.app) pour gérére un site statique exposant un flux RSS basé sur la liste des épisodes. Ni plus, ni moins.

## La pratique

...