# Generazione dei mutanti

Idealmente i mutanti generati dovrebbero essere il __meno differenti possibile__ dal programma di partenza, ovvero dovrebbe esserci __un mutante per ogni singola anomalia__ che sarebbe possibile inserire nel programma.

Questo richiederebbe però di generare __infiniti__ mutanti, mentre per mantenere la suite di test _eseguibile in tempi ragionevoli_ il numero di mutanti non dovrebbe essere troppo elevato: un centinaio è una buona stima, ma un migliaio sarebbe auspicabile. \
Visto il numero limitato è necessario dunque concentrarsi sulla "__qualità__" dei mutanti generati, dove i mutanti sono tanto più buoni quanto più permettono di scovare degli errori.
Per questo motivo vengono creati degli specifici _operatori_ che dato un programma restituiscono dei mutanti _utili_.

## Operatori mutanti

Come già accennato, gli __operatori mutanti__ sono delle funzioni (_o piccoli programmi_) che dato un programma \\(P\\) generano un insieme di mutanti \\(\Pi\\).
Essi operano eseguendo piccole __modifiche sintattiche__ che modifichino la __semantica del programma__ senza però causare errori di compilazione.

Tali operatori si distinguono in __classi__ in base agli oggetti su cui operano:

- __costanti__ e __variabili__, per esempio scambiando l'occorrenza di una con l'altra;
- __operatori__ ed __espressioni__, per esempio trasformando `<` in `<=`, oppure `true` in `false`;
- __comandi__, per esempio trasformando un `while` in `if`, facendo così eseguire il ciclo una sola volta.

Alcuni operatori possono essere anche specifici su alcuni tipi di applicazioni, come nel caso di:

- operatori per __sistemi concorrenti__: operano principalmente sulle primitive di sincronizzazione – come eseguire una `notify()` invece che una `notifyAll()`;
- operatori per __sistemi object-oriented__: operano principalmente sulle interfacce dei moduli.

Poiché la generazione dei mutanti è un'attività tediosa, il compito di applicare questi operatori viene spesso affidato a tool automatici.
Esistono però numerosi __problemi di prestazioni__, in quanto per ogni mutante occorre modificare il codice, ricompilarlo, controllare che non si sovrapponga allo spazio di compilazione delle classi di altri mutanti e fare una serie di altre operazioni che comportano un pesante overhead.
Per questo motivo i tool moderni lavorano spesso sull'__eseguibile__ in sé (_sul bytecode nel caso di Java_): sebbene questo diminuisca il lavoro da fare per ogni mutante è possibile che il codice eseguibile così ottenuto sia un programma che non sarebbe possibile generare tramite compilazione.
Si espande quindi l'universo delle possibili anomalie anche a quelle _non ottenibili_, un aspetto che bisognerà tenere in considerazione nella valutazione della metrica di copertura.

## High Order Mutation

Normalmente i mutanti vengono generati introducendo una _singola modifica_ al programma originale.
Nella variante __HOM__ (__High Order Mutation__) si applicano invece modifiche a __codice già modificato__.

La giustificazione per tale tecnica è che esistono alcuni casi in cui trovare errori dopo aver applicato più modifiche è _più difficile_ rispetto ad applicarne solo una.
Può essere che un errore mascheri parzialmente lo stato inconsistente dell'altro rendendo più difficile il rilevamento di malfunzionamenti, cosa che porta a generare test ancora più approfonditi.
