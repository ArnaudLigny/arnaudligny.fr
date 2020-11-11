---
title: Créer rapidement une landing page avec Tailwind CSS
date: 2020-11-11
tags:
  - Développement
  - CSS
image: /images/tailwind-css.png
image_header: false
typora-root-url: ../../static
---

Ça faisait plusieurs semaines que j'avais envie de créer des mini-sites (*landing pages*) dédiés à quelques-unes de mes solutions open-source.

Néanmoins, je n'avais pas envie de (re)partir pour des dizaines heures d'intégration HTML/CSS (c'est un métier exigeant qui demande une forte expérience) pour essayer d’obtenir un résultat pro et respectant un maximum de standards.

Aussi je me suis dit que ce serait l’occasion idéale de tester [Tailwind CSS](https://tailwindcss.com/), un framework CSS « utility-first » conçu pour créer rapidement une page web sur mesure.

<video autoplay loop muted>
  <source src="/videos/tailwind-css-demo.mp4" type="video/mp4">
</video>
<!-- break -->

## Le principe

L’approche proposer par Tailwind CSS est de travailler avec des classes CSS pré-configurées : couleurs, graisses, marges, alignements, etc.

Par exemple, pour centrer du texte dans une balise `div` il suffit de lui appliquer la classe `text-center`. Simple et intuitif.

Néanmoins, ça devient un peu moins intuitif quand il faut se souvenir du « shortcut » de chacune de ces classes. Par exemple `-my-10` pour appliquer une marge négative de 40 pixels en haut et en bas.  
Mais il existe des solutions telles que [*Tailwind Cheat Sheet*](https://nerdcave.com/tailwind-cheat-sheet) qui liste toutes les classes de manière très visuelle, et offre un moteur de recherche (ou plutôt de filtrage) très efficace.

![Tailwind Cheat Sheet](/images/2020-11-11-creer-rapidement-une-landing-page-avec-tailwind-css/image-20201111221533370.png)

De plus, pour « jouer » avec les breakpoints il suffit d’ajouter le préfixe adéquate à la classe cible.

Par exemple `p-2 md:p-4` appliquera un `padding-top` de 0.5rem par défaut et de 1rem à partir d’une largeur d’écran de 768px.

## En pratique

Tailwind CSS peut être utilisé tel quel, juste en incluant la feuille de styles complète, compressée, depuis un CDN :  
`<link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">`.

Si cette méthode est pratique pour effectuer des tests rapides, c’est une mauvaise pratique : même compressé le fichier reste très lourd puisqu’il contient toutes les classes, y compris celles que vous n’utiliserez jamais.  
Et vous ne pourrez effectuer aucune personnalisation.

Mieux vaut installer l’utilitaire, créer une feuille de styles de référence (et personnalisable), un fichier de configuration et compiler la feuille de styles « de production ».

Installation :

```bash
npm install tailwindcss
```

Feuille de styles de référence, `tailwind.css` :

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

Création du fichier de configuration, `tailwind.config.js`:

```bash
npx tailwindcss init
```

Compilation :

```
npx tailwindcss build tailwind.css -o styles.css
```

Enfin, afin de réduire la taille du fichier produit, Tailwind CSS peut supprimer toutes les classes inutilisées s’il détecte que la compilation est réalisée dans un environnement de production (via `NODE_ENV`) :

```javascript
module.exports = {
  purge: [
    './templates/**/*.html',
  ]
}
```

> Note : pour forcer la purge en local il suffit d’ajouter le paramètre `enabled: true` à la configuration.

## Conclusion

Tailwind CSS est vraiment très facile à prendre en main, intuitif, pour un résultat qualitatif en quelques heures.  
J’imagine que certains puristes trouverons l’approche trop dirigiste et uniforme (en terme de rendu) mais retenez que Tailwind CSS est un outil « d’industrialisation » qui tend vers l’efficacité avant tout.

Enfin, afin d’illustrer mon propos je vous invite à regarder un exemple de résultat via la [landing page de ***The Butler***](https://the-butler.cecil.app/) (ma solution permettant de créer un blog en 1 minute grâce à [Cecil](https://cecil.app/) et [Netlify](https://www.netlify.com/)).

J’en ai d’ailleurs fait un thème « clef en main » pour [Cecil](https://cecil.app/) (mon générateur de site statique), disponible sur GitHub : [github.com/Cecilapp/theme-applanding](https://github.com/Cecilapp/theme-applanding#readme).

> Note complémentaire : je vous recommande également le site [Tailwind Toolbox](https://www.tailwindtoolbox.com/) pour vous aider à démarrer grâce à ses  « starter templates » (soyez tout de même prudent : certains sont un peu datés).