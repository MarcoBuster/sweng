---
layout: post
title: "[01] Introduzione"
date:   2022-10-03 14:30:00 +0200
toc: true
---

# Informazioni logistiche
- Non ci sarà lo streaming però ci sono le videolezioni
- Teoria
    - Lun 14:30-17:00 Aula 403
    - Mer 14:30-17:00 Aula 403
- Laboratorio
    - Gio 13:30-17:30 due turni equivalenti
        - Turno A matricole pari
        - Turno B matricole dispari
    - Due persone per computer, a coppia
- Non c'è libro di testo, ma consigliati: 
    - Software Engineering (Carlo Ghezzi, Dino Mandridi)
    - Design Patterns (Eric Freeman, Elisabeth Robison)
    - Handbook of Software and Systems Engineering (Albert Endres, Dieter Rombath)

## Esami
- __Laboratorio__
    - prova pratica di laboratorio di 4 ore
    - OPPURE _per chi segue tutti i laboratori_ ci saranno due laboratori valutati A COPPIE
- __Teoria__ 
    - prova orale
- Prima di fare l'orale bisogna fare il laboratorio
- La prova di laboratorio vale all'infinito

# Introduzione 

## Storia 
Con la diffusione dei primi computer in ambito accademico, negli anni '50 e '60 si è subito colta la necessità di superare metodi di produzione "artigianale" del software: sebbene il cliente e il programmatore coincidessero e i programmi fossero prettamente matematici, si iniziavano già a vedere i primi problemi. Negli anni '70, si inizia dunque a pensare a dei metodi, dei processi e a degli strumenti che potessero migliorare e ___"assicurare"___ la __qualità del software__, sviluppando un approccio di tipo ingegneristico costituito da una serie di fasi.

## Approccio ingegneristico
1. __Target__: ci si prefigge un obiettivo da raggiungere.
2. __Metric__: si definisce una metrica per misurare la qualità del software, ovvero quanto esso si avvicina al target prefissato.
3. __Method, Process, Tool__: si provano una serie di metodi, processi e strumenti per avvicinarsi all'obiettivo.
4. __Measurements__: si misura tramite la metrica stabilita se le strategie implementate sono state utili e quanto ci hanno avvicinato (o allontanato) all'obiettivo. A seconda dei risultati ottenuti vi sono due possibili strade:
    - risultati soddisfacenti (_aumento delle metrica_) - accettiamo come buoni metodi e processi utilizzati.
    - risultati insoddisfacenti (_diminuzione della metrica_)- ci sono dei peggioramenti o dei forti effetti collaterali, di conseguenza bisogna modificare il lavoro qualcosa: si possono cambiare target o metrica se ci si rende conto di non aver ben definito l'obiettivo, ma più comunemente bisogna rivedere i processi e metodi usati.

Ma __che cosa si intede per target__? Gli obiettivi da raggiungere possono essere di due tipi: la risoluzione dei __problemi nella progettazione del software__ e l'assicurazione di una qualche __qualità che il software dovrà avere__. È dunque necessario chiedersi le seguenti domande:
- Quali problemi ci sono?
- Quali qualità deve avere il software?

### Problemi principali
Vediamo allora a questo punto alcuni dei problemi che possono insorgere durante lo sviluppo di software, partendo dal presupposto che una delle più grandi fonti di problemi sono le __persone__.  L'obiettivo della disciplina è infatti principalmente quello di risolvere i __problemi di comunicazione__, che possono essere:
- tra il __programmatore__ e il __cliente__: sono esperti di domini diversi ed è difficile comprendersi;
- tra un __programmatore__ e altri __programmatori__.

Un'altra fonte di problemi sono le __dimensioni__ del software, che possono raggiungere valori molto elevati in termini di milioni di righe di codice e migliaia di _"anni uomo"_ di lavoro. Lo sviluppo software non è più piccolo e domestico, e questo crea chiaramente problemi di manutenzione e gestione della codebase.

Il software è infine __facilmente malleabile__, ovvero modificabile nel tempo: il moltiplicarsi di versioni, evoluzioni e variazioni di target può creare non poche difficoltà.

