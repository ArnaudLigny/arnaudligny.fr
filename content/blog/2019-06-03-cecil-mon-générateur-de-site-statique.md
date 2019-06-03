---
title: "Cecil : mon générateur de site statique"
date: 2019-06-03
tags: [Développement, SSG]
published: false
---

[Cecil](https://cecil.app/) est un projet personnel, se présentant sous la forme d'une application en [ligne de commande](https://fr.m.wikipedia.org/wiki/Interface_en_ligne_de_commande) facilitant la création d’un site web.

<blockquote class="twitter-tweet tw-align-center" data-lang="fr"><p lang="en" dir="ltr">Create and deploy a static blog in 1 minute with <a href="https://twitter.com/Cecil_Static?ref_src=twsrc%5Etfw">@Cecil_Static</a> (<a href="https://t.co/FzVEkJ7VaL">https://t.co/FzVEkJ7VaL</a>) and <a href="https://twitter.com/Netlify?ref_src=twsrc%5Etfw">@Netlify</a>, from a mobile phone! 😁 <a href="https://t.co/AMx3hPpaCd">pic.twitter.com/AMx3hPpaCd</a></p>&mdash; Arnaud Ligny 👨‍💻 💡 🚀 (@ArnaudLigny) <a href="https://twitter.com/ArnaudLigny/status/1123984989270544386?ref_src=twsrc%5Etfw">2 mai 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Le concept (et la première version) a émergé en 2013 et depuis je n’ai cessé de faire évoluer l’application, de l'enrichir, tout en essayant de respecter le principe suivant :

> L’application doit être simple à appréhender et le contenu doit être au cœur de son usage.

<!-- break -->

## Un générateur de site statique ?

Cecil n’est pas un CMS ([Système de gestion de contenu](https://fr.m.wikipedia.org/wiki/Syst%C3%A8me_de_gestion_de_contenu)) mais « uniquement » un outil facilitant la création d’un site web à partir :

1. de contenus (textes et images)
2. de templates HTML/CSS

Ainsi Cecil va injecter les contenus — souvent rédigés sous la forme d’articles, de billets de blog, ou encore de simples pages de texte — dans un template qui lui va garantir la mise en forme pour une mise à disposition sur le web.

En pratique c’est ce que fait n’importe quel outil de publication dynamique de contenu (tel que [WordPress](https://fr.m.wikipedia.org/wiki/WordPress) par exemple), sauf que ce dernier (re)génère la page à chaque consultation par l'internaute et que très souvent les données textuels sont enregistrées dans une [base de données](https://fr.m.wikipedia.org/wiki/Base_de_donn%C3%A9es).

Dans le cas d’un générateur comme Cecil le site est créé (ou « généré ») en une seule fois, à chaque modification (texte ou mise en forme) sous la forme d’une arborescence de fichiers : pages HTML, feuilles de styles, images, etc.

Une fois le site web (re)généré, il suffit de le publier sur n’importe quelle plateforme d’hébergement de site web pour le rendre disponible.

**C’est pour cela que l’on utilise le terme de « site statique » : le site web généré s’« auto-suffit », c’est à dire qu'il n’a pas besoin d’être interprété (dynamiquement) par le serveur pour être consulté depuis un navigateur web.**

## Pourquoi créer un nouvel outil ?

En effet, quand j’ai commencé à imaginer cette application [la mouvance statique](https://frank.taillandier.me/2016/03/08/les-gestionnaires-de-contenu-statique/) était déjà engagée et il existait déjà de nombreux générateurs de site statique, tels que : [Jekyll](https://jekyllrb.com/), [Pelican](https://getpelican.com), [Sculpin](https://sculpin.io/), [Nikola](https://getnikola.com), [Hexo](https://hexo.io/), [Spress](https://spress.yosymfony.com/), ou encore [Hugo](https://gohugo.io/) qui était très prometteur !

La réponse tiens en 3 points :

1. J’avais besoin d’un outil très simple fonctionnellement et techniquement
2. Je souhaitais utiliser un moteur de template complet et agréable à utiliser au quotidien
3. Enfin, naissait l’envie — après la naissance de mon fils — de me lancer dans énième *side project* 😄

> Concernant la programmation, je n’avais ni le temps ni l’envie d’investir dans un nouveau langage en dehors de mon temps de travail. Aussi j’ai préféré enrichir et développer mes connaissance déjà solide en PHP. Plusieurs années après je regrette nullement ce choix !

## Comment Cecil fonctionne ?

Cecil est donc une application en ligne de commande...

to do

