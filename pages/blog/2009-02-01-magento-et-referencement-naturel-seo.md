---
title: "Magento et référencement naturel (SEO)"
date: 2009/02/01
tags:
  - e-commerce
  - Magento
  - SEO
years: [2009]
published: true
---
[Magento Commerce](/tags/magento/), la solution e-commerce open-source du moment est-elle optimisée pour le référencement naturel ?

En l'état j'aurais tendance à dire que non.

Voici ce que propose Magento :

* URL simplifiée et réécriture automatique ;
* Méta données (titre et description) génériques et spécifiques par page ;
* Génération automatique du [sitemap XML](https://www.sitemaps.org) ;
* Génération automatique d'une page listant les termes populaires.

Malgré cette liste de fonctionnalités qui pourait semblée suffisante, ça ne l'esti plus en 2009. En effet, les options de paramètrages sont actuellement trop limitées : de ce fait, en fonctionnement automatique, le SEO proposé par Magento peut avoir des conséquences néfastes sur votre référencement.
<!-- excerpt -->

Voici un exemple flagrant : si un des produits du catalogue appartient à plusieurs catégories et que l'on active la génération automatique d'URL, Magento va générer autant de chemins différents que de catégories pour ce produit.

Cela peut semblé négligeable car Google ne pénalise pas le contenu dupliqué à l'intérieur d'un même site.  
Néanmoins le problème du _duplicate content_ à toujours des conséquences :

* Le sitemap est surchargée d'URL inutiles et ne sera donc pas entièrement [crawlé](http://fr.wikipedia.org/wiki/Crawler) par Google (et les autres moteurs de recherche) ;
* Google va devoir faire l'effort de choisir entre l'une des URL pointant vers le produit, afin de déterminer la plus pertinente.

C'est là que le problème se pose et que les pros du SEO vous diront : plus votre site demande de travail à Google pour référencer votre boutique et moins ce dernier lui fera confiance...

Lorsque l'on a connaissance de ce genre de problèmatiques liées au référencement naturel, on est capable de configurer l'outil en conséquence. Ça fonctionne par exemple très bien avec quelques [astuces SEO pour Drupal](https://narno.com/blog/seo-pour-drupal/).  
Néanmoins, dans le cas de Magento les options de configuration proposées par défaut sont rapidement limitées et les modules SEO se font rare sur [Magento Connect](http://www.magentocommerce.com/magento-connect).

Tel que je présente les choses le tableau de la SEO pour Magento pourrait semblé bien noir, mais il ne faut pas oublier que Magento est basé sur un framework : Il est donc possible d'améliorer tout ça grâce à quelques développements spécifiques s'appuyant sur les conseils d'un spécialiste du SEO.

Il n'en reste pas moins qu'il sera rapidement nécessaire que la société Varien intègre certains fondamentaux, tel que la prise en compte de la langue du site, non pas via la session utilisateur (arg !) mais plutôt via l'URL (via un répertoire virtuel ou un sous-domaine), par exemple :

* `http://fr.ma-boutique.com`
* `http://www.ma-boutique.com/fr/`

En synthèse je dirais que [Magento Commerce](/tags/magento/) est un fantastique outil de création de boutique en ligne, que les fondations techniques et fonctionnelles sont très bonnes, et qu'avec un peu de maturité certaines lacunes de SEO peuvent être comblées simplement.
