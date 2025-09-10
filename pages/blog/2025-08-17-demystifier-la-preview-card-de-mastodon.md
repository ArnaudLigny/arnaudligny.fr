---
title: "Démystifier la Preview Card de Mastodon"
description: "Comprendre comment Mastodon génère les aperçus de liens partagés."
date: 2025-08-17
tags: [Mastodon, Preview Card]
years: [2025]
image: assets/images/2025-08-17-demystifier-la-preview-card-de-mastodon/image-20250817211726181.png
#typora-root-url: "../../assets"
typora-copy-images-to: ../../assets/images/${filename}
published: false
---
Depuis quelques semaines je tente de comprendre la logique de construction de la « Preview Card » de Mastodon.

Mais d’abord qu’est-ce qu’une « Preview Card » ?

Il s’agit ici de l’aperçu d’un contenu, partagé via une URL, au sein d’un post Mastodon, par exemple : 

![Example de Preview Card](../../assets/images/2025-08-17-demystifier-la-preview-card-de-mastodon/image-20250817211726181.png "Example de Preview Card")

<!-- break -->

Dans l’exemple ci-dessus le lien <https://arnaudligny.fr/blog/arretez-de-faire-des-sites-dynamiques/> est illustré par une image et des informations complémentaires issues de la page source : le titre, la date et l’auteur.

## Collecte des données

Maintenant, essayons de comprendre comment ces données sont colletées depuis la page cible.

