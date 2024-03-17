---
title: "Installer Subversion sur Debian, accessible via Apache2"
date: 2007-01-14
tags:
  - Développement
years: [2007]
published: true
---
Je m'étais promis d'installer [SVN](http://subversion.tigris.org) sur mon serveur afin de me simplifier la vie de développeur et c'est enfin fait !

Finalement l'opération à été nettement plus simple que ce que j'avais imaginé, même si c'est toujours les petites touches finales qui sont pénibles... bref, je vais vous expliquer ici comment installer un serveur subversion, créer un dépôt (également appelé référentiel ou *repository*), le rendre accessible par le Web (via [Apache2](http://httpd.apache.org/docs/2.0/)) et appliquer des règles d'accès.
<!-- excerpt -->
### Subversion

#### Installation

```bash
apt-get install subversion subversion-tools
```

(subversion-tools est un package supplémentaire d'outils pour l'administration et la maintenance de Subversion)

#### Création d'un dépôt

Maintenant que Subversion est installé, il toute de suite possible de créer son premier dépôt :

```bash
mkdir --p /path/to/svn/repositories
cd /path/to/svn/repositories
svnadmin create myrepository
```

### Accès au dépôt via Apache2

#### Installation du module

Afin de rendre accessible le dépôt créé (autrement qu'en local) nous allons installer le module [WebDAV](http://httpd.apache.org/docs/2.0/mod/mod_dav.html) pour SVN pour Apache2. Ainsi, notre dépôt deviendra accessible depuis le Web via HTTP en passant par le protocole dav_svn.

```bash
apt-get install libapache2-svn
a2enmod dav_svn
/etc/init.d/apache2 reload
```

Facile non ?! ^^

#### Configuration d'Apache2

Le module est installé, passons maintenant à partie un peu plus délicate, la configuration d'Apache2.
Dans le cas présenté ici, j'ai modifié le fichier de configuration d'Apache2, à savoir 'apache2.conf' auquel j'ai ajouté les lignes suivantes en fin de fichier :

```ini
<location /myrepository/svn>
    DAV svn
    SVNPath /path/to/svn/repositories/myrepository
    # how to authenticate a user
    AuthType Basic
    AuthName "SVN : My Repository"
    AuthUserFile /path/to/private/myrepository.htpasswd
    # our access control policy
    AuthzSVNAccessFile /path/to/private/myrepository.authz
    <LimitExcept GET PROPFIND OPTIONS REPORT>
        Require valid-user
    </LimitExcept>
</location>
```

#### Droits Apache2

Afin qu'Apache2 puissent accéder aux fichiers de votre dépôt, il est nécessaire de modifier les droits qui leurs sont appliqués :

```bash
chown -R www-data:www-data /path/to/svn/repositories
chmod -R 775 /path/to/svn/repositories
```

On relance Apache2 pour valider notre configuration et on passe aux droits d'accès.

### Sécurisation et règles d'accès

#### Sécuriser l'accès

Afin de protéger l'accès au dépôt que nous avons créé, nous allons créé un fichier d'utilisateurs (chacun étant associé à un mot de passe haché).

```bash
cd /path/to/private/
htpasswd -cm myrepository.htpasswd myuser
```

***Note :***

```bash
-cm : c = création, m = hachage MD5
```

Il est également conseillé de créer un accès anonyme pour la consultation des sources :

```bash
htpasswd -m myrepository.htpasswd anonymous
```

#### Définir les permissions

Ce fichier d'utilisateurs n'est intéressant qu'une fois combiné à un fichier de permissions (*authz*) afin de définir des règles simple sur qui peut faire quoi et où.

```bash
touch /path/to/private/myrepository.authz
```

Exemple de règles appliqué à mon dépôt :

```ini
[groups]
dev = narno, engy

[/]
anonymous = r
@dev = rw

[/trunk]
@dev = rw

[/branches]
narno = rw
engy = r

[/tags]
narno = rw
engy = r
```

L'édition du fichier de permission s'effectue à la manière d'un fichier *INI* :

- nous définissons d'abord un groupe *dev* comportant 2 utilisateurs, à savoir narno et engy (ces 2 utilisateurs doivent exister dans le fichier de d'utilisateur créé à l'étape précédente)
- ensuite nous appliquons des droits pour chacun des niveaux de l'arborescence du dépôt

Encore une fois, rien de bien compliqué !

### Tests

Afin de s'assurer que notre configuration est parfaitement opérationnelle, nous allons effectuer 2 tests rapide :

#### Création des 3 branches de référence

```bash
svn mkdir http://localhost/myrepository/svn/trunk \
http://localhost/myrepository/svn/branches \
http://localhost/myrepository/svn/tags -m "Création des 3 branches de référence." --username=myuser
```

#### Accès à ces branches via votre navigateur

Tentez simplement de parcourir votre dépôt via votre navigateur préféré :

```
http://localhost/myrepository/svn
```


Voilà, vous êtes paré pour développer en toute tranquillité ! ^^

Dans le courant de la semaine, je compléterais ce tutorial par un billet dédié à l'installation de **[Trac](http://trac.edgewall.org/)**. A suivre ! ;-)
