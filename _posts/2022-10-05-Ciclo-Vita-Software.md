---
layout: post
title: "[02] Modelli di ciclo di vita del software"
date:   2022-10-05 14:30:00 +0200
toc: true
---

In questa lezione vedremo i principali modelli di ciclo di vita del software, ovvero famiglie di processi di sviluppo che si distinguono per il modo in cui le fasi di produzione viste nella scorsa lezione vengono organizzate in un processo unitario. Ognuno di tali modelli avrà i propri pro e i propri contro, ed è bene da subito capire che non esiste il modello giusto per ogni situazione.

# Modelli sequenziali

Il modo più semplice e immediato di organizzare le fasi del ciclo di vita di un software è sicuramente quello __sequenziale__: i vari passaggi vengono posti in un ordine prestabilito e vengono attraversati uno alla volta uno dopo l'altro. Da questa idea nascono i cosiddetti _modelli sequenziali_, di cui il più famoso è certamente il _modello a cascata_.

## Modello a cascata

### Caratteristiche e punti di forza

{% responsive_image path: assets/02_waterfall-model.png %}

Nato negli anni '50 ma diventato famoso solo negli anni '70 grazie allo sviluppo di un grosso software per la difesa area chiamato SAGE (_Semi-Automated Ground Environment_), il modello a cascata organizza le fasi in una serie di step sequenziali: fatto uno si passa al successivo fino ad arrivare alla fine, come in una sorta di _catena di montaggio_. Viene infatti forzata una __progressione lineare__ da una fase alla successiva; non è previsto in questo modello tornare indietro a uno step precedente.

Sebbene varino molto da processo a processo, la maggior parte dei processi che segue il modello a cascata include almeno le seguenti fasi organizzate in quest'ordine:

1. Requisiti
2. Progetto
3. Codifica
4. Testing
5. Prodotto

Ognuno di tali step produce un output, detto __semilavorato__, che è dato come input allo step successivo. In virtù dell'affidamento su tali semilavorati intermedi il modello a cascata si dice __document-based__: tra una fase e l'altra si crea infatti un documento che è il mezzo di trasmissione dell'informazione. Questo aspetto permette una __buona separazione dei compiti__ tra i vari dipendenti che lavorano al progetto: ognuno è infatti specializzato in una singola fase e una volta prodotto il documento utile ad avviare la fase successiva il suo coinvolgimento nel progetto non è più necessario ed esso può essere assegnato ad altri lavori.

La linearità del modello rende inoltre possibile __pianificare i tempi__ accuratamente e monitorare semplicemente lo stato di avanzamento in ogni fase: è infatti sufficiente stimare la durata di ogni fase per ottenere una stima del tempo di completamento dell'intero progetto. Si tratta però di una stima a senso unico: una volta finita una fase non è possibile ridurre il tempo speso, e in caso di inconvenienti l'unica opzione è cercare di assorbire il ritardo.

### Criticità

Sebbene il modello a cascata abbia il grande pregio di aver posto l'attenzione sulla comunicazione tra gli elementi del progetto in un momento storico in cui il modello di sviluppo più diffuso era di tipo _code-and-fix_, esso soffre di numerose criticità.

In primo luogo il modello __non prevede una fase di manutenzione__ del software prodotto: esso assume di non dover apportare modifiche al progetto dopo averlo consegnato, e impedisce dunque di _"tornare indietro"_ in alcun modo. Ovviamente questa assunzione è un'illusione smentita nella quasi totalità nei casi: qualunque software è destinato ad evolvere, e più un software viene usato più cambia. Una volta finito lo sviluppo ciò che si può fare è rilasciare al più piccole patch, che tuttavia non fanno altro che disallineare la documentazione prodotta precedentemente con il software reale.

