---
layout: post
title: "[14] Reti di Petri"
date: 2022-12-12 14:40:00 +0200
toc: true
---

# Reti di Petri

Servono per formalizzare le specifiche.

Sono in parte simili alle macchine a stati finiti, ma nascono specificatamente per descrivere sistemi concorrenti.

A differenza delle FSM, infatti:
- lo __stato__ non è più a livello di sistema ma come una composizione di stati parziali; le entità sono distinte ognuna con il proprio stato ma .... 
- le __transazioni__ non operano sullo stato globale ma si limitano a variarne una prte.

Un vantaggio delle reti di Petri è che possono essere viste anche in maniera informale dal cliente: i nodi sono _posti_ collegati alle _transizioni_ tramite archi di un grafo bipartito.
Ai posti sono assegnati dei ___token___, cui disposizione determina lo stato attuale della rete.

<!-- NON CHIARA QUESTA PARTE, SICURAMENTE IMPORTANTE -->
Una transizione è _abilitata_ quando ha negli archi entranti dei nodi con un certo numero di gettoni;
viene quindi _fireata_ (quale era il termine italiano?) i gettoni in ingresso vengono __distrutti__ e ne vengono creati altri verso i nodi uscenti. 

## Definizione matematica

Una rete di Petri è una 5-tupla $$[P, \, T; \; F, \, W, \, M_0]$$:
- $$P$$ è l'insieme dei posti; 
- $$T$$ è l'insieme delle transizioni (_gettoni_);
- $$F$$ è la relazione di flusso;
- $$W$$ è una funzione che associa un peso ad ogni flusso; 
- $$M_0$$: la marcatura iniziale, ovvero l'assegnamento iniziale dei _gettoni_,

con:
- $$P \cap T = \varnothing$$; 
- $$P \cup T \neq \varnothing$$;
- $$F \subseteq (P \times T) \cup (T \times P)$$;
- $$W: \: F \rightarrow \mathbb N \setminus \{ 0 \}$$;
- $$M_0: P \rightarrow \mathbb N$$.

Utilizziamo alcune _scorciatoie_:
- $$\operatorname{Pre}(a) = \{ d \in (P \cup T) \ \text{t.c.} \ \langle d, \, a \rangle \in F \}$$;
- $$\operatorname{Post}(a) = \{ d \in (P \cup T) \ \text{t.c.} \ \langle a,\, d \rangle \in F \}$$.

### Comportamento dinamico

Una transizione $$t \in T$$ è __abilitata__ in una particolare marcatura $$M$$ se e solo se

$$
\forall p \in \operatorname{Pre}(t) \quad M(p) \geq W( \langle p, \, t \rangle )
$$

significa che ......... __località dell'analisi__ ..........

In notazione, `M [ t >` significa che $$t$$ è abilitata in $$M$$. 

Lo __scatto__ di una transizione $$t \in T$$ in una particolare marcatura $$M$$, produce nel momento successivo una nuova marcatura $$M'$$ tale per cui

$$
\begin{align*}
\forall p \in \operatorname{Pre}(t) \setminus \operatorname{Post}(t)& \quad M'(p) = M(p) - W(\langle p, \, t \rangle) \\
\forall p \in \operatorname{Post}(t) \setminus \operatorname{Pre}(t)& \quad M'(p) = M(p) + W(\langle t, \, p \rangle) \\
\forall p \in \operatorname{Post}(t) \cap \operatorname{Pre}(t)& \quad M'(p) = M(p) - W(\langle p, \, t \rangle) + W(\langle t, \, p \rangle) \\
\forall p \in P \setminus \left ( \operatorname{Post}(t) \cap \operatorname{Pre}(t) \right )& \quad M'(p) = M(p)
\end{align*}
$$

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
