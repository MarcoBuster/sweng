---
layout: post
title: "[01] Introduzione"
date:   2022-10-03 14:30:00 +0200
author: "Marco Aceti"
toc: true
---

## Informazioni logistiche
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

### Esami
- __Laboratorio__
    - prova pratica di laboratorio di 4 ore
    - OPPURE _per chi segue tutti i laboratori_ ci saranno due laboratori valutati A COPPIE
- __Teoria__ 
    - prova orale
- Prima di fare l'orale bisogna fare il laboratorio
- La prova di laboratorio vale all'infinito

## Introduzione 

### Storia 
- Negli anni '50 e '60 si è colta la necessità di superare metodi di produzione artigianale. Il cliente e il programmatore coincidevano e i programmi erano prettamente matematici, ma comunque si vedevano i primi problemi.
- Negli anni '70, si iniziano a pensare a dei metodi, dei processi e a degli strumenti che potessero migliorare e ___"assicurare"___ la __qualità del software__.

### Approccio ingegneristico
1. __Target__
2. __Metric__: occorre definire una metrica per misurare la qualità del software.
3. __Method, Process, Tool__: quali metodi processi e strumenti bisogna applicare per arrivare all'obiettivo?
4. __Measurements__: si misura se le strategie implementate sono state utili e quanto ci hanno avvicinato (o allontanato) all'obiettivo. Ho due strade:
    - risultati soddisfacenti - ci sono dei miglioramenti
    - risultati insoddisfacenti - ci sono dei peggioramenti o dei forti effetti collaterali

Ma __quale è il target__? Mi chiedo le seguenti domande:
- Quali problemi ci sono?
- Quali qualità ha il software?

#### Problemi principali
- Di solito il problema più grande sono le __persone__. Il programmatore non è il cliente e questo crea __problemi di comunicazione__. 
    - Il cliente e il programmatore sono esperti di domini diversi: l'informatico è esperto di informatica, ma il cliente può essere esperto di altri campi (come biologia, finanza, ecc...).
    - Ci sono anche problemi di comunicazione tra sviluppatori. 
- Ci sono problemi anche di __dimensioni__ del software. Alcuni sono fatti da milioni di righe di codice e migliaia di _'anni uomo'_ investiti. Lo sviluppo software non è più una cosa piccola. 
- La __malleabilità__ del software porta al moltiplicarsi di versioni e evoluzioni.

#### Processo di sviluppo di un software
- Un buon processo produce un prodotto di qualità.

Quali sono le _qualità_ a cui miriamo nel software?
- Il software deve __funzionare__.
    - Se fa quello che è stato chiesto (rispetta le specifiche) allora è __corretto__.
        - I __requesiti__ sono quello che il cliente vuole. Spesso sono cambiati in corso d'opera oppure sono espressi in modo sbagliato. È necessaria un'interazione continua. 
        - Le __specifiche__ sono ciò che è stato formalizzato.
        > __Prima legge di R.Glass__. Requirements deficiences are the _prime source_ of project failures.
    - Mi devo _poter fidare_: deve essere __affidabile__.
    - Non deve fare male: deve essere __innocuo__ (safety) e __robusto__ anche per requisiti non espressamente richiesti. 