Il modello soffre inoltre di una generale __rigidità__, che mal si sposa con la flessibilità naturalmente richiesta dall'ambiente di sviluppo software. In particolare, l'impossibilità di tornare indietro implica un __congelamento dei sottoprodotti__: una volta prodotto un semilavorato esso è fisso e non può essere modificato; questo è particolarmente critico per le stime e specifiche fatte durante le prime fasi, che sono fisiologicamente le più incerte.

Infine, il modello a cascata adotta un approccio volto alla __monoliticità__: tutta la pianificazione è orientata ad un singolo rilascio, e l'eventuale manutenzione può essere fatta solo sul codice. Inutile dire che si tratta di una visione fallace, in quanto come già detto più volte il software è destinato ad essere modificato e ad evolvere.

### _Who's Afraid of The Big Bad Waterfall?_

> LIBRO: __The Leprechauns of Software Engineeering__ di Laurent Bossavit.

In realtà, il modello a cascata non è mai stato veramente elogiato, ma è sempre stato utilizzato come paragone negativo per proporre altri modelli o variazioni.
Nel corso del tempo la sua presentazione è stata erroneamente attribuita al paper [_"Managing the development of large software systems: concepts and techniques"_](https://dl.acm.org/doi/10.5555/41765.41801) di W.W. Royce, di cui veniva citata solo la prima figura: Royce stava a dire il vero presentando quel modello per descrivere la sua esperienza nello sviluppo software, per poi proporre altri concetti più moderni (come lo sviluppo incrementale) che non sono però mai stati colti dalla comunità scientifica.

Anche noi utilizziamo il modello a cascata solo come paragone negativo, e in generale nell'ambiente di sviluppo software esso non è più applicato alla lettera. Alcuni suoi aspetti si sono però mantenuti come linee guida generali (es. l'ordine delle fasi); è infatti bene chiarire subito che esistono due tipi di modelli:

- __prescrittivi__: forniscono delle indicazioni precise da seguire per svolgere un processo;
- __descrittivi__: colgono certi aspetti e caratteristiche di particolari processi esistenti, ma non obbligano a seguirli in modo rigoroso.

Tutti i modelli visti per ora ricadono perlopiù nell'ambito descrittivo, mentre i modelli AGILE che vedremo più avanti tendono ad essere più di tipo prescrittivo.

### Modello a cascata: pro e contro

<table style="margin-bottom: 20px">
    <thead>
        <tr>
            <th style="text-align:center">Pro</th>
            <th style="text-align:center">Contro</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <ul>
                    <li>Document-based</li>
                    <li>Buona suddivisione dei compiti</li>
                    <li>Semplice pianificazione dei tempi</li>
                </ul>
            </td>
            <td>
                <ul>
                    <li>Rigidità</li>
                    <li>Congelamento dei sottoprodotti</li>
                    <li>Monoliticità</li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>

## Modello a V (denti di pesce cane)
{% responsive_image path: assets/02_v-model.png %}

Dal modello a cascata nascono poi numerose varianti che cercano di risolverne i vari problemi: tra queste spicca per rilevanza il __modello a V__, che introduce fondamentalmente una __più estesa fase di testing__.

Nonostante sia ancora un modello sequenziale come il modello a cascata, nel modello a V vengono infatti evidenziati nuovi legami tra le fasi di sviluppo, che corrispondono alle attività di __verifica__ e __convalida__: alla fine di ogni fase si _verifica_ che il semilavorato ottenuto rispetti la specifica espressa dalla fase precedente, e inoltre si richiede la _convalida_ del fatto che esso sia in linea con i veri vincoli e necessità del cliente. Come si vede, questo modello pone l'accento sul rapporto con il cliente, che viene continuamente coinvolto con la richiesta di feedback su ciascun sottoprodotto generato.

Volendo formalizzare, le due nuove attività introdotte sono dunque:

- __verifica__ (freccie grigie): controlla la correttezza rispetto alla descrizione formale delle specifiche;
- __validazione__ (freccie bianche): controlla la compatabilità del sistema con le esigenze del cliente tramite feedback continuo.

# Modelli iterativi

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
