---
title: "Augmenter la qualité des photos sur Magento"
date: 2009-06-22
tags:
  - Magento
published: true
---
J'ai récemment été confronté à des problèmes de qualité des photos sur [Magento](http://www.magentocommerce.com).

Dans un premier temps, j'ai vainement cherché une option pour régler cela via le back-office de Magento... j'ai finis par me rendre à l'évidence : ce n'est pas possible (tout du moins jusque la version 1.3).
J'ai ensuite étudié le code source afin de déterminer comment le framework gère et surtout génère les différentes tailles des photos (sur la page liste, les miniatures, etc.) des produits.

J'ai ainsi découvert que Magento utilise [GD2](http://www.php.net/gd), avec un réglage de qualité à 80% par défaut (et non modifiable via la configuration, back-office ou XML). Une valeur de 80/100 de qualité est suffisante dans la plupart des cas. Néanmoins dans le domaine du e-commerce ont sait qu'une photo de très bonne qualité peut faire la différence.
<!-- excerpt -->
L'idée est donc de pousser la qualité de compression (jpeg) à 90%, voici les solutions envisagées :

1. Modifier le code PHP trouvé plus haut : NON, il ne faut jamais modifier directement le code issu du core de Magento !
2. Créer un module permettant d'administrer la valeur de la qualité de compression via le back-office : intéressant, réutilisable mais trop long à réaliser. Je passe ! :-)
3. Overrider (surcharger) le code : facile, rapide et "propre" : la solution que j'ai retenu

## Modifier la qualité de compression des photos Magento :

**Étape 1**

Copier le ficher ```/lib/Varien/Image/Adapter/Gd2.php``` vers ```/app/code/local/Varien/Image/Adapter/Gd2.php``` en créant les répertoires manquant si nécessaire.

**Étape 2**

Ouvrir le fichier Gd2.php (la copie, pas l'original) au environ de la ligne 80 et remplacer :

```php
call_user_func($this->_getCallback('output'), $this->_imageHandler, $fileName);
```
par :
```php
if ($this->_fileType === IMAGETYPE_JPEG) {
    call_user_func($this->_getCallback('output'), $this->_imageHandler, $fileName, 90);
} else {
    call_user_func($this->_getCallback('output'), $this->_imageHandler, $fileName);
}
```

Dans le code ci-dessus j'ai opté pour 90, mais vous pouvez faire varier cette valeur entre 0 et 100 de qualité.

**Étape 3**

Pour terminer, il faut penser à vider le cache des images via System > Cache Management.

Voilà, c'était simple, efficace et réutilisable sur n'importe quel projet, à partir du moment ou vous travaillez avec des images au format jpeg (qui le format le plus commun dans le domaine de la photo numérique) et que votre serveur supporte GD2.

## Mise à jour juin 2010 :

Il est à noter que depuis Magento version CE 1.4 et EE 1.8, il n'est plus nécessaire de dupliquer l'adapter.
En effet, une nouvelle méthode setQuality() à été implémentée et elle peut être utilisée directement dans les templates.

**Par exemple :**
```php
echo $this->helper('catalog/image')
    ->init($this->getProduct(), 'image', $_image->getFile())
    ->resize(42, 50)
    ->setQuality(90);
```
