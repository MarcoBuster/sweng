---
layout: post
title: "[14] Reti di Petri"
date: 2022-12-12 14:40:00 +0200
toc: true
---

Sono in parte simili a FSM, ma nascondono alcuni particolari ideati specificatamente per descrivere sistemi concorrenti. Quì i concetti di stato e di transizione cambiano:
* Lo stato non è più visto a livello di sistema ma come composizione di tanti stati parziali
* Le transizioni non operano più quindi su uno stato globale, ma varieranno una parte dello stato (uno stato parziale per l'appunto)

## Informalmente:

Prima di vedere la definizione formale, vediamo una spiegazione più informale:

<!Inserire immagine esempio>

In una rete di Petri abbiamo 2 tipi di nodi, i _POSTI_ e le _TRANSIZIONI_. Gli archi collegano solo nodi di tipi diversi tra loro.
Ogni _posto_ contiene diversi _token_ che determinano lo stato del sistema. Ogni posto può contenere un numero libero di nodi.
Come cambio lo stato della rete (ovvero come cambio i token)? Quando una transizione viene "triggerata" alcuni token vengono distrutti e altre generati: __i token quindi NON SI SPOSTANO da un posto all'altro, ma vengono creati e distrutti__.


# Definizione

Noi vediamo la definizione PT-net, ma esistono diversi dialetti, estensioni e riduzioni

>Una Rete di Petri è (classicamente) una 5-tuple $$<P,T,F,W,M_0>$$ in cui:
> * $P$ è l'insieme dei posti 
> * $T$ è l'insieme delle transizioni
> * $F$ è la relazione di flusso 
> * $W$ è la funzione che associa un peso ad ogni flusso
> * $M_0$ è la marcatura iniziale
> * $$ P \cap T \neq \void, P \cup T \neq \void, F \subseteq (P\timesT)\cup(T\cross P), W:F\rightarrow \N - {0}, M_0 : P \rightarrow \N $$

## Parte statica
Useremo un paio di scorciatoie, come dei preset e dei postset:

- $Pre(a) = {d\in(P \cup T)|<d,a>\in F}$ //preset
- $Post(a) = {d\in(P \cup T)|<a,d>\in F}$ //postset

## Parte dinamica
Una transizione t in T è _abilitata_ in M se e solo se per ogni posto appartenente al preset della transizione la marcatura di quel posto è maggiore-uguale al peso di quell'arco

In altre parole, una transizione è abilitata su un posto se esiste un arco tra il posto e la transizione e ha abbastanza token per la transizione. Questo deve valere PER OGNI ARCO IN INGRESSO NELLA TRANSIZIONE.

> `M[t>` := "t è abilitata in M"


Lo _scatto_ di una transizione in t in una marcatura M produce una nuova marcatura M':
- Per tutti i posti che appartengono al preset ma non al postset, M' sarà uguale ad M a cui viene sottratto il peso di quell'arco
- Per tutti i posti che appartengono al postset ma non al preset, M' sarà uguale ad M a cui vengono aggiunti il peso di quell'arco
- Se i posti appartengono sia al preset che al postset allora M'(p) = M(p) - W(<p,t>) + W(<t,p>)
- Per tutti i posti non toccati dalla transazione, M'(p) = M(p)


> `M[t>M'` := "Lo scatto nella transizione t produce la Marcatura M'"

<!Esempi: produttore, consumatore e buffer>

NB: posso "convertire" facilmente una FSM in una Rete di Petri

NB: la non evoluzione è possibile. Se non si creano le condizioni perchè una transizione venga triggerata, non viene triggerata.

Se devo scegliere quale transizione far scattare tra più transizioni, posso scegliere arbitrariamente quella che voglio: non c'è quindi determinismo.


# Come sfruttare per bene le Reti di Petri
Gli esempi dati fino ad ora traducevano semplicemente una FSM in una rete di Petri. Possiamo ovviamente fare di meglio

<!Qui manca una cosa>

<!In realtà sta traducendo dagli esempi, vedi se riesci a recuperare qualcosa>

---
---
# Relazioni tra transizioni
## Sequenza
Una transizione t1 è in sequenza con una transizione t2 in una marcatura M se e solo se:
`M[t1> AND NOT(M[t2>) AND M[1t2>`
* `M[t1>` := t1 è abilitata in M
* `NOT(M[t2>)` := t2 non è abilitata in M
* `M[t1t2>` := t2 viene abilitata dallo scatto di t1 in M

## Conflitto
Due transizioni (t1,t2) sono in conflitto:
* _Strutturale_ se e solo se $Pre(t_1) \cap Pre(t_2) \neq \empty$
* _Effettivo in una marcatura M_ se e solo se `M[t1> AND M[t2> AND` $\exist p \in Pre(t1) \cup ...$
  * t1 e t2 sono abilitate in M
  * esiste un posto in ingresso ad entrambe che non possiede abbastanza token per far scattare entrambe

Esiste anche una versione rilassata del conflitto, non simmetrica:

`M[t1> AND M[t2> AND NOT(M[t1t2>)`


## Concorrenza
Quando 2 transizioni "non si danno fastidio"

t1 e t2 sono in relazione di concorrenza:
* _strutturale_ se e solo se $Pre(t_1) \cap Pre(t_2) = \empty$
* _effettiva_ se e solo se tutti i posti in ingresso ad entrambe hanno abbastanza token per entrambe

Attenzione: è possibile che siamo in una situazione di concorrenza strutturale ma non effettiva: basta che le due transizioni non siano abilitate


# Insieme di Raggiungibilità
> R È il più piccolo insieme di marcature tale che:
> * $M\in R(P/T,M)$
> * $(M'\in R(P/T,M) \& \exists t \in T M' [t>M')) \rightarrow M'' \in R(P/T,M)$


# Proprietà di limitatezza
Una rete P/T con marcatura M si dice limitata se e solo se il numero di token per ogni posto è limitato


# Dalle reti di Petri agli Automi a stati finiti
Se la rete è limitata allora l'insieme di raggiungibilità è finito: è quindi possibile definire un automa a stati finiti corrispondente in cui gli stati sono le possibili marcature dell'insieme di raggiungibilità e le transizioni sono gli archi.

Scrivere una rete di petri in termini di FSM ci permette di utilizzare allo stesso tempo un modo di scrivere le cose in modo più sintetico e comprensibile (Reti di Petri) mentre utilizzare tutta la teoria conosciuta per poter analizzare la FSM corrispondente

# Vitalità di una transizione
Una transizione t in una marcatura m è detta _viva_ con un certo _grado_ se:
* Grado 0
  * Non è abilitata in nessuna marcatura appartenente all'insieme di raggiungibilità (in questo caso diciamo che è morta)
* Grado 1
  * Esiste almeno una marcatura raggiungibile in cui è abilitata
* Grado 2
  * Per ogni n > 0 esiste almeno una sequenza ammissibile in cui la transizione scatta n volte
  * "n grande a piacere"
* Grado 3
  * Esiste una sequenza di scatti ammissibile in cui scatta infinite volte
  * infinite volte (!= n grande a piacere)
* Grado 4
  * in qualunque marcatura raggiungibile esiste una sequenza ammissibile in cui scatta (in questo caso diciamo che è viva)

> Una rete è __viva__ se tutte le sue transizioni sono __vive__


# Dialetti
Ci sono diversi dialetti delle reti di petri che possono aggiungere certe caratteristiche

## Capacità dei posti
Una possibile estensione è quella che mette un upper-bound di token possibili in un posto

è un dialetto che si può modellare con una rete di petri classica, ad esempio attraverso l'uso del _posto complementare_. Questo vale però solo per le reti _pure_, ovvero reti in cui non esistono posti che sono in ingresso e uscita contemporaneamente ad una transizione.

### Posto complementare
>Un posto è complementare di p se e solo se .....
<!Latex required>

### Abilitazione con capacità
In caso di reti con capacità sui posti la definizione di abilitazione quale sarebbe?

Abbiamo 2 opzioni:
- t è abilitata in M se e solo se [...]
  - <!Latex requires>
  - Per ogni arco di ingresso al posto dobbiamo avere il posto alla transizione con lo stesso peso
- t è abilitata in M se e solo se [...]
  - <!Latex required>


## Archi inibitori
È un'altra estensione che dice che non ci devono essere più di un certo numero di token in un posto per abilitare una transizione (anche 0).
In caso di rete limitata non cambia la potenza espressiva di una Rete di Petri perchè se sappiamo che un posto è limitato/limitabile, creo un posto complementare (trattato differentementa dal caso precedente), facciamo che tutti i k token siano nel posto complementare che inibirà {in qualche modo che ora vedremo} la transizione nel caso ci siano più gettoni.
In caso di rete non limitata invece cambia la potenza della rete.

Ha qualche downside però, non riusciamo ad adattare alcune tecniche di analisi che vedremo, quindi {Per il Prof. Bellettini} è bene limitarne l'uso ai casi in cui si riveli necessario.

## Eliminazione dei pesi sugli archi
Possiamo eliminare i pesi sugli archi combinando scatti di più transizioni in posti complementari.
Ci porta ad avere la stessa marcatura avendo componenti omogenei, ma siamo legati a sequenze di scatti di transizioni che, se non avvenissero correttamente, potremmo cadere in problemi di concorrenza.
Se vogliamo produrre più token, possiamo avere un altro posto complementare globale, collegato quindi a tutte le transizioni, che fa prendere il lock a tutte le transizioni che ci portano in uno stato parziale e lo fa rilasciare dopo che le altre transizioni "aggiuntive" si sono concluse.
Se invece vogliamo consumare più gettoni... Diciamo che è complicato. Si può fare, ma se ne esce generalmente overingegnerizzati

## Reti Condizioni - Eventi
Sono in realtà proprio un'altra cosa rispetto alle P/T
Una rete viene detta C/E se:
- Tutti gli archi hanno peso 1
- Tutti i posti hanno capacità 1

Se i posti (Condizioni) in ingresso a t contengono un token, allora la transizione t (Evento) può scattare

Una rete P/T limitata ha una corrispondente nella classe C/E


# Caratteristiche che ci interessano

## Conservatività
Per ogni posto della rete abbiamo un peso.
>Data una funzione H che assegna i pesi, una rete P/T con marcatura M si dice conservativa se e solo se per ogni marcatura raggiungibile la somma pesata dei gettoni della marcatura rimane uguale a quella della marcatura di partenza.

Una rete che garantisce la conservatività __garantisce__ che la rete è limitata.
Non è vero il contrario.

### Rete strettamente conservativa
È un caso speciale della rete conservativa:

>Una rete conservativa rispetto alla funzione che assegna tutti pesi uguali a 1 si dice __fortemente conservativa__.

Il numero di token nella rete __non cambia mai__:
<!Latex>

Posso pensarla anche così: Il numero di token consumati dallo scatto di una transizione è uguale al numero di gettoni generati dallo stesso
<!Latex>

La prima formula è un'analisi che lavora sulle marcature.
È dinamica.

La seconda formula è un analisi che lavora sulla topologia.
È statica.

Sono quindi equivalente pur lavorando su aspetti diversi?
NO.
La seconda formula tiene conto anche delle transizioni non morte. È quindi più generale, ma potrebbe anche considerare non strettamente conservativi casi che invece lo sono.
<!Abbiamo Dubbi signori????????>

## Stato base e Rete reversibile
Una marcatura M' è detta stato base se per ogni marcatura M in R(M0) M' è raggiungibile da M
Una rete di petri è detta reversibile se per ogni marcatura M in R(M0) M0 è raggiungibile da M (Ovvero: lo stato iniziale è stato base)

# Analisi

Che domande possiamo farci durante l'analisi delle reti di petri?
- Può essere raggiunta una determinata marcatura?
- è possibile una certa sequenza di transizione?
- ci possono essere in un certo stato di deadlock?
- La rete è viva?


## Tecniche di analisi
Le dividiamo in tecniche:
* Dinamiche
  * Albero (grafo) delle marcature raggiungibili
  * Albero (grafo) della copertura delle marcatura raggiungibili
* Statiche
  * Identificazione delle P-invarianti
  * Identificazione delle T-invarianti

## Albero di raggiungibilità

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
