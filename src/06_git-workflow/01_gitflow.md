# GitFlow

GitFlow è una tecnica di organizzazione dei branch e delle repository che prevede la creazione sia di diversi tipi di branch a vita limitata che il loro _merge_ guidato.

È disponibile online una [cheatsheet](https://danielkummer.github.io/git-flow-cheatsheet/) che fornisce una panoramica veloce delle principali operazioni e dei comandi di GitFlow. 
Si tratta di uno strumento utile per chi è alle prime armi con questa tecnica di organizzazione dei branch, ma non esaustivo: per una comprensione più approfondita del metodo, è meglio integrarlo con altre risorse.

I branch e i tipi di branch previsti da GitFlow sono:
- branch master;
- branch develop;
- feature branches;
- release branches;
- hotfix branches.

## `develop` e `master`

![GitFlow develop e master](/assets/06_gitflow-develop-master.png)

In GitFlow, ci sono due branch che hanno una durata più lunga rispetto ai branch temporanei utilizzati per lavorare su specifiche funzionalità o correzioni di bug:
- __`master`__: contiene le versioni stabili del codice sorgente, pronte per essere consegnate o rilasciate al cliente o al pubblico. Queste versioni sono considerate _affidabili_ e _testate_, quindi possono essere utilizzate in produzione;
- __`develop`__: è il ramo di integrazione in cui vengono integrati i contribuiti di tutti i gruppi; è anche il punto di partenza degli altri tipi di branch.

Al termine di ogni rilascio, il contenuto del branch `develop` viene integrato nel branch `master`, che rappresenta la versione stabile del codice. Le _versioni notturne_, invece, sono versioni di sviluppo che vengono rilasciate periodicamente e contengono le ultime modifiche apportate al codice. Esse vengono create partendo dal branch `develop`, che rappresenta il punto di integrazione di tutti i contributi dei gruppi di lavoro.

## Feature

![GitFlow feature](/assets/06_gitflow-feature.png)

I __*feature branch*__ sono branch temporanei utilizzati per sviluppare nuove funzionalità o per correggere bug. __Possono essere creati solo a partire dal branch `develop`__ e vengono utilizzati per isolare il lavoro su una specifica funzionalità o problema dal resto del codice. 
Quando il lavoro è completato, il feature branch viene integrato di nuovo nel `develop` tramite un merge. 
In questo modo, è possibile lavorare in modo organizzato su diverse funzionalità o problemi senza interferire tra loro.
Per integrare il lavoro svolto in un feature branch nel branch `develop`, è necessario eseguire un merge del feature branch nel `develop`. 
Ci sono diversi modi di fare ciò, a seconda delle preferenze e delle esigenze specifiche.
Un modo semplice di fare il merge è utilizzare il comando `git merge` dalla riga di comando. 
Se il merge non è possibile a causa di conflitti, sarà necessario risolverli manualmente prima di poter completare l'operazione. 
Una volta risolti i conflitti, sarà necessario creare un nuovo commit per finalizzare il merge.

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
### `--no-fast-forward`

![GitFlow fast forward](/assets/06_gitflow-feature-ff.png)

Di default, git risolve il merge di due branch con la stessa storia banalmente eseguendo il _fast forward_, ovvero spostando il puntatore del branch di destinazione all'ultimo commit del branch entrante.

In GitFlow è preferibile esplicitamente __disabilitare il fast forward__ (con l'opzione `--no-ff`) durante il merge in `develop` in quanto è più facile distinguere il punto di inizio e il punto di fine di una feature.

## Squashing

Usando git è anche possibile eseguire in fase di merge lo _squashing_ dei commit, ovvero la fusione di tutti i commit del branch entrante in uno solo. 
Questa operazione è utile per migliorare la leggibilità della history dei commit su branch grossi (come `develop` o `master`) ma il suo uso in GitFlow è opinabile: il prof. Bellettini consiglia di non utilizzarlo, in modo da mantenere i commit originali.

## Release

![GitFlow release](/assets/06_gitflow-release.png)

Lo scopo di creare una release è __cristalizzare l'insieme delle funzionalità__ presente sul branch `develop` all'inizio di essa dedicandosi solo alla sistemazione degli errori o alle attività necessarie per il deploy (modifica del numero di versione, ...). 
L'insieme delle funzionalità rilasciate è quello presente sul branch `develop` al momento di inizio di una release. 

I bug fix possono essere ri-mergiati in `develop`, anche utilizzando la funzionalità __cherry-pick__ di git; essa permette di selezionare un commit specifico da un ramo e applicarlo in un altro ramo. 
Ad esempio, se si ha un ramo di sviluppo ("`develop`") e un ramo di release ("`release`"), è possibile utilizzare il cherry-pick per selezionare solo i commit che contengono bugfix e applicarli al ramo di release, senza dover fare un merge di tutto il ramo di sviluppo. 
Ciò può essere utile in casi in cui si vuole mantenere la stabilità del ramo di release, includendo solo i bugfix considerati essenziali per la release.

Per iniziare una nuova release è sufficiente creare un nuovo branch da `develop`:
```bash
$ git checkout -b release/v1.2.3 develop
```

Al termine della creazione della release, è necessario fare il merge della release nel branch `master` e nel branch `develop`. 
Il merge in `master` rappresenta il rilascio della nuova versione del codice, che diventa disponibile per il pubblico o per il cliente. 
Il merge in `develop`, invece, integra le modifiche apportate durante la creazione della release nel branch di sviluppo, in modo che siano disponibili per le release future. 
In questo modo, è possibile gestire in modo organizzato il ciclo di vita del codice e il flusso di lavoro.
```bash
$ git checkout master               # entra nel branch master
$ git merge --no-ff release/v1.2.3  # mergia la feature
$ git tag -a v1.2.3                 # tagga sul branch master il rilascio
$ git checkout develop              # entra nel branch develop
$ git merge --no-ff release/v1.2.3  # mergia la feature
$ git branch -d release/v1.2.3      # elimina il branch della feature
```

In git, i tag sono etichette che possono essere applicate a un commit per segnalarne l'importanza o per marcare un punto specifico dello storico del repository. Un __tag è un puntatore costante al commit__ a cui è stato applicato, quindi non cambia mai e permette di fare riferimento in modo stabile a una versione specifica del codice. Al contrario, i branch sono puntatori dinamici che vanno avanti nel tempo, seguendo l'evoluzione del codice attraverso i nuovi commit

In GitFlow, le release sono versioni stabili del codice che vengono rilasciate al pubblico o al cliente. 
Ogni release viene creata partendo dal branch `develop` e viene gestita come un branch a sé stante, che viene chiuso una volta che tutte le modifiche previste sono state integrate. 
Al contrario, le feature sono branch temporanei utilizzati per sviluppare nuove funzionalità o per correggere bug. 
È possibile avere più feature aperte contemporaneamente, ma solo una release rimanere aperta in un dato istante.

## Hotfix

Un _hotfix_ è una riparazione veloce di difetti urgenti senza dover aspettare la prossima release.
È l'unico caso per cui non si parte da `develop`, ma dall'ultima - o una particolare - versione rilasciata su `master`.

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

# Limiti

Quali sono i limiti di git presentato così?

git e GitFlow come sono stati esposti presentano numerosi vincoli, tra cui:
- la __mancanza di un sistema di autorizzazione granulare__, ovvero la possibilità di assegnare permessi in modo specifico e mirato a diverse funzionalità o risorse. Inoltre, non esiste una distinzione tra diversi livelli di accesso, quindi o si ha accesso completo a tutte le funzionalità o non si ha accesso a niente;
- l'__assenza di code review__, ovvero il processo di revisione del codice sorgente da parte di altri sviluppatori prima che venga integrato nel codice base.

## `git request-pull` &mdash; _generates a summary of pending changes_

Il tool `git request-pull` è un comando di git che serve per formattare e inviare una proposta di modifiche a un repository tramite una mailing list. 
Il comando crea un messaggio di posta elettronica che chiede al maintainer del repository di "pullare" le modifiche, ovvero di integrarle nel codice base. 
Oggi, questa pratica è stata in molti progetti sostituita dalle pull request, che sono richieste di integrazione delle modifiche presentate attraverso un'interfaccia web. 
Le pull request offrono una serie di vantaggi rispetto alle richieste via email, come una maggiore trasparenza del processo di integrazione, una maggiore efficienza e una maggiore facilità di utilizzo.

La sintassi del comando è la seguente:

    git request-pull [-p] <start> <URL> [<end>]

Per esempio, i contributori Linux usano questo strumento per chiedere a Linus Torvalds di unire le modifiche nella sua versione.
L'output generato mostra file per file le modifiche fatte e i commenti dei commit creati, raggruppati per autore.

```
$ git request-pull master git@gitlab.di.unimi.it:silab-gang/sweng.git lezioni/09
The following changes since commit a16f3a0488c062d7b61dc4af15c2ba8081166040:

  Handle '/sweng' path (2022-11-25 19:14:40 +0100)

are available in the git repository at:

  git@gitlab.di.unimi.it:silab-gang/sweng.git lezioni/09

for you to fetch changes up to 4ac534bcd31c8c0353070c3f42eea09737b497b5:

  Refactor notes on Factory method pattern (2022-12-19 09:58:32 +0100)

----------------------------------------------------------------
Daniele Ceribelli (6):
      Add pattern Adapter
      Add notes until decorator
      Finish notes
      Add notes until factory method pattern
      Add notes until Abstract Factory pattern
      Finish notes with all patterns

Marco Aceti (14):
      Add lesson notes
      Add flyweight pattern
      Add observer pattern
      Add more patterns
      Fix typo
      Merge branch 'master' into lezioni/09
      Replace hook UMLs images with PlantUML
      Merge branch 'master' into lezioni/09
      Fix gitLab CI (take 2)
      Refactor diagrams until 'Strategy'
      Refactor all remaining diagrams
      Merge remote-tracking branch 'gitlab/master' into lezioni/09
      Merge remote-tracking branch 'gitlab/master' into lezioni/09
      Make 'Decorator' code samples *readable*

Matteo Mangioni (18):
      Add introduction
      Integrate Singleton notes
      Add images for first patterns
      Integreate Iterator notes
      Integrate Chain of Responsibility notes
      Integrates FlyWeight notes
      Add NullObject pattern
      Merge branch 'lezioni/09' of gitlab.com:silab-gang/sweng into lezioni/09
      Merge branch 'mangio/patterns-appunti' into lezioni/09
      Integrate Strategy section
      Integrate Observer notes
      Refactor notes on pattern Adapter
      Refactor notes on pattern Facade
      Make already reviewed notes follow new style guide
      Refactor notes on pattern Composite
      Refactor notes on pattern Decorator
      Refactor notes on pattern State
      Refactor notes on Factory method pattern

 _posts/2022-10-26-Patterns.md               | 1301 ++++++++++++++++++++++++++
 assets/09_esempio-abstract-factory.png      |  Bin 0 -> 2362937 bytes
 assets/09_facade.png                        |  Bin 0 -> 73981 bytes
 assets/09_model-view-controller.png         |  Bin 0 -> 2751267 bytes
 assets/09_model-view-presenter.png          |  Bin 0 -> 2118448 bytes
 assets/09_nullObject-valori-non-assenti.png |  Bin 0 -> 67792 bytes
 6 files changed, 1301 insertions(+)
 create mode 100644 _posts/2022-10-26-Patterns.md
 create mode 100644 assets/09_esempio-abstract-factory.png
 create mode 100644 assets/09_facade.png
 create mode 100644 assets/09_model-view-controller.png
 create mode 100644 assets/09_model-view-presenter.png
 create mode 100644 assets/09_nullObject-valori-non-assenti.png
```

Questo modello è molto più _peer to peer_ delle pull request proposte dai sistemi semi-centralizzati spiegati in seguito.
