---
layout: post
title: "[14] Reti di Petri"
date: 2022-12-12 14:40:00 +0200
toc: true
---

# [Reti di Petri](https://www2.informatik.uni-hamburg.de/TGI/PetriNets/index.php)

In questa lezione verranno mostrate le reti di Petri come esempio di linguaggio formale; fin dall'inizio del corso è stato possibile apprendere come l'ingegneria del software si occupi di linguaggi e comunicazione.
Infatti partendo dai processi, che sfruttano un linguaggio poco formale e con poca terminologia tecnica (ad esempio le user story), passando per la progettazione in cui è stato utilizzato un linguaggio più rigoroso, si arriva infine a un vero linguaggio formale utile a raccogliere delle specifiche.
Per descrivere le reti di Petri esistono diversi modi, noi vedremo alcuni dialetti di cui uno utile a descrivere i sistemi real time (temporizzati), che avendo diverse criticità è fondamentale andare formalizzare i requisiti per ridurle al minimo.
Formalizzare e utilizzare linguaggi complessi può essere costoso, infatti questa pratica viene utilizzata quando l'applicazione può avere delle conseguenze gravi in caso di fallimento (ad esempio un software per gestire un razzo spaziale se dovesse avere dei problemi potrebbe causare molti danni, economici e non solo);
Quindi bisogna almeno garantire la safety prima di mettere in funzione il software.

Le reti di Petri sono in parte simili agli automi a stati finiti, ma nascono specificatamente per descrivere sistemi concorrenti.
Cambiano però il concetto di stato e transizione, in quanto lo __stato__ non è più un'informazione atomica vista a livello di sistema ma è divisa in tante parti diverse, e la sua composizione avverrà tramite la visione generale di tutti questi stati parziali.
Quindi sarà rappresentare entità distinte, avente ognuna un suo stato, ma allo stesso tempo avere un'evoluzione globale del sistema.
Di conseguenza le __transazioni__ non operano sullo stato globale ma si limitano a variarne una parte, da ciò è possibile notare la differenza con gli automi a stati finiti in cui esisteva un unico stato attivo, e gli stati disponibili erano dati dal prodotto cartesiano di tutti i possibili valori delle diverse entità.

## Definizione informale
Un vantaggio delle reti di Petri è che possono essere viste in maniera informale dal cliente, infatti è facile definire una rete di Petri in cui i nodi sono _posti_ e _transizioni_, collegati tra loro tramite degli archi.
Possiamo quindi dire che questa struttura è un grafo bipartito, ovvero un grafo in cui i nodi sono messi in relazione __solo__ con nodi dell'altro tipo, quindi i posti possono essere collegati soltanto a transizioni e viceversa.
Ai posti sono assegnati dei ___token___, ovvero degli elementi che vengono assegnati ai posti.
Ogni posto può contenere da 0 a un numero potenzialmente infinito di token (successivamente si approfondirà questo punto per capire se ha senso o no assegnare infiniti gettoni a un posto), ed è proprio la disposizione di questi gettoni nella rete a determinarne il suo stato complessivo.

{% responsive_image path: 'assets/14_Rete-Petri-informale.png' %}

Essendo che i gettoni determinano lo stato di ogni parte della rete, allora sicuramente il loro assegnamento ai posti può cambiare, questo perché lo stato della rete può evolvere.
Ciò accade tramite la trasformazione effettuata dalla transizione; possiamo quindi dire che una transizione è _abilitata_ quando all'interno dei posti collegati in ingresso a essa esistono un certo numero di gettoni.
Inoltre una transizione abilitata si dice che __scatta__ (fire) quando consuma i gettoni nei posti in ingresso e ne vengono generati altri nei posti collegati in uscita.
È importante notare come i gettoni __non si spostano__ da un posto a un altro conseguentemente a uno scatto, ma vengono proprio __distrutti__ nei posti in ingresso alla transizione e __generati__ nei posti in uscita.
Quest'ultima considerazione è importante per capire che i gettoni non sono sempre nello stesso numero.

Tramite questa struttura è facile mostrare al cliente quando qualcosa cambia all'interno del sistema, quindi è molto utile perché risulta essere più intuitivo rispetto a un linguaggio logico e descrittivo.
Questo è il vantaggio dei __modelli operativi__ come questo, la cui pecca però è che oltre a descrivere che cosa fa il sistema da informazioni anche su come lo fa, quindi rischia di diventare una via di mezzo tra una specifica ed un oggetto di design.
Il motivo per cui è possibile chiamarla specifica è che non viene effettivamente detto come il sistema deve svolgere il suo compito ma si deve comportare nello stesso modo descritto. <!-- Questa frase può essere scritta meglio -->
Quindi la rete descritta è una macchina di riferimento da utilizzare come confronto per capire se il funzionamento del sistema finale si comporta come dovrebbe (si può quindi dire che è come se fosse un oracolo).

