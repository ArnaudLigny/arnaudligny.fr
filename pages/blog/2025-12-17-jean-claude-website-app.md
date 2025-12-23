---
title: "Les aventures de Jean Claude : un site web et une app mobile"
description: "J’ai créé le site web et l’app mobile du jeu Les aventures de Jean Claude, avec Cecil."
date: 2025-12-17
tags: [Cecil]
image: /images/2025-12-17-jean-claude-website-app/jeanclaude-aventures.com.png
typora-root-url: ../../assets
typora-copy-images-to: ../../assets/images/${filename}
published: false
---
L’année dernière les camarades des éditions [Univers Détendu](https://universdetendu.com) ont financé leur projet de jeu sur [Ulule](https://fr.ulule.com/les-aventures-de-jean-claude/) : [Les aventures de Jean Claude](https://jeanclaude-aventures.com) 💀.

Suite à cette réussite, il était important de créer un site web afin de présenter le jeu, partager les règles au format PDF, etc.
Aussi, Cécile Ricordeau m’a demandé de créer une landing page, avec « ton générateur de site statique », sur la base d’un thème HTML/CSS acheté en ligne pour une bouché de pain afin de maitriser les coût et le temps de production.

<!-- break -->

## Création du site

J’ai donc accepté avec plaisir, parce que j’avais à la fois envie de donner un coup de main à ce super projet et que c’était l’occasion de mettre en œuvre Cecil sur un nouveau cas d’usage.

Aussi, je m’étais d’abord concentré sur la transformation du thème en templates Twig et… j’ai rapidement été confronté à tout un tas de mauvaises pratiques : duplication de styles CSS, abus de scripts, etc.

Bref, j’ai alors entrepris de m’inspirer du rendu global de ce thème pour en créer un sur mesure, à l’aide de mes connaissances de HTML et surtout de [Tailwind CSS](https://tailwindcss.com).

Ça m’a ainsi permis de réaliser un template de référence très épuré, performant et respectant un maximum de bonnes pratiques afin de booster le SEO : « [Jean Claude le jeu](https://www.google.com/search?q=jean+claude+le+jeu&oq=jean+claude+le+jeu) ».

![Site web jeanclaude-aventures.com](/images/2025-12-17-jean-claude-website-app/jeanclaude-aventures.com.png "Capture d'écran du site web.")

Parmi les fonctionnalités clefs de Cecil, le site exploite :

- la génération automatique des [meta tags orientés SEO](https://cecil.app/documentation/configuration/#metatags)
- l’[intégration d’une vidéo](https://cecil.app/documentation/content/#embedded-links) YouTube
- l’optimisation des images

## L’application mobile

Puis, quelques mois plus tard, l'équipe a imaginé une application web afin d'enrichir l'epérience de jeu, via un "sac à dos infini" virtuel permettant d'y piocher des idées afin d'amorcer la créativiter des joueurs.

L'idée était simple :

- une page web unique
- un affichage compatible avec un appareil mobile et une tablette
- une liste d'idées gérées via un tableur (au format CSV)
- un bouton affichant une idée priochée aléatoirement dans cette liste



![PWA Sac à dos infini de Jean Claude](/images/2025-12-17-jean-claude-website-app/jeanclaude-sac.netlify.app.png "Capture d'écran de l'application mobile (PWA).")

---
*[CSV]: "Comma-separated values"