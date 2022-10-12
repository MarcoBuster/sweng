---
layout: post
title: "[03] eXtreme programming 2"
date: 2022-10-12 14:40:00 +0200
toc: true
---

# Tecnice XP (continuo)

## 8. Proprietà collettiva

Il codice non appartiene a una persona sola, ma al team: tutti sono responsabili di tutto il codice e tutti possono modificare tutto.

Aiuta il refactoring: più punti di vista possono portare valore.

## 9. Integrazione continua

Dall'integrazione saltano fuori dei problemi non visibili durante lo sviluppo del componente singolo. 
È quindi cruciale integrare un pezzo alla volta per limitare la "zona da guardare" in caso salti fuori un problema imprevisto.

Nel caso di XP l'integrazione è così frequente e immersa nello sviluppo quotidiano che ogni volta che sviluppo una piccola feature è mio compito integrarla nella macchina di riferimento.
L'accesso alla macchina è esclusivo: ci si accede tramite un _token_ (fisico o virtuale). 

Finché il componente non è integrato in maniera funzionante con il resto del lavoro allora non si può dire che è stato completato.

Integrare frequentemente riduce la probabilità di compiere errori di integrazione.

## 10. Settimana di 40 ore

Darsi dei limiti al lavoro permette il riposo, che aumenta la produttività e riduce il turnover.

È importante avere un ritmo __sostenibile__ di produttività e sviluppo.

## 11. Cliente sul posto

La specifica può rimanere "leggera" perché in caso di dubbi è possibile parlare al cliente, che ha come priorità rispondere a noi ed è fisciamente presente con il team di sviluppo.

Il cliente è rappresentativo di tutti gli stakeholder? Per funzionare il cliente deve essere una persona responsabile o comunque importante.

In caso questa possibilità non sia possibile si introduce la figura del _Product Owner_, ovvero il membro del team che si impersona nel cliente e prende le decisioni per lui. 
In caso di dubbi si interfaccia lui al cliente.

## 12. Standard di codifica

È importante che siano istituite degli standard che definiscono lo stile del codice. 
Ci sono dei tool automatici che controllano che il codice rispetti gli standard automaticamente. 

## 13. Just rules

Tutte le regole __decise a livello di team__ vanno seguite: si può decidere di non seguire qualche regola, ma deve essere una decisione di team non di singolo o coppia.

Ogni tanto si fanno le __restrospettive__ in cui si può parlare dei problemi e mettere in discussione le regole.

# Altre cose di XP

## Raggruppamento per fasi

Possiamo raggruppare le tecniche nelle fasi classiche.

- __Requirements__:
    - gli utenti fanno parte del team di sviluppo;
    - consegne incrementali e pianificazioni continue.
- __Design__:
    - una metafora come visione unificante di un progetto;
    - refactoring;
    - presumere la semplicità.
- __Code__:
    - programmazione a coppie;
    - proprietà collettiva;
    - integrazioni continue;
    - standard di codifica.
- __Test__:
    - testing di unità continuo (da scriversi prima del codice);
    - test funzionale scritto dagli utenti.

