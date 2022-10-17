---
layout: post
title: "[04] Open source"
date: 2022-10-12 14:40:00 +0200
toc: true
---
# Open source

## Cattedrale e bazaar
__The Cathedral and the Bazaar (Raymond)__

> Every good work of software starts by scratching a developer's personal itch.

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

## Confronto

...

## An empirical study of open-source and closed-source software products

È stato fatto uno studio che confronta progetti open e closed. 
Copiare tabelllina nel paper.

## Sfide che si amplificano
L'integrazione del software, nel modello a cascata era una fase circoscritta e a sé stante.

Microsoft ha ipotizzato uno schema che sembra molto innovativo: _Stabylize & Synchronize_.
Durante il giorno ci sono gli sviluppatori che lavorano sul proprio pezzo di codice in cui erano responsabile; ogni notte il software veniva quindi ricompilato da zero. 
La mattina dopo se la compilazione falliva si trovava il responsabile e lo si puniva.
Altrimenti, ogni giorno avevano la "versione migliore possibile" di Windows.

Nel modello XP l'integrazione viene eseguita più volte al giorno, escludendosi a vicenda (solo un accesso alla macchina per volta).

Nell'open source l'integrazione viene eseguita continuamente e senza coordinazione a priori.

### Team
Nell'open source, inoltre, ci sono problemi con il team.
Bisogna decidere come comunicare, come tenersi uniti, come coordinarsi e anche come ottenere nuove collaborazioni.

Ci sono degli strumenti di supporto che vengono utilizzati.

Per la comunicazione c'è:
- in generale internet
- forum, per tenere la community unita e rispondere dubbi ai nuovi utenti

Inoltre, ci sono strumenti per la sincronizzazione del lavoro e di versioning per codice e documentazione.

Automatizzazione della build: deve essere facile (addirittura banale) poter compilare il codice e ricreare l'ambiente di sviluppo omogeneo per tutti. 

Bug tracking: è importante 'educare' il reporter dei bug e avere un sistema e un posto accessibile a tutti per vedere se sono state già inviate, e per organizzarle.
Anche la segnalazione d'errore avrà il suo "ciclo di vita". 



