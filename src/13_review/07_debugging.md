# Debugging

Il debugging è l'insieme di tecniche che mirano a __localizzare__ e __rimuovere__ le anomalie che sono la causa di malfunzionamenti riscontrati nel programma.
Come già detto, esso non è invece utilizzato per _rilevare_ tali malfunzionamenti.

Il debugging richiede una __comprensione approfondita del codice__ e del funzionamento del programma e può essere un processo complesso e articolato.
Tuttavia, può contribuire in modo significativo a migliorare la qualità e la stabilità del codice, oltre che a _risolvere_ malfunzionamenti.

Trattandosi di ricerca delle anomalie che generano malfunzionamenti noti, l'attività è definita per un __programma__ e __un insieme di dati che causano malfunzionamenti__.
Essa si basa infatti sulla __riproducibilità__ del malfunzionamento, verificando prima che non sia dovuto in realtà a specifiche in errate.

Si tratta di un'attività molto complicata, come fa notare Brian W. Kernighan nella sua famosa citazione:

> _"Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it"._

È dunque importante scrivere codice __più semplice possibile__ in modo tale da poterne fare un altrettanto semplice debugging laddove necessario.

## Perché è così difficile?

L'attività di debugging è particolarmente complessa soprattutto perché non è sempre possibile individuare con precisione la __relazione anomalia-malfunzionamento__.
Non è un legame banale, in quanto potrebbero esserci anomalie che prima di manifestarsi sotto forma di malfunzionamenti abbiano avuto molte evoluzioni.

Inoltre, __non esiste una relazione biunivoca__ tra anomalie e malfunzionamenti: non è detto che un'anomalia causi un unico  malfunzionamento, ma nemmeno che un malfunzionamento sia causato da un'unica anomalia.

Un altro problema è dovuto al fatto che la __correzione di anomalie__ non garantisce affatto un software migliore o con meno errori: per correggere un'anomalia è necessario per forza di cose anche modificare il codice sorgente, ma ogni volta che viene fatto si apre la possibilità di introdurre __nuove anomalie__ nel codice stesso.

## Tecnica _naïve_

La tecnica di debugging maggiormente utilizzata dai programmatori consiste nell'introdurre nel modulo in esame una serie di __comandi di output__ (es. _print_) che stampino su console il valore intermedio assunto dalle sue variabili.
Questo permetterebbe di osservare l'evoluzione dei dati e, si spera, di comprendere la causa del malfunzionamento a partire da tale storia.

Nonostante sia __facile da applicare__, si tratta in realtà di una tecnica __molto debole__: non solo essa __richiede la modifica del codice__ (e quindi una _rimozione_ di tali modifiche al termine), ma è __poco flessibile__ in quanto richiede una nuova compilazione per ogni stato esaminato. \
Bisogna inoltre considerare che questa tecnica testa un __programma diverso__ da quello originale che presenta delle _print_ aggiuntive solo _apparentemente_ innocue e senza effetti collaterali.

L'unico scenario (irrealistico) in cui la tecnica potrebbe essere considerata sufficiente
sarebbe nel caso in cui il codice sia progettato talmente bene e il modulo così ben isolato che basterebbe scrivere un'unica _print_ per risalire all'anomalia.

### Tecnica _naïve_ avanzata

Un miglioramento parziale alla tecnica appena descritta si può ottenere sfruttando le __funzionalità del linguaggio__ oppure alcuni tool specifici per il debug, come per esempio:

- `#ifdef` e `gcc -D` per il linguaggio C;
- __librerie di logging__ (con diverso livello), che permettono peraltro di rimuovere i messaggi di log in fase di produzione del codice;
- __asserzioni__, ovvero check interni al codice di specifiche proprietà: possono essere visti anche come _"oracoli" interni_ al codice che permettono di segnalare facilmente stati illegali.

Ciò non toglie che la tecnica sia comunque __naïve__, in quanto si sta ancora modificando il codice in modo che fornisca informazioni aggiuntive.

## Dump di memoria

Una tecnica lievemente più interessante è quella dei __dump di memoria__, che consiste nel produrre un'__immagine esatta__ della __memoria__ del programma dopo un passo di esecuzione: si scrive cioè su un file l'intero contenuto della memoria a livello di linguaggio macchina (_nei sistemi a 32 bit, la dimensione dei dump può arrivare fino a 4GB_).

```txt
Segmentation fault (core dumped)
```

