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
- Negli anni '50 e '60 si è colta la necessità di superare metodi di produzione artigianale. Il cliente e il programmatore coincidevano e i programmi erano prettamente matematici, ma comunque si vedevano i primi problemi.
- Negli anni '70, si iniziano a pensare a dei metodi, dei processi e a degli strumenti che potessero migliorare e ___"assicurare"___ la __qualità del software__.

## Approccio ingegneristico
1. __Target__: obbiettivo da raggiungere.
2. __Metric__: occorre definire una metrica per misurare la qualità del software.
3. __Method, Process, Tool__: quali metodi processi e strumenti bisogna applicare per arrivare all'obiettivo?
4. __Measurements__: si misura se le strategie implementate sono state utili e quanto ci hanno avvicinato (o allontanato) all'obiettivo. Ho due strade:
    - risultati soddisfacenti - se i risultati sono buoni possiamo accettare ciò che è stato fatto.
    - risultati insoddisfacenti - ci sono dei peggioramenti o dei forti effetti collaterali, di conseguenza bisogna modificare il lavoro fatto.

Ma __quale è il target__? Mi chiedo le seguenti domande:
- Quali problemi ci sono?
- Quali qualità ha il software?

### Problemi principali
- Di solito il problema più grande sono le __persone__. Il programmatore non è il cliente e questo crea __problemi di comunicazione__. 
    - Il cliente e il programmatore sono esperti di domini diversi: l'informatico è esperto di informatica, ma il cliente può essere esperto di altri campi (come biologia, finanza, ecc...).
    - Ci sono anche problemi di comunicazione tra sviluppatori. 
- Ci sono problemi anche di __dimensioni__ del software. Alcuni sono fatti da milioni di righe di codice e migliaia di _'anni uomo'_ (somma del tempo impiegato da tutte le persone che lavorano al progetto) investiti. Lo sviluppo software non è più una cosa piccola. 
- La __malleabilità__ del software porta al moltiplicarsi di versioni e evoluzioni, siccome il target può variare nel tempo.

### Requisiti e specifiche
- I __requesiti__ sono quello che il cliente vuole. Spesso sono cambiati in corso d'opera oppure sono espressi in modo sbagliato. È necessaria un'interazione continua. 
- Le __specifiche__ sono ciò che è stato formalizzato dal programmatore (se i requisiti sono stati espressi in modo non corretto anche le specifiche risulteranno inesatte).

# Qualità

Le qualità del prodotto si dividono in due tipi:
- __qualità esterne__: qualità che vengono colte dal cliente;
- __qualità interne__: qualità che vengono esclusivamente colte dallo sviluppatore.

Le qualità interne influenzano molto le qualità esterne (per esempio se ho un codice ottimizzato ed efficiente, il mio software produrrà i risultati più velocemente).

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
            Un software è corretto se soddisfa la specifica dei suoi <i>requisiti funzionali</i>.
        </td>
    </tr>
    <tr>
        <th>Affidabilità</th>
        <td>
            È molto difficile perseverare la correttezza, in quanto è una proprietà assoluta e <i>"matematica"</i>.
            L'affidabilità è invece relativa: un software può essere affidabile (o <i>dependable</i>)
            nonostante contenga pochi errori.
        </td>
    </tr>
    <tr>
        <th>Robustezza</th>
        <td>
            Un software è robusto se si comporta in modo accettabile anche in circostanze non previste nella specifica dei requisiti.
        </td>
    </tr>
    <tr>
        <th rowspan="3"><i>Essere bello</i></th>
        <th>Usabilità</th>
        <td>
            Un software è usabile (o <i>user-friendly</i>) se i suoi utenti lo ritengono facile da utilizzare.
            Si possono fare degli esperimenti (le grandi aziende lo fanno) per testare e quantificare l’usabilità del software, con degli umani.
        </td>
    </tr>
    <tr>
        <th>Prestazioni</th>
        <td>
            Ad ogni software è richiesto un certo livello di prestazioni. L'efficienza è una qualità interna e misura come il software utilizza le risorse del computer. La performance d'altro canto è invece una qualità esterna ed è basata sui requisiti dell'utente. La performance ha effetto sull'usabilità.
        </td>
    </tr>
    <tr>
        <th>Verificabilità</th>
        <td>
            Un software è verificabile se le sue proprietà sono verificabili facilmente. La verifica può essere fatta con metodi formali o informali, come il testing.
        </td>
    </tr>
    <tr>
        <th rowspan="2"><i>Farmi diventare ricco</i></th>
        <th>Riusabilità</th>
        <td>
            Con la proprietà di riusabilità, utilizziamo un prodotto per costruire - anche con modifiche minori - un altro prodotto.
        </td>
    </tr>
    <tr>
        <th>Manutenibilità</th>
        <td>
            Per <i>manutenzione software</i> si intendono tutte le modifiche apportate al software dopo il rilascio iniziale.
            Questa proprietà può essere vista come due proprietà separate:
            <ul style="margin-bottom: 0;">
                <li><b>Riparabilità</b>: un software è riparabile se i suoi difetti possono essere corretti con una quantità di lavoro ragionevole.</li>
                <li><b>Evolvibilità</b>: indica la capacità del software di poter evolvere aggiugendo funzionalità. È importante considerare questo aspetto fin dall'inizio: studi rilevano come l'evolvibilità decresce con il passare delle release.</li>
            </ul>
        </td>
    </tr>
