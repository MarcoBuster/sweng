---
layout: post
title: "[02] Modelli di ciclo di vita del software"
date:   2022-10-05 14:30:00 +0200
toc: true
---

# Il modello a cascata

È una famiglia di processi in cui in ogni step non è possibile tornare indietro allo step precedente sequenziale, stile "catena di montaggio".

È nato alla fine degli anni '50 nel Dipartimento di Difesa degli Stati Uniti ma è diventato famoso negli anni '70. 

Ci sono i seguenti processi:
1. Requisiti
2. Progetto
3. Codifica
4. Testing
5. Prodotto

## Caratteristiche
Il modello a cascata si dice __document-based__: tra una fase e l'altra si crea un documento che è il mezzo di comunicazione dell'informazione. Viene forzata una progressione lineare da una fase alla successiva.

C'è una separazione dei compiti: ognuno è specializzato in una certa parte e comunica con gli altri attraverso dei documenti (semi-elaborati). 

È possibile pianificare i tempi e monitorare lo stato di avanzamento in ogni fase. È però a senso unico: non esiste un vero modo per forzare il cambiamento di tempo nel futuro, l'unica opzione è cercare di assorbire il ritardo.

## Punti di forza
<!-- forse da mettere alla fine? bo -->

## Problemi di comunicazione

<!-- memino -->

## Manuntenzione
È un'illusione quella che dopo aver consegnato il non dover _tornare indietro_. Nel modello a cascata non viene prevista perché non si può tornare indietro.

Se mettiamo una pezza disallineamo il prodotto da tutta la documentazione che abbiamo prodotto precedentemente.
La maggiorparte (~70%) dei costi di sviluppo ricadono proprio nella manutenzione, che non è prevista dal modello.

## Criticità

- Rigidità.
- Congelamento dei sotto prodotti: le stime e le specifiche sono fatte solo nelle prime fasi.
- Monoliticità: tutta la pianificazione è orientata ad un singolo rilascio. La manuntenzione è fatta solo sul codice. 


# Rant del prof

LIBRO: _Who's Afraid of The Big Bad Waterfall?_

Ci sono due tipi di modelli:
- __prescrittivi__: indicazioni da seguire per svolgere un processo;
- __descrittivi__: colgono certi aspetti e caratteristiche di particolari processi.

# Varianti del modello a cascata

## Modello a V (denti di pesce cane)
È ancora sequenziale, ma vengono evidenziati dei legami tra le attività. In particolare sono evidenziate le attività di verifica e convalida. 

- La __verifica__ controlla la correttezza rispetto alla descrizione formale.
- La __validazione__ è invece controllare che il sistema sia alle esigenze del cliente (feedback continuo).

## Modello a cascata con singola retroazione

<!-- immagine -->

Una fase può portare modifiche nella fase precedente (__iterazione__). 
Per esempio, posso _iterare_ tra _Codifica_ e _Testing_ fino a consegnare il prodotto.

## Modello a fontana

<!-- immagine -->

Ideato nel 1993. In un qualunque momento se ci sono errori si torna indietro e si ricontrollano tutte le fasi precedenti partendo dall'inizio. 

Nell'ultima fase (_programma in uso_) ci sono ancora due strade: manutenzione ed evoluzione. È quindi il primo modello che vediamo che prevede queste due strade fondamentali. 
La consegna del prodotto non è quindi più l'atto finale, ma solo un altro step del processo: concetto di __versione incrementale__.

Si può parlare di:
- __implementazione iterativa__ se... <!-- non ho capito -->
- __sviluppo incrementale__ <!-- ancora non ho capito -->
    - la manutenzione non è una particolarità ma è perfettamente integrata nel modello; è vista come normali richieste di cambiamenti (correzioni) nel modello.

## Modelli prototipali
Viene introdotta il concetto di prototipi usa e getta (_throw away_). Per crearli non vengono seguiti i principi di Ingegneria del Software ma vengono fatti velocemente; sono utilizzati solo per validare le aspettative del cliente. Il rischio più grande di partire da quello e dover stravolgere tutto ad ogni modifica, ritrovandosi software non mantenibile e illegibile con debito tecnico.

Possono essere:
- __pubblici__, per capire meglio i requisiti del cliente;
- __privati__, per esplorare nuovi strumenti, linguaggi, diverse scelte per problemi difficili.

