---
title: "Mon expérimentation sur le rendu des Preview Cards de Mastodon"
description: "À partir d’un site de tests dédié, j’ai analysé comment Mastodon construit et affiche les Preview Cards d’URL partagées."
date: 2026-05-25
tags: [Mastodon, Preview Card, Métadonnées]
years: [2026]
typora-copy-images-to: ../../assets/images/${filename}
published: true
---
En août 2025, j’expliquais dans un [pouet](https://gazuji.com/@arnaud/115045426207388290) que j’essayais de démystifier la Preview Card de Mastodon : quelles données sont récupérées depuis une URL, dans quel ordre, selon quel type de media, et avec quel rendu final.

Pour transformer cette intuition en analyse concrète, j’ai mis en place :

- un site de test : <https://aligny.gitlab.io/mastodon-preview-card/>
- et son dépôt GitLab : <https://gitlab.com/aligny/mastodon-preview-card>

<!-- break -->

L’objectif était simple : provoquer volontairement différents cas (métadonnées Open Graph, données structurées, `oEmbed`, vidéos, etc.) et observer le comportement de Mastodon.

## Pourquoi cette expérimentation ?

Quand on partage une URL sur Mastodon, la Preview Card parait simple. En réalité, son rendu dépend de plusieurs sources de données, avec des priorités qui ne sont pas toujours évidentes.

Mon but était donc de :

- comprendre la logique de sélection des données
- identifier les cas limites
- vérifier les différences entre ce qu’on "attend" et ce qui est effectivement affiche

## Ce que j’ai observé

En synthèse, pour la page cible d’une URL :

1. si un Endpoint `oEmbed` JSON est détecté, il est utilise de manière exclusive
2. sinon, si des données structurées JSON sont présentes, elles sont privilégiées
3. sinon, les méta tags Open Graph sont utilisés (souvent en combinaison avec d’autres données)
4. à défaut, Mastodon retombe sur des éléments HTML plus basiques (`lang`, `<title>`, `description`)

Pour une vidéo, la présence de `twitter:player` influence directement la manière d’embarquer le contenu.

## Point d’attention

J’ai aussi constaté une limite intéressante : le méta tag `fediverse:creator`, utile pour afficher un lien vers le compte Mastodon de l’auteur, ne se combine pas bien avec un Endpoint `oEmbed`.

Autre observation : j’ai repéré un bug dans la version web de Mastodon, ou la description pouvait disparaitre quand l’auteur était fourni via la balise fediverse.

Ce constat a mené a la création d’une pull request :
<https://github.com/mastodon/mastodon/pull/35875>

## Le site de test en pratique

Le site [Mastodon Preview Card](https://aligny.gitlab.io/mastodon-preview-card/) me sert de laboratoire pour :

- comparer rapidement plusieurs stratégies de métadonnées
- valider un comportement sans dépendre d’un seul article "réel"
- documenter les cas d’usage avec des exemples reproductibles

## Ce que j’en retiens

Cette expérimentation m’a confirmé que pour maitriser le rendu d’une Preview Card Mastodon, il ne suffit pas de "poser quelques meta tags" sur sa page Web : il faut réfléchir en priorités de sources, en compatibilité entre standards, et en comportement réel du client Mastodon. Oui, c’est un peu pénible…

---

Ressources :

- [Understanding Mastodon Preview Card Display Logic](https://box464.com/posts/mastodon-preview-cards/)
- [PreviewCard - Mastodon documentation](https://docs.joinmastodon.org/entities/PreviewCard/)
