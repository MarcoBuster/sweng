---
layout: post
title: "[12] Modelli di ciclo di vita del software"
date:   2022-11-23 14:30:00 +0200
toc: true
---

# Verifica e Convalida

Verifica e convalida sono due termini con un significato apparentemente molto simile ma che celano in realtà una differenza non banale tra loro:

>Per _convalida_ intendiamo il confronto del software con i __requisiti__ (informali) posti dal committente

>Per _verifica_ intendiamo il confronto del software con le __specifiche__ (formali) prodotte dall'analista

Ci sono quindi due punti critici che vanno a sottolineare maggiormente questa differenza:

- Requisiti e specifiche sono spesso formulati in maniera diversa
    - Molto spesso i requisiti, essendo scritti dal committente, sono scritti in un linguaggio più vicino al dominio di quest'ultimo piuttosto che di uno sviluppatore. Diversamente, le specifiche sono scritte in un linguaggio più vicino al dominio dello sviluppatore, solitamente in maniera formale (ma non sempre), sicuramente in maniera poco ambigua

- I requisiti è facile che cambino, mentre le specifiche sono più congelate (dipende però molto dai contratti tra committente e team di sviluppo)

Più in generale, possiamo dire che se nella verifica la parte di formalizzazione è più difficile a favore di un'operazione di confronto con il test più semplice, per quanto riguarda la convalida è l'inverso (ovvero, non essendoci alcuna formalizzazione è tipicamente più difficile confrontare il proprio software direttamente con i requisiti del committente)





    

Abbiamo quindi bisogno di terminologia comune (Con lo stampino di IEEE):

## Malfunzionamento (o guasto/failure)

- Funzionamento non corretto di un programma
- è legato al FUNZIONAMENTO del programma: non al suo codice
    - Lo percepisco all’esterno: il risultato non corrisponde alle mie aspettative

## Difetto(anomalia/fault)

- è legato al codice ed è condizione necessaria (ma non sufficiente) perché si verifichi un malfunzionamento.

## Sbaglio (Mistake)

- è la causa di un’anomalia. In genera si tratta di un errore umano (concettuale, battitura, scara conoscenza del linguaggio…)
    - Esempio:
        - Errori di battitura (scrivere * invece di +)
        - Concettuale (non sapere cosa vuol dire raddoppiare)
        - Padronanza del linguaggio (Credere che * fosse il simbolo dell’addizione)
    

## Statico vs Dinamico

- Le tecniche statiche sono basate sull’ANALISI DEL CODICE
    - Modelli formali
    - Analisi del dataflow
    - Modelli statistici
    - In pratica andiamo ad analizzare il codice a priori
- Tecniche dinamiche sono basate sull’esecuzione del codice e dagli stati raggiungibili durante l’esecuzione
    - Testing
    - Debugging
    - Si cerca di provare tutti gli stati possibili
        - Ma questo a volte non è possibile perché il numero può esplodere

## CLASSIFICAZIONE delle tecniche

≤≤ Disegno di una piramide>>

## Metodi Formali

- Tecniche che si prefiggono di provare l’assenza di anomalie nel prodotto finale

Ad esempio:

- Analisi del dataflow
- Dimostrazione di correttezza delle specifiche logiche

***INACCURATEZZA PESSIMISTICA: se non si riesce a dimostrare l’assenza di un problema dico che non va bene***

## Testing

- Tecniche che si prefiggono di rilevare malfunzionamenti O fornire fiducia nel prodotto
    - **WhiteBox**
        - Posso testare vedendo il componente in maniera trasparente
    - **BlackBox**
        - Non posso testare vedendo il componente al suo interno. Vedo solo input e output.
    - **GrayBox**
        - Conosco ‘a metà’

***********************************************************************************************************************************************************************INACCURATEZZA OTTIMISTICA: se non si riescono a dimostrare la presenza di problemi dico che va bene***********************************************************************************************************************************************************************

## Debugging

- Tecniche che si prefiggono di localizzare le anomalie che causano malfunzionamenti rilevati in precedenza
    - Approccio incrementale: permette di limitare la parte in cui ricercare il difetto
    - Produzione degli stati intermedi dell’esecuzione del programma

# Correttezza di un programma

- Consideriamo un programma $P$ come una funzione da un insieme di dati $D$ (dominio) a un insieme di dati $R$ (codominio)
- $P(d)$ indica l’esecuzione di $P$ sul dato in ingresso $d \in D$
- $ok(P,D)$  indica la correttezza di $P$ per il dato $d$

$P$  è corretto $\iff$ [……]

Qui iniziamo con un po’ di formalità, recupera.

## Test ideale:

diciamo che un test è ideale sse il superamento del test implica la correttezza del programma.

**************************Generalmente è impossibile trovare un test ideale.**************************

### Tesi di Dijkstra

- Il test di un programma può rilevare la presenza di malfunzionamenti
- Non esiste un algoritmo che dato un programma arbitrario P generi un …………….

Dato che è improponibile eseguire esaustivamente tutti i test possibili, devo avere dei criteri di selezione dei test che spero approssimi il più possibile al test ideale

### Criterio affidabile

Si dice affidabile un criterio che se presi T1 e T2 in base al criterio C allora o hanno entrambi successo o nessuno dei due ha successo

### Criterio di validità

Un criterio C si dice valido se qualora P non sia corretto allora esiste almeno un T selezionato in base a C che ha successo per il programma P

**************************************************************************************************************************************************************Se un criterio è valido e affidabile allora se un test appartenente al criterio passa implica che il programma sia corretto**************************************************************************************************************************************************************

Ma SAPPIAMO che questo non è possibile.

## Quindi come ragioniamo?

Un caso di test per poter portare a evidenziare un malfunzionamento causato da una anomalia deve soddisfare tre requisiti:

1. eseguire il comando che contiene l’anomalia
2. l’esecuzione del comando contenente l’anomalia deve portare il sistema in uno stato scorretto
3. lo stato scorretto deve propagarsi fino all’uscita del codice in esame, in modo da produrre un output

[…….]

In pratica dobbiamo capire quanto “coprire” i casi che possiamo testare.

Devo decidere quando smettere, quali test è opportuno aggiungere e come confrontare la bontà di test differenti.

### Copertura dei comandi:

**Un test T soddisfa il criterio di copertura dei comandi sse ogni comando eseguibile del programma è eseguita in corrispondenza di almeno un caso di test t contenuto in T.**

### Copertura delle decisioni

**Un test T soddisfa il criterio di copertura delle decisioni sse ogni decisione effettiva viene resa sia vera che falsa[…]**

La metrica è la frazione delle decisioni che sono state rese sia vere che false su quele per cui è possibile farlo.

⚠️Copertura delle decisioni ⇒ Copertura dei comandi ⚠️

### To be continued…