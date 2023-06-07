# Modelli temporali

Esistono una serie di proposte per modellare il concetto di __tempo__ (_deterministico_) all'interno delle reti di Petri.
Esse si dividono sostanzialmente in due grandi categorie:

- quelle che introducono __ritardi sui posti__;
- quelle che introducono __ritardi sulle transizioni__.

### Tempo sui posti

Il tempo associato a ciascun posto rappresenta il __tempo che un gettone deve rimanere in tale posto prima di essere considerato per l'abilitazione__ di transizioni che hanno tale posto nel proprio preset.

![](/assets/16_tempo-sui-posti.png)

Dopo lo scatto di una transizione i gettoni generati in un posto non fanno cioè funzionalmente parte della sua marcatura prima che sia passato un dato intervallo di tempo \\(\Delta\\).
Tale \\(\Delta\\) può quindi essere considerato la __durata minima di permanenza__ del gettone in tale posto, bloccando così quella porzione di stato del sistema per un certo periodo.

### Tempo sulle transizioni

Quando si associa un tempo ad una transizione è bene indicare che cosa esso rappresenti.
Il tempo di una transizione può infatti rappresentare due concetti molto differenti:

- la __durata della transizione__, ovvero il tempo richiesto dopo lo scatto della transizione perché vengano generati i gettoni nel suo postset (una sorta di _ritardo di scatto_);
- il __momento dello scatto__ della transizione, che può essere espresso in modo diverso a seconda del modello.

Esistono a dire il vero anche modelli misti che permettono di specificare sia la durata di una transizione che il suo tempo di scatto.

#### Equivalenza tra tempi sui posti e sulle transizioni

È facile dimostrare che sia le reti che definiscono tempi sui posti che quelle che definiscono tempi sulle transizioni, sia come durata che come momento dello scatto, sono __funzionalmente equivalenti__, ovvero permettono di rappresentare lo stesso insieme di sistemi.

Ciò è testimoniato dal fatto che, come mostra la figura sottostante, ogni rete avente tempo sui posti può essere trasformata in una rete con durata delle transizioni semplicemente aggiungendo una transizione di "ritardo" e separando il posto in due.
Ovviamente vale anche il viceversa.

![](/assets/16_tempo-posti-to-durata.png)

Similmente, reti con durata delle transizioni possono essere trasformate in reti con tempi di scatto per le transizioni modellando esplicitamente con un posto il ritardo con cui vengono generati gettoni nel postset della transizione originale.

![](/assets/16_durata-to-tempo-scatto.png)

#### <big>Tempi di scatto</big>

Ritornando un attimo sui nostri passi, diamo ora un'occhiata migliore a come si possono definire i tempi di scatto di una transizione.

Nella definizione dei tempi di scatto delle transizioni esistono infatti una serie di alternative molto differenti.
Innanzitutto, i tempi possono essere:

- __unici__, ovvero ogni transizione scatta (o può scattare) in _uno e un solo_ specifico momento;
- __multipli__, ovvero ogni transizione scatta (o può scattare) in _uno in un insieme_ di momenti.
    A seconda del modello considerato tali insiemi possono essere veri e propri __insiemi matematici__ (_es. reti TB_) oppure __intervalli__.

Si noti come i primi possono essere visti come casi particolari dei secondi. \
Considerando ciò, gli insiemi (anche unitari) di tempi di scatto si distinguono poi in due categorie:

- __insiemi costanti__, ovvero tali per cui l'insieme dei tempi di scatto è __definito staticamente__ ed è sempre uguale indipendentemente dall'evoluzione della rete;
- __insiemi variabili__, ovvero tali per cui l'insieme dei tempi di scatto può __variare dinamicamente__ in base allo stato della rete o a porzioni di esso (_es. reti TB e HLTPN_).

Anche in questo caso i primi possono essere visti come un caso particolare dei secondi, in cui cioè l'insieme _potrebbe_ variare ma non varia mai. \
Infine, i tempi di scatto stessi possono essere divisi in base a come vengono definiti:

- __tempi relativi__, ovvero espressi _solo_ in termini relativi al tempo di abilitazione della transizione (_es. "2 ms dopo l'abilitazione"_);
- __tempi assoluti__, ovvero espressi in termini relativi a tempi assoluti e ai tempi associati ai gettoni che compongono l'abilitazione (_es. "dopo 3 minuti dall'avvio del sistema" o "dopo 4 ms dal tempo associato all'ultimo gettone nell'abilitazione"_) (_es. reti TBe TCP_).

Nuovamente, i primi possono essere visti come un sottoinsieme dei secondi.

Tutto questo insieme di variabili permette di definire reti temporizzate basate su tempi di scatto delle transizioni anche molto diverse tra di loro.
Avremo per esempio le _reti Time Petri_, che utilizzano tempi di scatto relativi, multipli e a intervalli costanti; le _reti Time Petri colorate_, simili alle precedenti ma che usano tempi assoluti; le _reti Time Petri ad alto livello_, che usano insiemi variabili, e molte altre.

Tra tutte queste tipologie, tuttavia, ci concentreremo sulle __reti Time Basic__.
In virtù delle inclusioni di cui abbiamo già detto tali reti saranno quindi le più generali possibile e, dunque, anche le più interessanti.
