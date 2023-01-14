---
layout: post
title: "[15] Analisi di Reti di Petri"
date: 2022-12-14 14:40:00 +0200
toc: true
---
# Analisi delle reti di petri
Le reti di Petri sono state introdotte per poter analizzare un sistema ancora prima di avere il codice, in modo da poter ragionare sul sistema.
Per fare ciò si potrebbe porre delle domande del tipo:
- può essere raggiunta una determinata marcatura?
- è possibile una certa sequenza di scatti?
- esiste uno stato di deadlock all'interno della rete?
- la rete (o una certa transizione) è viva? e di che grado?

Per rispondere a queste domande esistono diverse tecniche che sonon suddivise in:
- Dinamiche
    - Albero (grafo) delle marcature raggiungibili (chiamato anche grafo di raggiungibilità);
    - Albero (grafo) della copertura delle marcatura raggiungibili (chiamato anche grafo di copertura).
- Statiche:
    - Identificazione delle P-invarianti (caratteristiche invarianti riguardanti i posti);
    - Identificazione delle T-invarianti (caratteristiche invarianti riguardanti alle transizioni).

Le tecniche dinamiche sono quelle che ragionano sugli stati raggiungibili durante l'esecuzione della rete di Petri (o di un programma), mentre le tecniche statiche sono quelle che ragionano sulla topologia della rete, ovvero su come è fatta strutturalmente.

## Albero di raggiungibilità
Per creare l'albero di raggiungibilità è necessario adottare il seguente algoritmo:

1. creaee la radice dell'albero corrispondente ad un nodo rappresentatne la marcatura iniziale, e etichettalo come "nuovo";
2. finchè esistono nodi "nuovi" esegui questi passi:
    1. seleziona una Marcatura $$M$$ con etichetta "nuovo" e prendiamolo in considerazione, togliendo l'etichetta;
    2. se la marcatura $$M$$ è identica ad una marcatura di un altro nodo che si trova sul cammino dalla radice a $$M$$, etichetta $$M$$ come "duplicata" (perchè esiste già e sono già note le sue evoluzioni) e passa ad un'altra marcatura;
    3. se invece in questa nuova marcatura $$M'$$ non è abilitata nessuna transizione, è da etichettare come "finale", e di conseguenza ci si trova in uno stato di deadlock;
    4. altrimenti finchè esistono transizioni abilitate in $$M$$ è necessario eseguire i seguenti passi per ogni transizione abilitata in $$M$$:
        1. creare la marcatura $$M'$$ prodotta dallo stato della transizione;
        2. creare un nodo corrispondente a $$M'$$ e successivamente aggiungere un arco da $$M$$ a $$M'$$ e marcare $$M'$$ come "nuovo".

### Esempio albero di raggiungibilità
Un esempio di esercizio in cui è necessario utilizzare un albero di raggiungibilità potrebbe essere:

modellare tramite una rete di Petri l'accesso ad una risorsa condivisa tra quattro lettori e due scrittori, ricordandosi che i lettori possono accedere contemporaneamente, emntre gli scrittori necessitano di un accesso esclusivo.

Un primo approccio è quello di creare una rete per i lettori e una per gli scrittori, successivamenti si procede modellando la risorsa condivisa su cui è necessario operare, collegando tutte le diverse parti create.

{% responsive_image path: assets/15_esempio-1-albero-raggiungibilita.png %}

A questo punto però i lettori non sono in grado di leggere dalla risorsa in modo concorrente, siccome nel posto "Risorsa" è presente un solo gettone, di conseguenza è necessario far si che i gettoni siano 4 in modo che tutti i lettori possano accedervi.
Sorge un altro problema però, bisogna fare in modo che gli scrittori non possano accedere alla risorsa se sta venendo letta, e la soluzione è quella di mettere un peso di quattro sugli archi da "risorsa" a "S_inizia" e da "S_finisce" a "Risorsa".
In questo modo uno scrittore per accedere dovrà avere a disposizione tutti i token di "Risorsa", che significa che nessun altro sta utilizzando la risorsa.
Il risultato finale è il seguente:

{% responsive_image path: assets/15_esempio-1-albero-raggiungibilita-rete-completa.png %}

