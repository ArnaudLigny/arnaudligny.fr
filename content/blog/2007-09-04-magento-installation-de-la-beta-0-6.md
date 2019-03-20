---
title: "Magento : installation de la béta 0.6"
date: 04-09-2007
tags: Magento
path: blog/magento-installation-de-la-beta-0-6
---
Après l'annonce de la [sortie de Magento béta 0.6](https://arnaudligny.fr/blog/magento-une-premiere-beta-telechargeable/), je me suis décidé à tenter l'installation de [Magento Commerce](http://www.magentocommerce.com/) : je ne vous cacherai pas que ma première tentative n'a pas été couronnée de succès.
<!-- excerpt -->
En effet, j'ai tout d'abord tenté une installation locale sur mon Windows XP SP2 via [Wamp Server](http://www.wampserver.com/). La première partie de l'installation s'est déroulée sans trop de difficultés :

Wamp configuré en PHP 5 Création d'une base de données pour accueillir les tables de Magento Activation du mode rewrite pour la réécriture d'URL Activation des extensions PHP : PDO, PDO pour MySQL, mcrypt

Une fois la procédure de configuration terminée, l'assistant d'installation de Magento est censé générer les fichiers de configuration (au format XML) et alimenter la base de données en conséquence... et là, c'est le drame : une exception PDO casse la procédure et impossible de continuer.
J'ai eu beau tenté de remplacer la DLL de PDO par celle conseillée dans les [commentaires du site officiel](http://www.magentocommerce.com/knowledge-base/entry/magento-installation-guide#comments) et décommenter une ligne de paramétrage de PDO (en concordance avec le message d'erreur renvoyé), rien n'y a fait !

J'ai donc abandonné l'installation sur Windows au profit d'une installation dans un environnement Linux via ma [Dedibox](http://www.dedibox.fr/) (Debian, PHP5, PDO). Là l'installation s'est déroulée sans difficultés aucune (il m'a juste fallut contrôler les droits sur les répertoires).

Malheureusement, béta (ou plutôt alpha pour 0.6, non ?) oblige, après quelques modifications dans le panneau de configuration du back-office fraîchement installé, ma home page de Magento à explosée...

Bref, je pense qu'il  va nous falloir patienter jusque la prochaine vrai béta pour tester plus en profondeur Magento Commerce. Affaire à suivre ! ;-)

Liens Magento :

* [site officiel de Magento Commerce](http://www.magentocommerce.com/)
* [site de la communauté francophone : Fragento](http://www.fragento.org/)
