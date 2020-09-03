---
title: "Debian + Apache2 + SSL"
date: 2006-12-21
tags:
  - Développement
---

Hier soir j'ai installé et configuré (rapidement) [OpenSSL](http://www.openssl.org) sur mon [Apache2](http://httpd.apache.org). Aucun objectif clair pour le moment, je pense que c'était plutôt histoire de tester le bignou et de préparer l'arrivée de [TRAC](http://trac.edgewall.org).

Bref, avec Apache2 la mise en place d'un accès sécurisé m'a semblé plutôt simple. Reste qu'en l'état, ça ne me sert pas à grand chose : il faudrait encore configurer un vhost associé afin de protéger tel ou tel contenu (comme un accès à des *repositories* SVN) et d'y associer les certificats qui vont bien.
Chaque chose en son temps, ce sera l'étape suivante !

En attendant, voici quelques commandes sous Debian :
<!-- excerpt -->
Installation du package OpenSSL (si ce n'est pas déjà le cas) :

```
# apt-get update# apt-get install openssl
```

Création de la clef et demande OpenSSL :

```
# openssl req -new > new.cert.csr
```

(*new* est un nom choisi arbitrairement)

Commande pour "enlever" la phrase de mot de passe, afin de ne pas devoir la renseigner au prochain redémarrage d'Apache (optionnel) :

```
# openssl rsa -in privkey.pem -out new.cert.key
```

Enfin, création à proprement dit du certificat (.crt) et de la clef (.key) :

```
# openssl x509 -in new.cert.csr -out new.cert.cert -req -signkey new.cert.key -days 365
```

(Attention, veillez à lancer cette commande dans le répertoire adéquate : je vous conseil "/etc/ssl/").

Voilà, il ne vous reste plus qu'à configurer le module et à paramétrer votre vhost (sans oublier d'écouter le port 443, port par défaut de SSL).

*Astuce rapide :*
Pour activer le module SSL d'Apache2, plutôt que de créer des liens symboliques :

```
# ln -s /etc/apache2/mods-available/ssl.conf# ln -s /etc/apache2/mods-available/ssl.load
```

je vous conseil la commande suivante :

```
# a2enmod ssl
```

