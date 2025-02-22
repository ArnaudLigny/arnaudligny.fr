---
title: Quoi de neuf dans Cecil depuis la release 8.0.0 ?
description: "La version 8 de Cecil est sorti en décembre 2023 : que s'est-il passé depuis ?"
date: 2025-02-19
tags: [Cecil]
years: [2025]
#image: /images/
#image_header: false
typora-root-url: "../../assets"
typora-copy-images-to: ../../assets/images/${filename}
published: false
---

La version 8 de [Cecil](https://cecil.app) est sortie en décembre 2023, annonçant le passage à PHP 8 et annonçant de futurs améliorations et autres fonctionnalités.

Un peu plus d’un an plus tard, qu’en est-il ?

Et bien… on peut dire que je n’ai pas chaumé et apporté de nombreuses améliorations à Cecil, et comme prévu le passage à PHP 8 a bien aidé à rendre le développement agréable et plus confortable pour moi.

Ce billet va prendre la forme d’un changelog, aussi détaillé que possible, toutes asseyant de ne pas être verbeux.

## Nouvelles fonctionnalités

### Global Sort by

Ajout d’une option de configuration afin de déterminer la méthode globale d’ordonnancement des pages :

```yaml
pages:
	sortby: date # default

sortby:
  variable: date    # date|updated|title|weight
  desc_title: false # false|true
  reverse: false    # false|true
```

Documentation : https://cecil.app/documentation/configuration/#pages







