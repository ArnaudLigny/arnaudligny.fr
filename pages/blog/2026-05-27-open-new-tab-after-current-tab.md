---
title: "Open-New-Tab-After-Current-Tab : ouvrir un nouvel onglet au bon endroit"
description: "Pourquoi j’ai créé Open-New-Tab-After-Current-Tab, une extension Chromium qui ouvre les nouveaux onglets juste après l’onglet actif."
date: 2026-05-27
tags: [WebExtensions, Chromium, Open source]
years: [2026]
typora-copy-images-to: ../../assets/images/${filename}
published: true
---
Quand on manipule beaucoup d’onglets, un détail devient vite irritant : dans Chrome ou Edge, un nouvel onglet s’ouvre en dernière position, loin du contexte en cours.

Pour un usage ponctuel, ce n’est pas dramatique. Mais quand on enchaine navigation, lecture et documentation, ce comportement peut être pénible.

J’ai donc créé [Open-New-Tab-After-Current-Tab](https://github.com/ArnaudLigny/Open-New-Tab-After-Current-Tab), une extension pensée pour un besoin simple : ouvrir le nouvel onglet juste après l’onglet actif.

<!-- break -->

## Ce que fait l’extension

Open-New-Tab-After-Current-Tab cible les navigateurs basés sur Chromium (notamment Chrome et Edge).

Son rôle est volontairement minimaliste :

- détecter l’ouverture d’un nouvel onglet
- le positionner juste après l’onglet actif

Résultat : une navigation plus cohérente quand on manipule beaucoup d’onglets en parallèle.

## Ressources

- Dépôt GitHub : <https://github.com/ArnaudLigny/Open-New-Tab-After-Current-Tab>
- Page du projet : <https://dev.ligny.org/Open-New-Tab-After-Current-Tab/>
- Extension sur le Chrome Web Store : <https://chromewebstore.google.com/detail/open-new-tab-after-curren/mmcgnaachjapbbchcpjihhgjhpfcnoan>
