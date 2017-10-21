---
title: "Magento et référencement naturel (SEO)"
date: 01-02-2009
tags: [e-commerce, Magento, SEO]
permalink: blog/magento-et-referencement-naturel-seo
---
[Magento Commerce](http://www.magentocommerce.com/), la solution e-commerce open-source du moment est-elle optimisée pour le référencement naturel ?
A l'heure actuel, j'aurai tendance à dire que non. Voici ce que propose Magento :

* URL simplifiées et réécriture automatique
* Méta données (titre et description) génériques et spécifiques par page
* Génération automatique du sitemap (au format XML)
* Génération automatique d'une page listant les termes populaires

Malgré cette liste de fonctionnalités qui pourait semblée suffisante, ça ne l'ai plus en 2009. En effet, les options de paramètrages sont actuellement trop limitées : de ce fait en fonctionnement automatique, le SEO proposé par Magento peut avoir des conséquences néfastes sur votre référencement.
<!-- excerpt -->
Voici un exemple flagrant : si un des produits du catalogue appartient à plusieurs catégories et que l'on active la génération automatique d'URL, Magento va générer autant de chemins différents que de catégories pour ce produit.

Cela peut semblé négligeable, car Google ne pénalise pas le contenu dupliqué à l'intérieur d'un même site. Néanmoins le problème du duplicate content à toujours des conséquences :

* le sitemap est surchargée d'URL inutiles et ne sera donc pas entièrement [crawlé](http://fr.wikipedia.org/wiki/Crawler) par Google (et autres moteurs)
* Google va devoir faire l'effort de choisir entre l'une des URL pointant vers le produit, afin de déterminer la plus pertinente

C'est là que le problème se pose et les pros du SEO vous le diront : plus votre site demande de travail à Google pour référencer votre boutique et moins ce dernier lui fera confiance... ce qui est finalement assez logique.

Lorsque l'on a connaissance de genre de problèmatiques liées au référencement naturel, on est capable de configurer l'outil en conséquence. Ca fonctionne par exemple très bien avec quelques [astuces SEO pour Drupal](http://www.narno.com/blog/seo-pour-drupal) (CMS).
Néanmoins, dans le cas de Magento les options de configuration proposées par défaut sont rapidement limitées et les modules SEO se font rare sur [Magento Connect](http://www.magentocommerce.com/magento-connect).

Tel que je présente les choses, le tableau de la SEO pour Magento pourrait semblé bien noir, mais il ne faut pas oublié que Magento est basé sur un framework : il est donc possible d'améliorer tout ça grâce à quelques développement s'appuyant sur les conseils d'un spécialiste du SEO.

Il n'en reste pas moins qu'il sera rapidement nécessaire que Varien intègre certains fondamentaux, tel que la prise en compte de la langue du site, non pas via la session utilisateur (arg !) mais plutôt via l'URL (sous la forme de répertoires virtuels ou de sous-domaines). Par exemple :

* http://fr.ma-boutique.com
* http://www.ma-boutique.com/fr/

En bilan je dirai que Magento Commerce est un fantastique outil de création de boutique en ligne, que les fondations techniques et fonctionnels sont très bon, et qu'avec un peu de maturité, certaines lacunes de SEO peuvent être simplement comblées.