Una volta creata la rete finale, è possibile creare l'albero di raggiungibilità seguendo l'algoritmo precedente. Il primo passo è quello di creare il nodo radice, che corrisponde alla marcatura iniziale, quindi avremo un nodo 40420 marcato come nuovo.
Successivamente, per ogni nodo marcato come nuovo, bisogna togliere la marcatura e verificare se esistono dei nodi dalla radice al nodo che stiamo considerando, e in questo esiste solo il nodo radice, quindi si può proseguire.
A questo punto per ogni transizione abilitata nella marcatura presa in considerazione bisogna creare la marcatura (questa fase è rappresentata dall'arco) e successivamente bisogna creare un nodo corrispondente marcato come nuovo.
La situazione attuale è la seguente:

{% responsive_image path: assets/15_esempio-1-albero-prima-giro-algoritmo.png %}

Ora bisogna procedere con l'algoritmo ripetendo i passi fino ad arrivare in una situazione in cui non esistono più nodi nuovi, ricordandosi di marcare come duplicati tutti i nodi che verranno a crearsi, che però sono già presenti almeno una volta nell'albero.

La situazione finale sarà questa:

{% responsive_image path: assets/15_esempio-1-albero-finale.png %}

<!-- immagine orrenda, da sistemare ora non ho tempo-->

A questo punto tramite questo albero di raggiungibilità rappresenta tutti gli stati raggiungibili dal sistema, non esistono altre marcature raggiungibili dalla marcatura iniziale.
Se si volesse verificare che gli scrittori sono in mutua esclusione con i lettori, basterà controllare se esiste una marcatura in cui il secondo e il quinto numero (rispettivamente "LettoriAttivi" e "ScrittoriAttivi") sono entrambi maggiori di zero.
Si può verificare in modo esaustivo (model checking) guardando tutti i nodi dell'albero.
Inoltre si può verificare se gli scrittori si escludono a vicenda, controllando se in ogni marcatura l'ultimo numero è maggiore di uno, oppure si può veridicare anche se esistono deadlock, veridicando se ci sono nodi terminali.
Un caso particolare invece è verificare se la rete è viva, in quanto è più semplice controllare ciò sul grafo di raggiungibilità, e per ottenerlo bisogna collassare tutti i nodi con la stessa marcatura, riportando le frecce corrispondenti.

{% responsive_image path: assets/15_grafo-di-raggiungibilita.png %}

<!-- Anche questa fa un po schifo ma non ho il tool per migliorarla -->

Questo è un sistema reversibile in cui ogni stato è un stato base, perchè da ogni stato è possibile raggiungere tutti gli altri stati.
Ora avendo questo grafo è facile capire che la rete è viva, in quanto sono rappresentate tutte le transizioni all'interno del grafo, e siccome il sistema è reversibile, è possibile affermare che la rete è viva.

### Limiti degli alberi di raggiungibilità
Limiti:
- Per poter creare un albero di raggiungibilità è necessario enumerare tutte le possibili marcature raggiungibili, di conseguenza la rete deve essere obbligatoriamente limitata, altrimenti non sarebbe possibile elencare tutti i nodi;
- la crescita degli stati globali può essere ingestibile per una rete limitata (crescita esponenziale).

Risposte:
- Questa tecnica di analisi non è in grado di dire se la rete è limitata o meno;
- Nel caso in cui si sappia già che la rete è limitata:
    - l'albero di raggiungibilità non perde informazioni ed è la esplicitazione degli stati della rete (Quindi ne è di fatto la FSM corrispondente).

## Albero di Copertura

Diciamo che una marcatura M copre una marcatura M' se e solo se per ogni posto in P la marcatura M(p) è maggiore o uguale a M'(p)

Per contro M si dice copribile a partire da una marcatura M' se esiste una marcatura M'' in R(M) che copre M.

Se M è la marcatura minima per abilitare t, la transizione è morta se e solo se M non è copribile a partire dalla marcatura corrente

{c'è l'inserimento di \omega che non mi è chiara, guardalo perchè lì c'è perdita di informazione ma anche vantaggi. Almeno, fino ad un certo punto.}


1. Crea la radice corrispondente alla marcatura iniziale e etichettalo come "nuovo"
2. Finchè esistono nodi "nuovi" esegui questi passi:
   1. Seleziona una Marcatura M con etichetta "nuovo" e togli l'etichetta
   2. Se M è identica ad una marcatura sul cammino dalla radice M, etichetta M come "duplicata" e passa ad un'altra marcatura
   3. Se in questa nuova marcatura M' non è abilitata nessuna marcatura, etichettala come "finale"
   4. Altrimenti finchè esistono transizioni abilitatein M esegui i seguenti passi per ogni transizione abilitata in M
      1. Crea la marcatura M' prodotta dallo stato di t
      2. Se sul cammino dalla radice a M esiste una copertura M'' coperta da M' aggiungi \omega in tutte le posizioni corrispondenti a coperture proprie
      3. Crea un nodo corrispondente a M', aggiungi un arco da M a M' ed etichetta M' come "nuovo"

### Esempio albero di copertura

### Limiti alberi di copertura
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