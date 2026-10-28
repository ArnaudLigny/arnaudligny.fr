---
title: "Failles critiques dans PHP : et si votre site n’avait pas besoin de PHP en production ?"
description: "Les failles CVE-2026-109618 et CVE-2026-109619 ont mis sous pression les équipes qui exploitent des sites PHP. Pour beaucoup de sites vitrines et de blogs, un site statique généré avec Cecil suffit, et son code PHP n’est jamais exposé."
date: 2026-10-28
tags: [Cecil, SSG, PHP, sécurité]
years: [2026]
published: true
---
La semaine dernière, l’équipe PHP a corrigé deux failles de sécurité critiques, et le CERT-FR a publié dans la foulée une [alerte relayée par Cybermalveillance.gouv.fr](https://www.cybermalveillance.gouv.fr/tous-nos-contenus/actualites/alerte-cyber-failles-de-securite-critiques-dans-php-202610). Pour de nombreuses équipes qui exploitent des sites sous WordPress, Drupal ou tout autre CMS PHP, la semaine a été longue : inventaire des serveurs, mises à jour en urgence, surveillance des logs.

Cette alerte pose pourtant une question qu’on oublie souvent : est-ce que tous ces sites avaient vraiment besoin d’exécuter du PHP en production ?
<!-- break -->

## Ce qu’il faut retenir de l’alerte

Les deux vulnérabilités, référencées [CVE-2026-109618](https://www.cve.org/CVERecord?id=CVE-2026-109618) et [CVE-2026-109619](https://www.cve.org/CVERecord?id=CVE-2026-109619), ont été corrigées dans le [bulletin PHP du 21 octobre 2026](https://www.php.net/archive/2026.php#2026-10-21-5). L’alerte du CERT-FR ([CERTFR-2026-ALE-014](https://www.cert.ssi.gouv.fr/alerte/CERTFR-2026-ALE-014/)) évoque des risques de prise de contrôle à distance, de déni de service, de vol ou de destruction de données, ainsi qu’un possible rebond vers le système d’information interne.

Les versions concernées :

| Branche                  | Versions vulnérables | Version corrigée    |
| ------------------------ | -------------------- | ------------------- |
| 5.x, 6.x, 7.x, 8.0, 8.1  | toutes               | aucune (fin de vie) |
| 8.2                      | < 8.2.35             | 8.2.35              |
| 8.3                      | < 8.3.36             | 8.3.36              |
| 8.4                      | < 8.4.27             | 8.4.27              |
| 8.5                      | < 8.5.12             | 8.5.12              |

Si vous exploitez un serveur PHP, la priorité reste évidemment de le mettre à jour. Et si vous tournez encore sur une branche en fin de vie, ce qui est le cas de beaucoup d’hébergements mutualisés et de « vieux » sites qu’on n’ose plus toucher, il n’y a tout simplement pas de correctif : il faut migrer.

## Le vrai problème : du code exécuté à chaque visite

WordPress et Drupal sont d’excellents outils, et ils ne sont pas en cause ici. Mais ils reposent sur un modèle dynamique : à chaque requête, le serveur exécute du PHP, interroge une base de données et assemble la page. Concrètement, n’importe quel visiteur, ou n’importe quel robot, peut envoyer des données à un interpréteur PHP accessible depuis Internet.

C’est précisément ce qui rend une faille dans le langage si sérieuse : la surface d’attaque, c’est le site lui-même, à chaque page, en permanence. À cela s’ajoutent les plugins, les thèmes, l’interface d’administration et la base de données, qui ont chacun leur propre historique de vulnérabilités.

Or, pour une grande partie du web, ce modèle est surdimensionné. Un site corporate, un blog, une documentation, une landing page ou le site d’un événement ont tous la même caractéristique : le contenu change quelques fois par semaine, mais il est consulté des milliers de fois par jour. Recalculer la même page à chaque visite n’apporte rien, à part de la charge serveur et des risques.

J’en avais déjà fait un plaidoyer il y a quelques années : [Arrêtez de faire des sites dynamiques](/blog/arretez-de-faire-des-sites-dynamiques/). Cette alerte en est une nouvelle illustration.

## Le modèle statique : générer une fois, servir partout

Un générateur de site statique (SSG) inverse la logique : les pages sont générées **une seule fois**, au moment de la publication, puis mises en ligne sous forme de simples fichiers HTML, CSS, JavaScript et images.

En production, il n’y a donc plus rien à exécuter : un serveur web ou un CDN se contente de servir des fichiers. Pas d’interpréteur, pas de base de données, pas de back-office exposé.

## Cecil : du PHP, mais jamais en production

[Cecil](https://cecil.app), le générateur de site statique que je développe depuis plusieurs années, est écrit en PHP. Ça peut sembler paradoxal dans le contexte, mais c’est justement là que réside tout l’intérêt : **PHP n’intervient qu’au moment du build**, sur votre poste ou dans votre pipeline de CI. Le code de Cecil, et plus largement le code PHP, n’est jamais exposé sur Internet.

Le fonctionnement est simple :

1. le contenu est rédigé en Markdown, avec un front matter pour les métadonnées ;
2. les gabarits sont écrits en [Twig](https://twig.symfony.com) ;
3. Cecil génère le site complet : pages, flux RSS, sitemap, images optimisées, CSS et JS minifiés ;
4. le dossier `_site` est déployé tel quel, sur n’importe quel hébergement.

```bash
cecil build
```

Et c’est tout. Le résultat se déploie sur Netlify, Cloudflare Pages, GitHub Pages, Vercel, un bucket S3 ou un bon vieux serveur Nginx.

Quand une faille PHP est publiée, le site en ligne n’est tout simplement pas concerné : il n’y a aucun PHP à attaquer.

### Et l’environnement de build ?

Soyons honnêtes : PHP reste présent dans la chaîne, au moment de la génération. Il faut donc, comme pour n’importe quel outil, le maintenir à jour. Mais le contexte n’a rien à voir :

- le build s’exécute ponctuellement, dans un environnement éphémère (une CI) ou sur votre poste ;
- il traite **vos** contenus, pas des requêtes envoyées par des inconnus ;
- il n’est pas joignable depuis Internet.

Et si vous ne voulez pas gérer PHP du tout, Cecil est désormais disponible sous forme de [binaire autonome](/blog/cecil-binaire-autonome/), qui embarque son propre PHP.

## Les autres bénéfices du statique

La sécurité est l’argument du moment, mais ce n’est pas le seul :

- **Performance** : des pages déjà prêtes, servies depuis un CDN au plus près des visiteurs. Difficile de faire plus rapide.
- **Disponibilité** : un pic de trafic ne fait pas tomber un site statique. Pas de base de données à saturer.
- **Coûts** : l’hébergement de fichiers statiques est souvent gratuit, ou presque.
- **Sobriété** : pas de calcul inutile à chaque visite, donc une empreinte serveur minimale.
- **Maintenance** : pas de mises à jour de cœur, de plugins ou de base de données à appliquer dans l’urgence.
- **Pérennité** : le contenu est stocké en Markdown, versionné dans Git, et reste lisible dans 20 ans.

## « Mais mes rédacteurs ont besoin d’une interface »

C’est l’objection la plus fréquente, et elle est légitime. Mais le statique ne signifie pas renoncer au confort d’édition : un CMS Git-based ou headless permet aux rédacteurs de modifier les contenus depuis une interface web, chaque publication déclenchant un nouveau build.

Ce site, par exemple, est édité avec [Pages CMS](https://pagescms.org) : j’écris dans une interface web, les modifications sont commitées dans le dépôt GitHub et le site est régénéré puis redéployé automatiquement.

Et les besoins dynamiques ponctuels (formulaire de contact, recherche, commentaires, voire [panier d’achat](/blog/un-site-e-commerce-avec-cecil-et-snipcart/)) se règlent très bien avec des services tiers ou des fonctions serverless, sans réintroduire un serveur applicatif complet.

## Le statique n’est pas la réponse à tout

Je ne vais pas prétendre qu’un générateur de site statique remplace tous les CMS. Un site e-commerce avec un gros catalogue, un intranet, une application avec des comptes utilisateurs ou un média qui publie en continu ont de vraies contraintes dynamiques.

Et un site statique n’est pas invulnérable : l’hébergement, le nom de domaine ou les scripts tiers doivent toujours être surveillés. La surface d’attaque est simplement beaucoup plus réduite.

En revanche, pour un très grand nombre de sites vitrines, de blogs et de documentations, la question mérite d’être posée sérieusement, surtout à l’heure de la prochaine refonte… ou de la prochaine alerte de sécurité.

## Essayer Cecil

Si vous êtes développeur PHP, vous retrouverez vos outils et vos habitudes : Composer, Twig, des composants Symfony. Sans en payer le prix côté sécurité en production.

```bash
cecil new:site mon-site
cecil serve
```

Pour aller plus loin :

- le site officiel : <https://cecil.app> ;
- la [documentation](https://cecil.app/documentation/) ;
- le code source sur [GitHub](https://github.com/Cecilapp/Cecil).
