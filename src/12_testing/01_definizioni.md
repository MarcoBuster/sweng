# Definizioni

## Correttezza

La maggior parte dei problemi che si verificano durante lo sviluppo di un progetto sono causati da _problemi di comunicazione_.
Ci possono essere incomprensioni quando le informazioni passano da una figura all'altra, come quando ci si interfaccia tra cliente, analista e programmatore.
Il programmatore dovrà adattare il proprio linguaggio per farsi comprendere dal cliente prestando maggiore attenzione alla formalità e alla chiarezza della comunicazione con il passare del tempo.
Più i concetti sono spiegati chiaramente, più è difficile incorrere in problemi successivi: è quindi necessario fare attenzione alla __terminologia__ utilizzata.

Partiamo quindi dalle basi: quando un programma si definisce ___corretto___?

Considerando un generico programma \\(P\\) come una funzione da un insieme di dati \\(D\\) (dominio) a un insieme di dati \\(R\\) (codominio) allora:

- \\(P(d)\\) indica l'__esecuzione__ di \\(P\\) su un certo input \\(d \in D\\),
- il risultato \\(P(d)\\) è __corretto__ se soddisfa le specifiche, altrimenti è scorretto,
- \\(\operatorname{ok}(P, \\, d)\\) indica la __correttezza__ di \\(P\\) per il dato \\(d\\)

quindi

$$
\boxed{P \text{ è } \textit{corretto} \Longleftrightarrow \forall d \in D \\:, \text{ } \operatorname{ok}(P, \\, d)}
$$

A parole, _un programma __è corretto__ quando __per ogni dato__ del dominio vale \\(\operatorname{ok}(P, \\, d)\\)_.

Per indicare la correttezza di programma \\(P\\) si utilizza la notazione \\(\operatorname{ok}(P, \\, D)\\), che appunto indica che \\(P\\) è _corretto_ per qualunque \\(d \in D\\).

## Definizione di test

Durante l'attività di testing ciò che viene fatto è sottoporre il programma a una serie di stimolazioni per saggiarne il comportamento in tali circostanze.
Eseguire un test vuole quindi dire eseguire il programma con una serie di input appartenenti al suo dominio e confrontare i risultati ottenuti con il risultato atteso secondo le specifiche.

Volendone dare una definizione più rigorosa, _un __test__ è un sottoinsieme del dominio dei dati_ e _un singolo __caso di test__ è un elemento di esso_.
Un test sono quindi __più stimolazioni__, mentre un caso di test è una __singola stimolazione__. \
Matematicamente:

- un test \\(T\\) per un programma \\(P\\) è un sottoinsieme del suo dominio \\(D\\);
- un elemento \\(t\\) di un test \\(T\\) è detto _caso di test_;
- l'esecuzione di un test consiste nell'esecuzione del programma \\(\forall t \in T \subseteq D\\).

Un programma \\(P\\) supera (o _passa_) un test \\(T\\) se:

$$
\operatorname{ok}(P, \\, T) \Longleftrightarrow \forall t \in T \\:, \text{ } \operatorname{ok}(P, \\, t)
$$

Quindi, _un programma è __corretto per un test__ quando __per ogni caso di test__ esso è __corretto___.

Lo scopo dei test è però ricercare comportamenti anomali nel programma per permetterci di correggerli.
Diciamo quindi che _un test \\(\\, T\\) ha __successo__ se rileva uno o più malfunzionamenti presenti nel programma \\(P\\)_:

$$
\operatorname{successo}(T, \\, P) \Longleftrightarrow \exists t \in T \\: | \\: \lnot \operatorname{ok}(P, \\, t)
$$

## Test ideale

Se un test non rileva alcun malfunzionamento __non significa che il programma sia corretto__: come visto nella lezione precedente, il test è un'attività ottimistica e normalmente il passaggio di un test non garantisce l'assenza di anomalie.
Questo smette però di essere vero nel caso di _test ideali_.

_Un test \\(T\\) si definisce __ideale__ per \\(P\\) se e solo se_

$$\operatorname{ok}(P, \\, T) \Rightarrow \operatorname{ok}(P, \\, D)$$

_ovvero se il superamento del test __implica la correttezza del programma___.

Purtroppo però in generale è ___impossibile_ trovare un test ideale__, come ci suggerisce la seguente ipotesi universalmente accettata:

> __Tesi di Dijkstra__:
>
> _Il test di un programma può rilevare la presenza di malfunzionamenti ma non dimostrarne l'assenza._
>
> _Non esiste quindi un algoritmo che dato un programma arbitrario \\(P\\) generi un test ideale __finito__ \
> (il caso \\(T = D\\) non va considerato)._

Notiamo come la tesi escluda esplicitamente il _test esaustivo_ \\(T = D\\), restringendosi a considerare i test finiti (mentre il dominio \\(D\\) potrebbe anche essere infinito).
Per capire il perché di questa distinzione è sufficiente osservare il seguente esempio:

```java
static int sum(int a, int b) {
    return a + b;
}
```

In Java un int è espresso su 32 bit, quindi il dominio di questa semplice funzione somma ha cardinalità \\(2^{32} \cdot 2^{32} = 2^{64} \sim 2 \cdot 10^{19}\\).
Considerando quindi un tempo di esecuzione ottimistico di 1 nanosecondo per ogni caso di test, un test esaustivo che provi tutte le possibili combinazioni di interi impiegherebbe più di 600 anni per essere eseguito per intero.

_Il __test esaustivo__ è quindi __impraticabile__._