Un bel sito: [http://extremeprogramming.org](http://extremeprogramming.org).

## Documentazione

Nel manifesto Agile c'è una dichiarazione forte: meglio il software funzionante che la documentazione.

La documentazione è...
- nel codice: 
    - gli standard di codifica permettono una maggiore leggibilità: non devo avere bisogno di scrivere i commenti; se ho sentito il bisogno di scrivere un commento per spiegare il codice, forse si dovrebbe cambiare il codice.
    - nei test unità
- nelle persone
    - nel cliente
    - il compagno di pair programming

### CRC Card
Le carte Class Responsibility Collaboration (CRC) sono un modo per comunicare per risolvere un problema temporaneo o chiarire un'idea, quindi non sono da mantenere fino alla fine. 
È peggio avere documentazione non aggiornata che non averla proprio.

## Quando non si può usare XP

Quando ci sono ostacoli a una delle 12 pratiche non si può usare. 
Per esempio, ci possono essere:
- barriere architettoniche/fisico/logistiche: team distanti che non possono stare nello stesso posto
- barriere manageriali o burocratici: team troppo numeroso o necessità di documentazione per certificazioni
- barriere tecnologiche: quando non è possibile avere feedback rapido 
- quando ci sono troppi stakeholders diversi in constrasto fra di loro
- meccanismi in cui la consegna incrementale non ha senso (_"Consegna o ti rovino la vita"_)

## Difetti di XP

- Sottovalutazione up-front: l'up front significa pensare al design prima di iniziare. Gli sviluppatori devono essere anche dei buoni progettisti.
- Sopravvalutazione user stories: possibile ambiguità
- Mancata evidenziazione dipendenze tra user stories: le user stories sono presentate come dipendenti, anche se potrebbero non esserlo
- TDD può portare a una visione troppo ristretta
- Cross functional teams: quando i team sono molto disomogenei ci possono essere problemi; per XP nessuno è indispensanbile e tutti possono sostituire tutti. 

### Mesi/uomo: produttività, stime, costi, velocità

Se il team è più grande di 8/10 persone l'overhead della comunicazione diventa troppo alto e Agile non funziona più.

# Open surs

## Cattedrale e bazaar
__The Cathedral and the Bazaar (Raymond)__
> Ogni buon lavoro software inizia dalla frenesia personale di uno sviluppatore

Chiede ad amici o colleghi cosa sono sull'argomento.

Si cercano pareri..

Le persone interessate che intendono spendere delle risorse (il proprio tempo libero) danno via a un progetto informale.

Un progetto open source nasce quando viene messo a disposizione il codice. 
È più facile coinvolgere più persone se il progetto pubblicato presenta errori, perché la comunità vorrà sistemare gli errori. 

I membri del progetto lavorano al problema fino a che non raggiungono dei risultati presentabili.
Ci deve essere interazione tra vecchi e nuovi membri del gruppo.

### Frasi dal libro

> Se dai a tutti il codice sorgente, ognuno di essi diventa un tuo ingegnere

...

> Se ci sono abbastanza occhi [che cercano errori], gli errori diventano di poco conto

...

> Se tratti i tuoi beta-tester come se fossero la tua risorsa più importante, essi risponderanno diventando la tua risorsa più importante

...

> Quando hai perso interesse in un programma, l'ultimo tuo dovere è passarlo a un successore competente

...

### tabella

mettere tabella roba con traditional / agile / open source / commento.

## Care and Feeding of FOSS

Questa è la fase delle idee nel mondo FOSS:

1. __Invention__: qualcuno ha un'idea e la implementa facendola funzionare;
2. __Expansion and Innovation__: il mondo si accorge dell'invenzione e la tecnologia inizia a espandersi;
3. __Consolidation__: alcuni progetti iniziano ad uscire fuori dominando gli altri. Alcuni progetti vengono assorbiti da altri o falliscono;
4. __Maturity__: il mercato si riduce a solo un piccolo insieme di prodotti. È difficile o impossibile entrare nel mercato. In questa fase le specifiche dell'idea sono chiare;
5. __FOSS Domination__: il prodotto opensource raggiunge / sorpassa e diventa dominante nel mercato;
6. __The FOSS era__: _"alla fine ci sarà solo il mondo open source"_.

## The Emerging Economic Paradigm Of Open Source

Perché le ditte pagano per l'open source? 

Ci sono diverse ditte in cui il software non è il prodotto, ma una __tecnologia abilitante essenziale__.

È importante dal punto di vista economico distinguire i casi di tecnologia __differenziante__ o __non differenziante__:
- il cliente si accorge degli effetti del software? Per esempio, le persone si accorge dell'esistenza del sistema di raccomandazione dei libri di Amazon
- i competitor hanno accesso allo stesso software? Se Amazon usa il sistema di raccomandazione venduto anche a Feltrinelli allora non conviene.

Se la risposta a una delle due domande è no, perché dovrei tenermi il software per me? Renderlo open source sparpaglia i costi. L'open source porta valore.