## Definizione matematica

Di reti di Petri ne esistono numerosi dialetti, in questo caso vediamo le __PT net__ (reti con posti e transizioni) che sono le più classiche, successivamente verranno descritte delle estensioni e riduzioni di queste reti.

Una rete di Petri classicamente è una 5-tupla $$[P, \, T; \; F, \, W, \, M_0]$$:
- $$P$$ è l'insieme degli identificatori dei posti;
- $$T$$ è l'insieme degli identificatori delle transizioni;
- $$F$$ è la relazione di flusso;
- $$W$$ è una funzione che associa un peso ad ogni flusso; 
- $$M_0$$ è la marcatura iniziale, ovvero l'assegnamento iniziale dei _gettoni_.

Da notare che P e T a livello matematico sono degli insiemi di identificatori che non si sovrappongono (ovvero sono tutti entità differenti) a cui poi verrà assegnato un significato, quindi precedentemente sono stati associati a posti e transizioni, ma di fatto sono tutti identificatori.

Data la 5-tupla appena descritta esistono le seguenti proprietà:
- $$P \cap T = \varnothing$$; 
- $$P \cup T \neq \varnothing$$ (una rete in cui non c'è nulla non è una rete, almeno un posto o una transizione ci devono essere);
- $$F \subseteq (P \times T) \cup (T \times P)$$;
- $$W: \: F \rightarrow \mathbb N - \{ 0 \}$$;
- $$M_0: P \rightarrow \mathbb N$$.

Utilizziamo alcune _scorciatoie_:
- $$\operatorname{Pre}(a) = \{ d \in (P \cup T) \ \text{t.c.} \ \langle d, \, a \rangle \in F \}$$;
- $$\operatorname{Post}(a) = \{ d \in (P \cup T) \ \text{t.c.} \ \langle a,\, d \rangle \in F \}$$.

esplicitando queste ultime due scritture:
- Il preset di un nodo _a_ è un insieme di quegli elementi _d_ appartenenti all'unione degli insiemi degli identificatori di posti e transizioni tali che esiste una relazione di flusso tra _d_ e _a_ appartenente a F, in sostanza questo insieme rappresenta l'insieme degli identificatori precedenti di _a_ <!-- al posto di precedenti si può mettere antecedenti -->
- Il postset di un nodo _a_ è un insieme di quegli elementi _d_ appartenenti all'unione degli insiemi degli identificatori di posti e transizioni tali che esiste una relazione di flusso tra _a_ e _d_ appartenente a F, in sostanza questo insieme rappresenta l'insieme degli identificatori successivi di _a_ <!-- al posto di precedenti si può mettere conseguenti, anche se forse è un po brutto -->

Tutto questo rappresente la parte statica delle reti di Petri, ovvero prendendo la situazione in un preciso istante, senza considerare i cambiamenti che potrebbero avvenire.

### Comportamento dinamico

Una transizione $$t \in T$$ è __abilitata__ in una particolare marcatura $$M$$, ovvero dato un particolare assegnamento di gettoni (marcatura iniziale oppure una sua evoluzione) se e solo se

$$
\forall p \in \operatorname{Pre}(t) \quad M(p) \geq W( \langle p, \, t \rangle )
$$

In notazione, `M [ t >` significa che $$t$$ è abilitata in $$M$$. 

Significa che per ogni elemento collegato in ingresso a t esiste un numero di gettoni maggiore del peso dell'arco che collega $$p$$ a $$t$$.
Un aspetto interessante di questa definizione è che non si sta ragionando su tutti i posti della rete, ma solo su quelli collegati in ingresso a _t_, di conseguenza non è necessario conoscere l'intera rete per poter affermare che una transizione sia abilitata o meno, ma basta controllare la zona che comprende i posti appartenenti a $$ \operatorname{Pre}(a) $$, questa situazione è chiamata __località dell'analisi__.

Lo __scatto__ di una transizione $$t \in T$$ in una particolare marcatura $$M$$, produce nel momento successivo una nuova marcatura $$M'$$ tale per cui

$$
\begin{align*}
\forall p \in \operatorname{Pre}(t) - \operatorname{Post}(t)& \quad M'(p) = M(p) - W(\langle p, \, t \rangle) \\
\forall p \in \operatorname{Post}(t) - \operatorname{Pre}(t)& \quad M'(p) = M(p) + W(\langle t, \, p \rangle) \\
\forall p \in \operatorname{Post}(t) \cap \operatorname{Pre}(t)& \quad M'(p) = M(p) - W(\langle p, \, t \rangle) + W(\langle t, \, p \rangle) \\
\forall p \in P - \left ( \operatorname{Post}(t) \cap \operatorname{Pre}(t) \right )& \quad M'(p) = M(p)
\end{align*}
$$

<!-- L'ultimo elemento di questa lista di formule non viene allineato bene non so per quale motivo -->

specificando in modo descrittivo le notazioni precedenti:
- Per ogni identificatore $$p$$ appartenenti al preset ma non al postset della transizione in esame, il numero di gettoni della nuova marcatura $$M'$$ sarà uguale al numero di gettoni della marcatura precedente $$M$$ meno il peso dell'arco che collega $$p$$ a $$t$$;
- Per ogni identificatore $$p$$ appartenenti al postset ma non al preset della transizione in esame, il numero di gettoni della nuova marcatura $$M'$$ sarà uguale al numero di gettoni della marcatura precedente $$M$$ più il peso dell'arco che collega $$p$$ a $$t$$;
- Per ogni identificatore $$p$$ appartenenti sia al preset sia al postset della transizione in esame, il numero di gettoni della nuova marcatura $$M'$$ sarà uguale al numero di gettoni della marcatura precedente $$M$$ meno il peso dell'arco che collega $$p$$ a $$t$$ più il peso dell'arco che collega $$t$$ a $$p$$;
- Per ogni identificatore $$p$$ appartenenti all'insieme dei posti meno l'intersezione tra preset e postset di $$p$$ la marcatura non cambia.

In notazione, `M [ t > M'` significa che lo scatto di $$t$$ in $$M$$ produce $$M'$$.

## Da FSM a Petri

È _meccanicamente_ possibile trasformare una macchina a stati finiti in una reti di Petri. 

## Ordine di esecuzione

L'ordine è non deterministico. 
Nel caso in cui è possibile scattare due transizioni, abbiamo tre scelte:
- attiviamo la prima;
- attiviamo la seconda;
- non ne attiviamo nessuna (è la _non evoluzione_ è comunque un'evoluzione).

## Relazioni

### Sequenza

Una transazione $$t_1$$ è __in sequenza__ con una transizione $$t_2$$ in una marcatura $$M$$ se e solo se

$$M \ [ \ t_1 > \land \ M \ [ \ t_2 > \land \ M \ [ \ t_1 t_2 >$$

- $$t_1$$ è abilitata in $$M$$;
- $$t_2$$ NON è abilitata in $$M$$;
- $$t_2$$ viene abilitata dallo scatto di $$t_1$$ in $$M$$.

### Conflitto

Due transazioni $$(t_1, \, t_2)$$ sono in:
- __conflitto strutturale__ se e solo se $$\operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) = \ !?$$
- __conflitto effettivo__ in una marcatura $$M$$ se e solo se:
    - $$M \ [ \ t_1 > \cap \ M \ [ \ t_2 > $$: $$t_1$$ e $$t_2$$ sono abilitate in $$M$$;
    - $$\exists p \in \operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) \text{ t.c. } (M(p) < W(\langle p, \, t_1 \rangle)>) + W(\langle  p, \, t_2\rangle)$$: esistono .......................

#### Versione 'rilassata'

$$
M \ [ \ t_1 > \land \ M \ [ \ t_2 > \land \ \lnot M \ [ \ t_1 t_2 > 
$$

### Concorrenza

Due transazioni $$(t_1, \, t_2)$$ sono in:
- __concorrenza strutturale__ se e solo se $$\operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) = \varnothing$$
- __concorrenza effettiva__ in una marcatura $$M$$ se e solo se:
    - ...........................

    ovvero se per tutti i posti che hanno in comune c'è un numero di gettoni sufficienti per farli attivare (??)


## Insieme di raggiungibilità 

L'insieme di raggiungibilità $$R$$ di una rete a partire da una marcatura $$M$$ è il più piccolo insieme di marcature tale che:
- $$M \in R(P/T, \, M)$$;
- $$(M' \in R(P/T, \, M) \land \exists t \in T \ M' [t> M'') \Rightarrow M'' \in R(P/T, \, M)$$.

## Limitatezza

Le possibili evoluzioni possono essere limitate o illimitate.

Una rete $$P/T$$ con una marcatura $$M$$ si dice limitata se e solo se:

$$\exists k \in \mathbb N \quad \forall M' \in R(P/T, \, M) \\
\forall p \in P \quad M'(p) \leq k$$

cioè se è possibile .............

## Da RtP a automi

Se la rete è limitata allora l'insieme di raggiungibilità è finito allora è possibile definire un automa a stati finiti corrispondente.

- gli stati sono le possibili marcature dell'insieme di raggiungibilità
- le transizioni sono ...

## Vitalità di una transizione

Una transazione $$t$$ in una marcatura $$M$$ è detta _viva_ in..
- __grado 0__ se non è abilitata in nessuna marcatura appartanente all'insieme di raggiungibilità (è __morta__);
- __grado 1__ se esiste almeno una marcatura raggiungibil$$ in cui è abilitata;
- __grado 2__ se per ogni numero $$n$$ esiste almeno una sequenza ammissibile in cui la transizione scatta $$n$$ volte;
- __grado 3__ se esiste una sequenza di scatti ammissibile in cui scatta infinite volte;
- __grado 4__ se in qualunque marcatura raggiungibile esiste una sequenza ammissibile in cui scatta (è __viva__).

## Capacità dei posti 

Una possibile estensione delle reti di Petri consiste nel fissare un massimo numero di token ammissibili in un posto.
Si può forzare la limitatezza.

Tale estensione aumenta la potenza espressiva oppure è semplicemente una scorciatoia? 
È solo una scorciatoia, sono equipollenti.

### Posto complementare

Un posto $$pc$$ è complementare di $$p$$ se e solo se:

$$
\forall t \in T ( \exists \langle p, t \rangle \in F) \Leftrightarrow \exists \langle t,pc \rangle \in F \quad W(\langle ......... \rangle) .........
$$

### Abilitazione co ncapacità

In caso di reti con capacità sui posti la definizione di _abilitazione_ è

$$t \in T$$ è __abilitata__ in $$M$$ se e solo se 

$$
\begin{align*}
\forall p \in \operatorname{Pre}(t) &\quad M(p) \geq W(\langle p, t \rangle) \\
\forall p \in \operatorname{Post}(t) &\quad M(p) + W(\langle t, p \rangle) \leq C(p)
\end{align*}
$$

oppure si può ragionare diversamente

$$t \in T$$ è __abilitata__ in $$M$$ se solo se:

$$
\begin{align*}
\forall p \in \operatorname{Pre}(t) &\quad M(p) \geq W(\langle p, t \rangle) \\
\forall p \in \operatorname{Post}(t) \setminus \operatorname{Pre}(t) &\quad M(p) + W(\langle t, p \rangle) \leq C(p) \\
\forall p \in \operatorname{Post}(t) \cap \operatorname{Pre}(t) &\quad M(p) + W(\langle p, t \rangle) - W(\langle t, p \rangle) \leq C(p)
\end{align*}
$$

<!-- aggiungere esempio / marcature pure / pure-equivalenti / ecc .. -->

## Archi inibitori
Permettono di dire che non deve essere presente un token perché la transizione sia abilitata.

Permettono di impedire che ci siano più di $$k$$ gettoni in un posto.

In caso di rete limitata non cambia la potenza. Perché?
se sappiamo già che un posto è limitato o non ci sono più di $$k$$ gettoni generabili in ogni caso allora diventa inutile.

Un arco inibitore può avere un peso che è di fatto $$k$$ citato prima.
Normalmente il peso è 1.

## Eliminazione pesi archi

primo caso.

secondo caso.

### Reti C/E

- tutti gli archi hanno peso 1
- tutti i posti hanno capacità 1

## Conservatività 

Esiste una funzione di pesi $$H: P \rightarrow \mathbb N \setminus \{ 0 \}$$ una rete P/T con una marcatura $$M$$ si dice conservativa rispetto a tale funzione se e solo se

$$
\forall M' \in R(P/T, \, M) \quad \sum_{p \in P} H(p) M'(p) = \sum_{p \in P} H(p) M(p)
$$

relazione conservatività e limitatezza.

### Rete strettamente conservativa

Una rete P/T conservativa rispetto alla funzione che assegna pesi tutti uguale a 1 si dice _strettamente conservativa_.

$$
\forall M' \in R(P/T, \, M) \quad \sum_{p \in P} M'(p) = \sum_{p \in P} M(p)
$$

Il numero di token consumati dallo scatto di una trnaiszione è uguale al numero di gettoni generati dallo stesso

$$
\forall t \in T \quad \sum_{p \in \operatorname{Pre}(t)} W(\langle p, t \rangle) = \sum_{p \in \operatorname{Post}(t)} W(\langle t, p \rangle)
$$

t non è morta
