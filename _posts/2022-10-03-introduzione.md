---
layout: post
title: "Introduzione"
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
        - > __Prima legge di R.Glass__. Requirements deficiences are the _prime source_ of project failures.
    - Mi devo _poter fidare_: deve essere __affidabile__.
    - Non deve fare male: deve essere __innocuo__ (safety) e __robusto__ anche per requisiti non espressamente richiesti. 
- Il software deve essere __bello__. Cosa vuol dire bello?
    - Facile da usare (__usabilità__). 
        - > __Legge di Nielsen-Norman__. Usability is quantifiable
        - Si possono fare degli esperimenti (le grandi aziende lo fanno) per testare e quantificare l'usabilità del software, con degli umani. Alcune metriche possono essere il tempo per svolgere un task, la frequenza di errori, ecc...
    - Veloce (__efficienza nell'uso delle risorse__). Deve essere efficiente nello spazio e nel tempo (e anche in altre dimensioni).
    - Pulito (__verificabilità__). Deve essere leggibile, rendendo semplice dimostrare che il software è corretto.
- Il software deve ___"farmi diventare ricco"___. 
    - Non rifare cose già fatte (__riusabilità__). È meglio _"non reinventare la ruota"_ e riutilizzare componenti. 
        - > __Legge di McIlroy__. Software reuse reduces cycle time and increases productivity and quality.
        - Non è sempre conveniente, bisogna sempre controllare la correttezza.
    - Semplificare gli interventi post consegna (__manutenibilità__). La manutenzione è qualunque intervento dopo aver consegnato il software. Gli interventi possono essere di diverso tipo:
        - correzione degli errori (__riparabilità__);
        - estensione dei requisiti, nuove situazioni (__evolvibilità__).
        - > __Leggi di M. Lehman__. A system that is used will be changed. An evolving system increases its complexity unless work is done to reduce it.