</tbody>
</table>

#### Leggi rilevanti

__Prima legge di R.Glass__. 
> La mancanza di requisiti è la prima causa del fallimento di un progetto.

__Legge di Nielsen-Norman__. 
> L'usabilità è misurabile.

__Legge di McIlroy__. 
> Riutilizzare il software permette di incrementare la produttività e la qualità.

__Leggi di M. Lehman__. 
> Un sistema che viene utilizzato cambierà. 

> Un sistema che evolve incrementa la sua complessita a meno che non evolva appositamente per ridurla.

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
            Un processo deve poter resistere agli imprevisti, come la mancanza improvvisa di personale o al cambiamento delle specifiche.
            Esistono certificazioni (**CMM: Capability Maturity Model**) che valutano la robustezza di alcuni processi aziendali; vengono per esempio considerate nei bandi pubblici.
        </td>
    </tr>
    <tr>
        <th rowspan="1"><i>Essere bello</i></th>
        <th>Produttività</th>
        <td markdown="span">
            La produttività di un team è molto meno della somma della produttività individuale dei suoi componenti. È una metrica difficile da misurare: conteggi come il numero di linee codice o la quantità di _tempo-uomo_ non sono buoni; per esempio, la gravidanza umana non è un'attività parallelizzabile.
        </td>
    </tr>
    <tr>
        <th rowspan="1"><i>Farmi diventare ricco</i></th>
        <th>Tempismo</th>
        <td markdown="span">
            Un processo deve consegnare il prodotto nei tempi stabiliti, in modo da rispettare i tempi del mercato. È spesso conveniente la tecnica dello *sviluppo incrementale*, ovvero la consegna frequente di parti sempre più grandi del prodotto (esempio: compilatore ADA). 
        </td>
    </tr>
</tbody>
</table>

# Il processo di produzione del software
Il processo che seguiamo per costruire, consegnare, installare ed evolvere il prodotto software, dall'idea fino alla consegna e al ritiro finale del sistema, è chiamato __processo di produzione software__.

Inanzitutto occorre riconoscere diverse problematiche.
- I __requisiti__ possono cambiare spesso.
- Produrre software __non è _solo_ scrivere codice__ (alla Programmazione I).
- Bisogna risolvere i __problemi di comunicazione__ tra tutte le diverse figure in gioco (tra sviluppatori, tra progettista e sviluppatori, ecc).
- Bisogna essere __rigorosi__, anche se può essere difficile. Ci sono lati positivi e negativi: la rigorisità può facilitare la comprensione di ciò che bisogna fare ma essere rigorosi implica molta fatica, e viceversa.
    > __Ipotesi di Bauer-Zemanek__: Metodi formali riducono in maniera significativa gli errori di progettazione, oppure permettono di eliminarli e risolverli prima.
    
    Trovare gli errori prima della fase di sviluppo permette di facilitarne la risoluzione e di risparmiare sia tempo che soldi.
- Ci sono __tanti aspetti__ da considerare, uno alla volta. Per parlare di aspetti diversi ho bisogno di metodi comunicazione diversi, che interessano ruoli diversi in tempi diversi (__Aspected Oriented Programming__).

Per modellare un ciclo di vita del software, devo:
- __identificare le varie attività necessarie__ e quindi:
    - deciderne le precedenze temporali;
    - chi le deve fare.
