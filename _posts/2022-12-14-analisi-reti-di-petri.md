---
layout: post
title: "[15] Analisi di Reti di Petri"
date: 2022-12-14 14:40:00 +0200
toc: true
---

Le dividiamo in tecniche:
* Dinamiche
  * Albero (grafo) delle marcature raggiungibili
  * Albero (grafo) della copertura delle marcatura raggiungibili
* Statiche
  * Identificazione delle P-invarianti
  * Identificazione delle T-invarianti

# Albero di raggiungibilità

Per creare l'albero di raggiungibilità:

1. Crea la radice corrispondente alla marcatura iniziale e etichettalo come "nuovo"
2. Finchè esistono nodi "nuovi" esegui questi passi:
   1. Seleziona una Marcatura M con etichetta "nuovo" e togli l'etichetta
   2. Se M è identica ad una marcatura sul cammino dalla radice M, etichetta M come "duplicata" e passa ad un'altra marcatura
   3. Se in questa nuova marcatura M' non è abilitata nessuna marcatura, etichettala come "finale"
   4. Altrimenti finchè esistono transizioni abilitatein M esegui i seguenti passi per ogni transizione abilitata in M
      1. Crea la marcatura M' prodotta dallo stato di t
      2. crea un nodo corrispondente a M', aggingi arco da M a M' e segna M' come "nuovo"

In questo albero abbiamo rappresentate tutte le marcature possibili nella rete in maniera esaustiva.
Una volta realizzato, è possibile analizzare se ci sono deadlock (stati terminali non previsti), se possiamo raggiungere una marcatura (le abbiamo tutte rappresentate), se è possibile una certa sequenza di transizioni e anche capire se la rete e viva {aggiungi il come}

## Limiti e Risposte
* Limiti:
  * Deve enumerare tutte le possibili marcature raggiungibili
  * Quindi se la rete non è limitata sono infiniti e quindi non può essere completato
* Risposte:
  * Non ci sa dire se una rete è limitata
  * Se è limitata:
    * Ci sa dire quasi tutto, non perde informazioni ed è la esplicitazione degli stati della rete (Quindi ne è di fatto la FSM corrispondente)
    * La crescita degli stati globali può però essere ingestibile (crescita esponenziale)

# Albero di Copertura

Diciamo che una marcatura M copre una marcatura M' se e solo se per ogni posto in P la marcatura M(p) è maggiore o uguale a M'(p)

Per contro M si dice copribile a partire da una marcatura M' se esiste una marcatura M'' in R(M) che copre M.

Se M è la marcatura minima per abilitare t, la transizione è morta se e solo se M non è copribile a partire dalla marcatura corrente

{c'è l'inserimento di \omega che non mi è chiara, guardalo perchè lì c'è perdita di informazione ma anche vantaggi. Almeno, fino ad un certo punto.}

## Creazione
1. Crea la radice corrispondente alla marcatura iniziale e etichettalo come "nuovo"
2. Finchè esistono nodi "nuovi" esegui questi passi:
   1. Seleziona una Marcatura M con etichetta "nuovo" e togli l'etichetta
   2. Se M è identica ad una marcatura sul cammino dalla radice M, etichetta M come "duplicata" e passa ad un'altra marcatura
   3. Se in questa nuova marcatura M' non è abilitata nessuna marcatura, etichettala come "finale"
   4. Altrimenti finchè esistono transizioni abilitatein M esegui i seguenti passi per ogni transizione abilitata in M
      1. Crea la marcatura M' prodotta dallo stato di t
      2. Se sul cammino dalla radice a M esiste una copertura M'' coperta da M' aggiungi \omega in tutte le posizioni corrispondenti a coperture proprie
      3. Crea un nodo corrispondente a M', aggiungi un arco da M a M' ed etichetta M' come "nuovo"


## Limiti e Risposte
* Ci dice se una rete è limitata (se \omega non compare in nessun nodo dell'albero di copertura)
* Ci dice se una P/T è binaria se nell'albero di copertura compaiono solo 0 e 1
* Una transizione è morta (0-live) se non appare come etichetta di un arco dell'albero di copertura
* Condizione necessaria affinchè un
