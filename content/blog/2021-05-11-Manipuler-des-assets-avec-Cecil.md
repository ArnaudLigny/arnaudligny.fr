---
title: Manipuler des assets avec Cecil
date: 2021-05-11
published: false
---

Un _asset_ est une **ressource web, tel qu’un fichier CSS, JavaScript ou encore une image**, permettant d’habiller ou de dynamiser un site web.

Ainsi, une feuille de styles peut être chargée en indiquant simplement le chemin vers le fichier correspondant :

```html
<link rel="stylesheet" href="/css/styles.css">
```

Dans l’exemple ci-dessus l’URL vers le fichier de la feuille de styles est « en dur » dans le template HTML et c’est suffisant dans la plupart des cas.

Néanmoins, quid des questions suivantes :

- Comment compresser ma feuille de styles pour gagner en performance ?
- Comment compiler un fichier [Sass](https://sass-lang.com) et modifier des variables facilement ?
- Comment informer les navigateurs web que ma feuille de style à été modifiée et ne pas demander aux internautes de « vider le cache » ?
- etc.

[Cecil](https://cecil.app), grâce à sa fonction [`asset()`](https://cecil.app/documentation/templates/#asset) combinée à un certain nombre de [filtres Twig](https://cecil.app/documentation/templates/#filters), répond à ces questions en permettant de manipuler (ou « processer ») facilement des ressources web.
<!-- break -->

## Créer un asset

Reprenons l’exemple précédent mais cette fois avec la fonction `asset()` :

```twig
<link rel="stylesheet" href="{{ asset('css/styles.css') }}">
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

### 
