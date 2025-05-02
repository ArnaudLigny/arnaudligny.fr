---
title: "Cecil : quoi de nouveau depuis la sortie de la version 8 ?"
description: "La version 8 de Cecil est sorti en décembre 2023 : que s'est-il passé depuis ?"
date: 2025-02-19
updated: 2025-05-02
tags: [Cecil]
years: [2025]
#image: /images/
#image_header: false
typora-root-url: "../../assets"
typora-copy-images-to: ../../assets/images/${filename}
published: false
---

La version 8 de [Cecil](https://cecil.app) est sortie en décembre 2023, annonçant le passage à PHP 8, de nouvelles fonctionnalités et autres améliorations.

Un peu plus d’un an après, est-ce que cette promesse a été tenue ? 😊

Et bien je crois qu’on peut dire que je n’ai pas chaumé en apportant de nombreuses améliorations à Cecil et, comme prévu, le passage à PHP 8 a bien aidé à rendre le développement plus confortable pour moi.

Ce billet va prendre la forme d’un changelog, aussi détaillé que possible, tout en asseyant de ne pas être trop verbeux.
<!-- break -->

## Nouvelles fonctionnalités

### Tri par défaut des pages

Ajout d’une option de configuration de la méthode d’ordonnancement des pages :

```yaml
pages:
  sortby: date # `date`, `updated`, `title` or `weight`
  # or
  sortby:
    variable: date    # `date`, `updated`, `title` or `weight`
    desc_title: false # sort by title in descending order
    reverse: false    # reverse the sort order
```

Documentation : <https://cecil.app/documentation/configuration/#pages-sortby>
