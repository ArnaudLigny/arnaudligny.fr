---
title: 'Debian + postreSQL + phppgadmin'
date: 2006-12-22
tags:
  - Développement
---

Depuis quelques temps, je fais pas mal "joujou" avec [ma Dedibox](https://web.archive.org/web/20070425184223/http://www.narno.com/blog?id=43) et je personnalise ma Debian selon mes besoin et mes envies.
Ainsi, la semaine dernière, j'ai installé [phppgadmin](http://www.phppgadmin.org/) (équivalent de [phpMyAdmin](https://web.archive.org/web/20070425184223/http://www.phpmyadmin.net/), mais pour [PostgreSQL](http://www.postgresql.org/)) pour interagir plus facilement avec PostgreSQL.

Pour ma part, PostgreSQL était déjà en place : je ne sais plus si le SGBD est installé par défaut avec Debian ou si j'ai fais la manip' moi même. Dans le doute, voici la commande qui va bien :

```
# apt-get install postgresql
```

De là, l'installation de phppgadmin est tout aussi simple :

```
# apt-get install phppgadmin
```

Vous pourrez ainsi accédé à l'interface de phppgadmin via l'URL suivante :

```
http://votre_serveur/phppgadmin
```
<!-- excerpt -->
Néanmoins, par défaut l'interface est pas mal protégé : en effet, une ouverture sur le web à un gestionnaire de base de données est toujours un facteur de risque.
Il vous faudra donc modifier la configuration de la manière suivante :

1. Ajuster le fichier de configuration lié à Apache afin que ce dernier en autorise l'accès :

   ```
   /etc/phppgadmin/apache.conf
   ```

   Le plus simple étant peut être de s'inspirer du fichier correspondant de phpMyAdmin.

2. Ensuite, il faut que vous autorises la connexion à Postgres via l'interface de phppgadmin. Pour celà, il suffit de l'autoriser dans le fichier de configuration correspondant :

   ```
   /etc/phppgadmin/config.inc.php
   ```

   remplacez :

   ```
   $conf['extra_login_security'] = false;
   ```

   par :

   ```
   $conf['extra_login_security'] = true;
   ```

3. Pensez à ouvrir le port de Postres : 5432

4. Enfin, le mot de passe par défaut du root, à savoir l'utilisateur *postgres* est vide. Pour pouvoir se connecter, il est nécessair de tapper un mot de passe. Il vous faudra donc le changer, ne ligne de commande bien sûr ! Je vous invite à vous référer ua site officiel pour les différentes commandes existantes pour Postgres (voir le lien tout en haut de ce billet).

   ```
   ALTER USER postgres WITH PASSWORD 'votre_mot_de_passe'
   ```

Ah oui, j'oubliais : il est possible que malgré l'application d'un mot de passe, vous n'arriviez pas à vous connecter. Le problème est du, encore une fois, à la configuration par défaut de Postgres. il faut modifier le fichier de configuration, au niveau des méthodes d'accès :

```
/etc/postgresql/pg_hba.conf
```

Remplacer les méthodes en place par ***MD5***, tout simplement ! (merci à Yom pour l'astuce ^^).

Et voilà une interface web bien pratique pour créer et modifier à volonté ses tables PostgeSQL ! Couplé à [PDO](https://web.archive.org/web/20070425184223/http://www.narno.com/blog?id=57), c'est un vrai bonheur ! :-)