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
* Ci dice se una rete è limitata (se \omega non compare o non compare in nessun nodo dell'albero di copertura)
* Ci dice se una P/T è binaria se nell'albero di copertura compaiono solo 0 e 1
* Una transizione è morta (0-live) se non appare come etichetta di un arco dell'albero di copertura
* Condizione necessaria affinchè un [....]

---
{DA METTERE IN L14}
# Rappresentazione Matriciale
È un'altra possibile rappresentazione per le reti di petri: n questo caso vengono utilizzate le matrici.
Il vantaggio delle matrici sono che è abbastanza facile manipolarle (matematicamente) anche in modo efficiente

Matrici usate:
- I (archi in input)
- O (archi in output)
- m (marcatura dei posti)

## Matrice I e  O
Ho bisogno di assegnare un indice ad ogni posto e un indice ad ogni transizione.
Sia I che O sono matrici di grandezza |P|x|T|
{Definizione latex}
"Per ogni flusso nella mia rete, allora I[i][j] = W(<p(i),t(i)>), altrimenti I[i][j] = 0"
Stesso discorso per la matrice O.

__Notazione__:

Con I[.][j] indichiamo l'intera colonna j-esima

{Immagine di esempio}

## Marcatura m
* È un vettore di colonna di dimensione |P| e indica la marcatura per ogni indice (Posto)

### Abilitazione di una transizione
m[tj> se e solo se I[.][j] <= m

### Scatto di una transizione
Se m[tj> m' allora:
m' = m - I[.][j] + O[.][j]

## Matrice di incidenza C
C = O - I

Ci permette di ottimizzare il calcolo dello scatto delle transizioni, ma non riesce però a calcolare l'abilitazione: se abbiamo reti non pure, [...]

### Sequenze di scatti
Consideriamo il legame tra la marcatura iniziale e la marcatura dopo n scatti della transizione t1

M[t1>M', M'[t1>M'', M''[t1>M''' ....

Grazie a C posso vedere direttamente Mn:

Mn = M + (C·s) con s numero di scatti


# Nuova tecnica di analisi: Ricerca di P-invariante e T-invarianti nella rete

## P-invariante
La rappresentiamo con un vettore h di dimensione |P| (h che ricorda la funzione H della definizione della rete conservativa, ma ha inoltre la possibilità che non tutti i pesi siano maggiore di zero). In questo caso il prodotto vettoriale h·m deve essere costante: h·m = h·m' per ogni m' raggiungibile da m.

Inoltre sappiamo che m' = m + C·s

Quindi h·m = h·m + h·C·S

Quindi h·C·s = 0 per ogni s che rappresenti una sequenza ammissibile

Condizione sufficiente verificabile staticamente: pe ogni possibile s

h·C = 0 => Per trovare le P-Invarianti basta trovare le soluzioni di questo sistema di equazioni


### Copertura di P-Invarianti
* Una combinazione lineare di P-invarianti è anch'essa un P-invariante
* Un P-Invariante che ha tutti pesi >= 0 è detto sempipositivo
* Se un posto ha peso positivo in un P-invariante semi-positivo allora il posto è limitato

Questo mi porta dire che se una rete è ricoperta da P-invarianti allora per ogni posto esiste almeno un pinvariante semipositivo il cui peso di tale posto sia positivo OVVERO la rete è limitata 


## Algoritmo di Farkas (1902)

È un algoritmo che trova le basi minime semipositive

{Algoritmo}


## T-invarianti
il concetto è simile alle P invarianti ma fa riferimento a sequenze di scatti che mi riporta alla situazione iniziale.

m' = m+C·s

m' = m

Soluzioni del sistema C·s = 0

ATTENZIONE: non tutte sono ammissibili

****Esercizio: modellare con una rete di petri il problema della capra, il cavolo e il cane****


# Controllori con specifica a stati proibiti

Trattiamo questa modellizzazioni nel mondo ideale in cui:

* Transizioni osservate
* Transizioni controllate

possono sempre applicabili senza problemi

CONTROLLARE significa assicurarsi che vengano rispettate certe proprietà: esprimiamo il comportamento desiderato del nostro sistema dicendo che una combinazione lineare delle marcature non deve superare un certo valore

## Mutua esclusione

Devono escludersi dalla zona critica:
* P1 + P2 <= 1
* Aggiungioamo un posto controllore Pc
  * P1+P3+Pc = 1
* Poi
  * aggiungiamo una riga opportuna a c e un elemento a m


{Latex}

LMs + Mc = [L I]M = b

Ma allora vogliamo dire che [L I] è un P-Invariante e quindi deve valere:

[L I]C = O

LCs + ICc = 0

Cc

{Latex,Latex,Latex, sintesi in LAtex}


### Sintesi del controllore


{{{PAPAPAPAAAAAAPAAAAPAPAPAPAAAAAAAAAAAAA}}}



# Estensioni delle reti di petri

* Reti temporizzate (ci interessano)
  * Temporizzate ad alto livello
* Stocastiche (nope)
* Generiche ad alto livello (interessanti ma nope)


Tutto questo ci serve per modellare sistemi Hard Real-time, sistemi critice che devono garantire molte cose. Vogliamo quindi avere modelli DETERMINISTICI

# Modelli temporali

* Esistono diverese proposte sulla maniera migliore per aggiungere il tempo alle reti di Petri:
  * Ritardi sui posti
  * Ritardi sulle transizioni
  * Tempi di scatto sulle transizioni
    * Tempi che possono essere unici o multipli, in un intervallo ecc...
    * Possono essere fissi o variabili
    * Assoluti o relativi

{...}