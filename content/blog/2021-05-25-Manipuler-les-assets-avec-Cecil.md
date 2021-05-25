---
title: Manipuler les assets avec Cecil
description: "Dans cet article j‘explique comment Cecil permet de manipuler des assets, sans dépendances à des outils tiers."
date: 2021-05-25
tags: [Cecil, asset]
published: true
---

Dans cet article j‘explique comment [Cecil](https://cecil.app), [mon générateur de site statique](/blog/cecil-mon-generateur-de-site-statique/), permet de manipuler des assets, sans dépendances à des outils tiers.

```twig
<link rel="stylesheet" href="{{ asset('css/styles.scss')|to_css|minify|fingerprint }}">
```
<!-- break -->

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

## Créer un asset

Reprenons l’exemple précédent en y appliquant la fonction `asset()` :

```twig
<link rel="stylesheet" href="{{ asset('css/styles.css') }}">
```

On crée ainsi un objet « asset » à partir du fichier `styles.css` préalablement déposé dans le dossier `static/css/` du projet.

### Minification

Le filtre `minify` réduit la taille d’un asset du type CSS ou JavaScript, en supprimant les espaces, retours à la ligne, etc.

Template :

```twig
<link rel="stylesheet" href="{{ asset('css/styles.css')|minify }}">
```

Rendu :

```html
<link rel="stylesheet" href="/css/styles.min.css">
```

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

Il est possible de paramétrer les règles de compilation via le fichier de configuration du projet (`config.yml` par défaut) de la manière suivante :

```yaml
assets:
  compile:
    style: expanded # expanded ou compressed
    import: [sass, scss] # liste des chemins importés, relatif au dossier static/
```

Il est également possible de remplacer la valeur des variables :

```yaml
assets:
    variables:
      primary: '#5a5a5a'
```

> Documentation : https://cecil.app/documentation/configuration/#assets

### Empreinte (fingerprinting)

Le filtre `fingerprint` créé l’empreinte de la ressource (d’après son contenu) et complète le nom du fichier en conséquence.   
Ainsi, si le fichier est modifié il aura une empreinte différente lors de la génération du site : le consommateur du fichier considérera donc que cette ressource est différente de celle qu’il a dans son cache et la téléchargera.

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

Par défaut le bundle porte le nom suivant :

- `style.css` pour les fichiers CSS
- `scripts.js` pour les fichiers JavaScript

Il est possible de personnaliser ce nom via l’option `filename`.

Template :

```twig
{{ asset(['css/styles-a.css', 'css/styles-b.css'], {filename: 'main.css'}) }}
```

Rendu :
```html
<link rel="stylesheet" href="/main.css">
```

### Attributs d’un asset

D’autre part, un asset expose un certain nombre d’attribut en fonction de son type :

- `file`: Chemin du fichier local
- `path`: Chemin web relatif
- `ext`: Extension
- `type`: Type de média (ex : `image`)
- `subtype`: Sous-type de média (ex : `image/jpeg`)
- `size`: Poids (en octets)
- `source`: Contenu avant traitement
- `content`: Contenu après traitement
- `integrity`: Hachage d'intégrité
- `width`: Largeur (dans le cas d’un fichier image)
- `height`: Hauteur (dans le cas d’un fichier image)
- `audio`: Tableau [Mp3Info](https://github.com/wapmorgan/Mp3Info#audio-information) (dans le cas d’un fichier MP3)

Exemples :

```twig
{% set image = asset('image.jpg') %}
<img src="{{ image }}" width="{{ image.width }}" integrity="{{ image.integrity }}" crossorigin="anonymous" />
```

```twig
Durée : {{ asset('title.mp3').audio.duration|round }} min
```

> Documentation : https://cecil.app/documentation/templates/#attributes

### Fichier distant

De plus, si le chemin passé à la fonction `asset()` est une URL, le fichier sera téléchargé localement et mis en cache pour les prochaines générations.

Exemple :

```twig
{{ asset('https://cdnjs.cloudflare.com/ajax/libs/anchor-js/4.3.1/anchor.min.js') }}
```

Le fichier, lors de la génération du site, sera enregistré de la manière suivante :

```
/assets/cdnjs.cloudflare.com/ajax/libs/anchor-js/4.3.1/anchor.min.js
```

### Paramétrage par défaut

Enfin, Cecil applique l’ensemble des traitements par défaut, désactivables via la configuration :

```yaml
assets:
  compile:
    enabled: true # compile automatiquement un fichier Sass
  minify:
    enabled: true # minifie automatiquement un fichier CSS ou JavaScript
  fingerprint:
    enabled: true # applique l'empreinte du fichier à son nom
```

Template :

```twig
<link rel="stylesheet" href="{{ asset('css/styles.scss') }}">
```

Rendu :

```html
<link rel="stylesheet" href="/css/styles.e549285c8ffa8af5e6254263c98d4397.min.css">
```

