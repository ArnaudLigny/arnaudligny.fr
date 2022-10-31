---
title: "Prévisualiser un site genéré avec Cecil sur mobile"
date: 2019-12-24
tags:
  - Cecil
  - Développement
  - SSG
image: /images/cecil-mobile-preview.png
image_header: false
typora-root-url: ../../static
---

Ci-dessous une [courte vidéo](/videos/cecil-apercu-sur-mobile.mp4){embed=false} expliquant comment tester un site généré par [Cecil](https://cecil.app) à partir d’un téléphone mobile, sur le même réseau Wi-Fi :

1. connaître l’adresse IP du réseau : `ipconfig getifaddr er0`
2. générer et servir le site via cette adresse : `cecil serve --host=192.168.X.Y`
3. ouvrir l’adresse du serveur sur le téléphone mobile : `http://192.168.X.Y:8000`

<!-- break -->

[Cliquez pour voir la vidéo](/videos/cecil-apercu-sur-mobile.mp4 "Prévisualiser un site genéré avec Cecil sur mobile"){controls preload=none poster=/videos/cecil-apercu-sur-mobile-poster.png}
