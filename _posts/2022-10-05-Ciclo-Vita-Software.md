---
layout: post
title: "[02] Modelli di ciclo di vita del software"
date:   2022-10-05 14:30:00 +0200
toc: true
---

In questa lezione vedremo i principali modelli di ciclo di vita del software.

# Modelli iterativi

## Modello a cascata

{% responsive_image path: assets/02_waterfall-model.png %}

Il modello a cascata nasce negli anni 50 ma diventa famoso solo negli anni 70 con un grosso software per la difesa area chiamato SAGE (Semi-Automated Ground Environment).

Ogni step produce un output che è dato come input allo step successivo; non è previsto in questo modello tornare indietro a uno step precedente.

Ci sono i seguenti processi:
1. Requisiti
2. Progetto
3. Codifica
4. Testing
5. Prodotto

### Caratteristiche
Il modello a cascata si dice __document-based__: tra una fase e l'altra si crea un documento che è il mezzo di comunicazione dell'informazione. Viene forzata una progressione lineare da una fase alla successiva, stile catena di montaggio.

C'è una separazione dei compiti: ognuno è specializzato in una certa parte e comunica con gli altri attraverso dei documenti (semi-elaborati). 

È possibile pianificare i tempi e monitorare lo stato di avanzamento in ogni fase; è però a senso unico: non esiste un vero modo per forzare il cambiamento di tempo nel futuro, l'unica opzione è cercare di assorbire il ritardo.

### Punti di forza
Nessuno LOL
<!-- ne ha? -->

### Manuntenzione
Il modello assume di non dover apportare modifiche al progetto dopo aver consegnato: non si può _"tornare indietro"_. 

Questa è un'illusione smentita nella quasi totalità nei casi: più un software viene usato più cambia. 

La maggiorparte dei costi dello sviluppo ricadono nella fase di manutenzione.
Mettere una "pezza" comporta a disallineare la documentazione prodotta precedentemente con il software reale. 

### Criticità
- Rigidità.
- Congelamento dei sotto prodotti: le stime e le specifiche sono fatte solo nelle prime fasi; non è possibile mettere in discussione ciò che è già stato fatto.
- Monoliticità: tutta la pianificazione è orientata ad un singolo rilascio. 
- Rilascio: la manuntenzione è fatta solo sul codice. 

### _Who's Afraid of The Big Bad Waterfall?_

> LIBRO: __The Leprechauns of Software Engineeering__ di Laurent Bossavit.

