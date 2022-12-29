---
layout: post
title: "[06] Git workflow"
date:   2022-10-19 14:45:00 +0200
toc: true
---

# Git Workflow

In Git, l'utilizzo dei branch è fortemente incentivato dal suo design e dalle sue funzionalità, rendendo praticamente impossibile lavorare senza utilizzarli. I branch consentono di creare versioni separate del codice, permettendo di lavorare su diverse funzionalità o correzioni di bug in modo indipendente e senza interferire con il codice principale. 
C'è __libertà completa__ sul loro utilizzo: tutti i branch hanno pari importanza, chiunque può crearli e nominarli in qualunque modo.

Lavorando in un team, è quindi necessario stabilire delle politiche sui tipi e i nomi di branch, in modo da organizzare il lavoro al meglio. 

## GitFlow

GitFlow è una tecnica di organizzazione dei branch e delle repository che prevede la creazione sia di diversi tipi di branch a vita limitata che il loro _merge_ guidato.

È disponibile online una [cheatsheet](https://danielkummer.github.io/git-flow-cheatsheet/) che fornisce una panoramica veloce delle principali operazioni e dei comandi di GitFlow. 
Si tratta di uno strumento utile per chi è alle prime armi con questa tecnica di organizzazione dei branch, ma non esaustivo: per una comprensione più approfondita del metodo, è meglio integrarlo con altre risorse.

I branch e i tipi di branch previsti da GitFlow sono:
- branch master;
- branch develop;
- feature branches;
- release branches;
- hotfix branches.

### `develop` e `master`

{% responsive_image path: 'assets/06_gitflow-develop-master.png' %}

In GitFlow, ci sono due branch che hanno una durata più lunga rispetto ai branch temporanei utilizzati per lavorare su specifiche funzionalità o correzioni di bug:
- __`master`__: contiene le versioni stabili del codice sorgente, pronte per essere consegnate o rilasciate al cliente o al pubblico. Queste versioni sono considerate _affidabili_ e _testate_, quindi possono essere utilizzate in produzione;
- __`develop`__: è il ramo di integrazione in cui vengono integrati i contribuiti di tutti i gruppi; è anche il punto di partenza degli altri tipi di branch.

Al termine di ogni rilascio, il contenuto del branch `develop` viene integrato nel branch `master`, che rappresenta la versione stabile del codice. Le _versioni notturne_, invece, sono versioni di sviluppo che vengono rilasciate periodicamente e contengono le ultime modifiche apportate al codice. Esse vengono create partendo dal branch `develop`, che rappresenta il punto di integrazione di tutti i contributi dei gruppi di lavoro.

### Feature

{% responsive_image path: 'assets/06_gitflow-feature.png' width: "400" %}

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
#### `--no-fast-forward`

{% responsive_image path: 'assets/06_gitflow-feature-ff.png' %}

Di default, Git risolve il merge di due branch con la stessa storia banalmente eseguendo il _fast forward_, ovvero spostando il puntatore del branch di destinazione all'ultimo commit del branch entrante.

In GitFlow è preferibile esplicitamente __disabilitare il fast forward__ (con l'opzione `--no-ff`) durante il merge in `develop` in quanto è più facile distinguere il punto di inizio e il punto di fine di una feature.

### Squashing

Usando Git è anche possibile eseguire in fase di merge lo _squashing_ dei commit, ovvero la fusione di tutti i commit del branch entrante in uno solo. 
Questa operazione è utile per migliorare la leggibilità della history dei commit su branch grossi (come `develop` o `master`) ma il suo uso in GitFlow è opinabile: il prof. Bellettini consiglia di non utilizzarlo, in modo da mantenere i commit originali.

### Release

{% responsive_image path: 'assets/06_gitflow-release.png' %}

Lo scopo di creare una release è __cristalizzare l'insieme delle funzionalità__ presente sul branch `develop` all'inizio di essa dedicandosi solo alla sistemazione degli errori o alle attività necessarie per il deploy (modifica del numero di versione, ...). 
L'insieme delle funzionalità rilasciate è quello presente sul branch `develop` al momento di inizio di una release. 

I bug fix possono essere ri-mergiati in `develop`, anche utilizzando la funzionalità __cherry-pick__ di Git; essa permette di selezionare un commit specifico da un ramo e applicarlo in un altro ramo. 
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

In Git, i tag sono etichette che possono essere applicate a un commit per segnalarne l'importanza o per marcare un punto specifico dello storico del repository. Un __tag è un puntatore costante al commit__ a cui è stato applicato, quindi non cambia mai e permette di fare riferimento in modo stabile a una versione specifica del codice. Al contrario, i branch sono puntatori dinamici che vanno avanti nel tempo, seguendo l'evoluzione del codice attraverso i nuovi commit

In GitFlow, le release sono versioni stabili del codice che vengono rilasciate al pubblico o al cliente. 
Ogni release viene creata partendo dal branch `develop` e viene gestita come un branch a sé stante, che viene chiuso una volta che tutte le modifiche previste sono state integrate. 
Al contrario, le feature sono branch temporanei utilizzati per sviluppare nuove funzionalità o per correggere bug. 
È possibile avere più feature aperte contemporaneamente, ma solo una release rimanere aperta in un dato istante.

### Hotfix

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

## Limiti

Quali sono i limiti di git presentato così?

Git e GitFlow come sono stati esposti presentano numerosi vincoli, tra cui:
- la __mancanza di un sistema di autorizzazione granulare__, ovvero la possibilità di assegnare permessi in modo specifico e mirato a diverse funzionalità o risorse. Inoltre, non esiste una distinzione tra diversi livelli di accesso, quindi o si ha accesso completo a tutte le funzionalità o non si ha accesso a niente;
- l'__assenza di code review__, ovvero il processo di revisione del codice sorgente da parte di altri sviluppatori prima che venga integrato nel codice base.

### git request-pull - generates a summary of pending changes

Il tool `git request-pull` è un comando di Git che serve per formattare e inviare una proposta di modifiche a un repository tramite una mailing list. 
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

are available in the Git repository at:

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
      Fix GitLab CI (take 2)
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

# Hosting centralizzato

Un hosting centralizzato Git è un servizio che fornisce una repository centrale per i progetti Git dove i contributi vengono integrati e gestiti, garantendo una maggiore trasparenza e controllo del processo di sviluppo e mantenendo molti vantaggi della decentralizzazione, come la possibilità di lavorare in modo asincrono e autonomo.

Gli hosting centralizzati come GitHub e GitLab, nella loro costante evoluzione, spesso inventano nuovi meccanismi e provano a imporre nuovi workflow, come il GitHub Flow o il GitLab Flow, per semplificare e ottimizzare il processo di sviluppo. Tuttavia, è importante valutare attentamente questi nuovi approcci e verificare se si adattano alle esigenze specifiche del progetto e della squadra di sviluppo.
Inoltre, molti servizi di hosting centralizzati offrono funzionalità aggiuntive, come la possibilità di eseguire il "fork" di un repository, inviare _pull request_ per le modifiche e di utilizzare strumenti di continuous integration (CI) per testare automaticamente le modifiche apportate al codice.

## Fork

Il "fork" di un repository Git è una __copia del repository originale__ che viene creata su un account di hosting diverso dal proprietario originale. 
Questo permette a un altro sviluppatore di creare una copia del repository e di lavorare su di essa senza influire sul lavoro del proprietario originale e __senza la sua autorizzazione__. 
È possibile quindi mantenere una _connessione_ tra i due repository e condividere facilmente le modifiche apportate.

La maggioranza delle piattaforme di hosting centralizzato __ottimizza la condivisione dello spazio degli oggetti__, utilizzando un'unica _repository fisica_ per tutti i fork.
Tuttavia, questo può comportare alcune problematiche di sicurezza, come ad esempio la difficoltà per la piattaforma di stabilire in quale fork si trova un determinato oggetto in caso di conflitto o la possibilità che un utente malintenzionato possa modificare o eliminare accidentalmente oggetti di altri fork. 
Per questo motivo, è importante che le piattaforme implementino __misure di sicurezza adeguate__ per proteggere i dati dei fork e garantire la tracciabilità delle modifiche ([esempio sul kernel Linux](https://github.com/torvalds/linux/commit/b4061a10fc29010a610ff2b5b20160d7335e69bf)). 

## Review / Pull request

Tra la creazione di una pull request e il suo _merge_, specialmente nei progetti open source (dove chiunque può proporre qualsiasi patch) è fondamentale prevedere un processo di __review__.

{% responsive_image path: 'assets/06_pull-request.png' %}

La funzionalità di _review/pull request_ permette di facilitare le interazioni tra gli sviluppatori utilizzando il sito di hosting come luogo comune per la discussione informale e la revisione delle modifiche.

## Continous integration (CI)

Come accennato in precedenza, molti servizi di hosting centralizzati offrono strumenti di __continuous integration__ (CI) che possono essere utilizzati per testare automaticamente le modifiche proposte nella pull request. 
Questi strumenti consentono di verificare che le modifiche non introducano errori o vulnerabilità e di garantire che il codice sia pronto per essere integrato nel repository principale.
Possono essere utilizzati anche per eseguire automaticamente la _suite di test_ o automatizzare il deployment.

{% responsive_image path: 'assets/06_ci-cd.png' %}

# Gerrit

Gerrit è un __sistema di review__ del codice sviluppato internamente da Google per gestire i progetti interni; si basa sul concetto di "peer review": tutti gli sviluppatori sono autorizzati a fare review delle proposte di modifica di qualsiasi zona di codice.

Nel processo di review di Gerrit, i __developer__ possono sottoporre proposte di cambiamento utilizzando un sistema di "patch" che descrive le modifiche apportate al codice. 
I __reviewer__, ovvero gli altri sviluppatori del progetto, possono quindi esaminare le patch e decidere se accettarle o rifiutarle. 
Una volta che una patch ha ricevuto un numero sufficiente di review positivi, viene automaticamente integrata nel __repository principale autoritativo__   in cui tutti hanno accesso in sola lettura.

Gerrit obbliga a strutturare le modifiche (_changeset_) in un unico commit (tecnica _squash_) al momento dell'accettazione. 
Ciò significa che tutte le modifiche apportate devono essere fuse in un unico commit, in modo da rendere più facile la gestione del repository. 
Al momento della review, invece, le modifiche rimangono separate in versioni singole, ovvero ogni modifica viene presentata come un commit separato, in modo che i reviewer possano esaminarle più facilmente.

## Verifier

Il verifier è uno strumento o un processo che viene utilizzato in Gerrit per verificare che le modifiche proposte siano corrette e funzionino come dovrebbero. 
In particolare, il verifier scarica la patch, la compila, esegue i test e controlla che ci siano tutte le funzioni necessarie. 
Se il verifier rileva dei problemi, può segnalarli al team di sviluppo perché vengano corretti prima che la patch venga accettata.

Una volta terminato il proprio processo, approva le modifiche votandole positivamente.
Solitamente sono necessari 1 o 2 voti per procedere.

## Approver

Una volta verificata, una proposta di modifiche deve essere anche approvata. 
L'approvatore deve determinare la risposta alle seguenti domande riguardo la proposta di modifiche:
- _è valida per lo scopo del progetto?_
- _è valida per l'architettura del progetto?_
- _introduce nuove falle nel design che potrebbero causare problemi in futuro?_
- _segue le best practices stabilite dal progetto?_
- _è un buon modo per implementare la propria funzione?_
- _introduce rischi per la sicurezza o la stabilità?_

Se l'approver ritiene che la proposta di modifiche sia valida, può approvarla scrivendo "LGTM" (acronimo di _"Looks Good To Me"_) nei commenti della pull request.

# Strumenti dell'open source

Gli strumenti dell'open source sono una serie di programmi, librerie e servizi che vengono utilizzati per sviluppare progetti open source. 
Questi strumenti sono pensati per semplificare il processo di sviluppo e gestione di progetti open source, rendendoli accessibili a una comunità di sviluppatori e contribuenti.

## Build automation

La build automation è un processo fondamentale nello sviluppo di software open source, che consiste nel creare un sistema automatizzato per compilare il codice sorgente in un eseguibile. 
Questo processo è importante perché consente di risparmiare tempo e risorse, evitando di dover compilare manualmente il codice ogni volta che si apportano modifiche. 
Inoltre, la build automation garantisce una maggiore qualità e coerenza del software, poiché il processo di compilazione viene eseguito in modo uniforme ogni volta.

### make

`make` è uno strumento di build automation che viene utilizzato per automatizzare il processo di compilazione di un progetto. 
In particolare, `make` viene utilizzato per specificare come ottenere determinati _targets_ (obiettivi), ovvero file o azioni che devono essere eseguite, partendo dal codice sorgente. 
Ad esempio, in un progetto di sviluppo software, un _target_ potrebbe essere il file eseguibile del programma, che viene ottenuto compilando il codice sorgente. 
`make` segue la filosofia _pipeline_, ovvero prevede l'utilizzo di singoli comandi semplici concatenati per svolgere compiti più complessi.

È supportata la _compilazione incrementale_, ovvero il fatto di compilare solo le parti del progetto che sono state modificate dall'ultima volta, al fine di velocizzare il processo. 
Inoltre, vengono gestite le _dipendenze_ tra file, ovvero le relazioni tra i diversi file che compongono il progetto: se un file sorgente dipende da un altro file, make assicura che il file dipendente venga compilato solo dopo che il file da cui dipende è stato compilato. 
Ciò garantisce che il progetto venga compilato in modo coerente e che le modifiche apportate a un file siano considerate correttamente nella compilazione dei file dipendenti.

```make
CC=gcc
CFLAGS=-I.

%.o: %.c $(DEPS)
  $(CC) -c -o $@ $< $(CFLAGS)

hellomake: hellomake.c hellofunc.o
  $(CC) -o hellomake hellomake.o hellofunc.o $< $(CFLAGS)
```

Nell'esempio, se il _target_ hellomake (definito dai file `hellomake.c` e `hellofunc.o`) è stato aggiornato, occorre ricompilarlo utilizzando i comandi sotto.

Tuttavia, make lavora a un livello molto basso, il che può rendere facile commettere errori durante la sua configurazione e utilizzo.

Non c'è portabilità tra macchine (ambienti) diverse.

#### Makefile

Un _Makefile_ è un file di testo che contiene le istruzioni per il programma make su come compilare e linkare i file sorgente di un progetto. 
Ogni riga del Makefile definisce un obiettivo o una dipendenza, insieme ai comandi che devono essere eseguiti per raggiungerlo. 
L'utilizzo del Makefile permette di automatizzare la compilazione e il linkaggio dei file sorgente, semplificando il processo di sviluppo di un progetto. 
Nell'esempio menzionato, il Makefile definisce il target `hellomake`, che dipende dai file `hellomake.c` e `hellofunc.o`, e fornisce i comandi per compilarli e linkarli insieme.

#### Generazione automatica

Sono stati creati dei tool (`automake`, `autoconf`, `imake`, ...) che _generano_ `Makefile` ad-hoc per l'ambiente attuale.

Il _mantra_:
```bash
$ ./configure
$ make all
$ sudo make install
```
era largamente utilizzato per generare un Makefile ad-hoc per l'ambiente attuale e installare il software sulla macchina in modo automatico. 
`automake`, `autoconf`, e `imake` sono strumenti che aiutano a questo scopo, generando Makefile che possono essere utilizzati per compilare e installare il software in modo automatico.

### Ant 
Ant nasce in Apache per supportare il progetto Tomcat.
Data una __definizione in XML__ della struttura del progetto e delle dipendenze invocava comandi programmati tramite classi Java per compilare il progetto.

Il vantaggio è che Java offre un livello d'astrazione sufficiente a rendere il sistema di build portabile su tutte le piattaforme.

Nella versione base supporta integrazioni con altri tool come CVS, Junit, FTP, JavaDOCS, JAR, ecc...
Non solo compila, ma fa anche deployment.
Il deployment consiste nell'installare e configurare un'applicazione o un sistema su uno o più server o ambienti di esecuzione. 
Nel contesto di Ant, il deployment può includere l'invocazione di comandi per copiare i file del progetto sui server di destinazione, configurare le impostazioni di sistema o dell'applicazione, avviare o fermare servizi o processi, e così via. 
In questo modo, Ant può essere utilizzato non solo per compilare il progetto, ma anche per distribuirlo e rendere disponibile l'applicazione o il sistema ai suoi utenti.

I target possono avere dipendenze da altri target.
I target contengono task che fanno effettivamente il lavoro; si possono aggiungere nuovi tipi di task definendo nuove classi Java.

Esempio di un build file:

```xml
<?xml version="1.0"?>
<project name="Hello" default="compile">
  <target name="clean" description="remove intermediate files">
    <delete dir="classes" />
  </target>
  <target name="clobber" depends="clean" description="remove all artifact files">
    <delete file="hello.jar">
  </target>
  <target name="compile" description="compile the Java source code to class files">
    <mkdir dir="classes" />
    <javac srcdir="." destdir="classes" />
  </target>
  <target name="jar" depends="compile" description="create a Jar file for the application">
    <jar destfile="hello.jar">
      <fileset dir="classes" includes="**/*.class" />
      <manifest>
        <attribute name="Main-Class" value="HelloProgram" />
      </manifest>
    </jar>
  </target>
</project>
```

### Gradle

Gradle è uno strumento di build automation che utilizza le repository Maven come punto di accesso alle librerie di terze parti. 
Maven è una piattaforma di gestione delle dipendenze e della build automation per il linguaggio di programmazione Java. 
Le repository Maven sono archivi online che contengono librerie Java, plugin e altri componenti utilizzati nella build di progetti Java. 
Gradle utilizza queste repository per cercare e scaricare le librerie di cui ha bisogno per eseguire la build del progetto.

Gradle, che supporta Groovy o Kotlin come linguaggi di scripting, adotta un approccio dichiarativo e fortemente basato su convenzioni. 
Ciò significa che tutto ciò che è già stato definito come standard non deve essere ridichiarato. 
Inoltre, Gradle definisce un linguaggio specifico per la gestione delle dipendenze e permette di creare build multi-progetto.

Gradle scala bene in complessità: permette di fare cose semplici senza usare le funzioni complesse. 
È estendibile tramite plugin che servono per trattare tool, situazioni, linguaggi legati solitamente al mondo Java.

#### Plugin

I plugin servono per trattare tool, situazioni, linguaggi definendo task e regole per lavorare più facilmente.

Il plugin _Java_ definisce:
- una serie di __sourceSet__, ovvero dove è presente il codice e le risorse. Principalmente sono:
  - `src/main/java`: sorgenti Java di produzione;
  - `src/main/resources`: risorse di produzione;
  - `src/test/java`: sorgenti Java di test;
  - `src/test/resources`: risorse di test.
- dei __task__, anche con dipendenze tra loro.

{% responsive_image path: 'assets/06_gradle-tasks.png' %}

#### Altri plugin
- application, per l'esecuzione;
- FindBugs, jacoco: per la verifica e la convalida;
- eclipse, idea: per integrazione con gli IDE;

## Bug tracking

Il bug tracking è stato reso necessario nel mondo open source per via della numerosità dei contributi e della alta probabilità di avere segnalazioni duplicate.

Inoltre, per gestire le segnalazioni di bug nell'ambito dello sviluppo open source, esistono diversi strumenti come git-bug, BugZilla, Scarab, GNATS, BugManager e Mantis.

### Bug workflow

{% responsive_image path: 'assets/06_bug-workflow.png' %}

L'obiettivo del bug tracking è avere più informazioni possibili su ogni bug per saperli riprodurre e quindi arrivare a una soluzione.

È importante verificare i bug una volta che l'_issue_ è stato aperto, in modo da poter confermare la sua esistenza e la completezza delle informazioni fornite.

Un _issue_ è un problema o una richiesta di funzionalità segnalata all'interno di un progetto di software. 
Gli issue vengono solitamente utilizzati per tenere traccia dei problemi noti o delle richieste di nuove funzionalità all'interno di un progetto, e possono essere gestiti attraverso un sistema di bug tracking o gestione delle richieste. 
Gli issue possono essere aperti da qualsiasi membro del team o dalla comunità, e possono essere risolti o chiusi da un membro del team responsabile.

Ci sono diversi modi per cui può essere chiuso un bug:
- __duplicate__: quando è stato già segnalato in precedenza e quindi non rappresenta un problema nuovo. In questo caso, viene solitamente fatto riferimento al numero del bug originale che ha già ricevuto una risoluzione;
- __wontfix__: il bug viene chiuso come "non risolvibile" perché o rappresenta una funzionalità voluta dal progetto o è troppo complesso da risolvere per essere considerato conveniente farlo dal punto di vista dei progettisti;
- __can't reproduce__: non è stato possibile riprodurre il bug, ovvero che non è stato possibile ottenere lo stesso risultato o il comportamento segnalato dal bug. Ciò può essere dovuto a una mancanza di dettagli o a un errore nella segnalazione del bug stesso;
- __fixed__: il bug è stato fixato;
vs __fix verified__: il fix è stato integrato in una release passando tutti gli step di verifica.
