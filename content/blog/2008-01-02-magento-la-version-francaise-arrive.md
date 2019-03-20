---
title: "Magento : la version française arrive !"
date: 02-01-2008
tags: Magento
path: blog/magento-la-version-francaise-arrive
---
> **Update :** l'extension FR, ou plutôt le [language pack français pour Magento](http://www.magentocommerce.com/extension/414/magento-community-modules--french-france-language-pack) est disponible en version stable.

En effet, l'équipe de [Fragento](http://fragento.org/) à réalisé un gros travail pour traduire la version béta de [Magento Commerce](http://narno.com/tag/magento).
<!-- excerpt -->
Au moment où j'écris ce billet, les fichiers de langues sont en cours de relecture. Si vous souhaitez participer à la version courante, suivez la procédure :

1. [Télécharger le fichier fr_FR.zip](http://www.magentocommerce.com/?ACT=25&fid=24&aid=398_uCqm2xkntLWb5FQK6woN&board_id=1)
2. Décompresser l’archive dans le répertoire `app/locale/` de votre installation de Magento (il doit déjà y avoir un répertoire `en_US`)
3. Vérifier que le cache n’est pas activé ou le rafraîchir : dans la console d’administration : "System > Cache management"
4. Dans la console d’administration, choisir "French (France)" en bas à gauche (Interface Locale)
5. Votre interface d’administration devrait être en français maintenant
6. Dans la console d’administration, aller dans le menu "Système > configuration", puis onglet "Général"
7. Sélectionner le magasin pour lequel vous voulez une locale française. Pour l’option locale, choisir "Français (France)"
8. Laissez vos commentaires sur le [forum](http://www.magentocommerce.com/boards/viewthread/2200/)

**Remarques :**

* Il est possible que certains textes ne soient pas traduit (les fichiers de traduction ne sont pas encore disponible chez Varien)
* Les catégories et les produits ne sont pas traduits, c'est à vous de le faire

Pour plus d'informations, je vous invite à consulter le [blog français sur le site officiel de Magento Commerce](http://www.magentocommerce.com/fr/comments/traduction-et-installation-de-magento-en-francais-on-y-arrive).
