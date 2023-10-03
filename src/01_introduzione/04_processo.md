# Il processo di produzione del software
Il processo che seguiamo per costruire, consegnare, installare ed evolvere il prodotto software, dall'idea fino alla consegna e al ritiro finale del sistema, è chiamato __processo di produzione software__.

Innanzitutto occorre riconoscere diverse problematiche.
- I __requisiti__ imposti dal cliente possono cambiare spesso.
- Produrre software __non è _solo_ scrivere codice__ (alla Programmazione I).
- Bisogna risolvere i __problemi di comunicazione__ tra tutte le diverse figure in gioco (tra sviluppatori, tra progettista e sviluppatori, ecc).
- Bisogna essere __rigorosi__, anche se può risultare difficile. Ci sono lati positivi e negativi: la rigorisità può facilitare la comprensione di ciò che bisogna fare ma implica  al contempo molta fatica extra, e viceversa.
    > __Ipotesi di Bauer-Zemanek (BZh3)__: _Metodi formali riducono in maniera __significativa__ gli errori di progettazione, oppure permettono di eliminarli e risolverli prima._

    Questa affermazione resta un'ipotesi perchè non è possibile dimostrare che sfruttando dei metodi formali ci sia una diminuzione degli errori, anche se nella pratica ciò avviene costantemente.

    Trovare gli errori prima della fase di sviluppo permette di facilitarne la risoluzione e di risparmiare sia tempo che soldi: tanto prima si individua un errore, tanto più facile sarà risolverlo.
    Tuttavia è importante sottolineare che utilizzare metodi formali non è necessario in ogni caso, perchè queste operazioni richiedono molto tempo, che deve essere sottratto ad altre fasi, ma spesso a causa delle consegne imminenti non è possibile permettersi di investire troppo tempo nella formalizzazione.
- Ci sono __tanti aspetti__ da considerare, che andranno affrontati uno alla volta. Per parlare di aspetti diversi ho bisogno di metodi comunicazione diversi, che interessano ruoli diversi in tempi diversi (_Aspect Oriented Programming_).

Tenendo a mente tutto queste problematiche è necessario decidere come organizzare l'attività di sviluppo software in modo da mitgarle. Per modellare un ciclo di vita del software, occorre dunque in primo luogo __identificare le varie attività necessarie__ e quindi:
- deciderne le precedenze temporali;
- decidere chi le debba fare.

In particolare, ci si pone due domande:
- cosa devo fare adesso?
- fino a quando e come?

L'ingegneria del software prova a rispondere a queste domande per individuare quali siano le fasi necessarie per sviluppare un software e quale sia la loro migliore disposizione temporale. È dunque bene specificare da subito che lo sviluppo di un programma non è solo coding: tale presupposto genera conseguenze disastrose.

Inizialmente, infatti, nell'ambito dello sviluppo software è stato adottato il modello ___code-and-fix___, che consisteva nei seguenti passi:
1. scrivi il codice;
2. sistemalo per eliminare errori, migliorare funzionalità o aggiungere nuove funzionalità.

Ben presto però questo modello si è dimostrato pesantemente inefficace in gruppi di lavoro complessi, specialmente quando il cliente non era più lo sviluppatore stesso ma utenti con poca dimestichezza con i computer, generando codice estremamente poco leggibile e manutenibile.

Per organizzare meglio l'attività di sviluppo e non ricadere negli errori del passato gli ingegneri del software hanno dunque individuato diverse __fasi__ del ciclo di vita di un software che, combinate, permettessero di produrre del software di qualità. Diamo dunque un'occhiata a quelle principali.

## Le fasi del ciclo di vita del software

### Studio di fattibilità
Lo studio di fattibilità è l'attività svolta prima che il processo di sviluppo inizi, per decidere se dovrebbe iniziare _in toto_.
L'__obiettivo__ è quello di produrre un __documento in linguaggio naturale__ presentante diversi scenari di sviluppo con soluzioni alternative, con una discussione sui trade-off in termini di benefici e costi attesi.
Questo documento è scritto utilizzando un linguaggio naturale perchè è destinato ai manager e non direttamente a coloro che devono sviluppare il progetto.

Più specificatamente, il documento include:
- uno studio di diversi scenari di realizzazione, scegliendo:
    - le architetture e l'hardware necessario;
    - se sviluppare in proprio oppure subappaltare ad altri.
- stima dei costi, tempi di sviluppo, risorse necessarie, benfici delle varie soluzioni e valutazione del _return on investment_.

