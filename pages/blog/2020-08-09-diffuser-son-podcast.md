---
title: "Diffuser son podcast simplement"
description: "Entre WordPress et les plateformes captives, il existe une troisième voie : diffuser son podcast avec une solution libre, auto-hébergée et statique."
date: 2020-08-10
updated: 2023-03-22
tags: [podcast, SSG, Cecil]
years: [2020]
image: /images/2020-08-09-diffuser-son-podcast/staticast-preview.png
published: true
---
Pendant le confinement j’ai écouté de nombreux podcasts divers et variés (depuis mon ordinateur ou mon smartphone) et j’ai constaté que la plupart des podcasteurs diffusaient leurs épisodes d’une des 2 manières suivantes :

1. auto-hébergé via un site [WordPress](https://fr.wordpress.com) équipé d’un plugin dédié (tel que [PowerPress](https://wordpress.org/plugins/powerpress/) ou encore [Seriously Simple Podcast](https://wordpress.org/plugins/seriously-simple-podcasting/)) : type de contenu dédié + lecteur « amélioré »;
2. via une plateforme de diffusion / hébergement dédiée (ex : [Ausha](https://fr.ausha.co), [podCloud](https://podcloud.fr/pricing), etc.) : facilité d’utilisation, nombreux services, mais captif.

Aussi, je me suis dis que ça pourrait être intéressant de proposer une solution alternative libre et open-source.
<!-- break -->
[toc]

## L'idée

Cette solution aurait pour objectifs :

1. d’être auto-hébergée (ou plutôt : que l’on puisse l’héberger sur le serveur web de son choix et qu’elle puisse être migrée avec peu d'efforts);
2. d’être simple à contribuer (déposer le fichier audio de l’épisode + rédiger la description);
3. de générer automatique le flux [RSS](https://fr.m.wikipedia.org/wiki/RSS) contenant les balises spécifiques au [podcasting](https://fr.m.wikipedia.org/wiki/Podcasting).

## Concrétisation

Étant moi-même intéressé par les solutions « [statiques](https://arnaudligny.fr/talks/le-statique-c-est-fantastique/) », en particulier via [Cecil](https://cecil.app) ([mon générateur de site statique](https://arnaudligny.fr/blog/cecil-mon-generateur-de-site-statique/)) j’ai entrepris de créer un template « clef en main » permettant de créer rapidement un site web de diffusion de podcast : [***Staticast***](https://github.com/Cecilapp/staticast#readme).

[Démo de Staticast](/videos/2020-08-09-diffuser-son-podcast/staticast-demo.mp4){embed autoplay loop muted poster=videos/2020-08-09-diffuser-son-podcast/staticast-demo-poster.png}

→ [Voir le site de démo](https://staticast.cecil.app)

## Le principe

Le principe est très simple : il s’agit de templates [Twig](https://twig.symfony.com/) (basés sur le thème [Garth](https://github.com/daviddarnes/garth) de [David Darnes](https://darn.es/)) combinés avec les contenus (fichiers audio + fichiers [Markdown](https://fr.m.wikipedia.org/wiki/Markdown)) par [Cecil](https://cecil.app) pour générer un site statique exposant un flux RSS basé sur la liste des épisodes.

Ni plus, ni moins.

## En pratique

La mise en œuvre est relativement simple (mais nécessite néanmoins quelques connaissances techniques).

### Installation

1. S’assurer que l'ordinateur est équipé de [PHP](https://php.net) (ce qui est le cas sur macOS et de nombreuses distributions Linux);
2. [Télécharger *Staticast*](https://github.com/Cecilapp/staticast/archive/master.zip) et installer le thème via la commande `composer install`;
3. [Télécharger `cecil.phar`](https://github.com/Cecilapp/Cecil/releases/latest/download/cecil.phar) et le placer à la racine du dossier.

### Création d'un épisode

1. Déposer le fichier audio dans le dossier `static/audio`;
2. Créer la page de présentation dans `content/episodes` (en s’inspirant des exemples présents dans ce dossier);
3. Supprimer les fichiers exemples.

### Génération du site et prévisualisation

1. Exécuter la commande `php cecil.phar serve` depuis un terminal;
2. Ouvrir l’adresse `http://localhost:8080` dans un navigateur web.

### Publication

Une fois satisfait du résultat localement, il ne reste plus qu'à publier le site sur un serveur web :

1. Exécuter la commande `php cecil.phar build` depuis un terminal;
2. Copier le contenu du dossier `_site` sur le serveur web.

## Conclusion

Et voilà ! 🎉

[***Staticast***](https://github.com/Cecilapp/staticast) nécessite de devoir mettre un peu les mains dans le cambouis, mais rien d'insurmontable. Et surtout, une fois l'étape d'installation réalisée, l'utilisation au quotidien est très simple !

> **Mise à jour d’octobre 2020**  
> J’ai ajouté la possibilité de créer un nouveau projet Staticast hébergé par Netlify et fournissant un CMS pré-configuré :  
> [![Déployer sur Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/Cecilapp/staticast&stack=cms "Déployer sur Netlify")