- bisogna porsi due domande:
    - cosa devo fare adesso?
    - fino a quando?

Rispondere a queste domande in determinati momenti ci permette di definire i vari modelli di ciclo di vita del software. (non molto chiara questa parte, sistemare con gli altri).

## Il modello _code-and-fix_
Inizialmente, nell'ambito dello sviluppo software è stato adottato il modello _code-and-fix_ che consisteva nei seguenti passi:
1. scrivi il codice;
2. sistemalo per eliminare errori, migliorare funzionalità o aggiungere nuove funzionalità.

Questo modello è risultato pesantemente inefficace in gruppi di lavoro complessi, specialmente qunado il cliente non era più lo sviluppatore stesso ma utenti con poca dimestichezza con i computer.

## Le fasi del ciclo di vita del software

### Studio di fattibilità
Lo studio di fattibilità è l'attività volta prima che il processo di sviluppo inizi, per decidere se dovrebbe iniziare _in toto_.
L'__obiettivo__ è quello di produrre un __documento in linguaggio naturale__ presentante diversi scenari con soluzioni alternative, con una discussione sui trade-off in termini di benefici e costi attesi.

Più specificatamente, il documento include:
- uno studio di diversi scenari di realizzazione, scegliendo:
    - le architetture e l'hardware necessario;
    - se sviluppare in proprio oppure subappaltare ad altri.
- stima dei costi, tempi di sviluppo, risorse necessarie e benfici delle varie soluzioni.

È spesso difficile fare un'analisi approfondita, a causa del poco tempo o di costi troppo elevati: spesso viene commissionata esternamente.

### Analisi e specifica dei requisiti
L'analisi e specifica dei requisiti è l'attività più critica e fondamentale del processo di produzione del software.
L'obiettivo è la stesura di un ___documento di specifica___ <!-- ... -->.


In questa fase i progettisti devono:
- comprendere il __dominio applicativo__ del prodotto, dialogando con il cliente e la controparte tecnica;
- identificare gli __stakeholders__, ovvero tutte le figure interessate al progetto. Non sono figure omogenee, può essere il _top manager_ fino al segretario;
- capire quali sono le __funzionalità richieste__: la domanda più importante che deve porsi il programmatore è il _cosa_ non il _come_: al cliente non interessano gli aspetti tecnici e le scelte architetturali interne del programmatore. Le __specifiche__ vanno quindi viste dal punto di vista del cliente.
- stabilire un __dizionario comune__ tra cliente e sviluppatore che può anche far parte della specifica;
- definire __altre qualità__ eventualmente richieste: per esempio, _"la centrale non deve esplodere_ non è un dettaglio implementativo, ma un requisito. Queste altre qualità si dicono __requisiti non funzionali__.

Lo scopo del _documento di specifica_ è duplice: da una parte, deve essere analizzato e approvato da __tutti gli stakeholders__ in modo da verificare il soddisfacimento delle aspettative del cliente e dall'altra è usato dai programmatori per sviluppare una soluzione che le soddisfi.
È un documento contrattuale e deve essere scritto formalmente per evitare contestazioni contrattuali e ambiguità.

Deve essere presente anche un __piano di test__, ovvero una collezione di collaudi che certificano la correttezza del lavoro: se questi test hanno esito positivo il lavoro viene pagato, altrimenti il progetto non viene accettato. A differenza dei lavori di ingegneria civile dove il collaudo è diretto, nell'ingegneria del software è molto difficile collaudare tutti i casi e gli stati possibili.

Un altro output di questa fase può essere anche il __manuale utente__, ovvero la _"vista esterna"_ (ciò che il cliente vuole vedere, evitando i dettagli implementativi) del sistema da progettare.

> __Legge di David__: Il valore dei modelli che rappresentano il software da diversi punti di vista dipendono dal punto di vista preso (assunto) ma non c'è nussuna vista che è la migliore per un unico scopo.

### Progettazione (design)
Il _design_ è l'attività attraverso la quale gli sviluppatore software strutturano l'applicazione a diversi livelli di dettaglio.
Lo scopo di questa fase è quello di scrivere un __documento di specifica di progetto__ contenente la descrizione dell'architettura software (i divesri linguaggi e viste). 

