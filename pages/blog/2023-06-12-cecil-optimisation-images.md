---
title: "Optimisation des images avec Cecil"
description: "Cecil : Optimisation automatique des images pour de meilleures performances."
date: 2023-06-12
tags: [Cecil, performance]
#image: /images/
image_header: false
typora-root-url: ../../assets
typora-copy-images-to: ../../assets/images/${filename}
published: true
---

[Cecil](/tags/cecil), mon générateur de site statique, permet de manipuler des _assets_ tels que les images, les styles (au format CSS ou Sass), les scripts, etc.

Concernant les images il en existe de deux types :

1. les images habillant les templates
2. les images illustrant le contenu des pages

Dans la suite de cet article nous allons nous concentrer sur les images au sein des pages, et la manière sont elles sont automatiquement optimisées.

<!-- break -->

## Ajouter une image

Le contenu des pages étant rédigé en [Markdown](https://cecil.app/documentation/content/#markdown), les [images](https://cecil.app/documentation/content/#images) sont contribuées via la syntaxe suivante :

```markdown
![Description alternative](/image.jpg)
```

Cecil va chercher l'image d'abord dans le dossier _assets_ puis, si elle ne s'y trouve pas, dans le dossier _static_. Et la balise HMTL générée sera de la forme :

```html
<img src="/image.jpg" alt="Description alternative">
```
## Optimisation automatique

Cecil ne se contente pas de générer une balise HTML image comme indiqué précédemment : elle est enrichie et le fichier est optimisé.

Par exemple, pour :

```markdown
![Description alternative](/image.jpg "Titre de l'image")
```

Le résultat pourra être (selon les options de configuration de [`assets`](https://cecil.app/documentation/configuration/#assets) et [`body`](https://cecil.app/documentation/configuration/#body)) :

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

### Explications

- Le fichier image original est compressé (qualité à 70/100 par défaut)
- Les attributs `width` et `height` sont ajoutés automatiquement
- L'attribut `loading="lazy"` est ajouté
- L'attribut `decoding="async"` est ajouté
- Les déclinaisons *responsives* sont générées (selon les [options de configuration](https://cecil.app/documentation/configuration/#assets))
- Une source alternative au format [WebP](https://developers.google.com/speed/webp) est générée (avec ses déclinaisons *responsives*)
- Si un titre est ajouté, alors la balise `<image>` est entourée dans une balise `<figure>` afin d'y ajouter un `<figcaption>` contenant le texte correspondant (acceptant le format Markdown)

## Performance

Grâce à ces optimisations, les gains de performance sont non négligeables :

- Le temps de chargement des pages contenant des images est nettement plus rapide via :
  1. la compression des fichiers
  2. l’utilisation de la basile `loading="lazy"` permet de ne charger que les images « visibles » (au dessus de la ligne de flottaison)
  3. l’utilisation de la basile `ecoding="async"` permet de continuer à charger le contenu d’une page sans attendre celui des images
- Si le navigateur le supporte, une version au format [WebP](https://developers.google.com/speed/webp) est proposée
- L’ajout automatique des attributs `width` et `height` évite le phénomène de [Cumulative Layout Shift (CLS)](https://web.dev/cls/)
- L’image affichée est dans les dimensions les plus proches de celle du [viewport](https://developer.mozilla.org/docs/Glossary/Viewport) ([images adaptatives](https://developer.mozilla.org/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images))

