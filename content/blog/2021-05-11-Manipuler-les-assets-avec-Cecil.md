---
title: Manipuler les assets avec Cecil
date: 2021-05-11
published: false
---

Dans cet article je vais vous montrer comment [Cecil](https://cecil.app), [mon générateur de site statique](/blog/cecil-mon-generateur-de-site-statique/), permet de manipuler des assets, sans dépendances à des outils tiers.

```twig
<link rel="stylesheet" href="{{ asset('css/styles.scss')|to_css|minify|fingerprint }}">
```

## Les bases

Un _asset_ est une **ressource web, tel qu’un fichier CSS, JavaScript ou encore une image**, permettant d’habiller ou de dynamiser un site web.

Ainsi, une feuille de styles peut être chargée en indiquant simplement le chemin vers le fichier correspondant :

```html
<link rel="stylesheet" href="/css/styles.css">
```

Dans l’exemple ci-dessus l’URL vers le fichier de la feuille de styles est « en dur » dans le template HTML et c’est souvent suffisant dans la plupart des cas.

Néanmoins, on peut rapidement se poser les questions suivantes :

- Comment compresser ma feuille de styles pour gagner en performance ?
- Comment compiler ma feuille de style au format [Sass](https://sass-lang.com) et modifier des variables ?
- Comment informer les navigateurs web que ma feuille de style à été modifiée et ne pas demander aux internautes de « vider le cache » ?

Cecil, grâce à sa fonction [`asset()`](https://cecil.app/documentation/templates/#asset) combinée à quelques [filtres Twig](https://cecil.app/documentation/templates/#filters), répond à ces besoins.
<!-- break -->

## Créer un asset

Reprenons l’exemple précédent en y appliquant la fonction `asset()` :

```twig
<link rel="stylesheet" href="{{ asset('css/styles.css') }}">
```

On crée ainsi un objet « asset » à partir du fichier `styles.css` préalablement déposé dans le dossier `static/css/` du projet.

### Compilation Sass

Le filtre `to_css` compile un asset de type [Sass](https://sass-lang.com).

Template :

```twig
<link rel="stylesheet" href="{{ asset('css/styles.scss')|to_css }}">
```

Rendu :

```html
<link rel="stylesheet" href="/css/styles.css">
```

### Minification

Le filtre `minify` compresse un asset du type CSS ou JavaScript.

Template :

```twig
<link rel="stylesheet" href="{{ asset('css/styles.css')|minify }}">
```

Rendu :

```html
<link rel="stylesheet" href="/css/styles.min.css">
```

### Prise d’empreinte (fingerprinting)

Le filtre `fingerprint` créé l’empreinte de la ressource (d’après son contenu) et complète le nom du fichier en conséquence.   Ainsi, si le fichier image est modifié il aura une aura empreinte différente lors de la génération du site : le consommateur du fichier image considérera donc que cette ressource est différente de celle qu’il a dans son cache et téléchargera l’image modifiée.

Template :
```twig
<link rel="stylesheet" href="{{ asset('css/styles.css')|fingerprint }}">
```
Rendu :
```html
<link rel="stylesheet" href="/css/styles.e549285c8ffa8af5e6254263c98d4397.css">
```

### Regroupement (bundle)

La fonction `asset()` peut également combiner une liste d’assets du même type.

Template :

```twig
<link rel="stylesheet" href="{{ asset(['css/styles-a.css', 'css/styles-b.css']) }}">
```

Rendu :

```html
<link rel="stylesheet" href="/css/styles.css">
```

### Sécurisation

to

### Personnalisation de la compilation Sass

to do

```yaml
assets:
  compile:
    enabled: true
    style: expanded
    import: [sass, scss]
    variables:
      primary: '#5a5a5a'
```

https://cecil.app/documentation/configuration/#assets

### Inline

to do

### Elément HTML

to do

### Attributs d’un asset

https://cecil.app/documentation/templates/#attributes

- `file`: filesystem path
- `path`: relative path
- `ext`: extension
- `type`: media type (ie: `image`)
- `subtype`: media sub type (ie: `image/jpeg`)
- `size`: size in octets
- `source`: content before compiling and/or minifying
- `content`: file content
- `integrity`: integrity hash
- `width`: image width
- `height`: image height
- `audio`: [Mp3Info](https://github.com/wapmorgan/Mp3Info#audio-information)

### Fichier distant

to do

