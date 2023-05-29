# Meccanismo di base
Ogni _cambiamento_ è regolato da:
- __check-out__: dichiara la volontà di lavorare partendo da una particolare revisione di un manufatto (o di una configurazione di diversi manufatti);
- __check-in__ (o __commit__): dichiara la volonta di registrarne una nuova (spesso chiamata change-set).

Queste operazioni vengono attivate rispetto a un _repository_.
Scambio di dati tra il repository (che contiene tutte le configurazioni) e il workspace (l'ambiente in cui si trova nel filesystem).

Solitamente ho un repository e \\( n \\) workspace, uno per ogni ambiente dove sto lavorando.

## Repository
La repository mantiene:
- date
- etichette
- versioni
- diramazioni (branches)
- ecc...

Per risparmiare spazio, le repository salvano solo le differenze tra una versione e l'altra. 
In realtà, Git non fa così, perché usa link simbolici: fare il _checkout_ di una specifica versione è instantaneo.

Le repository possono essere centralizzate o distribuite.

Nei sistemi di versioning distribuiti c'è il concetto di __hashing__, in modo da identificare file uguali anche se in posizioni diverse.
Per confrontare storie diverse si utilizzano gli hash dei file e delle directory.

### Cosa tracciare?
Qualunque sistema si usi, occorre prendere decisioni importanti che influenzano la replicabilità della produzione.
- Si traccia l'evoluzione anche di componenti fuori dal nostro controllo (librerie, compilatori)?
- Si archiviano i file che sostitusicono il prodotto (eseguibile, ecc...)?

La risposta ad entrambe queste domande è __no__, perché è scomodo, anti economico, costoso...
Questo porta però problemi, perché non c'è perfetta replicabilità.

## Accesso concorrente

Quando il repository è condiviso da un gruppo di lavoro, nasce il problema di gestirne l'accesso concorrente. 
Esistono due modelli:
- __modello _'pessimistico'___ (RCS): prevedo il possibile conflitto assicurandomi che chi lavora sia l'unico con l'accesso in scrittura. Funziona solo in ambienti centralizzati, nell'open source non può funzionare.
- __modello _'ottimistico'___ (CVS): il sistema si disinteressa del problema e fornisce supporto per le attività di _merge_ di change-set paralleli potenzialmente conflittuali. 
    
Il modello ottimistico può essere regolato con i branch: l'attività di _merge_ è quindi fondamentale.
CVS/Subversion scoraggiava i branch, Git li rende facili e li incoraggia.
In Git, l'uso dei branch è talmente comune che a volte è necessario introdurre delle politiche (come GitFlow) sul loro utilizzo.