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

Dans l’exemple ci-dessus l’URL vers la feuille de styles est « en dur » dans le template HTML : dans la plupart des cas cette solution est fonctionnelle et suffisante.

On peut appliquer la même méthode pour une image [Open Graph](https://opengraphprotocol.org) :

```html
<meta property="og:image" content="/images/image.jpg">
```

Sauf quand dans le cas ci-dessus, l’URL n’est pas valide car elle doit être absolue pour être utilisée par un service tiers.

## Créer une URL

Aussi, afin de dynamiser les URL, Cecil expose la [fonction Twig](https://twig.symfony.com/doc/2.x/templates.html#functions) [`url()`](https://cecil.app/documentation/templates/#url).

Reprenons l’exemple ci-dessus en utilisant cette fonction :

```twig
<meta property="og:image" content="{{ url('images/image.jpg',{canonical:true}) }}">
->
<meta property="og:image" content="https://domain.tld/images/image.jpg">
```

Néanmoins cette méthode reste limitée car elle se contente de générer une URL « fixe » pour une ressource donnée : si l’image est modifiée, le consommateur de cette URL (un navigateur web de l’internaute, le robot Twitter de création de Card, etc.) ne le saura pas et utilisera l’image qu’il a dans son cache, jusqu’à péremption.

## Manipuler une ressource

Nous arrivons ainsi dans le vif du sujet : Cecil expose une fonction [`asset()`](https://cecil.app/documentation/templates/#asset) permettant de manipuler des ressources web.

Reprenons une nouvelle fois l’exemple précédent mais cette fois avec la fonction `asset()` :

```twig
<meta property="og:image" content="{{ url('images/image.jpg',{canonical:true}) }}">
->
<meta property="og:image" content="{{ asset('images/image.jpg')|url({canonical:true}) }}">
```

A première vue cette approche semble plus verbeuse, puisqu’il est nécessaire de :

1. utiliser la fonction `asset()` pour créer un objet ressource
2. utiliser le filtre [`url`](https://cecil.app/documentation/templates/#url-1) avec l’option permettant de retourner une URL canonique

Néanmoins Cecil va également appliquer un certain nombre d’actions par défaut sur la ressource manipulée.

### Fingerprinting

```twig
<meta property="og:image" content="{{ asset('images/image.jpg')|url({canonical:true}) }}">
->
<meta property="og:image" content="https://domain.tld/image.e549285c8ffa8af5e6254263c98d4397.jpg">
```

Cecil détermine automatiquement l’empreinte (_fingerprint_) de la ressource d’après son contenu, compléte le nom du fichier avec cette empreinte et enregistre le fichier.

Aussi, si le fichier image est modifié il aura une aura empreinte différente lors de la génération du site : le consommateur du fichier image considérera donc que cette ressource est différente de celle qu’il a dans son cache et téléchargera cette nouvelle image.