# Qualità
Per fare fronte ai problemi sopracitati si sviluppano allora una serie di processi per lo sviluppo software: essi non assicurano la bontà del programma finito, ma possono assicurare la presenza di _proprietà desiderabili_ del prodotto, dette __qualità__. Le qualità del prodotto, che costituiscono a conti fatti un "valore per le persone", si dividono innanzitutto in due tipi:
- __qualità esterne__: qualità che vengono colte dal cliente;
- __qualità interne__: qualità che vengono esclusivamente colte dallo sviluppatore.

Le qualità interne influenzano molto le qualità esterne (per esempio se ho un codice ottimizzato ed efficiente, il mio software produrrà i risultati più velocemente). Prima di vedere quali siano le proprietà auspicabili in un software, però, facciamo un'importante distinzione a livello terminologico tra __requisiti e specifiche__:
- I __requisiti__ sono quello che il cliente vuole che il software faccia. Spesso sono cambiati in corso d'opera oppure sono espressi in modo sbagliato, per cui è necessaria un'interazione continua. 
- Le __specifiche__ sono ciò che è stato formalizzato dal programmatore a partire dai requisiti: si tratta di una definizione più rigorosa di che cosa dovrà fare il software. Si noti però che se i requisiti sono stati espressi in modo non corretto anche le specifiche risulteranno inesatte (vd. <a href="#g1">G1</a>).

Fatta questa doverosa distinzione, vediamo quali sono le qualità che un software dovrebbe idealmente possedere.

## Qualità del software

Un software di qualità deve <b><i>funzionare</i></b>, <b><i>essere bello</i></b> e <b><i>"farmi diventare ricco"</i></b>.

<table style="margin-bottom: 20px">
<thead>
    <tr>
        <th>Un software deve...</th>
        <th>Qualità</th>
        <th>Descrizione</th>
    </tr>
</thead>
<tbody>
    <tr>
        <th rowspan="3"><i>Funzionare</i></th>
        <th>Correttezza</th>
        <td>
            Un software è corretto se soddisfa la specifica dei suoi <i>requisiti funzionali</i>. Si tratta di una proprietà <i>"matematica"</i> e relativamente dimostrabile in modo formale.
        </td>
    </tr>
    <tr>
        <th>Affidabilità</th>
        <td>
            Un software è affidabile quando ci si può fidare del suo funzionamento, ovvero ci si può aspettare che faccia ciò che gli è stato chiesto.
            Se è molto difficile perseverare la correttezza, in quanto si tratta una proprietà assoluta, l'affidabilità è invece relativa: un software può essere affidabile (o <i>dependable</i>) nonostante contenga qualche errore.
        </td>
    </tr>
    <tr>
        <th>Robustezza</th>
        <td>
            Un software è robusto se si comporta in modo accettabile anche in circostanze non previste nella specifica dei requisiti, senza generare effetti troppo negativi.
        </td>
    </tr>
    <tr>
        <th rowspan="3"><i>Essere bello</i></th>
        <th>Usabilità</th>
        <td>
            Un software è usabile (o <i>user-friendly</i>) se i suoi utenti lo ritengono facile da utilizzare.
            Si possono fare degli esperimenti (le grandi aziende lo fanno) per testare e quantificare l’usabilità del software ponendolo di fronte a dei soggetti umani (vd. <a href="#nn23">NN23</a>).
        </td>
    </tr>
    <tr>
        <th>Prestazioni</th>
        <td>
            Ad ogni software è richiesto un certo livello di prestazioni. L'efficienza è una qualità interna e misura come il software utilizza le risorse del computer; la performance, d'altro canto, è invece una qualità esterna ed è basata sui requisiti dell'utente. Essa ha effetto sull'usabilità, e spesso viene considerata alla fine dello sviluppo software visto che vari avanzamenti tecnologici possono efficientare algoritmi e processi prima troppo costosi.
        </td>
    </tr>
    <tr>
        <th>Verificabilità</th>
        <td>
            Un software è verificabile se le sue proprietà sono verificabili facilmente: è importante essere in grado di poter dimostrare la correttezza e la performance di un programma, e in tal senso la <b>leggibilità</b> del codice è fondamentale. 
            La verifica può essere fatta con metodi formali o informali, come il testing.
            È considerata una qualità interna, ma alcune volte può diventare una qualità esterna: per esempio, in ambiti in cui la sicurezza è critica il cliente può chiedere la verificabilità di certe proprietà.
        </td>
    </tr>
    <tr>
        <th rowspan="2"><i>Farmi diventare ricco</i></th>
        <th>Riusabilità</th>
        <td>
            Le componenti del software che costruiamo dovrebbero essere il più riutilizzabili possibile così da risparmiare tempo in futuro: ciò può essere fatto non legandole troppo allo specifico contesto applicativo del software che stiamo sviluppando.
            Con la proprietà di riusabilità, utilizziamo un prodotto per costruire - anche con modifiche minori - un altro prodotto (vd. <a href="#mi15">MI15</a>).
        </td>
    </tr>
    <tr>
        <th>Manutenibilità</th>
        <td>
            Per <i>manutenzione software</i> si intendono tutte le modifiche apportate al software dopo il rilascio iniziale.
            Questa proprietà può essere vista come due proprietà separate:
            <ul style="margin-bottom: 0;">
                <li><b>Riparabilità</b>: un software è riparabile se i suoi difetti possono essere corretti con una quantità di lavoro ragionevole.</li>
                <li><b>Evolvibilità</b>: indica la capacità del software di poter evolvere aggiugendo funzionalità. È importante considerare questo aspetto fin dall'inizio: studi rilevano come l'evolvibilità decresce con il passare delle release (vd. <a href="#l27-28">L27-28</a>).</li>
            </ul>
        </td>
    </tr>
