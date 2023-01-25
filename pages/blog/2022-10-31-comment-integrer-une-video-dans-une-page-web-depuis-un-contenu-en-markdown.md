---
title: "Comment intégrer une vidéo dans une page Web depuis un contenu en Markdown ?"
date: 2022-10-31
tags: [Réflexion, Markdown, Cecil]
#image: 
image_header: false
typora-copy-images-to: ../../assets/images/${filename}
published: true
---
Réflexion du week-end : comment intégrer *simplement* une vidéo dans une page Web (statique, générée) depuis un contenu rédigé en Markdown ?

Après avoir tourné le truc dans tout "les sens", j'ai finalement opté pour le lien *embedded*.
<!-- break -->
En effet, au début, pour intégrer un fichier vidéo j'ajoutais simplement la balise HTML `<video>` dans mon texte rédigé en Markdown : c'est relativement simple quand on sait comment doit être structuré l'élément HTML.  
Néanmoins, ça n'est pas forcément évident pour un contributeur lambda.

Aussi, j'avais d'abord imaginé "tricher" avec le format d'image Markdown en jouant sur l'attribut "alt" pour indiquer qu'il s'agissait d'une vidéo et non d'une image.  
Par exemple : `![video](video.mp4)`.  
De là j'avais modifié mon convertisseur Markdown vers HTML pour qu'il détecte le texte "video" dans la description alternative afin qu'il retourne un élément `<video>` à la place d'un `<img>`.  
En pratique ça fonctionnait bien mais c'était une mauvaise idée : détourner ainsi le format d'image prêtait à confusion et on perdait à la fois l'aperçu dans l'éditeur mais surtout la compréhension pour quelqu'un qui découvre le contenu ("c'est quoi ce fichier vidéo dans une image ?!").

Bref, je me suis alors dit qu'il fallait rester simple et proposer une solution plus intuitive pour le contributeur.

- Quel est l'objectif ? Partager une vidéo.
- Qu'est-ce qu'on en connaît ? Son lien et son titre.
- Conclusion ? On écrit un lien !

`[Une vidéo très intéressante](vidéo-interessante.mp4)`

Le texte du lien permet de qualifier la vidéo et il suffit de suivre le lien pour la consulter.

Maintenant, dans un contexte de page Web, on souhaite quand même afficher directement la vidéo dans un lecteur HTML natif.

L'idée ici est simplement d'enrichir la syntaxe Markdown "link" avec un attribut, selon le pseudo standard supporté par Markdown Extra :  
`[Une vidéo très intéressante](vidéo-interessante.mp4){embed}`

De là mon convertisseur va chercher si le lien est un fichier et si ce fichier a une extension vidéo "embeddable" (`mp4` dans exemple).  
Si oui, il va retourner un élément `<video>` plutôt que `<a>`.

Voilà, j'avais juste envie de partager cette réflexion 😊