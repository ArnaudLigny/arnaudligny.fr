---
title: "Low-Quality Image Placeholders (LQIP)"
description: "Comment Cecil optimise l’affichage des images pendant leur chargement."
date: 2024-03-15
updated: 2025-09-01
tags: [Cecil]
years: [2024]
image: images/2024-03-15-cecil-lqip/cecil-lqip-cover.png
image_header: false
typora-root-url: ../../assets
typora-copy-images-to: ../../assets/images/${filename}
published: true
---

> Ce billet fait suite à un [précédent article](/blog/cecil-optimisation-images) traitant des capacités de [Cecil](/tags/cecil) à optimiser les images (au sein des pages).

Même si les images ne bloquent pas le rendu d’une page web, il est important de penser à l’expérience utilisateur pendant leur chargement.

En effet, si une image n’est pas encore chargée et que ses dimensions (largeur x hauteur) sont définies, une zone vide sera affichée.

<!--break-->

Exemple :

[Exemple de chargement d’une image](/videos/2024-03-15-cecil-lqip/cecil-lqip-empty.mp4){embed}

L'une des approches possibles est *Low-Quality Image Placeholders* (LQIP), qui pourrait être traduit par « Espaces réservés aux images de basse qualité ».

## LQIP c’est quoi ?

Cette approche n’est pas nouvelle, conceptualisée par [Guy Podjarny](https://twitter.com/guypod) en 2013 : *[Introducing LQIP – Low Quality Image Placeholders](https://www.guypo.com/introducing-lqip-low-quality-image-placeholders)*.

Le principe est simple : afin de ne pas afficher une « boite vide » à l’endroit d’une image pas encore chargée, pourquoi ne pas afficher une version basse qualité, très légère donc rapide à charger ?

Exemple :

[Exemple de chargement d’une image avec LQIP](/videos/2024-03-15-cecil-lqip/cecil-lqip-data.mp4){embed}

## Implémentation

### Via JavaScript

Une approche commune est d’utiliser une bibliothèque JavaScript de « lazy loading » qui saura remplacer l’image basse qualité une fois l’image finale chargée par le navigateur :

```html
<img data-src="/hq-image.jpg"
     src="/low-image.jpg"
/>
```

Ici l’attribut `src` sera remplacé par la valeur de `data-src` via JavaScript.

### Via CSS

L’autre option, qui ne nécessite pas JavaScript, s’appuie sur CSS et plus particulièrement sur la propriété `background-image` :

```html
<img src="/hq-image.jpg"
     style="background-image:url(data:image/jpeg;base64,<data>);background-size:cover;"
/>
```

Ici `<data>` contient les données de l’image basse qualité, encodée en [base 64](https://developer.mozilla.org/docs/Web/HTTP/Basics_of_HTTP/Data_URLs).

C’est cette approche que j’ai retenu pour Cecil afin de ne pas imposer la dépendance à JavaScript.

## Utilisation avec Cecil

Son utilisation avec Cecil est très simple : il suffit d’ajouter l’attribut `placeholder=lqip` à une image formatée en Markdown :

```markdown
[Image d'exemple](/hq-image.jpg){placeholder=lqip}
```

Et… c’est tout 😊

De plus, afin de gagner en temps de génération, il est possible d’afficher non pas une image en basse qualité mais simplement la couleur dominante de l’image via `placeholder=color`.

Exemple :

[Exemple de chargement d’une image avec une couleur de fond](/videos/2024-03-15-cecil-lqip/cecil-lqip-color.mp4){embed}

Pour en savoir plus, je vous invite à consulter la documentation : <https://cecil.app/documentation/content/#placeholder>
