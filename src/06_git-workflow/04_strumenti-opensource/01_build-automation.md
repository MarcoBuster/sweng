# Build automation

La build automation è un processo fondamentale nello sviluppo di software open source, che consiste nel creare un sistema automatizzato per compilare il codice sorgente in un eseguibile. 
Questo processo è importante perché consente di risparmiare tempo e risorse, evitando di dover compilare manualmente il codice ogni volta che si apportano modifiche. 
Inoltre, la build automation garantisce una maggiore qualità e coerenza del software, poiché il processo di compilazione viene eseguito in modo uniforme ogni volta.

## `make`

`make` è uno strumento di build automation che viene utilizzato per automatizzare il processo di compilazione di un progetto, infatti non è altro che uno script di comandi _shell_. 
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

Tuttavia, make lavora a un livello molto basso, il che può rendere facile commettere errori durante la sua configurazione e utilizzo, quindi deve essere reso il più __parametrico__ possibile.

Nonostante la parametrizzazione _non c'è portabilità_ tra macchine diverse, sia per architettura che per sistema operativo.

### `Makefile`

Un _Makefile_ è un file di testo che contiene le istruzioni per il programma make su come compilare e linkare i file sorgente di un progetto. 
Ogni riga del Makefile definisce un obiettivo o una dipendenza, insieme ai comandi che devono essere eseguiti per raggiungerlo. 
L'utilizzo del Makefile permette di automatizzare la compilazione e il linkaggio dei file sorgente, semplificando il processo di sviluppo di un progetto. 
Nell'esempio menzionato, il Makefile definisce il target `hellomake`, che dipende dai file `hellomake.c` e `hellofunc.o`, e fornisce i comandi per compilarli e linkarli insieme.

### Generazione automatica

Sono stati creati dei tool (`automake`, `autoconf`, `imake`, ...) che _generano_ `Makefile` ad-hoc per l'ambiente attuale.

Il _mantra_:
```bash
$ ./configure
$ make all
$ sudo make install
```
era largamente utilizzato per generare un Makefile ad-hoc per l'ambiente attuale e installare il software sulla macchina in modo automatico. 
`automake`, `autoconf`, e `imake` sono strumenti che aiutano a questo scopo, generando Makefile che possono essere utilizzati per compilare e installare il software in modo automatico.

## Ant 
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

Ovviamente è un progetto scritto in Java pensato per compilare codice Java che poi girerà sulla JVM, quindi ottimo in questo caso specifico perchè risolve i problemi dovuti ad avere macchine con diversi ambienti. Ma è anche estremamente limitante, infatti è complesso utilizzarlo con altri linguaggi.

## Gradle

Gradle è uno strumento di build automation che utilizza le repository Maven come punto di accesso alle librerie di terze parti. 
Maven è una piattaforma di gestione delle dipendenze e della build automation per il linguaggio di programmazione Java. 
Le repository Maven sono archivi online che contengono librerie Java, plugin e altri componenti utilizzati nella build di progetti Java. 
Gradle utilizza queste repository per cercare e scaricare le librerie di cui ha bisogno per eseguire la build del progetto.

Gradle è pur sempre java oriented, ma meno di ANT, infatti supporta Groovy o Kotlin come linguaggi di scripting, che non sono precompilati a bytecode e adotta un approccio dichiarativo e fortemente basato su convenzioni. 
Ciò significa che tutto ciò che è già stato definito come standard non deve essere ridichiarato. 
Inoltre, Gradle definisce un linguaggio specifico per la gestione delle dipendenze e permette di creare build multi-progetto.

Gradle scala bene in complessità: permette di fare cose semplici senza usare le funzioni complesse. 
È estendibile tramite plugin che servono per trattare tool, situazioni, linguaggi legati solitamente al mondo Java.

### Plugin

I plugin servono per trattare tool, situazioni, linguaggi definendo task e regole per lavorare più facilmente, ci permettono di creare catene di task legate tra di loro e vedere le dipendenze del caso specifico, oppure di far girare solo determinati gruppi di test che mi interessano.

Il plugin _Java_ definisce:
- una serie di __sourceSet__, ovvero dove è presente il codice e le risorse. Principalmente sono:
  - `src/main/java`: sorgenti Java di produzione;
  - `src/main/resources`: risorse di produzione;
  - `src/test/java`: sorgenti Java di test;
  - `src/test/resources`: risorse di test.
- dei __task__, anche con dipendenze tra loro.

![Task gradle](/assets/06_gradle-tasks.png)

### Altri plugin
- application, per l'esecuzione;
- FindBugs, jacoco: per la verifica e la convalida;
- eclipse, idea: per integrazione con gli IDE;