- Il software deve essere __bello__. Cosa vuol dire bello?
    - Facile da usare (__usabilità__). 
        > __Legge di Nielsen-Norman__. Usability is quantifiable
        - Si possono fare degli esperimenti (le grandi aziende lo fanno) per testare e quantificare l'usabilità del software, con degli umani. Alcune metriche possono essere il tempo per svolgere un task, la frequenza di errori, ecc...
    - Veloce (__efficienza nell'uso delle risorse__). Deve essere efficiente nello spazio e nel tempo (e anche in altre dimensioni).
    - Pulito (__verificabilità__). Deve essere leggibile, rendendo semplice dimostrare che il software è corretto.
- Il software deve ___"farmi diventare ricco"___. 
    - Non rifare cose già fatte (__riusabilità__). È meglio _"non reinventare la ruota"_ e riutilizzare componenti. 
        > __Legge di McIlroy__. Software reuse reduces cycle time and increases productivity and quality.
        - Non è sempre conveniente, bisogna sempre controllare la correttezza.
    - Semplificare gli interventi post consegna (__manutenibilità__). La manutenzione è qualunque intervento dopo aver consegnato il software. Gli interventi possono essere di diverso tipo:
        - correzione degli errori (__riparabilità__);
        - estensione dei requisiti, nuove situazioni (__evolvibilità__).
        - > __Leggi di M. Lehman__. A system that is used will be changed. An evolving system increases its complexity unless work is done to reduce it.

### Processo di qualità
Quali caretteristiche ha un processo di qualità?
- Deve resistere agli imprevisti (__robustezza__). Se un programmatore manca, gli altri possono sopperire oppure la conoscenza è centralizzata in solo una o poche persone? 
    - Ci sono delle certificazioni che misurano la robustezza di alcuni processi aziendali. Vengono considerate per esempio nei bandi pubblici.
- Deve essere veloce (__produttività__). È una metrica difficile da misurare; si può erroneamente fare contando il numero di codice o la quantità di _mesi uomo_ (ci sono attività non parallelizzabili - come la gravidanza).
- Cogliere l'attimo (__tempismo__). Una strategia di marketing è creare _"hype"_ attorno al software, nonostante in mano si ha solo una parte o proprio niente (_vaporware_). Consegnare man mano è spesso conveniente per _"far abituare"_ il cliente al software.

## Il processo di produzione del software
Inanzitutto occorre riconoscere che:
- produrre software __non è _solo_ scrivere codice__ (alla Programmazione I);
- bisogna riconscere i __problemi di comunicazione__;
- bisogna essere __rigorosi__;
    > __Ipotesi di Bauer-Zemanek__: Formal methods significantly reduce design errors, or eliminate them early.
- ci sono __tanti aspetti__ da considerare, uno alla volta. Per parlare di aspetti diversi ho bisogno di metodi comunicazione diversi, anche interessando ruoli diversi in tempi diversi (__Aspected Oriented Programming__).

Per modellare un ciclo di vita del software, devo:
- identificare i vari passi e le attività necessarie, considerando anche
    - 
??? DA INTEGRARE

### Studio di fattibilità
- È una definizione preliminare del problema, considerando anche il mercato e i concorrenti.
- Occore studiare i diversi scenari di realizzazione, scegliendo:
    - le architetture e l'hardware necessario;
    - se sviluppare in proprio oppure subappaltare ad altri.
- Stima dei costi, tempi di sviluppo, risorse necessarie e benfici delle varie soluzioni.
- Spesso è difficile fare un'analisi approfondita:
    - il committente spesso è esterno
    - si hanno dei limiti di tempo stringenti
- L'__output__ dello studio di fattibilità è un documento in linguaggio naturale.

### Analisi e specifica dei requisiti
- Questa fase serve per __comprendere__ meglio il __dominio applicativo__.
- Identificare gli __stakeholders__ (tutte le figure interessate al progetto).
- Capire quali sono le funzionalità richieste. 
    - La domanda da chiedere è il __COSA__, non il __COME__. Al cliente non interessano i componenti o i lati architetturali del programmatore.
- Le specifiche sono quindi dal __punto di vista del cliente__ al quale non interessano i dettagli implementativi.
- Definire quali __altre qualità__ sono richieste (_"la centrale non deve esplodere"_ non è un dettaglio implementativo, è un requisito).
- Stabilire un __dizionario comune__ può far parte della specifica.
- L'__output__ è un _documento di specifica_, che è:
    - un documento contrattuale approvato dal committente;
    - la base per il lavoro di design e verifica;
    - importante sia un documento formale per evitare contestazioni contrattuali e ambiguità.
- Un altro output può essere anche il __manuale utente__. 
- Nel documento di specifica deve essere presente anche un __piano di test__, una collezione di collaudi che certificano la correttezza. A differenza di lavori di ingegneria civile dove il collaudo è straight-forward (un ponte che può reggere 10 tonnellate ne regge anche 5) nell'ingegneria del software è molto difficile collaudare tutti i casi.

> __Legge di David__: The value of models depends on the view taken, but none is best for all purposes.

### Progettazione (Design)
- Risponde alla seguente domanda: come i requisiti precedentemente trovati possono essere realizzati in maniera opportuna?
- Si definisce l'architettura del sistema:
    - scelta di un'architettura software di riferimento;
    - scomposizione in moduli o oggetti: object oriented design, non necessariamente object oriented programming;
    - identificazione di patterns: soluzioni "belle" per problemi ricorrenti.
- __Output__: documento di specifica del progetto. ??? ALTRO 

### Programmazione e test di unità
- Le _scatole nere_ definite al punto precedente vengono effettivamente realizzate.
- I singoli modi vengono testati indipendentemente. Si utilizzano dei framework per il test con:
    - moduli stub: moduli fitizzi che _mockano_ altri moduli non ancora implementati;
    - moduli driver: ???.
- __Output__: un insieme di moduli separati sviluppati indipendentemente con un'interfaccia concordata e singolarmente verificati.

### Integrazione e test di sistema
- Vengono uniti i vari componenti
- Ottengo il __test di integrazione__:  ?????????????????

### Manutenzione
- Ci sono diversi tipi di manutenzione:
    - __Correttiva__
    - __Adattiva__
    - __Perfettiva__: migliorare certi componenti senza modificare aspetti esterni ma migliorando aspetti interni al programma. Serve per migliorare in futuro. 
- __Output__: un prodotto migliore

### Altre attività
- __Documentazione__: può essere vista come attività trasversale; di solito è un'attività snobbata e procastinata, anche perché le specifiche cambiano. 
- __Verifica e controllo qualità__
- __Gestione del processo__: gestione incentivi (premi di produzione), responsabilità, eccezioni. 
- __Gestione delle configurazioni__: relazioni inter-progettuali. Ci potrebbero essere parti di libreria condivise tra più progetti e sono da gestire.