</tbody>
</table>

### Leggi rilevanti

<a id="g1"></a>
__Prima legge di R.Glass (G1)__. 
> La mancanza di requisiti è la prima causa del fallimento di un progetto.

<a id="nn23"></a>
__Legge di Nielsen-Norman (NN23)__.
> L'usabilità è misurabile.

<a id="mi15"></a>
__Legge di McIlroy (MI15)__. 
> Riutilizzare il software permette di incrementare la produttività e la qualità.

<a id="l27-28"></a>
__Leggi di M. Lehman (L27-28)__. 
> Un sistema che viene utilizzato cambierà. 

> Un sistema che evolve incrementa la sua complessita a meno che non si lavori appositamente per ridurla.

## Qualità del processo
> Un progetto è di qualità se segue un buon processo.

Sappiamo che il prodotto è influenzato dal processo che viene utilizzato per svilupparlo, di conseguenza possiamo parlare anche di  __qualità del processo__.

Anche un processo deve funzionare, essere essere bello e farmi diventare ricco, ma dobbiamo interpretare queste parole in maniera differente.

Quali caretteristiche ha un processo di qualità?

<table style="margin-bottom: 20px">
<thead>
    <tr>
        <th>Un processo deve...</th>
        <th>Qualità</th>
        <th>Descrizione</th>
    </tr>
</thead>
<tbody>
    <tr>
        <th rowspan="1"><i>Funzionare</i></th>
        <th>Robustezza</th>
        <td markdown="span">
            Un processo deve poter resistere agli imprevisti, come la mancanza improvvisa di personale o il cambiamento delle specifiche.
            Esistono certificazioni (<i>CMM: Capability Maturity Model</i>) che valutano la robustezza di alcuni processi aziendali e che vengono per esempio considerate nei bandi pubblici.
        </td>
    </tr>
    <tr>
        <th rowspan="1"><i>Essere bello</i></th>
        <th>Produttività</th>
        <td markdown="span">
            La produttività di un team è molto meno della somma della produttività individuale dei suoi componenti. È una metrica difficile da misurare: conteggi come il numero di linee codice scritte o la quantità di <i>tempo-uomo</i> richiesta per un lavoro si rivelano spesso un po' fallaci (per esempio, la gravidanza umana non è un'attività parallelizzabile, ma si potrebbe dire che servono 9 mesi-donna per creare un bambino).
        </td>
    </tr>
    <tr>
        <th rowspan="1"><i>Farmi diventare ricco</i></th>
        <th>Tempismo</th>
        <td markdown="span">
            Un processo deve consegnare il prodotto nei tempi stabiliti, in modo da rispettare i tempi del mercato. È spesso conveniente la tecnica dello <b>sviluppo incrementale</b>, ovvero la consegna frequente di parti sempre più grandi del prodotto (es. compilatore ADA): essa permette infatti di conquistare il cliente ancor prima di avere il prodotto finito. 
        </td>
    </tr>