È spesso difficile fare un'analisi approfondita, a causa del poco tempo disponibile o di costi troppo elevati, di conseguenza non è raro che questa fase venga commissionata esternamente, in modo da poterla affidare a del personale esperto e investire il tempo risparmiato per altre attività.

### Analisi e specifica dei requisiti
L'analisi e specifica dei requisiti è l'attività più critica e fondamentale del processo di produzione del software.
L'obiettivo è la stesura di un ___documento di specifica___ <!-- ... -->.


In questa fase i progettisti devono:
- comprendere il __dominio applicativo__ del prodotto, dialogando con il cliente e la controparte tecnica;
- identificare gli __stakeholders__, ovvero tutte le figure interessate al progetto, e studiarne le richieste. Spesso non si tratta di figure omogenee (può essere il _top manager_ fino al segretario) e le loro necessità sono molto diverse;
- capire quali sono le __funzionalità richieste__: la domanda più importante che deve porsi il programmatore è il _cosa_ non il _come_; al cliente non devono infatti interessare gli aspetti tecnici e le scelte architetturali interne. Le __specifiche__ vanno quindi viste dal punto di vista del cliente.
- stabilire un __dizionario comune__ tra cliente e sviluppatore che può anche far parte della specifica per agevolare la comunicazione (questo perchè la stessa parola in contesti differenti può assumere significati diversi, e quindi creare ambiguità);
- definire __altre qualità__ eventualmente richieste dal cliente: per esempio, _"la centrale non deve esplodere"_ non è un dettaglio implementativo, ma un requisito. Queste ulteriori qualità, che non sempre sono solo esterne, si dicono __requisiti non funzionali__.

Lo scopo del _documento di specifica_ è duplice: da una parte, deve essere analizzato e approvato da __tutti gli stakeholders__ in modo da verificare il soddisfacimento delle aspettative del cliente, e dall'altra è usato dai programmatori per sviluppare una soluzione che le soddisfi, fungendo da punto di partenza per il design.
È un documento contrattuale e deve essere scritto in modo formale per evitare contestazioni contrattuali e ambiguità.

Deve essere presente anche un __piano di test__, ovvero una collezione di collaudi che certificano la correttezza del lavoro: se questi test hanno esito positivo il lavoro viene pagato, altrimenti il progetto non viene accettato. A differenza dei lavori di altri tipi di ingegneria, per esempio l'ingegneria civile, dove il collaudo è diretto, nell'ingegneria del software è molto difficile collaudare tutti i casi e gli stati possibili.

Un altro output di questa fase può essere anche il __manuale utente__ o  __maschere di interazione__, ovvero la _"vista esterna"_ (ciò che il cliente vuole vedere, evitando i dettagli implementativi) del sistema da progettare.

Il documento di specifica è un documento scritto in modo formale, perchè è la base da cui partire per iniziare lo sviluppo. è possibile sfruttare due tipi di modelli per produrre il documento di specifica:
- __Modelli descrittivi__: I modelli descrittivi rappresentano il sistema logicamente in modo da poter verificare le sue proprietà.
- __Modelli operazionali__: I modelli operazionali forniscono una rappresentazione del sistema tramite un modello eseguibile capace di mostrare le proprietà del sistema (in questo caso è facile cadere nella tentazione di pensare subito al _come_ realizzare una funzioalità).

> __Legge di David__: Il valore dei modelli che rappresentano il software da diversi punti di vista dipendono dal punto di vista preso (assunto), ma non c'è nessuna vista che è la migliore per ogni scopo.

### Progettazione (design)
Il _design_ è l'attività attraverso la quale gli sviluppatori software strutturano l'applicazione a diversi livelli di dettaglio.
Lo scopo di questa fase è quello di scrivere un __documento di specifica di progetto__ contenente la descrizione dell'architettura software (i diversi linguaggi e viste). 

Durante questa fase occorre quindi:
- scegliere un'__architettura software di riferimento__;
- __scomporre__ in moduli o oggetti gli incarichi e i ruoli: si tratta del cosiddetto _object oriented design_, non necessariamente accompagnato da object oriented programming;
- __identificare i patterns__, ovvero problemi comuni a cui è già stata trovata una soluzione generale giudicata come _"bella"_ dalla comunità degli sviluppatori (ne vedremo un paio più avanti nel corso). I pattern favoriscono alcune qualità, come il design.

### Programmazione e test di unità
In questa fase le _"scatole nere"_ - i moduli o oggetti definiti al punto precedente - vengono realizzate e per ognuna di esse vengono definiti dei __test unitari__ che ne mostrano la correttezza.
Vi è infatti spesso la brutta abitudine di non fare il testing durante lo sviluppo di ciascun componente, ma solamente alla fine di tutto: questa usanza è molto pericolosa perché un problema scoperto solo alla fine è molto più oneroso da risolvere.