In realtà, la tecnica waterfall non è mai stata in realtà elogiata, ma è sempre stata utilizzata come paragone negativo per proporre altri modelli o variazioni. 
Nel corso del tempo è stata erroneamente attribuita al paper [_"Managing the development of large software systems: concepts and techniques"_](https://dl.acm.org/doi/10.5555/41765.41801) di W.W. Royce, perché veniva citata solo la prima figura. 
Royce stava presentando quel modello per descrivere la sua esperienza nello sviluppo software, per poi proporre altri concetti più moderni (come lo sviluppo incrementale) che non sono però mai stati colti dalla comunità scientifica.

Ci sono quindi due tipi di modelli:
- __prescrittivi__: forniscono delle indicazioni da seguire per svolgere un processo;
- __descrittivi__: colgono certi aspetti e caratteristiche di particolari processi esistenti.

## Modello a V (denti di pesce cane)
{% responsive_image path: assets/02_v-model.png %}

Nonostante sia ancora un modello sequenziale come il modello a cascata, nel modello a V vengono evidenziati dei legami tra le attività, che corrispondono alle attività di __verifica__ e __convalida__.
È ancora un modello sequenziale.

Le due attività introdotte sono:
- __verifica__ (freccie grigie): controlla la correttezza rispetto alla descrizione formale delle specifiche;
- __validazione__ (freccie bianche): controlla la compatabilità del sistema con le esigenze del cliente tramite feedback continuo.

## Modello a cascata con singola retroazione

{% responsive_image path: 'assets/02_waterfall-retroazione.png' %}

Una fase può portare modifiche nella fase precedente (__iterazione__). 
Per esempio, posso _iterare_ tra _Codifica_ e _Testing_ fino a consegnare il prodotto.

Anche in questo modello non si può tornare indietro dalla consegna, quindi eseguire attività di manutenzione.

## Modello a fontana

{% responsive_image path: 'assets/02_fountain-model.png' %}

È stato ideato nel 1993. 
In un qualunque momento se ci sono errori si torna indietro ripartendo dall'inizio (_software pool_) e ricontrollando tutte le fasi precedenti. 

È il primo modello in cui sono previste delle azioni dopo la consegna (la __manutenzione__).
Nell'ultima fase (_programma in uso_) ci sono ancora due strade: manutenzione ed evoluzione. 
La consegna del prodotto non è quindi più l'atto finale, ma solo un altro step del processo: concetto di __versione incrementale__.

# Modelli incrementali

Un modello incrementale è un particolare modello iterativo in cui in una delle nelle iterazioni è inclusa la consegna.

Si può parlare quindi di:
- __implementazione iterativa__: dopo aver raccolto le specifiche e aver progettato il sistema, _iterativamente_ sviluppo i componenti, li integro nel prodotto finale, quindi consegno.
- __sviluppo incrementale__: l'iteratività interessa tutte le fase, comprese quelle di specifiche e realizzazione.  

Lo sviluppo incrementale riconosce la criticità della variabilità delle richieste e la integra nel processo. 
La manutenzione non è quindi più una particolarità ma è vista come normali richieste di correzioni perfettamente integrate nel modello.

## Modelli prototipali
Un particolare modello incrementale è quello protitipale. In questo modello viene introdotto il concetto di __protitipi usa e getta__ (_throw away_). 

Lo scopo del prototipo __non è consegnare__ un prodotto finito, ma __ricevere feedback__ dal cliente per essere sicuri di aver compreso a pieno i suoi requisiti.

La tentazione può essere quella di consegnare il prodotto finito, ma c'è il __rischio__ enorme di dover mantenere poi in futuro software non mantenibile, illeggibile e con altissimo debito tecnico.

I protitipi possono essere:
- __pubblici__: per capire meglio i requisiti del cliente;
- __privati__: per esplorare nuovi strumenti, linguaggi, scelte per problemi difficili.

__Legge di Bohem__
> La propotipizzazione riduce gli errori di analisi dei requisiti e di design, specialmente per le interfacce utente.

## I problemi dei modelli incrementali

Viene complicato il lavoro di planning: bisogna pianificare tutte le iterazioni e lo stato di avanzamento è meno visibile.
Ad ogni iterazione, dobbiamo rimetere mano a ciò che è stato fatto: il processo può non convergere.

Ma cosa è un'iterazione, quanto dura? Ci sono diversi rischi:
- voler aggiungere troppe funzionalità nella prima iterazione;
- overhead dovuto a troppe iterazioni: per esempio, Microsoft Office 2020 e 2019 vengono sviluppati contemporaneamente;
- avere un eccessivo overlapping tra le iterazioni: non si ha tempo di aver feedback dell'utente.

### Pinball Life-Cycle
{% responsive_image path: 'assets/02_pinball-life-cycle.png' %}

Il _"modello meme"_ Pinball Life-Cycle estremizza queste problematiche: l'ordine in cui faccio le attività è casuale, incoltrollabile.

Qualunque passo è possibile, non vengono imposti vincoli temporali. Il processo è __non misurabile__.

## Modelli trasformazionali
{% responsive_image path: 'assets/02_transformational-models.png' %}

I modelli trasformazionali sono l'opposto di Pinball Life-Cycle.
Ad ogni passo vengono controllate tutte le cose che accadono, in __modo formale__.

Partendo dalle specifiche informali, mediante una sequenza di __passi di trasformazione__ dimostrabili tutti formalmente arriviamo alla versione finale.
Se le specifiche sono corrette e i passi di trasformazioni sono dimostrati allora ottengo un programma corretto. 

{% responsive_image path: 'assets/02_formal-transformations.jpg' %}

Viene quindi introdotto il concetto di __prova formale di correttezza__, nella realtà presente solo negli ambienti di ricerca e produzione hardware. 

Ad ogni passo si ottiene un __protitipo__ che differisce dal prodotto finale per efficienza e completezza.

## <i>Meta</i>modello a spirale
{% responsive_image path: 'assets/02_spiral-model.png' %}
Un metamodello è un modello che mi permette di rappresentare e discutere di altri modelli.

Nel metamodello a spirale l'attenzione è sui __rischi__, ovvero prevedere cosa può andare male.
È un modello incrementale, ma ad ogni iterazione c'è una decisione. Le fasi generali sono:
- Determinare obiettivi, alternative e vincoli
- Valutazione alternative, identificazione rischi
- Sviluppo e verifica
- Pianificare la prossima iterazione

Nella figura il raggio della spirale indica i __costi__: ad ogni iterazione aumentano.

### Variante _"win-win"_
I rischi ad ogni fase non sono solo rischi tecnologici ma anche __contrattuali__ con il cliente. Ad ogni iterazione bisogna trovare un punto di equilibrio _win-win_: entrambi le parti vincono (o hanno l'illusione di aver vinto).

## Modello COTS (Component Off The Shelf)
{% responsive_image path: 'assets/02_cots.png' %}

Questo modello si concentra molto sulla __riusabilità__. 
Si parte dalla disponibilità interna o sul mercato di moduli preesistenti sui quali basare il sistema.

Questo modello di design necessita di far dialogare componenti che non necessariamente comunicano già insieme.

È un modello di sviluppo diverso perché richiede attività diverse. In particolare:
- _requirements specification_
- ___component analysis___: prima di progettare considero la disponibilità di componenti che implementano una parte o tutte le funzionalità richieste;
- ___requirements modification___: stabilire se il cliente è disposto ad accettare un cambiamento nei requisiti necessario per utilizzare un componente particolare;
- ___system design with reuse___: occorre progettare il sistema per far interagire componenti che non necessariamente sono stati originariamente progettati per interagire;
- _development and integration_;
- _system validation_.

# Metodologie Agili
Le metodologie agili _"nascono dal basso", ovvero solitamente da chi sviluppa, per colmare un disagio prevalente nell'usare i metodi tradizionali.

## [Manifesto](https://agilemanifesto.org/iso/it/manifesto.html)

Per migliorare il modo in cui sviluppiamo il software, dobbiamo dare più importanza ad alcuni valori rispetto agli altri.

- Gli __individui__ e la __collaborazione tra individui__ è più importante di processi e strumenti.
- Il __software che funziona__ è più importante della documentazione ben fatta.
- La __collaborazione con il cliente__ è più importante del contratto.
- __Rispondere al cambiamento__ è più importante che seguire un piano.

LIBRO: Agile! Bertrand Meyer

## Lean Software
Nasce da Toyota: l'obiettivo è __ridurre gli sprechi__ / la spazzatura: i sottoprodotti che non vengono consegnati (testing, ...) potrebbero essere ignorati.

Posticipare le scelte vincolanti può aiutare a risparmiare risorse.

## Kanban
{% responsive_image path: 'assets/02_kanban.jpg' %}

L'obiettivo è __minimizzare il lavoro in corso__ (work in progress). 
C'è una tabella con 5 colonne:
- __backlog__: richieste dal cliente
- __da fare__: attività da fare in questa iterazione
- __in esecuzione__
- __in testing__
- __fatto__

Ogni __card__ (storia) è assegnata a un utente (o coppia nel _pair programming_). 
Ogni utente si concentra su un lavoro bloccante per un'altro. 
La tabella dà a colpo d'occhio informazioni sullo stato del progetto per tutti.

## _Scrum_
L'obiettivo è __fissare i requisiti__ durante le iterazioni (__brevi__, da 2 a 4 settimane). Al termine di ogni iterazione si rimettono in discussione i requisiti con il cliente.

## Crystal
Viene introdotto il concetto di __comunicazione osmotica__. Nel modello a cascata la comunicazione è fatta tramite documenti rigidi; in Crystal la conoscenza viene condivisa nel team tramite _"osmosi"_. 
Il pair programming è in quest'ottica: tra i due componenti la conoscenza è condivisa. 
Crystal estende questo concetto all'intero team.

Funziona solo con team piccoli (max 8-10 persone).  

## eXtreme Programming (XP)
Motto: __incrementa quindi semplifica__; sviluppo guidato dal test (_test-first_: prima testa poi sviluppa). 

Vedere lezione successiva.
