# Modelli incrementali

Un modello incrementale è un particolare modello iterativo in cui nelle iterazioni è inclusa anche la consegna: questo permette di sviluppare il software a poco a poco, rilasciandone di volta in volta parti e componenti che costruiscano _incrementalmente_ il programma finito.

Si noti la differenza tra incrementale e iterativo; si può parlare infatti di:

- __implementazione iterativa__: dopo aver raccolto le specifiche e aver progettato il sistema, _iterativamente_ sviluppo i componenti, li integro nel prodotto finale, quindi consegno.
- __sviluppo incrementale__: l'iteratività interessa tutte le fasi, comprese quelle di specifiche e realizzazione.  

Lo sviluppo incrementale riconosce la criticità della variabilità delle richieste e la integra nel processo. 
La manutenzione non è quindi più una particolarità ma è vista come normale e perfettamente integrata nel modello: in tal senso, la richiesta di una nuova feature o la correzione di un errore generano gli stessi step di sviluppo.

## Modello prototipale

Un particolare modello incrementale è quello protitipale: in questo modello viene introdotto il concetto di __protitipi usa e getta__ (_throw away_), interi programmi che vengono costruiti e poi vengono buttati via.

Lo scopo del prototipo __non è consegnare__ un prodotto finito, ma __ricevere feedback__ dal cliente per essere sicuri di aver compreso a pieno i suoi requisiti, oppure testare internamente un'idea o uno strumento. Per questo motivo tali prototipi vengono costruiti fregandosene di correttezza, pulizia del codice, leggibilità eccetera.
I protitipi possono dunque essere:

- __pubblici__: per capire meglio i requisiti del cliente (vd. <a href="#b3">L3</a>);
- __privati__: per esplorare nuovi strumenti, linguaggi, scelte per problemi difficili; inoltre, molto spesso una volta programmata una soluzione si capisce anche meglio il problema (_"do it twice"_).

La tentazione coi prototipi pubblici può essere quella di consegnarli come prodotto finito, ma c'è il __rischio__ enorme di dover mantenere poi in futuro software non mantenibile, illeggibile e con altissimo debito tecnico.

<a id="b3"></a>
__Legge di Bohem (L3)__
> La propotipizzazione riduce gli errori di analisi dei requisiti e di design, specialmente per le interfacce utente.

## I problemi dei modelli incrementali

Come già detto nessun modello è perfetto, e anche i modelli incrementali soffrono di alcuni problemi.

Viene innanzitutto __complicato il lavoro di planning__: bisogna pianificare tutte le iterazioni e lo stato di avanzamento è meno visibile; inoltre, la ripetizione di alcune fasi richiede di avere sempre sul posto gli esperti in grado di eseguirle.
Ad ogni iterazione, poi, dobbiamo rimettere mano a ciò che è stato fatto, in un processo che potrebbe non convergere mai a una versione finale.

Ma cosa è un'iterazione, e quanto dura? Tagliare verticalmente sulle funzionalità non è infatti facile, soprattutto considerando che quando si consegna il prodotto esso dev'essere funzionante con tutti i layer necessari ed essere al contempo pensato per poter crescere con successivi attaccamenti. Ci sono dunque diversi rischi:

- voler aggiungere troppe funzionalità nella prima iterazione;
- overhead dovuto a troppe iterazioni;
- avere un eccessivo overlapping tra le iterazioni: non si ha tempo di recepire il feedback dell'utente (es. Microsoft Office 2020 e 2019 vengono sviluppati contemporaneamente).

### Pinball Life-Cycle

![Pinball Life-Cycle](/assets/02_pinball-life-cycle.png)

Il _"modello meme"_ del Pinball Life-Cycle, creato da Ambler come critica ai modelli incrementali, estremizza queste problematiche: l'ordine in cui faccio le attività è casuale, incoltrollabile. Qualunque passo è possibile dopo qualunque altro, e non si possono imporre vincoli temporal: il processo è __non misurabile__.

Si tratta ovviamente di una visione eccessivamente pessimistica, ma spesso nelle aziende non specializzate l'iter di sviluppo assomiglia effettivamente a questo.