</tbody>
</table>

# Il processo di produzione del software
Il processo che seguiamo per costruire, consegnare, installare ed evolvere il prodotto software, dall'idea fino alla consegna e al ritiro finale del sistema, è chiamato __processo di produzione software__.

Innanzitutto occorre riconoscere diverse problematiche.
- I __requisiti__ imposti dal cliente possono cambiare spesso.
- Produrre software __non è _solo_ scrivere codice__ (alla Programmazione I).
- Bisogna risolvere i __problemi di comunicazione__ tra tutte le diverse figure in gioco (tra sviluppatori, tra progettista e sviluppatori, ecc).
- Bisogna essere __rigorosi__, anche se può essere difficile. Ci sono lati positivi e negativi: la rigorisità può facilitare la comprensione di ciò che bisogna fare ma implica  al contempo molta fatica extra, e viceversa.
    > __Ipotesi di Bauer-Zemanek (BZh3)__: Metodi formali riducono in maniera significativa gli errori di progettazione, oppure permettono di eliminarli e risolverli prima.
    
    Trovare gli errori prima della fase di sviluppo permette di facilitarne la risoluzione e di risparmiare sia tempo che soldi: tanto prima si individua un errore, tanto più facile sarà risolverlo.
- Ci sono __tanti aspetti__ da considerare, che andranno affrontati uno alla volta. Per parlare di aspetti diversi ho bisogno di metodi comunicazione diversi, che interessano ruoli diversi in tempi diversi (_Aspect Oriented Programming_).

Tenendo a mente tutto queste problematiche è necessario decidere come organizzare l'attività di sviluppo software in modo da mitgarle. Per modellare un ciclo di vita del software, occorre dunque in primo luogo __identificare le varie attività necessarie__ e quindi:
- deciderne le precedenze temporali;
- decidere chi le debba fare.

In particolare, ci si pone due domande:
- cosa devo fare adesso?
- fino a quando e come?

L'ingegneria del software prova a rispondere a queste domande per individuare quali siano le fasi necessarie per sviluppare un software e quale sia la loro migliore disposizione temporale. È dunque bene specificare da subito che lo sviluppo di un programma non è solo coding: tale presupposto genera conseguenze disastrose.

Inizialmente, infatti, nell'ambito dello sviluppo software è stato adottato il modello ___code-and-fix___, che consisteva nei seguenti passi:
1. scrivi il codice;
2. sistemalo per eliminare errori, migliorare funzionalità o aggiungere nuove funzionalità.

Ben presto però questo modello si è dimostrato pesantemente inefficace in gruppi di lavoro complessi, specialmente quando il cliente non era più lo sviluppatore stesso ma utenti con poca dimestichezza con i computer, generando codice estremamente poco leggibile e manutenibile.

Per organizzare meglio l'attività di sviluppo e non ricadere negli errori del passato gli ingegneri del software hanno dunque individuato diverse __fasi__ del ciclo di vita di un software che, combinate, permettessero di produrre del software di qualità. Diamo dunque un'occhiata a quelle principali.

## Le fasi del ciclo di vita del software

### Studio di fattibilità
Lo studio di fattibilità è l'attività svolta prima che il processo di sviluppo inizi, per decidere se dovrebbe iniziare _in toto_.
L'__obiettivo__ è quello di produrre un __documento in linguaggio naturale__ presentante diversi scenari di sviluppo con soluzioni alternative, con una discussione sui trade-off in termini di benefici e costi attesi.

Più specificatamente, il documento include:
- uno studio di diversi scenari di realizzazione, scegliendo:
    - le architetture e l'hardware necessario;
    - se sviluppare in proprio oppure subappaltare ad altri.