Durante questa fase occorre quindi:
- scegliere un'__architettura software di riferimento__;
- __scomporre__ in moduli o oggetti gli incarichi e i ruoli: _object oriented design_, non necessariamente object oriented programming;
- __identificare i patterns__, ovvero problemi comuni a cui è già stata trovata una soluzione generale giudicata come _"bella"_ dalla comunità (e che verrà studiata più avanti nel corso). I pattern favoriscono alcune qualità, com il design.

### Programmazione e test di unità
In questa fase le _"scatole nere"_ - i moduli o oggetti definiti al punto precedente - vengono realizzate e per ognuna di esse vengono definiti dei __test unitari__ che ne mostrano la correttezza.
Non sempre il testing si fa durante lo sviluppo del componente, molte volte viene fatto alla fine. Questa usanza è pericolosa perché scoprire un problema alla fine è molto più oneroso da risolvere.

I singoli moduli vengono testati indipendentemente, anche se alcune funzioni da cui dipendono non sono ancora sono state implementate: una tecnica è usare moduli fittizzi (___stub___) che ne emulano le funzionalità.
I moduli ___driver___ invece forniscono una situazione su cui applicare il modulo che sto testando.
Nei linguaggi più utilizzati esistono framework che facilitano le suddette operazioni al programmatore.

L'obiettivo di questa fase è avere un __insieme di moduli__ separati __sviluppati indipendentemente__ con un'interfaccia concordata e __singolarmente verificati__.

### Integrazione e test di sistema
In questa fase i moduli singolarmente implementati e testati vengono __integrati__ insieme, che in alcuni modelli (come nello sviluppo incrementale) viene accorpata alla precedente.

Nei test, i moduli _stub_ e _driver_ vengono sostituiti con i componenti reali formando un sistema sempre più grande fino ad ottenere il risultato richiesto.
I test di questo tipo vengono detti __test di integrazione__. 

L'integrazione può essere adottata seguendo un approccio _top down_ o _bottom up_. La fase finale è l'___alpha testing___, ovvero il testing del sistema in condizioni realistiche.

### Consegna, installazione e manutenzione
Dopo aver completato lo sviluppo, il software deve essere __consegnato__ ai clienti. Prima di consegnarlo a tutti, si seleziona un gruppo di utenti per raccogliere ulteriore feedback; questa fase è chiamata ___beta testing___.

L'__installazione__ (deployment) definisce il _run-time_ fisico dell'architettura del sistema. Per esempio, un servizio di rete potrebbe necessitare di apparecchiatura server da installare e particolari configurazioni.

Infine, la __manutenzione__ può essere definita come l'insieme delle attività finalizzate a modificare il sistema dopo essere stato consegnato al cliente. La manutenzione può essere di tipo:
- __correttivo__: sistemare errori nel sistema;
- __adattivo__: vedere il concetto di _evolvibilità_.
- __perfettivo__: si tratta di migliorare certi aspetti interni al programma senza modificare gli aspetti esterni. Serve per migliorare la futura manutenzione riducendo il debito tecnico.

Il __costo__ della manutenzione concorre al costo del software in una misura spesso superiore al 60%.

L'_output_ di questa fase è un __prodotto migliore__.

### Altre attività
- __Documentazione__: può essere vista come attività trasversale. Per esempio, un documento di specificazione contenente diagrammi UML e una descrizione narrativa che spiega le motivazione dietro certe decisioni può essere il risultato principale della fase di progettazione.
È un'attività spesso procastina, perché le specifiche possono cambiare spesso. In alcuni gruppi esistono delle figure che si occupano di questa attività, anche se può essere pericoloso: non tutti possono capire ciò che il programmatore ha creato.
- __Verifica e controllo qualità__ (Quality Assurance): mella maggiorparte dei casi, la verifica è svolta attraverso review e ispezioni. L'obiettivo è anticipare il prima possibile la scoperta e la sistemazione degli errori in modo da evitare di consegnare sistemi difettosi. Andrebbe fatta costantemente e non tutta alla fine.
- __Gestione del processo__: gestione incentivi (premi di produzione), responsabilità, formazione del personale, eccetera. 
- __Gestione delle configurazioni__: relazioni inter-progettuali. Sono da gestire i casi in cui parti di libreria vengono condivise tra più progetti che vorrebbero modificare la libreria stessa.

Tutte queste diverse attività saranno specificate successivamente entrando nel dettaglio.
