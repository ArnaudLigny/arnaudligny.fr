---
title: Optimisation des images avec Cecil
description: Comment Cecil optimise automatiquement les images dans les contenus rédigés en Markdown et pour quels gains de performance.
date: 2023-06-11
updated: 2025-07-13
tags: [Cecil, Performance]
years: [2023]
image: /images/2023-06-11-cecil-optimisation-images/undraw_Image_post_re_25wd.png
image_header: false
typora-root-url: ../../assets
typora-copy-images-to: ../../assets/images/${filename}
type: post
slug: cecil-optimisation-images
published: true
---
[Cecil](/tags/cecil), mon [générateur de site statique](https://cecil.app), permet de manipuler des ressources web (_assets_) tels que des images, des feuilles de styles (CSS ou Sass), des scripts, etc.

Dans le cas des images, on peut considérer qu’il en existe de deux types selon l’usage :

1. les images habillant les templates
2. les images illustrant le contenu des pages

Dans la suite de cet article je vais me concentrer sur les images contenues dans les pages, et comment elles sont optimisées par Cecil.

<!-- break -->

![Photographie aérienne d’une chaîne de montagnes recouverte de neige sous un ciel blanc et bleu de jour](../../assets/images/2023-06-11-cecil-optimisation-images/rohit-tandon-9wg5jCEPBsw-unsplash.jpg "Photo d'illustration de [Rohit Tandon](https://unsplash.com/fr/@sepoys)"){loading=eager fetchpriority=high}

## Ajout d'une image

Le contenu des pages étant rédigé en [Markdown](https://cecil.app/documentation/content/#markdown), les [images](https://cecil.app/documentation/content/#images) sont contribuées via la syntaxe suivante :

```markdown
![Description alternative](/image.jpg)
```

La balise HMTL générée sera de la forme :

```html
<img src="/image.jpg" alt="Description alternative">
```

:::info
Remarque : Cecil va d’abord chercher le fichier image dans le dossier _assets_ puis, si il ne s'y trouve pas, dans le dossier _static_ (cf. la [documentation officielle](https://cecil.app/documentation/content/#files-organization)).
:::

## Optimisation automatique

En l’état l’image s’affichera correctement dans un navigateur web, mais nécessiterait d’être « retraitée » pour de meilleures performances.

Ainsi, en activant les options adéquates, Cecil ne se contente pas de générer une balise image comme indiqué ci-dessus : la balise est enrichie et le fichier est optimisé.

Par exemple, considérons une image _image.jpg_ au format JPEG, de dimensions 800 x 600 pixels :

```markdown
![Description alternative](/image.jpg "Titre de l'image")
```

Avec les options [_assets_](https://cecil.app/documentation/configuration/#assets) et [_body_](https://cecil.app/documentation/configuration/#body) suivantes (paramétrées dans le fichier _config.yml_) :

```yaml
# Paramétrage global des assets de type image
assets:
  images:
    optimize: true
    quality: 75
    responsive:
      widths: [480, 640, 768, 1024]
      sizes:
        default: '(max-width: 480px) 480px, (max-width: 640px) 640px, (max-width: 800px) 768px, (max-width: 1600px) 1024px'
# Paramétrage des images au sein du contenu d'une page
pages:
  body:
    images:
      formats: [webp]
      responsive: true
      lazy: true
      decoding: true
      caption: true
```

Le rendu sera :

```html
<figure>
  <picture title="Titre de l'image">
    <source type="image/webp"
      srcset="/assets/thumbnails/480/image.webp 480w,
              /assets/thumbnails/640/image.webp 640w,
              /assets/thumbnails/768/image.webp 768w,
              /image.webp 800w"
      sizes="(max-width: 480px) 480px, (max-width: 640px) 640px, (max-width: 800px) 768px, (max-width: 1600px) 1024px"
    >
    <img src="/image.jpg"
      alt="Description alternative"
      width="800"
      height="600"
      loading="lazy"
      decoding="async"
      srcset="/assets/thumbnails/480/image.jpg 480w,
              /assets/thumbnails/640/image.jpg 640w,
              /assets/thumbnails/768/image.webp 768w,
              /image.jpg 800w"
      sizes="(max-width: 480px) 480px, (max-width: 640px) 640px, (max-width: 800px) 768px, (max-width: 1600px) 1024px"
    >
  </picture>
  <figcaption>Titre de l'image</figcaption>
</figure>
```

Description :

- Le fichier original est copié et compressé ;
- Les attributs `width` et `height` sont déterminés automatiquement depuis les propriétés du fichier ;
- L'attribut `loading="lazy"` est ajouté ;
- L'attribut `decoding="async"` est ajouté ;
- Les déclinaisons _responsives_ sont générées (selon les [options de configuration](https://cecil.app/documentation/configuration/#assets)) ;
- Une source alternative au format [WebP](https://developers.google.com/speed/webp) est générée (également avec ses déclinaisons _responsives_) ;
- Si un titre est ajouté alors la balise `<image>` est encapsulée dans une balise `<figure>` afin d'y ajouter une balise `<figcaption>` contenant le texte correspondant (acceptant le format Markdown, afin d’y mettre un lien vers la source par exemple).

### À propos des images responsives

Afin d’automatiser le traitement, Cecil propose la configuration suivante par défaut :

- redimensionnement automatique de l’image source selon les largeurs d’affichage les plus communes : 480, 640, 768, 1024, 1366, 1600, 1920 ;
- application de la largeur maximum via l’attribut size : `100vw`.

Néanmoins l’objectif est également de permettre la personnalisation de ces configurations afin d’adapter la génération au _design_ du site, par exemple :

```yaml
assets:
  images:
    responsive:
      widths: [480, 640, 768, 1024]
      sizes:
        default: '(max-width: 480px) 480px, (max-width: 640px) 640px, (max-width: 800px) 768px, (max-width: 1600px) 1024px'
```

## Gains de performance

Grâce à ces optimisations automatique, les gains de performance sont non négligeables :

- Le temps de chargement des pages contenant des images est accéléré via :
  1. La **compression du fichier** d’origine (avec une qualité cible de 75%, suffisante pour un affichage web) ;
  2. L’ajout d'une **alternative au format WebP**, plus léger et supporté par la majorité des navigateurs web ;
  3. La proposition de différentes dimensions (**images _responsives_** ou [images adaptatives](https://developer.mozilla.org/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images) en français), permettant au navigateur web d'utiliser celle qui est la plus adaptée à la zone d'affichage (_[viewport](https://developer.mozilla.org/docs/Glossary/Viewport)_) ;
  4. L’ajout de la balise **`loading="lazy"`** permettant de ne charger que les images « visibles » (au dessus de la ligne de flottaison) ;
  5. L’ajout de la balise **`decoding="async"`** permettant de continuer à charger le contenu d’une page sans attendre celui des images.
- L’ajout des dimensions évite le phénomène de [**Cumulative Layout Shift** (CLS)](https://web.dev/cls/).

## Conclusion

Comme vous pouvez le constater, l’objectif est de simplifier le travail des personnes en charge de la rédaction des contenus, qui n’ont ainsi pas à se soucier d’optimiser manuellement (ou via des outils externes) leurs images d’illustration.

Si vous souhaitez aller plus loin je vous invite à consulter la [documentation des images de Cecil](https://cecil.app/documentation/content/#images).