- stima dei costi, tempi di sviluppo, risorse necessarie e benfici delle varie soluzioni.

È spesso difficile fare un'analisi approfondita, a causa del poco tempo disponibile o di costi troppo elevati: spesso viene commissionata esternamente.

### Analisi e specifica dei requisiti
L'analisi e specifica dei requisiti è l'attività più critica e fondamentale del processo di produzione del software.
L'obiettivo è la stesura di un ___documento di specifica___ <!-- ... -->.


In questa fase i progettisti devono:
- comprendere il __dominio applicativo__ del prodotto, dialogando con il cliente e la controparte tecnica;
- identificare gli __stakeholders__, ovvero tutte le figure interessate al progetto, e studiarne le richieste. Spesso non si tratta di figure omogenee (può essere il _top manager_ fino al segretario) e le loro necessità sono molto diverse;
- capire quali sono le __funzionalità richieste__: la domanda più importante che deve porsi il programmatore è il _cosa_ non il _come_; al cliente non devono infatti interessare gli aspetti tecnici e le scelte architetturali interne. Le __specifiche__ vanno quindi viste dal punto di vista del cliente.
- stabilire un __dizionario comune__ tra cliente e sviluppatore che può anche far parte della specifica per agevolare la comunicazione;
- definire __altre qualità__ eventualmente richieste dal cliente: per esempio, _"la centrale non deve esplodere"_ non è un dettaglio implementativo, ma un requisito. Queste ulteriori qualità, che non sempre sono solo esterne, si dicono __requisiti non funzionali__.

Lo scopo del _documento di specifica_ è duplice: da una parte, deve essere analizzato e approvato da __tutti gli stakeholders__ in modo da verificare il soddisfacimento delle aspettative del cliente, e dall'altra è usato dai programmatori per sviluppare una soluzione che le soddisfi, fungendo da punto di partenza per il design.
È un documento contrattuale e deve essere scritto in modo formale per evitare contestazioni contrattuali e ambiguità.

Deve essere presente anche un __piano di test__, ovvero una collezione di collaudi che certificano la correttezza del lavoro: se questi test hanno esito positivo il lavoro viene pagato, altrimenti il progetto non viene accettato. A differenza dei lavori di altri tipi di ingegneria, per esempio l'ingegneria civile, dove il collaudo è diretto, nell'ingegneria del software è molto difficile collaudare tutti i casi e gli stati possibili.

Un altro output di questa fase può essere anche il __manuale utente__, ovvero la _"vista esterna"_ (ciò che il cliente vuole vedere, evitando i dettagli implementativi) del sistema da progettare.

> __Legge di David__: Il valore dei modelli che rappresentano il software da diversi punti di vista dipendono dal punto di vista preso (assunto), ma non c'è nessuna vista che è la migliore per ogni scopo.

### Progettazione (design)
Il _design_ è l'attività attraverso la quale gli sviluppatori software strutturano l'applicazione a diversi livelli di dettaglio.
Lo scopo di questa fase è quello di scrivere un __documento di specifica di progetto__ contenente la descrizione dell'architettura software (i diversi linguaggi e viste). 

Durante questa fase occorre quindi:
- scegliere un'__architettura software di riferimento__;
- __scomporre__ in moduli o oggetti gli incarichi e i ruoli: si tratta del cosiddetto _object oriented design_, non necessariamente accompagnato da object oriented programming;
- __identificare i patterns__, ovvero problemi comuni a cui è già stata trovata una soluzione generale giudicata come _"bella"_ dalla comunità degli sviluppatori (ne vedremo un paio più avanti nel corso). I pattern favoriscono alcune qualità, come il design.

### Programmazione e test di unità
In questa fase le _"scatole nere"_ - i moduli o oggetti definiti al punto precedente - vengono realizzate e per ognuna di esse vengono definiti dei __test unitari__ che ne mostrano la correttezza.
Vi è infatti spesso la brutta abitudine di non fare il testing durante lo sviluppo di ciascun componente, ma solamente alla fine di tutto: questa usanza è molto pericolosa perché un problema scoperto solo alla fine è molto più oneroso da risolvere.

