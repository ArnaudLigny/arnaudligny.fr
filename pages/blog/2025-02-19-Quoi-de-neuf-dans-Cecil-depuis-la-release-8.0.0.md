---
title: "Cecil : quoi de nouveau depuis la sortie de la version 8 ?"
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

En décembre 2023 je sortais la [version 8.0.0](https://github.com/Cecilapp/Cecil/pull/1676) de [Cecil](https://cecil.app), annonçant le passage à [PHP 8](https://www.php.net/releases/8.0/) et la promesse de nombreuses améliorations.

Un peu plus d’un an après, est-ce que cette promesse a été tenue ? 😊

Et bien… je crois qu’on peut dire que je n’ai pas chaumé et que j’ai apporté de nombreuses améliorations à Cecil et, comme prévu, le passage à PHP 8 a bien aidé à rendre le développement plus confortable pour moi.

Ce billet va prendre la forme d’un changelog, aussi détaillé que possible, toutes essayant de ne pas être trop verbeux.
<!-- break -->

## Nouvelles fonctionnalités

### Tri par défaut des pages

Ajout d’une option de configuration permettant de définir la méthode de tri par défaut des pages :

```yaml
pages:
  # basic
  sortby: date # date|updated|title|weight, date by default
  # advanced
  sortby:
    variable: date    # date|updated|title|weight
    desc_title: false # false|true
    reverse: false    # false|true
```

Documentation : <https://cecil.app/documentation/configuration/#pages>
