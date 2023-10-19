# Meccanismo di base

## Di cosa si occupano
Gli SCM non dipendono da linguaggi di programmazione, infatti questi lavorano su file, considerandone le righe di testo (ignorando quindi se sia codice, un immagine o altri formati, gli scm considereranno questi come un insieme di linee testuali).
Un'eccezione è Monticello, che consiste in un intero ambiente di sviluppo per il linguaggio smalltalk, contenente un tool di versioning creato appositamente per questo linguaggio.

Ogni _cambiamento_ è regolato da:
- __check-out__: dichiara la volontà di lavorare partendo da una particolare revisione di un manufatto (o di una configurazione di diversi manufatti);
- __check-in__ (o __commit__): dichiara la volonta di registrarne una nuova (spesso chiamata change-set).

Queste operazioni vengono attivate rispetto a un _repository_.
Scambio di dati tra il repository (che contiene tutte le configurazioni) e il workspace (l'ambiente in cui si trova nel filesystem).

Solitamente ho un repository e \\( n \\) workspace, uno per ogni ambiente dove sto lavorando.

## Repository
La repository mantiene date, etichette, versioni, diramazioni (branches) e altri dati.
Per risparmiare spazio, le repository salvano solo le differenze tra una versione e l'altra; In realtà, Git non fa così, perché usa link simbolici: fare il _checkout_ di una specifica versione è instantaneo.

Le repository possono essere centralizzate o distribuite.

Nei sistemi di versioning distribuiti c'è il concetto di __hashing__, in modo da identificare file uguali anche se in posizioni diverse.
Per confrontare storie diverse si utilizzano gli hash dei file e delle directory.

### Cosa tracciare?
Ma in un progetto cosa è necessario tracciare? Sicuramente devono essere tracciati tutti i file relativi al codice sorgente o file di configurazione, ma per quanto riguarda il resto non c'è una risposta precisa, questo perchè dipende dalle necessità, in linea di massima però occorre prendere due decisioni importanti che influenzano la __replicabilità__ della produzione, ovvero:
- Si traccia l'evoluzione dei componenti fuori dal nostro controllo (come ad esempio compilatori o librerie)?
- Si archiviano i file che costituiscono il prodotto (ovvero i binari del software)?

Solitamente la risposta a queste due domande è __no__, questo perchè tracciare le librerie o i binari del software è costoso e poco pratico, ma così facendo la perfetta replicabilità va perduta.
Infatti è possibile che alcuni software con il passare del tempon non possano essere eseguiti perchè le tecnologie necessarie al loro funzionamento non sono più disponibili (compilatori con una versione molto vecchia ad esempio). c'è da dire però che se un progetto viene mantenuto costantemente la sua vita viene allungata di conseguenza.
Per ovviare a questi problemi è possibile fornire una versione già compilata del software, infatti oggi su alcuni siti come github ci sono delle sezioni (diverse da quelle dove viene messo il codice) dove è possibile pubblicare il binario del software.

## Accesso concorrente

Quando il repository è condiviso da un gruppo di lavoro, nasce il problema di gestirne l'accesso concorrente. 
Esistono due modelli:
- __modello _'pessimistico'___ (RCS): prevedo il possibile conflitto assicurandomi che chi lavora sia l'unico con l'accesso in scrittura. Funziona solo in ambienti centralizzati, nell'open source non può funzionare.
- __modello _'ottimistico'___ (CVS): il sistema si disinteressa del problema e fornisce supporto per le attività di _merge_ di change-set paralleli potenzialmente conflittuali. 
    
Il modello ottimistico può essere regolato con i branch: l'attività di _merge_ è quindi fondamentale.
CVS/Subversion scoraggiava i branch, ma Git li rende facili e li incoraggia.
In Git, l'uso dei branch è talmente comune che a volte è necessario introdurre delle politiche (come GitFlow) sul loro utilizzo.

## SCM distribuito
Sfruttando i sistemi Sofware Configuration Management in modo distribuito può portare diversi vantaggi a fronte di alcune problematiche.
I vantaggi sono diversi, tra cui:
- La possibilità di lavorare offline, e una volta che si ha a disposizione una connesione internet sarà possibile aggiornare il repository remoto;
- Maggiore velocità;
- Vengono supportati diversi modi di lavorare, ovvero:
    - Due peer collaborano direttamente condividendo tra loro il proprio lavoro;
    - Simil centralizzato, ovvero si ha un repository 'di riferimento' su una macchina raggiungibile da tutti;
    - Gerarchico a più livelli.

La problematica principale di questo approccio è che ogni peer ha un suo repository e non vi è una sincronizzazione automatica, di conseguenza sono necessari dei comandi espliciti per fare il _merge_ ad un altro repository.