I singoli moduli vengono testati indipendentemente, anche se alcune funzioni da cui dipendono non sono ancora sono state implementate: per risolvere tale dipendenza si utilizzano allora moduli fittizzi (___stub___) che emulino le funzionalità di quelli mancanti.
Altri moduli, detti ___driver___, forniscono invece una situazione su cui applicare il modulo che sto testando.
Nei linguaggi più utilizzati esistono framework che facilitano le suddette operazioni al programmatore.

L'obiettivo di questa fase è avere un __insieme di moduli__ separati __sviluppati indipendentemente__ con un'interfaccia concordata e __singolarmente verificati__.

### Integrazione e test di sistema
In questa fase i moduli singolarmente implementati e testati vengono __integrati__ insieme a formare il software finito. In alcuni modelli di sviluppo (come nello sviluppo incrementale) questa fase viene accorpata alla precedente.

Nei test, i moduli _stub_ e _driver_ vengono sostituiti con i componenti reali formando un sistema sempre più grande fino ad ottenere il risultato richiesto.
È poi fondamentale testare che l'intero programma funzioni una volta assemblato (non basta che le singole parti funzionino!): test di questo tipo vengono detti __test di integrazione__. 

L'integrazione può essere adottata seguendo un approccio _top down_ o _bottom up_. La fase finale è l'___alpha testing___, ovvero il testing del sistema in condizioni realistiche.

### Consegna, installazione e manutenzione
Dopo aver completato lo sviluppo, il software deve essere __consegnato__ ai clienti. Prima di consegnarlo a tutti, si seleziona un gruppo di utenti per raccogliere ulteriore feedback; questa fase è chiamata ___beta testing___.

L'__installazione__ (deployment) definisce il _run-time_ fisico dell'architettura del sistema. Per esempio, un servizio di rete potrebbe necessitare di apparecchiatura server da installare e particolari configurazioni.

Infine, la __manutenzione__ può essere definita come l'insieme delle attività finalizzate a modificare il sistema dopo essere stato consegnato al cliente. La manutenzione può essere di tipo:
- __correttivo__: sistemare errori nel sistema;
- __adattivo__: adattare il software ai nuovi requisiti (vd. _evolvibilità_);
- __perfettivo__: migliorare certi aspetti interni al programma senza modificare gli aspetti esterni. Serve per migliorare la futura manutenzione riducendo il cosiddetto _debito tecnico_.

Come già detto, è necessario sviluppare avendo in mente la futura manutenzione di ciò che si sta scrivendo: infatti, il __costo__ della manutenzione concorre al costo del software in una misura spesso superiore al 60%.

L'_output_ di questa fase è un __prodotto migliore__.

### Altre attività
Alle attività sopracitate se ne aggiungono altre:
- __Documentazione__: può essere vista come attività trasversale. Per esempio, un documento di specificazione contenente diagrammi UML e una descrizione narrativa che spiega le motivazione dietro certe decisioni può essere il risultato principale della fase di progettazione.
È un'attività spesso da procastinare, perché le specifiche possono cambiare spesso. In alcuni gruppi esistono delle figure che si occupano di questa attività, anche se può essere pericoloso: non tutti possono capire ciò che un programmatore ha creato.
- __Verifica e controllo qualità__ (Quality Assurance): nella maggior parte dei casi, la verifica è svolta attraverso review e ispezioni. L'obiettivo è anticipare il prima possibile la scoperta e la sistemazione degli errori in modo da evitare di consegnare sistemi difettosi. Andrebbe fatta costantemente e non tutta alla fine.
- __Gestione del processo__: gestione incentivi (premi di produzione), responsabilità, formazione del personale, perfezionamento del processo con l'esperienza guadagnata, eccetera. 
- __Gestione delle configurazioni__: gestione delle relazioni inter-progettuali, ovvero delle risorse di sviluppo non appartenenti ad un singolo progetto. Un esempio potrebbe essere una libreria condivisa tra più progetti, i quali vorrebbero modificare la libreria stessa.

Tutte queste diverse attività saranno specificate successivamente entrando nel dettaglio.
