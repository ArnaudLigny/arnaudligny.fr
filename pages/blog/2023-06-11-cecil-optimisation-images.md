---
title: "Optimisation des images avec Cecil"
description: "Comment Cecil optimise automatiquement les images dans les contenus écrit en Markdown et pour quels gains de performance."
date: 2023-06-11
tags: [Cecil, Performance]
image: images/web-dev-fast-load-times.svg
image_header: false
typora-root-url: ../../assets
typora-copy-images-to: ../../assets/images/${filename}
published: true
---
[Cecil](/tags/cecil), mon [générateur de site statique](https://cecil.app/), permet de manipuler des ressources web (_assets_) tels que les images, les styles (CSS ou Sass), les scripts, etc.

Si on se concentre sur les images, on peut considérer qu’il en existe de deux types selon l’usage :

1. les images habillant les templates
2. les images illustrant le contenu des pages

Dans la suite de cet article je vais me concentrer sur les images contenues dans les pages, et comment elles sont optimisées par Cecil.

![Illustration de Fast load times](/images/web-dev-fast-load-times.svg "Illustration de [Fast load times](https://web.dev/fast/)")

<!-- break -->

## Ajouter une image

Le contenu des pages étant rédigé en [Markdown](https://cecil.app/documentation/content/#markdown), les [images](https://cecil.app/documentation/content/#images) sont contribuées via la syntaxe suivante :

```markdown
![Description alternative](/image.jpg)
```

:::note
Remarque : Cecil va chercher l'image d'abord dans le dossier _assets_ puis, si elle ne s'y trouve pas, dans le dossier _static_.
:::

La balise HMTL générée sera de la forme :

```html
<img src="/image.jpg" alt="Description alternative">
```

## Optimisation automatique

Cecil ne se contente pas de générer une balise image comme indiqué précédemment : celle-ci est enrichie et le fichier est optimisé.

Par exemple, pour :

```markdown
![Description alternative](/image.jpg "Titre de l'image")
```

Le résultat pourrait être (pour une image en 800x600 px et selon les options de configuration de [`assets`](https://cecil.app/documentation/configuration/#assets) et [`body`](https://cecil.app/documentation/configuration/#body)) :

```html
<figure>
  <picture title="Titre de l'image">
    <source type="image/webp"
      srcset="/assets/thumbnails/320/image.webp 320w,
              /assets/thumbnails/640/image.webp 640w,
              /image.webp 800w"
      sizes="100vw"
    >
    <img src="/image.jpg"
      alt="Description alternative"
      width="800"
      height="600"
      loading="lazy"
      decoding="async"
      srcset="/assets/thumbnails/320/image.jpg 320w,
              /assets/thumbnails/640/image.jpg 640w,
              /image.jpg 800w"
      sizes="100vw"
    >
  </picture>
  <figcaption>Titre de l'image</figcaption>
</figure>
```

### Explications

- Le fichier image original est compressé (avec une qualité cible de 75% par défaut, suffisante pour un affichage web)
- Les attributs `width` et `height` sont déterminés depuis les propriétés du fichier
- L'attribut `loading="lazy"` est ajouté
- L'attribut `decoding="async"` est ajouté
- Les déclinaisons _responsives_ sont générées (selon les [options de configuration](https://cecil.app/documentation/configuration/#assets))
- Une source alternative au format [WebP](https://developers.google.com/speed/webp) est générée (avec ses déclinaisons _responsives_)
- Si un titre est ajouté, alors la balise `<image>` est encapsulée dans une balise `<figure>` afin d'y ajouter un `<figcaption>` contenant le texte correspondant (acceptant le format Markdown, pour y mettre un lien vers la source par exemple)

## Performance

Grâce à ces optimisations, les gains de performance sont non négligeables :

- Le temps de chargement des pages contenant des images est plus rapide via :
  1. la compression du fichier d’origine
  2. l’ajout d'une alternative dans un format « moderne » (WebP)
  3. l’utilisation de la basile `loading="lazy"` qui permet de ne charger que les images « visibles » (au dessus de la ligne de flottaison)
  4. l’utilisation de la basile `decoding="async"` qui permet de continuer à charger le contenu d’une page sans attendre celui des images
- L’ajout des dimensions évite le phénomène de [Cumulative Layout Shift (CLS)](https://web.dev/cls/)
- L’image est proposée au navigateur dans les dimensions les plus proches de celle du [viewport](https://developer.mozilla.org/docs/Glossary/Viewport) ([images adaptatives](https://developer.mozilla.org/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images))

Comme vous pouvez le constater, l’objectif est de simplifier le travail des personnes en charge de la rédaction des contenus, qui n’ont ainsi pas à se soucier d’optimiser manuellement (ou via des outils externes) leurs images d’illustration.

Si vous souhaitez en savoir plus, je vous invite à consulter la [documentation des images de Cecil](https://cecil.app/documentation/content/#images).
