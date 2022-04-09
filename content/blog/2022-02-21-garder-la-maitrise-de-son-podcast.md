---
title: Garder la maîtrise de son podcast
description: ""
date: 2022-02-21
tags: [Podcast, SSG, Cecil]
image: /images/2022-02-21-garder-la-maitrise-de-son-podcast/staticast-preview.png
image_header: false
typora-root-url: "../../assets"
typora-copy-images-to: ../../assets/images/${filename}
draft: true
---

Depuis quelques années le [podcasting](/tags/podcast)[^podcasting] prend de plus en plus d’ampleur, certainement parce que le format séduit aussi bien les créateurs que les auditeurs : pour les uns il est très plaisant de s’exprimer de vive voix, d’échanger avec un ou plusieurs interlocuteurs, et pour les autres il s’écoute comme une émission de radio avec la liberté du « on demand »[^on-demand].

<!-- break -->

[toc]

## Flux RSS ?

D'un point de vue technique, la manière de mettre à disposition un podcast est relativement simple : il s'agit d'un flux [RSS](https://fr.m.wikipedia.org/wiki/RSS) – listant des fichiers audio – auquel les auditeurs s'abonnent ([Syndication](https://fr.m.wikipedia.org/wiki/Wikip%C3%A9dia:Syndication)) et qu'ils peuvent ensuite écouter via une application dédiée (web ou mobile).  
Ainsi, au dela du processus principal de création (à savoir l'enregistrement, le montage et la rédaction de la description d'un épisode, etc.) il est donc nécessaire de générer un fichier RSS écrit en XML.

Par exemple :

```xml
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0"
  xmlns:content="http://purl.org/rss/1.0/modules/content/"
  xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
  xmlns:googleplay="http://www.google.com/schemas/play-podcasts/1.0"
>
  <channel>
    <title><![CDATA[Podcast title]]></title>
    <description><![CDATA[Description]]></description>
    <lastBuildDate>2020-06-17T02:00:00+02:00</lastBuildDate>
    <link>https://example.com/episodes/</link>
    <language>en</language>
    <generator>https://cecil.app</generator>
    <itunes:summary><![CDATA[Description]]></itunes:summary>
    <googleplay:description><![CDATA[Description]]></googleplay:description>
    <itunes:owner>
      <itunes:name><![CDATA[Owner name]]></itunes:name>
      <itunes:email>owner@domain.tld</itunes:email>
    </itunes:owner>
    <googleplay:owner>owner@domain.tld</googleplay:owner>
    <image>
      <url>https://example.com/cover.png</url>
      <title><![CDATA[Staticast]]></title>
      <link>https://example.com/episodes/</link>
      <description><![CDATA[Staticast]]></description>
      <width>1400</width>
      <height>1400</height>
    </image>
    <itunes:image href="https://example.com/cover.png" />
    <googleplay:image href="https://example.com/cover.png" />
    <itunes:author><![CDATA[Author name]]></itunes:author>
    <googleplay:author><![CDATA[Author name]]></googleplay:author>
    <itunes:category text="Category" />
    <googleplay:category text="Category" />
    <itunes:type>episodic</itunes:type>
    <item>
      <guid>https://staticast-demo.cecil.app/episodes/1/</guid>
      <title><![CDATA[Episode title]]></title>
      <description><![CDATA[<Description]]></description>
      <pubDate>2020-06-17T02:00:00+02:00</pubDate>
      <link>https://example.com/episodes/4/</link>
      <itunes:summary><![CDATA[Description]]></itunes:summary>
      <googleplay:description><![CDATA[Description]]></googleplay:description>
      <enclosure url="https://example.com/episode-1.mp3" length="252235" type="audio/mpeg" />
      <itunes:duration>11</itunes:duration>
    </item>
  </channel>
</rss>
```



### Construire le flux RSS

- Apple : https://help.apple.com/itc/podcasts_connect/#/itcb54353390
- Google : https://support.google.com/podcast-publishers/answer/9889544
- Autre : https://www.feedforall.com/macdocs/html/podcastdocumentation.html

### Valider le flux RSS

- Podbase : https://podba.se/validate/










[^podcasting]: Système de diffusion d'émissions audio ou vidéo sur Internet, qui permet de les télécharger et de les transférer sur un appareil numérique (selon [Le Robert](https://www.lerobert.com/google-dictionnaire-fr?param=podcasting)).

[^on-demand]: « à la demande »

*[RSS]: Really Simple Syndication, littéralement « syndication vraiment simple »
*[XML]: eXtensible Markup Language
