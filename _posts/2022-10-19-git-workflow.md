---
layout: post
title: "[06] Git workflow"
date:   2022-10-19 14:45:00 +0200
toc: true
---

# Git Workflow

In Git è praticamente impossibile non utilizzare i branch. 
C'è __libertà completa__ sul loro utilizzo: tutti i branch hanno pari importanza, chiunque può crearli e nominarli in qualunque modo.

Lavorando in un team, è quindi necessario stabilire delle politiche sui tipi e i nomi di branch, in modo da organizzare il lavoro al meglio. 

## GitFlow

GitFlow è una tecnica di organizzazione dei branch e della repository.
I branch sono differenziati in tipi e possono avere vita limitata.
Le operazioni di creazione e _merge_ di branch sono guidate.

È disponibile online una [cheatsheet](https://danielkummer.github.io/git-flow-cheatsheet/) molto interessante, ma non esaustiva.

I branch e i tipi di branch previsti da GitFlow sono:
- branch master;
- branch develop;
- feature branches;
- release branches;
- hotfix branches.

## develop e master

{% responsive_image path: 'assets/06_gitflow-develop-master.png' %}

In GitFlow, ci sono due rami con _"vita infinita"_:
- __master__: contiene le versioni _"stabili e pronte alla consegna"_;
- __develop__: è il ramo di integrazione in cui vengono integrati i contribuiti di tutti i gruppi; è anche il punto di partenza degli altri tipi di branch.

Al termine di ogni rilascio il contenuto di develop viene mergiato in master.
Dal develop vengono rilasciate le _versioni notturne_.

## feature branch

{% responsive_image path: 'assets/06_gitflow-feature.png' width: "400" %}

I feature branch __possono partire solo dal branch develop__ e non da nessun altro branch.

Per iniziare una feature...
```bash
$ git checkout develop                  # entra nel branch develop
$ git branch feature/myFeature          # crea un branch di feature
$ git checkout feature/myFeature        # entra nel branch appena creato
```

Al termine della feature, integro:

```bash
$ git checkout develop                  # entra nel branch develop
$ git merge --no-ff feature/myFeature   # mergia il branch di feature
$ git branch -d feature/myFeature       # elimina il branch di feature
```
### -\-no-fast-forward

{% responsive_image path: 'assets/06_gitflow-feature-ff.png' %}

Di default, Git risolve il merge di due branch con la stessa storia banalmente eseguendo il _fast forward_, ovvero spostando il puntatore del branch di destinazione all'ultimo commit del branch entrante.

In GitFlow è preferibile esplicitamente __disabilitare il fast forward__ (con l'opzione `-\-no-ff`) durante il merge in develop in quanto è più facile distinguere il punto di inizio e il punto di fine di una feature.

### Squashing

Usando Git è anche possibile eseguire in fase di merge lo _squashing_ dei commit, ovvero la fusione di tutti i commit del branch entrante in uno solo. 
Questa operazione è utile per migliorare la leggibilità della history dei commit su branch grossi (come develop o master) ma il suo uso in GitFlow è opinabile: il prof. Bellettini consiglia di non utilizzarlo, in modo da mantenere i commit originali.

## Release

{% responsive_image path: 'assets/06_gitflow-release.png' %}

Lo scopo di creare una release è __cristalizzare l'insieme delle funzionalità__ presente sul branch develop all'inizio di essa dedicandosi solo alla sistemazione degli errori o alle attività necessarie per il deploy (modifica del numero di versione, ...). 
L'insieme delle funzionalità rilasciate è quello presente sul branch develop al momento di inizio di una release 

I bug fix possono essere ri-mergiati in develop, anche utilizzando la funzionalità __cherry-pick__ di Git.

Per iniziare una nuova release è sufficiente creare un nuovo branch da develop:
```bash
$ git checkout -b release/v1.2.3 develop
```

Al termine della creazione della release, occorre mergiarla in master e in develop. 
```bash
$ git checkout master               # entra nel branch master
$ git merge --no-ff release/v1.2.3  # mergia la feature
$ git tag -a v1.2.3                 # tagga sul branch master il rilascio
$ git checkout develop              # entra nel branch develop
$ git merge --no-ff release/v1.2.3  # mergia la feature
$ git branch -d release/v1.2.3      # elimina il branch della feature
```

La differenza tra tag e branch è che il __tag è puntatore costante al commit__, mette il branch va avanti tra commit e commit.

Un'altra differenza tra release e feature è che posso avere solo una release aperta in un dato istante.

## Hotfix

Un hotfix è una riparzione veloce di difetti urgenti senza dover aspettare la prossima release.
È l'unico caso per cui non si parte da develop, ma dall'ultima - o una particolare - versione rilasciata su master.

```bash
$ git checkout -b hotfix/CVE-123 master # crea un branch di hotfix
```

Quando lo chiudo:
```bash
$ git checkout master                   # entra nel branch master
$ git merge --no-ff hotfix/CVE-123      # mergia l'hotfix
$ git tag -a hotfix/CVE-123             # tagga sul branch master il rilascio
$ git checkout develop                  # entra nel branch develop
$ git merge --no-ff hotfix/CVE-123      # mergia l'hotfix
$ git branch -d hotfix/CVE-123          # elimina il branch di hotfix
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