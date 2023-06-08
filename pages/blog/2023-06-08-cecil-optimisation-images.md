---
title: "Optimisation des images avec Cecil"
description: "Gestion et optimisation automatique des images avec Cecil."
date: 2023-06-08
tags: [Cecil]
#image: /images/
image_header: false
typora-root-url: ../../assets
typora-copy-images-to: ../../assets/images/${filename}
published: false
---

[Cecil](/tags/cecil), mon générateur de site statique, permet de manipuler des assets dont les images habillant les templates et celles illustrant le contenu des pages.

Ainsi, il existe deux approches pour gérer les fichiers image :

2. Soit en les déposant dans le dossier _assets_ : ils seront manipulables via la fonction [`asset()`](https://cecil.app/documentation/templates/#asset) au sein des templates
2. Soit en les déposant dans le dossier _static_ : ils seront copiés tel quel dans le site généré, selon la même arborescence

Dans cet article je vais mettre l'accent sur les fonctionnalités permettant d'optimiser les images au sein d'une page de contenu.

## Ajouter une image dans une page

Le contenu des pages étant rédigé dans le format [Markdown](https://cecil.app/documentation/content/#markdown), les [images](https://cecil.app/documentation/content/#images) sont contribuées via la syntaxe suivante :

```markdown
![Description alternative](/image.jpg)
```

La balise HMTL générée sera de la forme :

```html
<img src="/image.jpg" alt="Description alternative">
```

Cecil va chercher l'image (ici `image.jpg`) d'abord dans le dossier _assets_ puis, si elle ne s'y trouve pas, dans le dossier _static_.

## Optimisation automatique

Cecil ne se contente pas de générer une image HTML comme indiquée précédemment : la balise sera enrichie et le fichier optimisé.

Ainsi, pour :

```markdown
![Description alternative](/image.jpg "Titre de l'image")
```

Le résultat sera :

```html
<figure>
  <picture title="Titre de l'image">
    <source type="image/webp"
      srcset="/assets/thumbnails/320/image.webp 320w,
              /assets/thumbnails/640/image.webp 640w,
              /assets/thumbnails/800/image.webp 800w"
      sizes="100vw"
    >
    <img src="/assets/thumbnails/800/image.jpg"
      alt="Description alternative"
      width="800"
      height="600"
      loading="lazy"
      decoding="async"
      srcset="/assets/thumbnails/320/image.jpg 320w,
              /assets/thumbnails/640/image.jpg 640w,
              /assets/thumbnails/800/image.jpg 800w"
      sizes="100vw"
    >
  </picture>
  <figcaption>Titre de l'image</figcaption>
</figure>
```

Explications :

- Le fichier image original est compressé (qualité à "70%)
- Les attributs `width` et `height` sont ajoutés
- L'attribut `loading="lazy"` est ajouté
- L'attribut `decoding="async"` est ajouté
- Les déclinaisons *responsives* sont générées (selon les règles définies dans la configuration)
- Une source alternative au format "moderne" WebP est générée (avec ses déclinaisons *responsives*)
- Si un titre est ajouté alors la balise `<image>` est entourée dans une balise `<figure>` afin d'y ajouter un `<figcaption>` contenant le texte correspondant

Notes :

- Les différentes largeurs des déclinaisons _responsives_ sont configurables
- La valeur de l'attribut `sizes` est configurable
- De manière générale, l'ensemble des optimizations sont configurables

