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

### Processo di sviluppo di un software
- Esiste la convinzione che un progetto è di qualità se segue a un buono processo.

Cosa significa di __qualità__?
- Il software deve __funzionare__.
    - Se fa quello che è stato chiesto (rispetta le specifiche) allora è __corretto__.
        - I __requesiti__ sono quello che il cliente vuole. Spesso sono cambiati in corso d'opera oppure sono espressi in modo sbagliato. È necessaria un'interazione continua. 
        - Le __specifiche__ sono ciò che è stato formalizzato dal programmatore (se i requisiti sono stati espressi in modo non corretto anche le specifiche risulteranno inesatte).
         > __Prima legge di R.Glass__. La mancanza di requisiti è la prima causa del fallimento di un progetto.
	- Mi devo _poter fidare_: il software deve essere __affidabile__.
    - Non deve fare male: deve essere __innocuo__ (safety) e __robusto__ anche per requisiti non espressamente richiesti. 
- Il software deve essere __bello__. Cosa vuol dire bello?
    - Facile da usare (__usabilità__). 
        > __Legge di Nielsen-Norman__. L'usabilità è misurabile.
        - Si possono fare degli esperimenti (le grandi aziende lo fanno) per testare e quantificare l'usabilità del software, con degli umani. Alcune metriche possono essere il tempo per svolgere un task, la frequenza di errori, ecc...
    - Veloce (__efficienza nell'uso delle risorse__). Deve essere efficiente nello spazio e nel tempo (e anche in altre dimensioni).
    - Pulito (__verificabilità__). Deve essere leggibile, rendendo semplice dimostrare che il software è corretto.
- Il software deve ___"farmi diventare ricco"___. 
    - Non rifare cose già fatte (__riusabilità__). È meglio _"non reinventare la ruota"_ e riutilizzare componenti, in questo modo è possibile evitare delle spese inutili. 
        > __Legge di McIlroy__. Riutilizzare il software permette di incrementare la produttività e la qualità.
        - È importante però _come_ viene riutilizzato il software, ne va comunque garantita la correttezza.
    - Semplificare gli interventi post consegna (__manutenibilità__). La manutenzione è qualunque intervento dopo aver consegnato il software. Gli interventi possono essere di diverso tipo:
        - correzione degli errori (__riparabilità__);
        - estensione dei requisiti, nuove situazioni (__evolvibilità__).
        - >__Leggi di M. Lehman__. Un sistema che viene utilizzato cambierà. Un sistema che evolve incrementa la sua complessita a meno che non evolva appositamente per ridurla.

Un software che possiede queste tre caratteristiche si dice di __qualità__.

Le qualità del prodotto si dividono in due tipi:
- __qualità esterne__: qualità che vengono colte dal cliente;
- __qualità interne__: qualità che vengono esclusivamente colte dallo sviluppatore.

Le qualità interne hanno un influenza sulle qualità esterne (per esempio se ho un codice ottimizzato ed efficiente, il mio software produrrà i risultati più velocemente).

Ciò che è stato appena descritto è la __qualità del prodotto__, esiste però anche la qualità del processo. 

## Qualità del processo
Sappiamo che il prodotto è influenzato dal processo che viene utilizzato per svilupparlo, di conseguenza possiamo parlare anche di  __qualità del processo__.

Anche un processo deve funzionare, essere essere bello e farmi diventare ricco, ma dobbiamo interpretare queste parole in maniera differente.

Quali caretteristiche ha un processo di qualità?
- [FUNZIONARE] Deve resistere agli imprevisti (__robustezza__). Se un programmatore manca, gli altri possono sopperire oppure la conoscenza è centralizzata in solo una o poche persone? oppure un altro imprevisto può essere anche il caso in cui le specifiche cambiano. 
    - Ci sono delle certificazioni che misurano la robustezza di alcuni processi aziendali (__CMM: Capability Maturity Model__). Vengono considerate per esempio nei bandi pubblici.
- [ESSERE BELLO] Deve essere veloce (__produttività__). È una metrica difficile da misurare; si può erroneamente fare contando il numero di linee di codice o la quantità di _mesi uomo_ (ci sono attività non parallelizzabili - come la gravidanza). Entrambe sono metriche pericolose, nel senso che non ci permettono di misurare effettivamente la produttività di un processo (la quantità di mesi uomo posso fornirla a posteriori, a lavoro finito, ma non a priori).
- [FARMI DIVENTARE RICCO] Cogliere l'attimo (__tempismo__). Ovvero il processo mi deve permettere di arrivare per primo sul mercato con un certo prodotto, in modo tale da essere il primo a rispondere ad una certa necessità. Una strategia di marketing è creare _"hype"_ attorno al software, nonostante in mano si ha solo una parte o proprio niente (_vaporware_). Consegnare man mano è spesso conveniente per _"far abituare"_ il cliente al software, queto modello di sviluppo è detto __incrementale__ (esempio: compilatore ADA). Cogliere l'attimo è molto difficile a causa dei frequenti cambi di requisiti.

# Il processo di produzione del software
Inanzitutto occorre riconoscere che:
- produrre software __non è _solo_ scrivere codice__ (alla Programmazione I);
- bisogna risolvere i __problemi di comunicazione__ tra tutte le diverse figure in gioco (tra sviluppatori, tra progettista e sviluppatori, ecc).
- bisogna essere __rigorosi__, anche se può essere difficile. Ci sono lati positivi e negativi: la rigorisità può facilitare la comprensione di ciò che bisogna fare ma essere rigorosi implica molta fatica, e viceversa.
    > __Ipotesi di Bauer-Zemanek__: Metodi formali riducono in maniera significativa gli errori di progettazione, oppure permettono di eliminarli e risolverli prima.
    
    trovare gli errori prima della fase di sviluppo permette di facilitarne la risoluzione e di risparmiare sia tempo che soldi.
- ci sono __tanti aspetti__ da considerare, uno alla volta. Per parlare di aspetti diversi ho bisogno di metodi comunicazione diversi, che interessano ruoli diversi in tempi diversi (__Aspected Oriented Programming__).

Per modellare un ciclo di vita del software, devo:
- identificare le varie attività necessarie, e successivamente un avolta definite occorre:
    - deciderne le precedenze temporali
    - chi le deve fare
- bisogna porsi due domande:
	- cosa devo fare adesso?
	- fino a quando?
rispondere a queste domande in determinati  momenti ci permette di definire i vari modelli di ciclo di vita del software. (non molto chiara questa parte, sistemare con gli altri)

## Studio di fattibilità
- Permette di definire meglio un problema, considerando anche il mercato e i concorrenti, oltre al fatto si essere in grado o meno di affrontare il problema.
- Occore studiare i diversi scenari di realizzazione, scegliendo:
    - le architetture e l'hardware necessario;
    - se sviluppare in proprio oppure subappaltare ad altri.
- Stima dei costi, tempi di sviluppo, risorse necessarie e benfici delle varie soluzioni.
- Spesso è difficile fare un'analisi approfondita, a causa del poco tempo o di costi troppo elevati, quindi:
    - spesso viene commissionata all'esterno.
    - si hanno dei limiti di tempo stringenti e quindi non è possibile fare un analisi approfondita
- L'__output__ dello studio di fattibilità è un documento in linguaggio naturale. questo documento che ti guida per capire se affrontare il progetto oppure no, e utilizzando quale approccio. (questo approccio è composto da scelte che nel tempo possono variare, siccome ciò si affronta in un momento iniziale della progettazione).

## Analisi e specifica dei requisiti
- Questa fase serve per __comprendere__ meglio il __dominio applicativo__ (dialogo tra cliente e controparte tecnica).
- Identificare gli __stakeholders__ (tutte le figure interessate al progetto, non sono figure omogenee, possono andare dal manager fino alla segretaria).
- Capire quali sono le funzionalità richieste. 
    - La domanda principare in questa fase dobbiamo capire __COSA__ ci viene chiesto, e non il __COME__. Al cliente non interessano i componenti o i lati architetturali del programmatore.
- Le specifiche sono quindi dal __punto di vista del cliente__ al quale non interessano i dettagli implementativi.
- Definire quali __altre qualità__ sono richieste (_"la centrale non deve esplodere"_ non è un dettaglio implementativo, è un requisito).
- Stabilire un __dizionario comune__ (tra cliente e sviluppatore) può far parte della specifica.
- L'__output__ è un _documento di specifica_, che è:
    - un documento contrattuale approvato dal committente;
    - la base, il punto di partenza per il lavoro di design e verifica;
    - importante sia un documento formale per evitare contestazioni contrattuali e ambiguità (questo costa però).
- Un altro output può essere anche il __manuale utente__, ovvero la vista esterna (di fatto ciò che il cliente vuole vedere alla fine, stando attenti a evitare dettagli implementativi) del sistema da progettare. 
- Nel documento di specifica deve essere presente anche un __piano di test__, una collezione di collaudi che certificano la correttezza (se ciò che è stato progettato passa questi test allora il lavoro viene pagato, altrimenti il progetto non viene accettato; infatti vengono chiamati anche test di accettazione). A differenza di lavori di ingegneria civile dove il collaudo è straight-forward (un ponte che può reggere 10 tonnellate ne regge anche 5, una cosa simile non è fattibile nell'ingegneria del software) nell'ingegneria del software è molto difficile collaudare tutti i casi.

> __Legge di David__: Il valore dei modelli che rappresentano il software da diversi punti di vista dipendono dal punto di vista preso (assunto) ma non c'è nussuna vista che è la migliore per un unico scopo.

## Progettazione (Design)
- Risponde alla seguente domanda: come le specifiche precedentemente trovate possano essere realizzate in maniera opportuna?
- Si definisce l'architettura del sistema:
    - scelta di un'__architettura software di riferimento__;
	- __scomposizione__ in moduli o oggetti quelli che sono gli incarichi: object oriented design, non necessariamente object oriented programming;
    - __identificazione di patterns__: problemi comuni a cui si trovata una soluzuine generale molto "bella", nel senso che valorizza certe qualità (ovviamente non tutte, come visto prima ci sono qualità non ottenibili se ce ne sono già presente altre, esempio: se il mio codice è ottimizzato magari ho dovuto renderlo illeggibile). i patterns scelgono appunto alcune qualità da favorire. qui stiamo parlando di riutilizzo di scelte di design.
- __Output__: documento di specifica del progetto con diversi linguaggi e con le diverse viste.

## Programmazione e test di unità
- Le _scatole nere_ (ovvero i moduli o oggetti definiti nella fase di progettazione) vengono effettivamente realizzate e testate in modo tale che si controlli la correttezza dei diversi componenti (test di unità del singolo componente). Non sempre il testing si fa durante lo sviluppo del componente, molte volte si testa tutto alla fine, ma è pericoloso perchè come detto prima scoprire un problema alla fine è più oneroso da risolvere. 
- I singoli moduli vengono testati indipendentemente anche se non è una cosa così immediata in quanto alcuni tipi di funzioni possono richiedere altre funzioni non ancora create (degli __stub__, cioè dei moduli fittizzi di cui componente testato necessita), oppure possono richiedere dei __driver__, ovvero delle situazioni su cui applicare il modulo che sto testando. Per esempio se bisogna testare una funzione di ordinamento si necessita di qualcosa da ordinare (driver) e magari deve utilizzare una funzione di ricerca non ancora creata (stub) per funzionare. Esistono dei framework che facilitano questa operazione aiutando il programmatore.
- __Output__: un insieme di moduli separati sviluppati indipendentemente con un'interfaccia concordata e singolarmente verificati.

## Integrazione e test di sistema
Questi moduli però devono riuscire a produrre un risultato sperato collaborando insieme, che non è sempre scontato, per fare ciò sostituisco stub e driver con componenti reali costituendo un sistema sempre più grande fino ad ottenere il risultato richiesto. Questi tipi di test sono chiamati __test di integrazione__.
Ci sono due approcci per farlo:
- top down
- bottom up

## Manutenzione
- Ci sono diversi tipi di manutenzione:
    - __Correttiva__
    - __Adattiva__: abbiamo visto prima la evolvibilità.
    - __Perfettiva__: migliorare certi componenti senza modificare aspetti esterni ma migliorando aspetti interni al programma. Serve per migliorare in futuro. 
- __Output__: un prodotto migliore

## Altre attività
- __Documentazione__: può essere vista come attività trasversale; di solito è un'attività snobbata e procastinata, anche perché le specifiche cambiano. Ci sono delle figure che si occupano di questo diverse dal programmatore, è pericoloso in quanto possono esserci problemi di comunicazione (l'addetto potrebbe non capire ciò che il programmatore ha creato). 
- __Verifica e controllo qualità__: anche questa pratica andrebbe fatta passo passo e non tutta alla fine.
- __Gestione del processo__: gestione incentivi (premi di produzione), responsabilità, formazione del personale, eccetera. 
- __Gestione delle configurazioni__: relazioni inter-progettuali. Ci potrebbero essere parti di libreria condivise tra più progetti che vorrebbero modificare la libreria stessa, e sono da gestire questi casi.

Tutte queste diverse attività saranno specificate successivamente entrando nel dettaglio.
