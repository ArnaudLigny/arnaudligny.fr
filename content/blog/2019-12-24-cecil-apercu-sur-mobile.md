---
title: "Cecil : aperçu sur mobile"
date: 2019-12-24
tags: [Développement, SSG, Cecil]
image: "/images/cecil-mobile-preview-banner.png"
draft: false
typora-root-url: ../../static
---

Ci-dessous une [courte vidéo](/videos/cecil-apercu-sur-mobile.mp4) expliquant comment tester un site généré par [Cecil](https://cecil.app) à partir d’un téléphone mobile, sur le même réseau Wi-Fi :

1. connaître l’adresse IP du réseau : `ipconfig getifaddr er0`
2. générer et servir le site via cette adresse : `cecil serve --host=192.168.X.Y`
3. ouvrir l’adresse du serveur sur le téléphone mobile : `http://192.168.X.Y:8000`
<!-- break -->
<video controls>
  <source src="/videos/cecil-apercu-sur-mobile.mp4" type="video/mp4">
</video>
