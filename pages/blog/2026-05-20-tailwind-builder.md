---
title: "Compiler une feuille de styles Tailwind CSS avec Composer, sans Node.js"
description: "J’ai créé Tailwind Builder, un package Composer qui compile Tailwind CSS via le binaire standalone adapté à votre OS."
date: 2026-05-20
updated: 2026-05-21
tags: [Tailwind CSS, PHP, Open source]
years: [2026]
typora-copy-images-to: ../../assets/images/${filename}
published: true
---
Quand on travaille sur un projet dans l'écosystème PHP (et dans mon cas souvent avec [Cecil](https://cecil.app)), on se retrouve vite avec un besoin simple : compiler une feuille de styles Tailwind CSS.

Le problème, c’est que la solution “classique” repose sur Node.js (et tout son écosystème), alors que pour certains projets on préfère garder une stack centrée sur Composer.

J’ai donc créé [Tailwind Builder](https://github.com/ArnaudLigny/tailwind-builder) : un package Composer qui compile Tailwind CSS en s’appuyant sur le binaire standalone officiel de Tailwind, automatiquement adapté à l’OS courant.

<!-- break -->

## Pourquoi ce projet ?

Mon objectif était double :

- Éviter d’ajouter Node.js juste pour une étape de build CSS
- Proposer une commande simple, portable et robuste pour les projets PHP

## Installation

L’installation est classique quand on utilise déjà Composer au quotidien :

```bash
composer require aligny/tailwind-builder
```

Ensuite, vous pouvez lancer la compilation directement :

```bash
vendor/bin/tailwind-build
```

## Utilisation

Par défaut, la commande cherche un fichier source `assets/tailwind.css` puis génère un fichier CSS compilé.

Exemple d’utilisation avec options :

```bash
vendor/bin/tailwind-build assets/tailwind.css \
  --output=public/styles.css \
  --minify \
  --tailwind-version=v4.3.0
```

Et pour les adeptes des scripts Composer :

```bash
composer tailwind:build -- assets/tailwind.css --output=public/styles.css --minify
```

## Ce que Tailwind Builder gère pour vous

Au-delà de la compilation, le package prend en charge plusieurs points pratiques :

- Téléchargement automatique du bon binaire Tailwind depuis GitHub Releases
- Mise en cache dans `.cache/tailwind/<version>/`
- Vérification SHA-256 par défaut pour éviter l’exécution d’un binaire non vérifié
- Verrouillage pendant le téléchargement pour éviter les conflits en exécution concurrente

J’ai aussi ajouté des options pour les cas avancés : choix explicite de la plateforme, chemin vers un binaire local, checksum fourni manuellement, etc.

## Et la suite ?

Le projet est jeune, mais déjà pleinement utilisable.

Si vous voulez tester, contribuer ou me faire un retour : <https://github.com/ArnaudLigny/tailwind-builder>

Comme souvent avec mes projets open source, je cherche le meilleur équilibre entre simplicité d’usage et exigences de qualité.  
Si Tailwind Builder vous évite un setup trop lourd, alors l’objectif est atteint 😊
