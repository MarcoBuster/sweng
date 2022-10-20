---
layout: post
title: "[06] Git workflow"
date:   2022-10-19 14:45:00 +0200
toc: true
---

# Git workflow

In Git flow, c'è differenziazione tra i tipi di branch. 
Ci sono delle operazioni "guidate".

## master e develop

Ci sono due rami con _"vita infinita"_:
- __master__: contiene le versioni _"stabili e pronte alla consegna"_;
- __develop__: è il ramo su cui viene integrata la versione comune in tutti i gruppi.

Ad ogni rilascio il contenuto di develop va in master.
Dal develop vengono rilasciate le _versioni notturne_.

## feature branch

Possono partire solo dal develop e non da nessun altro branch

```bash
$ git checkout develop
$ git branch feat1
$ git checkout feat1
```

Dopo aver finito la feature, posso...

```bash
$ git checkout develop
$ git merge --no-ff feat1
$ git branch -d feat1
```

No fast forward nel merge in modo da distinguere il punto di inizio e il punto di fine di una feature.

Lo squash è opinabile, se non lo si fa si mantengono i commit originali. 

## Release

La release è lo freezing delle nuove funzionalità.
L'insieme delle funzionalità che vado a rilasciare sono quelle presenti su develop nel momento in cui faccio `start-release`.

```bash
$ git checkout -b ver develop
```

Viene creato quindi un branch di release in cui vengono stabilizzate le robe presenti nel develop.

Alla fine della rilascio...
```bash
$ git checkout master
$ git merge --no-ff release-ver
$ git tag -a ver
$ git checkout develop
$ git merge --no-ff release-ver
$ git branch -d release-ver
```

La differenza tra tag e branch è che il tag rimane costante sul commit, mette il branch va avanti tra commit e commit.

Un'altra differenza tra release e feature è che posso avere solo una release.

## Hotfix

Riparazione veloce di difetti urgenti senza aspettare la prossima release.

Non parto dal develop, ma dall'ultima (o da una) versione rilasciata.

```bash
$ git checkout -b ver master
```

Quando lo chiudo:
```bash
$ git checkout master
$ git merge --no-ff ver
$ git tag -a ver
$ git checkout develop
$ git merge --no-ff ver
$ git branch -d ver
```

## Limiti

Quali sono i limiti di git presentato così?

### Review
`git-request-pull`: genera un sommario delle modifiche pendenti.

Non è la pull request, ma una request pull. 
È un modo che aveva pensato Linus Torvalds per formattare la proposta di modifiche e inviarla su una mailing list.

    git request-pull [-p] <start> <URL> [<end>]

Diviso per autore mostra i commenti dei commit creati, file per file le modifiche fatte.
È una formattazione a 'summary' di cosa si sta cercando di pullare.
Molto più 'peer to peer' del modello 'pull request' semi-centralizzato attuale.

# Hosting centralizzato

Permettono di superare i limiti della decentralizzazione.

Inventano nuovi meccanismi, provando a imporre nuovi workflow (GitHub Flow, GitLab Flow, ...).

## Fork

Risolve un primo problema di autorizzazione: permette di mantenere legami tra repository su sito di hosting ma con owner e autorizzazioni diversi.

Ottimizza la condivisione dello spazio degli oggetti.

Praticamente nel 2020 hanno bannato youtube-dl da Github
Dei geni hanno forkato la repo dei DMCA (reclami copyright) 

## Review / Pull request

<!-- aggiungere img schema -->

Permette interazioni lasche tra sviluppatori mediante sito di hosting.

Nella PR si può commentare e discutere in modo informale. 

Ci possono usare dei tool, spesso integrati nella piattaforma, di CI per testare/controllare automaticamente la richiesta.

C'è un sistema che permette di interagire e creare delle basi di conoscenza anche tra sconosciuti in modo da poter implementare la feature.

# Gerrit

Nasce interno a Google, per sviluppare progetti interni.

Si basa su un meccanismo di _peer review_: non c'è una persona fissa che è l'unico maintainer di una zona, ma tutti fanno review. 

- I developer possono sottoporre proposte di cambiamento;
- I reviewer possono validare le suddette proposte;

Una volta che ci sono _tot_ review positivi, la patch approda su un git server _autorativo_ in cui tutti hanno permesso solo di scrittura.

Gerrit obbliga a strutturare le modifiche (changeset) in un unico commit (squash) al momento dell'accettazione; al momento della review rimangono le versioni singole. 

## Verifier

Scarica la patch, la compila, controlla che ci siano tutti funzioni, controlla che tutto funzioni come dovrebbe.

## Approver

Se sei assegnato come approver a una modifica, devi determinare:
- ...

Se approvi la modifica, la puoi approvare con LGTM (_"Looks Good To Me"_).

# Strumenti dell'opensource

## Build automation

Un pezzo importante è la build automation, ovvero l'insieme delle operazioni che partendo dal codice sorgente arrivano all'eseguibile compilato.

### make

Definisco a livello di shell quali sono i comandi da dare per ottenere certi obiettivi.

Gestisce le dipendenze tra i file.

<!-- esempio -->

È a un livello molto basso ed è prono ad errori.
Non c'è portatibilità tra macchine (ambienti) diverse.

#### Generazione automatica

Sono stati creati dei tool (`automake`, `autoconf`, `imake`, ...) che _generano_ `Makefile`.

### Ant 
Ant nasce in Apache per supportare il progetto Tomcat.

Scritto in Java per progetti Java. Usa XML per specificare le azioni.

Nella versione base supporta già un integrazione per alcuni tool come CVS, Junit, ...
Non fa solo compilazione, ma anche deployment.

### Gradle
Gradle è fatto Kotlin. 
Approccio dichiarativo e fortemente basato su convenzioni: tutto quello che è già definito come standard non è necessario ridichiarlo un'altra volta.
Definisce un linguaggio specifico per le dipendenze.
Permette di creare build multi-progetto.

Scala bene in complessità: permette di fare cose semplici senza usare le funzioni compresse. 
È estendibile tramite plugin che servono per trattare tool, situazioni, linguaggi legati solitamente al mondo Java.

#### Plugin Java

Definisce il:
- sourceSet: dove è presente il codice sorgente
- task

...

#### Altri plugin
- application (esecuzione)
- ...
- eclipse
- idea

## Bug tracking

È stato reso necessario nel mondo open source per via della numerosità dei contributi e della alta probabilità di avere segnalazioni duplicate.

### Bug workflow

Ci sono diversi modi per cui può essere chiuso un bug:
- duplicate
- wontfix
- can't reproduce
- fix verified
