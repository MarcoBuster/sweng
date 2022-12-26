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

GitFlow è una tecnica di organizzazione dei branch e delle repository che prevede la creazione di diversi tipi di branch a vita limitata e il loro _merge_ guidato.

È disponibile online una [cheatsheet](https://danielkummer.github.io/git-flow-cheatsheet/) che fornisce una panoramica veloce delle principali operazioni e dei comandi di GitFlow. Si tratta di uno strumento utile per chi è alle prime armi con questa tecnica di organizzazione dei branch, ma non esaustivo e potrebbe essere utile integrarlo con altre risorse per una comprensione più approfondita del metodo.

I branch e i tipi di branch previsti da GitFlow sono:
- branch master;
- branch develop;
- feature branches;
- release branches;
- hotfix branches.

### develop e master

{% responsive_image path: 'assets/06_gitflow-develop-master.png' %}

In GitFlow, ci sono due branch che hanno una durata più lunga rispetto ai branch temporanei utilizzati per lavorare su specifiche funzionalità o correzioni di bug:
- __master__: contiene le versioni stabili del codice sorgente, pronte per essere consegnate o rilasciate al cliente o al pubblico. Queste versioni sono considerate affidabili e testate, quindi possono essere utilizzate in produzione;
- __develop__: è il ramo di integrazione in cui vengono integrati i contribuiti di tutti i gruppi; è anche il punto di partenza degli altri tipi di branch.

Al termine di ogni rilascio, il contenuto del branch develop viene integrato nel branch master, che rappresenta la versione stabile del codice. Le _versioni notturne_, invece, sono versioni di sviluppo che vengono rilasciate periodicamente e contengono le ultime modifiche apportate al codice. Esse vengono create partendo dal branch develop, che rappresenta il punto di integrazione di tutti i contributi dei gruppi di lavoro.

## feature branch

{% responsive_image path: 'assets/06_gitflow-feature.png' width: "400" %}

I feature branch sono branch temporanei utilizzati per sviluppare nuove funzionalità o per correggere bug. __Possono essere creati solo a partire dal branch develop__ e vengono utilizzati per isolare il lavoro su una specifica funzionalità o problema dal resto del codice. Quando il lavoro è completato, il feature branch viene integrato di nuovo nel develop tramite un merge. In questo modo, è possibile lavorare in modo organizzato su diverse funzionalità o problemi senza interferire tra loro.
Per integrare il lavoro svolto in un feature branch nel branch develop, è necessario eseguire un merge del feature branch nel develop. Ci sono diversi modi di fare ciò, a seconda delle preferenze e delle esigenze specifiche.
Un modo semplice di fare il merge è utilizzare il comando git merge dalla riga di comando. Se il merge non è possibile a causa di conflitti, sarà necessario risolverli manualmente prima di poter completare l'operazione. Una volta risolti i conflitti, sarà necessario creare un nuovo commit per finalizzare il merge.

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
L'insieme delle funzionalità rilasciate è quello presente sul branch develop al momento di inizio di una release. 

I bug fix possono essere ri-mergiati in develop, anche utilizzando la funzionalità __cherry-pick__ di Git.
La funzionalità cherry-pick di Git permette di selezionare un commit specifico da un ramo e applicarlo ad un altro ramo. Ad esempio, se si ha un ramo di sviluppo ("develop") e un ramo di release ("release"), è possibile utilizzare il cherry-pick per selezionare i commit che contengono fix per bug e applicarli al ramo di release, senza dover fare un merge di tutto il ramo di sviluppo. Ciò può essere utile in casi in cui si vuole mantenere la stabilità del ramo di release, includendo solo i fix per bug che sono considerati essenziali per la release.

Per iniziare una nuova release è sufficiente creare un nuovo branch da develop:
```bash
$ git checkout -b release/v1.2.3 develop
```

Al termine della creazione della release, è necessario fare il merge della release nel branch master e nel branch develop. Il merge in master rappresenta il rilascio della nuova versione del codice, che diventa disponibile per il pubblico o per il cliente. Il merge in develop, invece, integra le modifiche apportate durante la creazione della release nel branch di sviluppo, in modo che siano disponibili per le release future. In questo modo, è possibile gestire in modo organizzato il ciclo di vita del codice e il flusso di lavoro.
```bash
$ git checkout master               # entra nel branch master
$ git merge --no-ff release/v1.2.3  # mergia la feature
$ git tag -a v1.2.3                 # tagga sul branch master il rilascio
$ git checkout develop              # entra nel branch develop
$ git merge --no-ff release/v1.2.3  # mergia la feature
$ git branch -d release/v1.2.3      # elimina il branch della feature
```

In Git, i tag sono etichette che possono essere applicate a un commit per segnalarne l'importanza o per marcare un punto specifico dello storico del repository. Un __tag è un puntatore costante al commit__ a cui è stato applicato, quindi non cambia mai e permette di fare riferimento in modo stabile a una versione specifica del codice. Al contrario, i branch sono puntatori dinamici che vanno avanti nel tempo, seguendo l'evoluzione del codice attraverso i nuovi commit

In GitFlow, le release sono versioni stabili del codice che vengono rilasciate al pubblico o al cliente. Ogni release viene creata partendo dal branch develop e viene gestita come un branch a sé stante, che viene chiuso una volta che tutte le modifiche previste sono state integrate. Al contrario, le feature sono branch temporanei utilizzati per sviluppare nuove funzionalità o per correggere bug. È possibile avere più feature aperte contemporaneamente, ma solo una release può essere aperta in un dato istante.

## Hotfix

Un hotfix è una riparazione veloce di difetti urgenti senza dover aspettare la prossima release.
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

Git e GitFlow come sono stati esposti presentano numerosi vincoli, tra cui:
- la __mancanza di un sistema di autorizzazione granulare__, ovvero la possibilità di assegnare permessi in modo specifico e mirato a diverse funzionalità o risorse. Inoltre, non esiste una distinzione tra diversi livelli di accesso, quindi o si ha accesso completo a tutte le funzionalità o non si ha accesso a niente;
- l'__assenza di code review__, ovvero il processo di revisione del codice sorgente da parte di altri sviluppatori prima che venga integrato nel codice base.

### git request-pull - generates a summary of pending changes

Il tool `git request-pull` era un comando di Git che serviva per formattare e inviare una proposta di modifiche a un repository tramite una mailing list. Il comando creava un messaggio di posta elettronica che chiedeva al maintainer del repository di "pullare" le modifiche, ovvero di integrarle nel codice base. Oggi, questa pratica è stata sostituita dalle pull request, che sono richieste di integrazione delle modifiche presentate attraverso un'interfaccia web. Le pull request offrono una serie di vantaggi rispetto alle richieste via email, come una maggiore trasparenza del processo di integrazione, una maggiore efficienza e una maggiore facilità di utilizzo.

    git request-pull [-p] <start> <URL> [<end>]

Per esempio, i contributori Linux usano questo strumento per chiedere a Linus Torvalds di unire le modifiche nella sua versione.
L'output generato mostra file per file le modifiche fatte e i commenti dei commit creati, raggruppati per autore.

```
$ git branch --show-current
lezioni/06
$ git request-pull master git@gitlab.di.unimi.it:silab-gang/sweng.git lezioni/06
The following changes since commit 7a75b799fa0247590cb3f6d545c5b773cdf07f4a:

  Merge branch 'lezioni/03' into 'master' (2022-11-29 16:23:53 +0000)

are available in the Git repository at:

  git@gitlab.di.unimi.it:silab-gang/sweng.git lezioni/06

for you to fetch changes up to 2a9cfd798168b374e8aa33999aafee3e5fcd537c:

  Merge branch 'master' into marco/06-integrazione (2022-11-30 14:49:27 +0100)

----------------------------------------------------------------
Marco Aceti (3):
      Add lesson notes
      Integrate and refactor notes until 'Limiti'
      Merge branch 'master' into marco/06-integrazione

 _posts/2022-10-19-git-workflow.md    | 250 ++++++++++++++++++++++++++++++++++
 assets/06_gitflow-develop-master.png | Bin 0 -> 3098301 bytes
 assets/06_gitflow-feature-ff.png     | Bin 0 -> 2512627 bytes
 assets/06_gitflow-feature.png        | Bin 0 -> 1774044 bytes
 assets/06_gitflow-hotfix.png         | Bin 0 -> 131372 bytes
 assets/06_gitflow-release.png        | Bin 0 -> 4477425 bytes
 6 files changed, 250 insertions(+)
 create mode 100644 _posts/2022-10-19-git-workflow.md
 create mode 100644 assets/06_gitflow-develop-master.png
 create mode 100644 assets/06_gitflow-feature-ff.png
 create mode 100644 assets/06_gitflow-feature.png
 create mode 100644 assets/06_gitflow-hotfix.png
 create mode 100644 assets/06_gitflow-release.png
```

Questo modello è molto più _peer to peer_ delle pull request proposte dai sistemi semi-centralizzati spiegati in seguito.

# Hosting centralizzato

Un hosting centralizzato Git è un servizio che fornisce una repository centrale per i progetti Git, permettendo di superare alcuni limiti della decentralizzazione, ovvero il modello di collaborazione tipico di Git in cui ogni copia del repository è autonoma e indipendente. L'hosting centralizzato consente di avere una repository centrale dove tutti i contributi vengono integrati e gestiti, garantendo una maggiore trasparenza e controllo del processo di sviluppo. Tuttavia, l'hosting centralizzato mantiene molti dei vantaggi della decentralizzazione, come la possibilità di lavorare in modo asincrono e la possibilità di fare il fork di progetti.

Gli hosting centralizzati come GitHub e GitLab, nella loro costante evoluzione, spesso inventano nuovi meccanismi e provano a imporre nuovi workflow, come il GitHub Flow o il GitLab Flow, per semplificare e ottimizzare il processo di sviluppo. Tuttavia, è importante valutare attentamente questi nuovi approcci e verificare se si adattano alle esigenze specifiche del progetto e della squadra di sviluppo.
Inoltre, molti servizi di hosting centralizzati offrono funzionalità aggiuntive, come la possibilità di eseguire il "fork" di un repository, inviare _pull request_ per le modifiche e di utilizzare strumenti di continuous integration (CI) per testare automaticamente le modifiche apportate al codice.

## Fork

Il "fork" di un repository Git è una __copia del repository originale__ che viene creata su un account di hosting diverso dal proprietario originale. Questo permette a un altro sviluppatore di creare una copia del repository e di lavorare su di essa senza influire sul lavoro del proprietario originale. In questo modo, è possibile mantenere una connessione tra i due repository e condividere facilmente le modifiche apportate.

L'utilizzo del fork __risolve__ un primo problema di __autorizzazione__ poiché permette a un altro sviluppatore di lavorare su una copia del repository senza dover ottenere le autorizzazioni del proprietario originale.

La maggioranza delle piattaforme di hosting centralizzato ottimizza la condivisione dello spazio degli oggetti, utilizzando un'unica repository fisica per tutti i fork. Tuttavia, questo può comportare alcune problematiche di sicurezza, come ad esempio la difficoltà per la piattaforma di stabilire in quale fork si trova un determinato oggetto in caso di conflitto o la possibilità che un utente malintenzionato possa modificare o eliminare accidentalmente oggetti di altri fork. Per questo motivo, è importante che le piattaforme di hosting centralizzato implementino misure di sicurezza adeguate per proteggere i dati dei fork e garantire la tracciabilità delle modifiche ([esempio sul kernel Linux](https://github.com/torvalds/linux/commit/b4061a10fc29010a610ff2b5b20160d7335e69bf)). 

## Review / Pull request

Tra la creazione di una pull request e il suo _merge_, specialmente nei progetti open source (dove chiunque può proporre qualsiasi patch) è fondamentale prevedere un processo di __review__.

{% responsive_image path: 'assets/06_pull-request.png' %}

La funzionalità di review/pull request permette di facilitare le interazioni tra gli sviluppatori utilizzando il sito di hosting come luogo comune per la discussione informale e la revisione delle modifiche.

Come accennato in precedenza, molti servizi di hosting centralizzati offrono strumenti di continuous integration (CI) che possono essere utilizzati per testare automaticamente le modifiche proposte nella pull request. Questi strumenti consentono di verificare che le modifiche non introducano errori o vulnerabilità e di garantire che il codice sia pronto per essere integrato nel repository principale.

# Gerrit

Gerrit è un __sistema di review__ del codice sviluppato internamente da Google per gestire i progetti interni; si basa sul concetto di "peer review": tutti gli sviluppatori sono autorizzati a fare review delle proposte di modifica di qualsiasi zona di codice.

Nel processo di review di Gerrit, i __developer__ possono sottoporre proposte di cambiamento utilizzando un sistema di "patch" che descrive le modifiche apportate al codice. 
I __reviewer__, ovvero gli altri sviluppatori del progetto, possono quindi esaminare le patch e decidere se accettarle o rifiutarle. 
Una volta che una patch ha ricevuto un numero sufficiente di review positivi, viene automaticamente integrata nel __repository principale autoritativo__   in cui tutti hanno accesso in sola lettura.

Gerrit obbliga a strutturare le modifiche (changeset) in un unico commit (squash) al momento dell'accettazione. Ciò significa che tutte le modifiche apportate devono essere fuse in un unico commit, in modo da rendere più facile la gestione del repository. Al momento della review, invece, le modifiche rimangono separate in versioni singole, ovvero ogni modifica viene presentata come un commit separato, in modo che i reviewer possano esaminarle più facilmente.

## Verifier

Il verifier è uno strumento o un processo che viene utilizzato in Gerrit per verificare che le modifiche proposte siano corrette e funzionino come dovrebbero. In particolare, il verifier scarica la patch, la compila, esegue i test e controlla che ci siano tutte le funzioni necessarie. Se il verifier rileva dei problemi, può segnalarli al team di sviluppo perché vengano corretti prima che la patch venga accettata.

Una volta terminato il proprio processo, approva le modifiche votandole positivamente.
Solitamente sono necessari 1 o 2 voti per procedere.

## Approver

Una volta verificata, una proposta di modifiche deve essere anche approvata. 
L'approvatore deve determinare la risposta alle seguenti domande riguardo la proposta di modifiche:
- è valida per lo scopo del progetto?
- è valida per l'architettura del progetto?
- introduce nuove falle nel design che potrebbero causare problemi in futuro?
- segue le _best practices_ stabilite dal progetto?
- è un buon modo per implementare la propria funzione?
- introduce rischi per la sicurezza o la stabilità? 

Se l'approver ritiene che la proposta di modifiche sia valida, può approvarla scrivendo "LGTM" (acronimo di _"Looks Good To Me"_) nei commenti della pull request.

# Strumenti dell'opensource

Gli strumenti dell'opensource sono una serie di programmi, librerie e servizi che vengono utilizzati per sviluppare progetti open source. Questi strumenti sono pensati per semplificare il processo di sviluppo e gestione di progetti open source, rendendoli accessibili a una comunità di sviluppatori e contribuenti.


## Build automation

La build automation è un processo fondamentale nello sviluppo di software open source, che consiste nel creare un sistema automatizzato per compilare il codice sorgente in un eseguibile. Questo processo è importante perché consente di risparmiare tempo e risorse, evitando di dover compilare manualmente il codice ogni volta che si apportano modifiche. Inoltre, la build automation garantisce una maggiore qualità e coerenza del software, poiché il processo di compilazione viene eseguito in modo uniforme ogni volta.

### make

`make` è uno strumento di build automation che viene utilizzato per automatizzare il processo di compilazione di un progetto. In particolare, `make` viene utilizzato per specificare come ottenere determinati _targets_ (obiettivi), ovvero file o azioni che devono essere eseguite, partendo dal codice sorgente. Ad esempio, in un progetto di sviluppo software, un target potrebbe essere il file eseguibile del programma, che viene ottenuto compilando il codice sorgente. `make` segue la filosofia _pipeline_, ovvero prevede l'utilizzo di singoli comandi semplici concatenati per svolgere compiti più complessi.

Supporta la _compilazione incrementale_, ovvero il fatto di compilare solo le parti del progetto che sono state modificate dall'ultima volta, al fine di velocizzare il processo. Inoltre, gestisce le _dipendenze_ tra file, ovvero le relazioni tra i diversi file che compongono il progetto: se un file dipende da un altro file, make assicura che il file dipendente venga compilato solo dopo che il file di cui dipende è stato compilato. Ciò garantisce che il progetto venga compilato in modo coerente e che le modifiche apportate a un file siano considerate correttamente nella compilazione dei file dipendenti.

```make
CC=gcc
CFLAGS=-I.

%.o: %.c $(DEPS)
  $(CC) -c -o $@ $< $(FLAGS)

hellomake: hellomake.c hellofunc.o
  $(CC) -o hellomake hellomake.o hellofunc.o -I.
```

Nell'esempio, se il _target_ hellomake (definito dai file `hellomake.c` e `hellofunc.o`) è stato aggiornato, occorre ricompilarlo utilizzando i comandi sotto.

Tuttavia, make lavora a un livello molto basso, il che può rendere facile commettere errori durante la sua configurazione e utilizzo.

Non c'è portabilità tra macchine (ambienti) diverse.

#### Makefile

Un Makefile è un file di testo che contiene le istruzioni per il programma make su come compilare e linkare i file sorgente di un progetto. Ogni riga del Makefile definisce un obiettivo o una dipendenza, insieme ai comandi che devono essere eseguiti per raggiungerlo. L'utilizzo del Makefile permette di automatizzare la compilazione e il linkaggio dei file sorgente, semplificando il processo di sviluppo di un progetto. Nell'esempio menzionato, il Makefile definisce il target hellomake, che dipende dai file hellomake.c e hellofunc.o, e fornisce i comandi per compilarli e linkarli insieme.

#### Generazione automatica

Sono stati creati dei tool (`automake`, `autoconf`, `imake`, ...) che _generano_ `Makefile` ad-hoc per l'ambiente attuale.

Il _mantra_:
```bash
$ ./configure
$ make all
$ sudo make install
```
 era largamente utilizzato per generare un Makefile ad-hoc per l'ambiente attuale e installare il software sulla macchina in modo automatico. `automake`, `autoconf`, e `imake` sono strumenti che aiutano a questo scopo, generando Makefile che possono essere utilizzati per compilare e installare il software in modo automatico.

### Ant 
Ant nasce in Apache per supportare il progetto Tomcat.
Data una __definizione in XML__ della struttura del progetto e delle dipendenze invocava comandi programmati tramite classi Java per compilare il progetto.

Il vantaggio è che Java offre un livello d'astrazione sufficiente a rendere il sistema di build portabile su tutte le piattaforme.

Nella versione base supporta integrazioni con altri tool come CVS, Junit, FTP, JavaDOCS, JAR, ecc...
Non solo compila, ma fa anche deployment.

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

Gradle è uno strumento di build automation che utilizza le repository Maven come punto di accesso alle librerie di terze parti. Maven è una piattaforma di gestione delle dipendenze e della build automation per il linguaggio di programmazione Java. Le repository Maven sono archivi online che contengono librerie Java, plugin e altri componenti utilizzati nella build di progetti Java. Gradle utilizza queste repository per cercare e scaricare le librerie di cui ha bisogno per eseguire la build del progetto.

Gradle, che supporta Groovy o Kotlin come linguaggi di scripting, adotta un approccio dichiarativo e fortemente basato su convenzioni. Ciò significa che tutto ciò che è già stato definito come standard non deve essere ridichiarato. Inoltre, Gradle definisce un linguaggio specifico per la gestione delle dipendenze e permette di creare build multi-progetto.

Scala bene in complessità: permette di fare cose semplici senza usare le funzioni complesse. 
È estendibile tramite plugin che servono per trattare tool, situazioni, linguaggi legati solitamente al mondo Java.

#### Plugin

I plugin servono per trattare tool, situazioni, linguaggi definendo task e regole per lavorare più facilmente.

Il plugin Java definisce:
- una serie di __sourceSet__, ovvero dove è presente il codice e le risorse. Principalmente sono:
  - `src/main/java`: sorgenti Java di produzione;
  - `src/main/resources`: risorse di produzione;
  - `src/test/java`: sorgenti Java di test;
  - `src/test/resources`: sorgenti di test.
- dei __task__, anche con dipendenze tra loro.

{% responsive_image path: 'assets/06_gradle-tasks.png' %}

Altri plugin sono 

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

Ci sono diversi modi per cui può essere chiuso un bug:
- __duplicate__;
- __wontfix__: o è una feature o è un errore talmente complesso da risolvere che non ne vale la pena, secondo i progettisti;
- __can't reproduce__;
- __fixed__ : il bug è stato fixato;
vs __fix verified__: il fix è stato integrato in una release passando tutti gli step di verifica.

