---
title: "Télécharger manuellement une extension Magento"
date: 2010-11-21
tags: "Magento"
---

**Mise à jour du 05/01/2013 :** J'ai créé un outil pour ça (in english) : [http://mage.narno.com](http://mage.narno.com).

Je partage ici une petite astuce pour télécharger simplement une extension Magento, sans utiliser le downloader.

L'idée est d'obtenir le code source d'une extension [MagentoConnect](http://www.magentocommerce.com/magento-connect), sans l'installer (afin d'étudier son code source par exemple).

**Mise à jour du 01/12/2011 :** Je me suis enfin décidé à mettre à jour ce tutoriel avec l'arrivé de MagentoConnect 2.0, dont le protocole à légèrement changé. Voir ci-dessous.

Pour rappel, il faut savoir que Magento utilise un serveur [PEAR](http://pear.php.net) pour packager et distribuer ses extensions. De ce fait, une fois que l'on connait le chemin d'accès au serveur PEAR de Magento et que l'on connais son arborcence il est très facile d’accédé à n'importe quel package.

**MagentoConnect 2.0 :** Ce n'est plus PEAR, mais les fondamentaux reste identiques !

Voici la procédure à suivre, en utilisant l'exemple du [Modern Theme](http://www.magentocommerce.com/magento-connect/Magento+Core/extension/146/modern-theme-for-magento-frontend-interface).

## 1. Déterminer l'extension à télécharger via sa page sur MagentoConnect

Modern Theme : [http://www.magentocommerce.com/magento-connect/Magento+Core/extension/146/modern-theme-for-magento-frontend-interface](http://www.magentocommerce.com/magento-connect/Magento+Core/extension/146/modern-theme-for-magento-frontend-interface)

Ici l'objectif est d'obtenir la clef PEAR de l'extension. Pour notre exemple la clef est : magento-core/Interface_Frontend_Default_Modern.

**MagentoConnect 2.0 :** ```http://connect20.magentocommerce.com/community/Interface_Frontend_Default_Modern```

## 2. Connaitre le numéro de la release la plus récente

```http://connect.magentocommerce.com/core/Chiara_PEAR_Server_REST/r/interface_frontend_default_modern/allreleases.xml```

* ```http://connect.magentocommerce.com``` : adresse du serveur PEAR
* ```core``` : pool du module, à savoir core ou community
* ```interface_frontend_default_modern``` : la clef de l'extension, en minuscules

**MagentoConnect 2.0 :** ```http://connect20.magentocommerce.com/community/Interface_Frontend_Default_Modern/releases.xml```

A partir de cette URL on obtient un fichier XML listant l'ensemble des versions disponible, ainsi que leur statut (stable, beta, etc.) :

```<r><v>1.4.1.1</v><s>stable</s></r>```

**MagentoConnect 2.0 :** Structure XML identique.

## 3. Construire le lien du package pour le télécharger

Une fois le numéro de version choisi (le dernier en l'occurrence) il suffit de construire l'URL d'accès au fichier téléchargeable (le package).

```http://connect.magentocommerce.com/core/get/Interface_Frontend_Default_Modern-1.4.1.1.tgz```

* ```get``` : demande un fichier
* ```Interface_Frontend_Default_Modern``` : la clef de l'extension
* ```1.4.1.1.tgz``` : numéro de version (release) + .tgz (archive tar compressé via gzip)

**MagentoConnect 2.0 :** ```http://connect20.magentocommerce.com/community/Interface_Frontend_Default_Modern/1.6.1.0/Interface_Frontend_Default_Modern-1.6.1.0.tgz```

Voilà, c'est tout simple et très pratique !

Il faut toutefois noter que l'extension ainsi télécharger n'est pas installable en l'état : il faut suivre la répartition des fichiers indiquer dans _package.xml_.

_Initialement publié sur [Narno.com](http://narno.com/blog/telecharger-manuellement-une-extension-magento)._