I singoli moduli vengono testati indipendentemente, anche se alcune funzioni da cui dipendono non sono ancora sono state implementate: per risolvere tale dipendenza si utilizzano allora moduli fittizzi (___stub___) che emulino le funzionalità di quelli mancanti.
Altri moduli, detti ___driver___, forniscono invece una situazione su cui applicare il modulo che sto testando.
Nei linguaggi più utilizzati esistono framework che facilitano le suddette operazioni al programmatore.

L'obiettivo di questa fase è avere un __insieme di moduli__ separati __sviluppati indipendentemente__ con un'interfaccia concordata e __singolarmente verificati__.

### Integrazione e test di sistema
In questa fase i moduli singolarmente implementati e testati vengono __integrati__ insieme a formare il software finito. In alcuni modelli di sviluppo (come nello sviluppo incrementale) questa fase viene accorpata alla precedente.

Nei test, i moduli _stub_ e _driver_ vengono sostituiti con i componenti reali formando un sistema sempre più grande fino ad ottenere il risultato richiesto.
Quindi i diversi moduli non vengono "assemblati" in una volta sola per poi testare il risultato finale, ma è un'operazione incrementale, fatta aggiungendo un modulo alla volta per evitare che si presentino diversi errori difficili da individuare.
Infine è fondamentale testare che l'intero programma per verificare che funzioni una volta assemblato (non basta che le singole parti funzionino!): test di questo tipo vengono detti __test di integrazione__. 

L'integrazione può essere adottata seguendo un approccio _top down_ o _bottom up_. La fase finale è l'___alpha testing___, ovvero il testing del sistema in condizioni realistiche.

### Consegna, installazione e manutenzione
Dopo aver completato lo sviluppo, il software deve essere __consegnato__ ai clienti. Prima di consegnarlo a tutti, si seleziona un gruppo di utenti per raccogliere ulteriore feedback; questa fase è chiamata ___beta testing___.

L'__installazione__ (deployment) definisce il _run-time_ fisico dell'architettura del sistema. Per esempio, un servizio di rete potrebbe necessitare di apparecchiatura server da installare e particolari configurazioni.

Infine, la __manutenzione__ può essere definita come l'insieme delle attività finalizzate a modificare il sistema dopo essere stato consegnato al cliente. La manutenzione può essere di tipo:
- __correttivo__: sistemare errori nel sistema;
- __adattivo__: adattare il software ai nuovi requisiti (vd. _evolvibilità_);
- __perfettivo__: migliorare certi aspetti interni al programma senza modificare gli aspetti esterni, anche se quest'ultimi possono subire dei miglioramenti. Serve per migliorare la futura manutenzione riducendo il cosiddetto _debito tecnico_.

Come già detto, è necessario sviluppare avendo in mente la futura manutenzione di ciò che si sta scrivendo: infatti, il __costo__ della manutenzione concorre al costo del software in una misura spesso superiore al 60%.

L'_output_ di questa fase è un __prodotto migliore__.

### Altre attività
Alle attività sopracitate se ne aggiungono altre:
- __Documentazione__: può essere vista come attività trasversale, da creare seguendo l'evoluzione del progetto. Per esempio, un documento di specificazione contenente diagrammi UML e una descrizione narrativa che spiega le motivazione dietro certe decisioni può essere il risultato principale della fase di progettazione.
È un'attività che spesso viene procastinata, perché le specifiche possono cambiare spesso. In alcuni gruppi esistono delle figure che si occupano di questa attività, anche se può essere pericoloso: non tutti possono capire ciò che un programmatore ha creato.
- __Verifica e controllo qualità__ (Quality Assurance): nella maggior parte dei casi, la verifica è svolta attraverso review e ispezioni. L'obiettivo è anticipare il prima possibile la scoperta e la sistemazione degli errori in modo da evitare di consegnare sistemi difettosi. Andrebbe fatta costantemente e non tutta alla fine.
- __Gestione del processo__: gestione incentivi (premi di produzione), responsabilità, formazione del personale, perfezionamento del processo con l'esperienza guadagnata, eccetera. 
- __Gestione delle configurazioni__: gestione delle relazioni inter-progettuali, ovvero delle risorse di sviluppo non appartenenti ad un singolo progetto. Un esempio potrebbe essere una libreria condivisa tra più progetti, i quali vorrebbero modificare la libreria stessa.

Tutte queste diverse attività saranno specificate successivamente entrando nel dettaglio.
