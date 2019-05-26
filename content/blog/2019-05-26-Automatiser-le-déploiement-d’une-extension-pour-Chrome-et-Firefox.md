---
title: "Automatiser le déploiement d’une extension pour Chrome et Firefox"
date: 2019-05-26
published: false
---

Ces dernières années j’ai développé [quelques extensions pour navigateur Web](https://chrome.google.com/webstore/search/ligny?_category=extensions), en l’occurence pour Chrome, puis pour Firefox (avec la standardisation de l'API [*WebExtensions*](https://developer.mozilla.org/fr/docs/Mozilla/Add-ons/WebExtensions)).

Initialement conçues et développées pour mon usage personnelle, j’ai pensé que ce serait utile de les partager, non seulement sur GitHub, mais aussi sur les *stores* officiels pour simplifier leur installation (en 1 clic).

Néanmoins, au fil des mises à jour il devenait pénible de :

1. mettre à disposition l’extension / l'addon sous forme d’archive dans la section release du dépôt GitHub
2. créer une nouvelle version et de l’uploader depuis la page de gestion de chacun des stores

Aussi, j’ai cherché à automatiser ces étapes via l’[intégration continue](https://fr.m.wikipedia.org/wiki/Int%C3%A9gration_continue) et le déploiement continu (ou [livraison continue](https://fr.m.wikipedia.org/wiki/Livraison_continue)).

