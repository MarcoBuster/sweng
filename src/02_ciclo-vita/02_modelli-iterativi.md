# Modelli iterativi

Osservando il modello a cascata e le sue varianti ci si è ben presto resi conto che la stringente sequenzialità delle fasi costituiva un grosso limite non conciliabile con la flessibilità richiesta dallo sviluppo software e con la naturale mutevolezza dei requisiti imposti dal cliente. Si inizia dunque a pensare di permettere agli sviluppatori di _ripetere_ alcune fasi più di una volta, ciclando su di esse fino a ottenere un prodotto soddisfacente: nascono così i primi __modelli interativi__.

## Modello a cascata con singola retroazione

![Waterfall con retroazione](/assets/02_waterfall-retroazione.png)

Uno dei primi modelli iterativi è in realtà una variante del modello a cascata, in cui si permette di fare un'unico salto indietro; a parire da una fase si può cioè __ritornare alla fase precedente__: così, per esempio, si può _iterare_ tra _Codifica_ e _Testing_ fino a consegnare il prodotto.
In realtà sfruttando questa nuova introduzione è facile notare che è possibile eseguire delle iterazioni complete che vanno dalla fase dei requisiti fino alla fase di testing.

Anche in questo modello non si può però tornare indietro dalla consegna per eseguire attività di manutenzione; inoltre, l'introduzione di un'iterazione rende molto __più difficile pianificare__ il lavoro e monitorarne l'avanzamento: si tratta questa di una caratteristica condivisa da molti modelli iterativi.

## Modello prototipale

Un particolare modello incrementale è quello protitipale: in questo modello viene introdotto il concetto di __protitipi usa e getta__ (_throw away_), interi programmi che vengono costruiti e poi vengono buttati via.

Lo scopo del prototipo __non è consegnare__ un prodotto finito, ma __ricevere feedback__ dal cliente per essere sicuri di aver compreso a pieno i suoi requisiti, oppure testare internamente un'idea o uno strumento. Per questo motivo tali prototipi vengono costruiti fregandosene di correttezza, pulizia del codice, leggibilità eccetera.
I protitipi possono dunque essere:

- __pubblici__: per capire meglio i requisiti del cliente (vd. <a href="#b3">L3</a>);
- __privati__: nel mondo agile sono chiamati _spike_, e servono a esplorare nuovi strumenti, linguaggi escelte per problemi difficili; inoltre, molto spesso una volta programmata una soluzione si capisce anche meglio il problema (_"do it twice"_).

La tentazione coi prototipi pubblici può essere quella di consegnarli come prodotto finito, ma c'è il __rischio__ enorme di dover mantenere poi in futuro software non mantenibile, illeggibile e con altissimo debito tecnico.

<a id="b3"></a>
__Legge di Bohem (L3)__
> La propotipizzazione riduce significativamente gli errori di analisi dei requisiti e di design, specialmente per le interfacce utente.

Il modello prototipale è iterativo perchè ogni volta viene buttato il lavoro fatto e rieseguito da capo, questo fino ad avere una versione definitiva senza le problematiche incontrate che hanno causato l'eliminazione dei lavori precedenti.