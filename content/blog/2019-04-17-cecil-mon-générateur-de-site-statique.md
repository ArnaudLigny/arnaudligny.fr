---
title: "Cecil : mon générateur de site statique"
date: 2019-04-17
tags:
  - Développement
  - SSG
published: false
---

[Cecil](https://cecil.app/) est un projet personnel, se présentant sous la forme d'une application en [ligne de commande](https://fr.m.wikipedia.org/wiki/Interface_en_ligne_de_commande) facilitant la création d’un site web.

Le concept et la première version ont émergés en 2013 et depuis l’application n’a cessée dévoluer, d’être enrichi, tout en respectant le principe suivant :

> L’application doit être simple à appréhender et le contenu au coeur de son usage.

## Un générateur de statique ?

Cecil n’est pas un CMS ([Système de gestion de contenu](https://fr.m.wikipedia.org/wiki/Syst%C3%A8me_de_gestion_de_contenu)) mais « uniquement » un outil facilitant la création d’un site web à partir :

1. de contenus (textes et images)
2. de templates HTML/CSS

Ainsi Cecil va injecter les contenus — souvent rédigés sous la forme d’articles, de billets de blog, ou encore de simples pages de texte — dans un template qui lui va garantir la mise en forme pour une mise à disposition sur le web.

En pratique c’est ce que fait n’importe quel outil de publication dynamique de contenu (tel que [WordPress](https://fr.m.wikipedia.org/wiki/WordPress) par exemple), sauf que ce dernier (re)genère la page à chaque consultation par l'internaute et que très souvent les données textuels sont enregistrées dans une [base de données](https://fr.m.wikipedia.org/wiki/Base_de_donn%C3%A9es).

Dans le cas d’un générateur comem Cecil le site est créé (ou « généré ») en une seule fois, à chaque modification (texte ou mise en forme) sous la forme d’une arborescence de fichiers : pages HTML, feuilles de styles, images, etc.

Une fois le site web (re)généré, il suffit de le publier sur n’importe quelle plateforme d’hébergement de site web pour le rendre disponible.

**C’est pour cela que l’on utilise le terme de « site statique » : le site web généré s’ « auto-suffit », c’est à dire qu'il n’a pas besoin d’être interprété (transformé) par le serveur pour être consulté depuios un navigateur web.**

