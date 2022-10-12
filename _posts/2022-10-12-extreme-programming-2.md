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
