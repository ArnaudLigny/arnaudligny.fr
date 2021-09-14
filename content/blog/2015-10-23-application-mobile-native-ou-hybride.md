---
title: "Application mobile : Native ou hybride ?"
date: 2015-10-23
tags:
  - Application mobile
  - React Native
image: /images/native-VS-hybrid.gif
published: true
---

Aujourd'hui, il n'est plus question de faire l'impasse quant à sa présence sur mobile lorsque l'on propose un service en ligne, que ce soit à destination du grand public ou de ses collaborateurs.

La "vraie" question qui se pose – encore – aujourd'hui est de savoir si cette application doit être développée dans le système natif de chacun des OS du marché à savoir iOS, Android ou encore Windows Mobile, ou si elle doit être hybride ?
<!-- excerpt -->
En effet, cette question n'est pas nouvelle et continuera à se poser tant que les technologies mises en oeuvre continueront à évoluer : D'avantage de puissance matérielle, navigateur Web embarqué dans l'application, enrichissement des API, etc.

Pour répondre à la question de "quoi choisir", il faut bien entendu comprendre les différences entre les deux approches.

## Qu'est-ce qu'une application "native" ?

Comme son nom le laisse supposer une application dite "native" est développée pour un système donné et uniquement pour celui-ci.

Ainsi, dans le cas d'une application iOS (iPhone, iPod, iPad, etc.), celle-ci sera programmée dans le langage [Objective C](https://fr.wikipedia.org/wiki/Objective-C) (et plus récemment [Swift](http://thenextweb.com/apple/2014/06/02/apple-announces-swift-new-programming-language-ios/)) alors que dans le cas d'une application Android, le langage utilisé est Java (même si Google utilise sa propre machine virtuelle : [Dalvik Virtual Machine](https://fr.wikipedia.org/wiki/Dalvik_(machine_virtuelle))).

### Les plus

Excellente expérience utilisateur : L'UI est cohérente avec l'OS, l'utilisateur trouve rapidement ses marques.  
Intégration simple avec le hardware du téléphone, et plus particulièrement avec les "capteurs" : GPS, appareil photo, bluetooth, etc.

### Les moins

Il est nécessaire de connaître le framework de développement de chacun des écosystèmes.  
Oblige à maintenir plusieurs socles applicatifs tout au long de la vie de l'application (autant de socles que de plateformes).

## Qu'est-ce qu'une application "hybride" ?

### Historiquement était la Web App

Pour parler d'application hybride, il faut d'abord aborder le cas des Web App. Une Web App est une application mobile développée à la manière d'un site Web « classique » (HTML, CSS, Javascript, etc.) et elle est exécutable via le navigateur Internet du téléphone mobile.

Une Web App est très simple à mettre en oeuvre car elle utilise des technologies Web et ne nécessite pas d'être contextualisée à l'environnement qui l'exécute : Le navigateur du téléphone se charge de l'exécuter.

Néanmoins, ce que l'on gagne en simplicité de mise en oeuvre est perdu en expérience utilisateur car la Web App n'est pas toujours bien adaptée à l'appareil qui l'affiche (ex: taille d'écran, pondéré par le [Responsive Web Design](https://fr.wikipedia.org/wiki/Site_web_adaptatif)) et n'est pas toujours très fluide ni réactive (puisqu'elle dépend du navigateur du téléphone et non du système directement).

D'autre part, contrairement à une application native, une Web App n'est pas capable de communiquer avec les différents capteurs du téléphone (voir plus haut).

En bref, une Wep App n'est à peine plus qu'un site Web adapté au mobile.

### L'hybridation

Pour répondre à cette double problématique réactivité et intégration native, l'approche hybride est née avec PhoneGap (depuis renommé [Apache Cordova](https://fr.wikipedia.org/wiki/Apache_Cordova)) en 2009 : Le principe est de garder cette logique d'application basée sur les technologies du Web (HTML, CSS et Javascript) tout en l'intégrant de manière plus forte au système.

En pratique Cordova expose des API interrogeables via Javascript, le langage de programmation utilisé au sein de l'application Web.

Les avantages d'une telle approche sont évidents :

* Concevoir et programmer une interface commune à l'ensemble des appareils
* ...dans des technologies déjà connues et maîtrisées par les professionnels du Web (HTML, CSS, Javascript)
* ...tout en étant capable d'interagir avec le device

## L'hybride c'est magique ! C'est la solution ultime ?

Oui et non.

### Quid de l'expérience utilisateur ?

Si une bonne partie du travail réalisé (le code) est partageable entre les différentes versions de l'application (une version par environnement cible), il n'en demeure pas moins qu'une application iOS n'est pas une application Android en terme d'expérience utilisateur : Il y a des codes visuels, une UI a respecter (ex: 1 bouton sur iPhone contre 3 sur un Nexus), etc.

### Et la performance alors ?

D'autre part, malgré l'évolution des technologies (puissance du hardware), le problème de performance subsiste, ce qui – dans une certaine mesure – peut impacter l'expérience utilisateur.

En effet, aujourd'hui le gain de réactivité est suffisant pour que ce ne soit pas pénalisant sur une application utilisée occasionnellement (plusieurs fois par semaine), là où ça peut être plus irritant dans le cas d'une application utilisée beaucoup plus régulièrement (plusieurs fois par jours) : délais de réaction lors de la sollicitation d'un élément de menu, temps de chargement d'un écran, etc.

Néanmoins, l'écart entre natif et hybride se restreint : un exemple valant mieux qu'un long discours, je vous invite à tester l'application Facebook Groups basée sur [React Native](https://facebook.github.io/react-native/), le framework hybride réalisé par Facebook.

## Conclusion

A la lecture de cet article, vous l'aurez compris, la balance penche d'avantage vers les solutions hybrides pour des raisons évidentes de coût de développement, de compétence des équipes de production, de flexibilité, etc.

L'élément différenciant restant l'expérience utilisateur "plus immersive" et surtout la réactivité au "10ème de seconde" dans le cas d'une application native.

**Ainsi, les critères de choix seront :**

1. Vous avez besoin d'une application très réactive et immersive (au sens environnement applicatif) et vous avez les moyens de vos ambitions : Faites du natif.
2. Pour tout les autres cas, la solution hybride est plus que recommandée !

*[OS]: Operating System / système d'exploitation
*[API]: Application Programming Interface
*[UI]: User Interface
*[GPS]: Global Positioning System

> _Initialement publié sur [Adfab Connect](https://connect.adfab.fr/mobile/application-mobile-native-ou-hybride)._