## Modelli trasformazionali

![Modelli trasformazionali](/assets/02_transformational-models.png)

Diametralmente opposti all'incubo del Pinball Life-Cycle troviamo i __modelli trasformazionali__: tali modelli pretendono infatti di controllare tutti i passi e i procedimenti in __modo formale__.

Partendo dai requisiti scritti in linguaggio informale, tali modelli procedono tramite una sequenza di __passi di trasformazione__ dimostrabili tutti formalmente fino ad arrivare alla versione finale.
Essi si basano infatti sull'idea che se le specifiche sono corrette e i passi di trasformazione sono dimostrati allora ottengo un programma corretto, ovvero di sicuro aderente alle specifiche di cui sopra. Inoltre, la presenza di una storia delle trasformazioni applicate permette un rudimentale versioning, con la possibilità di tornare indietro a uno stato precedente del progetto semplicemente annullando le ultime trasformazioni fatte.

![Trasformazioni formali](/assets/02_formal-transformations.jpg)

Ad ogni passo si ottiene quindi un __protitipo__ che differisce dal prodotto finale per efficienza e completezza, ma che è possibile trasformare in un altro più efficiente e corretto. Non si tratta tuttavia di un processo totalmente automatico, anzi: ad ogni passo di "ottimizzazione", ovvero applicazione di una trasformazione, è richiesto l'intervento di un decisore umano che scelga che cosa ottimizzare.

Viene quindi introdotto il concetto di __prova formale di correttezza__ delle trasformazioni applicate; per via di questo approccio molto matematico questo tipo di modelli è nella realtà applicato quasi solo negli ambienti di ricerca e produzione hardware.

## <i>Meta</i>modello a spirale

![Modello a spirale](/assets/02_spiral-model.png)

Introduciamo ora un metamodello, ovvero un modello che ci permette di rappresentare e discutere di altri modelli (una sorta di framework).

Nel metamodello a spirale l'attenzione è posto sui __rischi__, ovvero sulla possibilità che qualcosa vada male (decisamente probabile nell'ambiente di sviluppo software).
Per questo motivo il modello è di tipo incrementale e pone l'accento sul fatto che non abbia senso fare lo studio di fattibilità una sola volta, ma ad ogni iterazione serva una decisione. Le fasi generali sono dunque:

- Determinazione di obiettivi, alternative e vincoli
- Valutazione alternative, identificazione rischi (decido se ha senso andare avanti)
- Sviluppo e verifica
- Pianificazione della prossima iterazione

Nella figura il raggio della spirale indica i __costi__, che ad ogni iterazione aumentano fisiologicamente.

### Variante _"win-win"_

Esiste una variante al modello a spirale che fa notare come i rischi ad ogni fase non sono solo rischi tecnologici ma anche __contrattuali__ con il cliente. Ad ogni iterazione bisogna dunque trovare con esso un punto di equilibrio _win-win_ in entrambi le parti "vincono" (o hanno l'illusione di aver vinto), così da far convergere tutti su un obiettivo comune.

## Modello COTS (Component Off The Shelf)

![Modello COTS](/assets/02_cots.png)

Vediamo infine un modello che si concentra molto sulla __riusabilità__: si parte dalla disponibilità interna o sul mercato di moduli preesistenti sui quali basare il sistema, e che è dunque necessario solo integrare tra di loro.

Non si creda che si tratti di un approccio facile: questo modello di design necessita di far dialogare componenti che non necessariamente comunicano già nel modo voluto.

Si tratta tuttavia di un modello di sviluppo diverso perché richiede attività diverse. In particolare:

- _Analisi dei requisiti_
- ___Analisi dei componenti___: prima di progettare considero la disponibilità di componenti che implementano una parte o tutte le funzionalità richieste;
- ___Modifica dei requisiti___: stabilisco se il cliente è disposto ad accettare un cambiamento nei requisiti necessario per utilizzare un componente particolare;
- ___Progetto del sistema col riuso di componenti___: occorre progettare il sistema per far interagire componenti che non necessariamente sono stati originariamente progettati per interagire;
- _Sviluppo e integrazione_;
- _Verifica del sistema_.