> __Legge di Bohem__: la propotipizzazione riduce gli errori di analisi dei requisiti e di design, specialmente per le interfacce utente.

# I problemi dei modelli incrementali

Viene complicato il lavoro di planning: bisogna pianificare tutte le iterazioni e lo stato di avanzamento è meno visibile.
Ad ogni iterazione, dobbiamo rimetere mano a ciò che è stato fatto: il sistema può non convergere.

Ma cosa è un'iterazione, quanto dura? Ci sono diversi rischi:
- rischio di voler mettere troppo nella prima iterazione;
- rischio di overhead dovuto a troppe iterazioni;
- rischio di avere un eccessivo overlapping tra le iterazioni: non si ha tempo di aver feedback dell'utente.

## Pinball Life-Cycle
- L'ordine in cui faccio le attività è casuale, incotrollabile.
- Qualunque passo è possibile
- Non vengono imposti vincoli temporali
- Non misurabile

# Modelli trasformazionali
Ad ogni passo vengono controll <!-- ... -->

Passi di trasformazioni (formalmente dimostrabili come corretti) portano ad avere la versione finale.

Viene quindi introdotto il concetto di __prova formale di correttezza__, nella realtà presente solo negli ambienti di ricerca e produzione hardware. È opportuno utilizzare solo in situazioni critiche. 

# <i>Meta</i>modello a spirale
Un metamodello è un modello che mi permette di rappresentare e parlare di altri modelli.

È un modello incrementale, ma ad ogni iterazione c'è una decisione. Le fasi generali sono:
- Determinare obiettivi, alternative e vincoli
- Valutazione alternative, identificazione rischi
- Sviluppo e verifica
- Pianificare la prossima iterazione

## Modello a spirale _win-win_
I rischi ad ogni fase non sono solo rischi tecnologici ma anche contrattuali con il cliente. Ad ogni iterazione bisogna trovare un punto di equilibrio _win-win_: entrambi le parti vincono (o hanno l'illusione di aver vinto).

# Modello COTS (Component Off The Shelf)
Questo modello si concentra molto sulla riusabilità. Si parte dalla disponibilità interna o sul mercato di moduli preesistenti sui quali basare il sistema.

<!-- ha scritto ceri KEK -->

Questo modello di design necessita di far dialogare componenti che non necessariamente comunicano già insieme.

# Metodologie Agili

Per migliorare il modo in cui sviluppiamo il software, dobbiamo dare più importanza ad alcuni valori rispetto agli altri.

- Gli __individui__ e la __collaborazione tra individui__ è più importante di processi e strumenti.
- Il __software che funziona__ è più importante della documentazione ben fatta.
- La __collaborazione con il cliente__ è più importante del contratto.
- __Rispondere al cambiamento__ è più importante che seguire un piano.

LIBRO: Agile! Bertrand Meyer

## Lean Software
Nasce da Toyota: l'obiettivo è __ridurre gli sprechi__ / la spazzatura: alcuni sottoprodotti che non vengono consegnati potrebbero essere ignorati.

## Kanban
L'obiettivo è __minimizzare il lavoro in corso__. 
C'è una tabella con 5 colonne:
- backlog
- da fare
- in esecuzione
- in testing
- fatto

Ogni card (storia) è assegnato a un utente (o coppia nel _pair programming_). Ogni utente si concentra su un lavoro bloccante per un'altro. La tabella dà a colpo d'occhio informazioni sullo stato del progetto per tutti.

## _Scrum_
L'obiettivo è __fissare i requisiti__ durante le iterazioni (__brevi__, da 2 a 4 settimane). Al termine di ogni iterazione si rimettono in discussione i requisiti con il cliente.

## Crystal
Viene introdotto il concetto di __comunicazione osmotica__. Nel modello a cascata la comunicazione è fatta tramite documenti rigidi; in Crystal la conoscenza viene condivisa nel team tramite _"osmosi"_. 
Il pair programming è in quest'ottica: tra i due componenti la conoscenza è condivisa. Crystal estende questo concetto all'intero team.

Funziona solo con team piccoli (max 8-10 persone).  

## eXtreme Programming (XP)
Motto: __incrementa quindi semplifica__; sviluppo guidato dal test (_test-first_: prima testa poi sviluppa). 
