# Reti TB come reti ad alto livello?

Ma è davvero necessario sviluppare un'intera serie di nuove tecniche di analisi specifiche per le reti Time Basic, o è possibile riutilizzare almeno in parte metodologie già discusse?

Si potrebbe infatti immaginare di considerare le reti TB come un tipo particolare di __reti ad Alto Livello__ (ER).
Come abbiamo già accennato, questo tipo di reti permettono infatti ai gettoni di avere un __qualunque contenuto informativo__ e di definire le transizioni come una coppia __predicato-azione__: il predicato descrive la condizione di abilitazione della transizione in funzione dei valori dei gettoni nel preset, mentre l'azione determina che valore avranno i gettoni creati nel postset. \
Volendo modellare il __tempo come concetto derivato__, ovvero non delineato esplicitamente ma che emerga comunque dal _funzionamento_ della rete, si potrebbero quindi creare delle reti ad Alto Livello con le seguenti caratteristiche:

- __contenuto informativo dei gettoni__: un'unica variabile temporale __chronos__ che contiene il timestamp della loro creazione;
- __predicati delle transizioni__: funzioni che controllano i timestamp dei gettoni nel preset e i propri tempi di scatto per determinare l'abilitazione o meno;
- __azioni delle transizioni__: generazione di gettoni dotati tutti dello _stesso dato temporale_, il quale è _non minore dei timestamp di tutti i gettoni nella tupla abilitante_.

Con queste accortezze è possibile riprodurre i timestamp e le regole di scatto di una rete TB.
Come sappiamo bene, tuttavia, questo non basta per modellare il _concetto_ di tempo: per avere un'espressività simile a quella delle reti Time Basic è infatti necessario anche il rispetto di una __semantica temporale__ e, in particolare, di quella più stringente, ovvero la semantica temporale forte (STS).

Nelle reti ad Alto Livello bisognerà dunque far rispettare i cinque assiomi temporali perché la traduzione da reti TB a reti ER sia completa.
Vediamo dunque come ciò potrebbe essere fatto:

- gli assiomi __A1__ e __A3__ sono sufficientemente semplici da modellare all'interno dei predicati delle transizioni, rendendo così la __semantica temporale debole__ rappresentabile nelle reti ad Alto Livello;

- l'assioma __A2__ è già più complesso da realizzare, in quanto richiede che lo scatto di una transizione generi dei gettoni con un timestamp maggiore di quello di tutti gli altri gettoni nella rete (_imponendo così che il tempo avanzi_).
  Tuttavia tale limite può essere aggirato con l'aggiunta di un __posto globale__ contenente il __gettone dell'ultimo scatto__ e aggiunto al preset di ogni transizione: in questo modo il gettone nel posto globale rappresenterà il _tempo corrente della rete_ e imporrà che i nuovi gettoni generati abbiano timestamp maggiore di esso.
  In questo modo una rete ER può realizzare anche la __semantica temporale monotonica debole__;

- gli assiomi __A4__ e __A5__, invece, si rivelano __estremamente problematici__: essi richiedono infatti che ciascuna transizione conosca il massimo tempo di scatto di tutte le altre transizioni per "decidere" se poter scattare oppure no.
  I predicati delle transizioni dovrebbero cioè avere in input l'intero stato della rete: sebbene questa cosa sia _teoricamente_ realizzabile con l'aggiunta di un posto globale in ingresso e uscita da ogni transizione in cui un gettone contenga come _contenuto informativo l'intero stato della rete_, nella pratica cio è __irrealizzabile__.

Come si vede, dunque, la necessità di modellare la __semantica temporale forte__ fa sì che __non si possa ridurre le reti TB a un caso particolare delle reti ER__, perdendo così anche la possibilità di utilizzare le tecniche di analisi già sviluppate per esse.

## Reti Time Petri ad Alto Livello (HLTPN)

Appurato che non è possibile tracciare un'equivalenza tra le reti TB e le reti ER viene dunque introdotto un modello ancora più completo, che racchiuda al suo interno sia gli __aspetti funzionali__ delle reti ad Alto Livello sia gli __aspetti temporali__ delle reti Time Basic: si tratta delle __reti Time Petri ad Alto Livello__ (_High-Level Time Petri Nets_, __HLTPN__).

![](/assets/16_HLTPNs.png)

Come appare chiaro dalla figura, all'interno delle reti HLTPN __gli aspetti funzionali possono dipendere da quelli temporali e viceversa__, espandendo così incredibilmente le capacità rappresentative del modello.
Si tratta di reti ovviamente molto complesse, anche se a dire il vero gran parte della complessità giunge dall'analisi della componente temporale: se riusciremo ad analizzare le reti temporizzate potremo riuscire ad analizzare anche le reti HLTPN.
