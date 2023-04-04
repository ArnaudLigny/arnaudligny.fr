---
title: De la refonte d'un site e-commerce
date: 2023-03-01
tags: Réflexion
published: false
---
Je crois que dans un projet de refonte d'un site e-commerce vers une approche découplée (ou composable), qui s'appuyait jusque là sur un progiciel monolithique "qui fait tout", c'est la gestion du métier (et de la data associée), et pas forcément l'aspect technique, qui pose des difficultés.

Alors oui ce type de refonte demande un effort non négligeable pour faire communiquer les briques techniques entre elles, mais c'est surtout la (re)compréhension de son écosystème qui pose des difficultés à l'équipe projet : où est cette données ? qui la pilote ? pour en faire quoi ?

J'ai le sentiment d'une perte de connaissance parce que "c'est notre outil actuel qui gère ça" ou encore "notre presta à développé une feature dans l'outil pour faire ça mais on sait pas trop comment ça fonctionne".
Alors, quand il faut dessiner la carte de ces données afin de les manipuler de manière pertinentes et sécurisée, forcément ça coince...

Pour moi le gage de réussite d'un tel projet c'est d'abord de prendre le temps d'avoir une vision claire de l'ensemble de l'écosystème fonctionnel et de la data, avant de se jeter sur telle ou telle solution technique "moderne", et de risquer de commettre les même erreurs.
Une fois cette "carte" dessinée, précisant la typologie de la données, le rôle des différents systèmes en présence, il devient beaucoup plus facile de se projeter dans le projet, de responsabiliser les équipes sur leur périmètre d'expertise, etc.

De plus, cela permet également de travailler par étapes, de "débrancher" certaines fonctionnalités pour les déplacer vers des composants, et ainsi de suite : c'est moins de risques, moins de stress et ça permet de mieux maitriser son planning globale.
