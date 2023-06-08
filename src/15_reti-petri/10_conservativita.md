<span style="display: none;">\\(\def\pt{\mathcal{P/T}}\\)</span>

# Conservatività 
La conservatività è una proprietà di una rete rispetto ad una funzione \\(H\\) che assegna un peso ad ogni posto della rete, e ognuno di questi pesi è positivo. \
Esiste quindi una **funzione di pesi** \\(H: P \rightarrow \mathbb N \setminus \{ 0 \}\\) tale per cui una rete \\(\pt\\) con una marcatura \\(M\\) si dice __conservativa rispetto ad \\(H\\)__ se e solo se:

$$
\forall M' \in R(\pt, \\, M) \quad \sum_{p \in P} H(p) M'(p) = \sum_{p \in P} H(p) M(p).
$$

Ovvero, per ogni marcatura \\(M'\\) raggiungibile dalla marcatura iniziale data una certa marcatura e una funzione \\(H\\), si dice che la rete è conservativa se la sommatoria dei gettoni di ogni posto (quest'ultimi pesati attraverso la funzione \\(H\\)) è _**costante** per qualunque marcatura raggiungibile_.

## Conservatività \\(\Rightarrow\\) limitatezza

Esiste inoltre un **legame** tra **conservatività** e **limitatezza**, ovvero _una rete che garantisce la conservatività è limitata, ma non è detto il viceversa_ (quindi _la limitatezza è una condizione necesaria ma non sufficiente per la conservatività_).

### Dimostrazione

Assumendo che \\(\sum_{p \in P} H(p) M(p)=k\\), allora

$$
\forall M' \in R(\pt, \\, M) \quad \sum_{p \in P} H(p) M'(p) = k.
$$

Sapendo inoltre che \\(\forall p \in P \quad H(p) > 0\\), allora ogni elemento della sommatoria ha un **contributo nullo o positivo**.
Infatti, se non ci sono gettoni all'interno del posto il contributo della sommatoria sarà un numero positivo (\\(H(p)\\)) moltiplicato per 0, quindi nullo. 

Quindi, se esiste almeno una marcatura di \\(p\\) cui numero di gettoni è diverso da 0, il suo contributo è positivo ma limitato da \\(k\\).
Questo vale per ogni posto all'interno della rete, riconducendosi di conseguenza alla definizione di <a href="#limitatezza">limitatezza</a>. 
<span style="float: right"> \\(\blacksquare\\) </span>

## Rete strettamente conservativa
La _conservatività stretta_ è un particolare caso di conservatività definibile come segue: una rete \\(\pt\\) conservativa rispetto alla funzione \\(H\\) che assegna pesi tutti uguali a 1 si dice _strettamente conservativa_.

$$
\forall M' \in R(\pt, \\, M) \quad \sum_{p \in P} M'(p) = \sum_{p \in P} M(p).
$$

La sommatoria del numero di gettoni per ogni posto in una _qualsiasi marcatura_ è **costante**, ovvero è uguale alla sommatoria dei gettoni della marcatura iniziale per ogni posto. 
In altre parole, dopo lo scatto di una transazione viene forzata la **distruzione del gettone in ingresso** e la **generazione di un'altro in uscita**. 

Matematicamente questo concetto si può esprimere anche tramite questa espressione:

$$
\forall t \in T \quad \sum_{p \in \operatorname{Pre}(t)} W(\langle p, \\,  t \rangle) = \\! \sum_{p \in \operatorname{Post}(t)} \\! W(\langle t, \\, p \rangle)
$$

Per ogni transizione \\(t\\) la somma dei pesi degli archi che collegano ogni elemento del preset di \\(t\\) alla transizione \\(t\\) deve essere uguale alla sommatoria dei pesi degli archi che collegano la transizione \\(t\\) con ogni posto nel postset di \\(t\\).

Le due espressioni sopra esprimono lo stesso concetto, ma la prima si riferisce alle **marcature** (stati) analizzando dinamicamente calcolando gli stati raggiungibili mentre l'altra all'**aspetto topologico** della rete (ovvero i pesi degli archi).

Si precisa che per quanto riguarda la seconda formula, le espressioni da considerare sono quelle __non morte__ (di grado \\(\geq 1\\)).
La seconda è anche più generale rispetto alla prima, ma potrebbe erroneamente considerare **non** strettamente conservative reti che **invece lo sono**.