Sebbene questa tecnica non richieda la modifica del codice, essa è spesso __difficile da applicare__ a causa della differenza tra la rappresentazione astratta dello stato (legata alle strutture dati del linguaggio utilizzato) e la rappresentazione a livello di memoria di tale stato.
Viene inoltre prodotta una __enorme mole di dati__ per la maggior parte inutili.

## Debugging simbolico

Il prossimo passo è invece il cosiddetto __debugging simbolico__, un'attività che utilizza __tool__ specifici di debugging per semplificare la ricerca delle anomalie che causano il malfunzionamento in esame.
Tali strumenti permettono di __osservare in tempo reale l'esecuzione del programma__, sollevando una cortina e rendendo possibile analizzare l'evoluzione del valore delle variabili passo per passo: questi tool non alterano il codice ma _come_ esso è eseguito.

A tal proposito, i debugger simbolici forniscono informazioni sullo stato delle variabili utilizzando lo __stesso livello di astrazione__ del linguaggio utilizzato per scrivere il codice: gli stati sono cioè rappresentati con __stessi simboli__ per cui le locazioni di memoria sono state definite (_stesse strutture dati_), rendendo quindi utile e semplice l'attività di __ispezione dello stato__.

In aggiunta, i debugger simbolici forniscono __ulteriori strumenti__ che permettono di visualizzare il comportamento del programma in maniera selettiva, come per esempio _watch_ e _spy monitor_.

Per regolare il flusso del programma è poi possibile inserire __breakpoint__ e __watchpoint__ su certe linee di codice che ne arrestino l'esecuzione in uno specifico punto, eventualmente rendendoli dipendenti dal valore di variabili.
Volendo poi riprendere l'esecuzione si può invece scegliere la granularità del successivo passo:

- __singolo__: si procede alla linea successiva;
- __dentro una funzione__: si salta al codice eseguito dalle funzioni richiamate sulla riga corrente;
- __drop/reset del frame__: vengono scartate le variabili nel frame d'esecuzione ritornando ad una situazione precedente.

### Debugging per prova

Molti debugging simbolici permettono non solo di visualizzare gli stati ottenuti, ma anche di  __esaminarli automaticamente__ in modo da verificarne la correttezza.

In particolare, utilizzando __watch condizionali__ è possibile aggiungere __asserzioni a livello di monitor__, verificando così che certe proprietà continuino a valere durante l'intera esecuzione. \
Così, per esempio, è possibile chiedere al _monitor_ (l'_esecutore_ del programma) di controllare che gli indici di un array siano sempre interni all'intervallo di definizione.

### Altre funzionalità dei debugger

Ma non finisce qui! I debugger moderni sono strumenti veramente molto interessanti, che permettono per esempio anche di:

- __modificare il contenuto di una variabile__ (o zona di memoria) a runtime;
- __modificare il codice__: nonostante non sia sempre possibile, può essere comodo per esempio dopo tante iterazioni di un ciclo;
- ottenere __rappresentazioni grafiche__ dei dati: strutture dinamiche come puntatori, alberi e grafi possono essere rappresentate graficamente per migliorare la comprensione dello stato.

## Automazione

Visti tutti questi fantastici tool può sorgere una domanda: __l'attività di debugging può essere automatizzata?__

Andreas Zeller tratta questo argomento in maniera approfondita nel suo [Debugging Book](http://debuggingbook.org/), proponendo alcune direzioni di sviluppo di ipotetici strumenti di debugging automatico. \
I due concetti principali della trattazione sono i seguenti:

- __shrinking input__: dato un __input molto grande__ e complesso che causa un malfunzionamento, strumenti automatici possono aiutare a ridurlo il più possibile in modo da semplificare il debugging;
- __differential debugging__: dato lo stesso input, in maniera automatica vengono esplorati gli stati del programma mutando ad ogni iterazione piccole porzioni di codice per individuare dove è più probabile che si trovi l'anomalia.

Purtroppo per il momento la prospettiva di debugger automatici è ancora lontana. \
Tuttavia, esiste già qualcosa di simile, vale a dire il comando __`git bisect`__ di Git: data una versione vecchia in cui il bug non è presente, una versione nuova in cui esso si è manifestato e un oracolo che stabilisce se il bug è presente o meno, Git esegue una __ricerca dicotomica__ per trovare la versione che ha introdotto il problema.
Sebbene non sia proprio la stessa cosa, si tratta sicuramente di uno strumento utile.
