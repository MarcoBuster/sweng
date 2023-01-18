---
layout: post
title: "[13] Testing e Processi di review"
date: 2022-11-23 14:40:00 +0200
toc: true
---

# Testing strutturale

La maggior parte dei problemi che si verificano durante lo sviluppo di un progetto sono causati da _problemi di comunicazione_.
Ci possono essere incomprensioni quando le informazioni passano da una figura all'altra, come quando ci si interfaccia tra cliente, analista e programmatore.
Il programmatore dovrà adattare il proprio linguaggio per farsi comprendere dal cliente prestando maggiore attenzione alla formalità e alla chiarezza della comunicazione con il passare del tempo.
Più i concetti sono spiegati chiaramente, più è difficile incorrere in problemi successivi: è quindi necessario fare attenzione alla __terminologia__ utilizzata.

Partiamo quindi dalle basi: quando un programma si definisce ___corretto___?

Considerando un generico programma $$P$$ come una funzione da un insieme di dati $$D$$ (dominio) a un insieme di dati $$R$$ (codominio) allora:

- $$P(d)$$ indica l'__esecuzione__ di $$P$$ su un certo input $$d \in D$$,
- il risultato $$P(d)$$ è __corretto__ se soddisfa le specifiche, altrimenti è scorretto,
- $$\operatorname{ok}(P, \, d)$$ indica la __correttezza__ di $$P$$ per il dato $$d$$

quindi

$$
\boxed{P \text{ è } \textit{corretto} \Longleftrightarrow \forall d \in D \:, \text{ } \operatorname{ok}(P, \, d)}
$$

A parole, _un programma __è corretto__ quando __per ogni dato__ del dominio vale $$\operatorname{ok}(P, \, d)$$_.

Per indicare la correttezza di programma $$P$$ si utilizza la notazione $$\operatorname{ok}(P, \, D)$$, che appunto indica che $$P$$ è _corretto_ per qualunque $$d \in D$$.

## Definizione di test

Durante l'attività di testing ciò che viene fatto è sottoporre il programma a una serie di stimolazioni per saggiarne il comportamento in tali circostanze.
Eseguire un test vuole quindi dire eseguire il programma con una serie di input appartenenti al suo dominio e confrontare i risultati ottenuti con il risultato atteso secondo le specifiche.

Volendone dare una definizione più rigorosa, _un __test__ è un sottoinsieme del dominio dei dati_ e _un singolo __caso di test__ è un elemento di esso_.
Un test sono quindi __più stimolazioni__, mentre un caso di test è una __singola stimolazione__. \\
Matematicamente:

- un test $$T$$ per un programma $$P$$ è un sottoinsieme del suo dominio $$D$$;
- un elemento $$t$$ di un test $$T$$ è detto _caso di test_;
- l'esecuzione di un test consiste nell'esecuzione del programma $$\forall t \in T \subseteq D$$.

Un programma $$P$$ supera (o _passa_) un test $$T$$ se:

$$
\operatorname{ok}(P, \, T) \Longleftrightarrow \forall t \in T \:, \text{ } \operatorname{ok}(P, \, t)
$$

Quindi, _un programma è __corretto per un test__ quando __per ogni caso di test__ esso è __corretto___.

Lo scopo dei test è però ricercare comportamenti anomali nel programma per permetterci di correggerli.
Diciamo quindi che _un test $$\, T$$ ha __successo__ se rileva uno o più malfunzionamenti presenti nel programma $$P$$_:

$$
\operatorname{successo}(T, \, P) \Longleftrightarrow \exists t \in T \: | \: \lnot \operatorname{ok}(P, \, t)
$$

### Test ideale

Se un test non rileva alcun malfunzionamento __non significa che il programma sia corretto__: come visto nella lezione precedente, il test è un'attività ottimistica e normalmente il passaggio di un test non garantisce l'assenza di anomalie.
Questo smette però di essere vero nel caso di _test ideali_.

_Un test $$T$$ si definisce __ideale__ per $$P$$ se e solo se_

$$\operatorname{ok}(P, \, T) \Rightarrow \operatorname{ok}(P, \, D)$$

_ovvero se il superamento del test __implica la correttezza del programma___.

Purtroppo però in generale è ___impossibile_ trovare un test ideale__, come ci suggerisce la seguente ipotesi universalmente accettata:

> __Tesi di Dijkstra__:
>
> _Il test di un programma può rilevare la presenza di malfunzionamenti ma non dimostrarne l'assenza._
>
> _Non esiste quindi un algoritmo che dato un programma arbitrario $$P$$ generi un test ideale __finito__ \\
> (il caso $$T = D$$ non va considerato)._

Notiamo come la tesi escluda esplicitamente il _test esaustivo_ $$T = D$$, restringendosi a considerare i test finiti (mentre il dominio $$D$$ potrebbe anche essere infinito).
Per capire il perché di questa distinzione è sufficiente osservare il seguente esempio:

```java
static int sum(int a, int b) {
    return a + b;
}
```

In Java un int è espresso su 32 bit, quindi il dominio di questa semplice funzione somma ha cardinalità $$2^{32} \cdot 2^{32} = 2^{64} \sim 2 \cdot 10^{19}$$.
Considerando quindi un tempo di esecuzione ottimistico di 1 nanosecondo per ogni caso di test, un test esaustivo che provi tutte le possibili combinazioni di interi impiegherebbe più di 600 anni per essere eseguito per intero.

_Il __test esaustivo__ è quindi __impraticabile__._

## Criteri di selezione

Assodato che un test ideale è impossibile da realizzare, come possiamo scegliere un _sottoinsieme del dominio_ che approssimi il più possibile un _test ideale_? \\
Esistono una serie di __criteri di selezione__ che hanno proprio lo scopo di guidare la selezione dei casi di test all'interno del dominio in modo da massimizzare la probabilità che il test abbia successo.
Prima però di illustrarne alcuni, vediamo quali caratteristiche dovrebbero avere questi criteri.

### Proprietà

#### Affidabilità

_Un criterio di selezione $$C$$ si dice __affidabile__ se presi due test $$T_1$$ e $$T_2$$ in base al criterio allora \\
o entrambi hanno successo o nessuno dei due ha successo_.

$$
\boxed{
    \operatorname{affidabile}(C, \, P) \Longleftrightarrow \left (
        \forall T_1 \in C, \, \forall T_2 \in C \:, \text{ } \operatorname{successo}(T_1, \, P) \Leftrightarrow \operatorname{successo}(T_2, \, P)
    \right )
}
$$

#### Validità

_Un criterio di selezione si dice __valido___ _se qualora $$P$$ non sia corretto, allora esiste almeno un test $$T$$ selezionato in base al criterio $$C$$ che ha successo e quindi rileva uno o più malfunzionamenti per il programma $$P$$:_

$$
\boxed{
    \operatorname{valido}(C, \, P) \Longleftrightarrow \left (
        \lnot \operatorname{ok}(P, \, D) \Rightarrow \exists T \in C \: | \operatorname{successo}(T,\,P)
    \right )
}
$$

#### Esempio

Si consideri il seguente codice.

```java
static int raddoppia(int par) {
    int risultato;
    risultato = (par * par);
    return risultato;
}
```

Un criterio che seleziona:

- _"i sottoinsiemi di $$\{0, \, 2\}$$”_ è __affidabile__, perché il programma funziona sia con $$0$$ sia con $$2$$, ma __non valido__, perché sappiamo che il programma non è corretto e non esiste un test che trovi malfunzionamenti;
- _"i sottoinsiemi di $$\{0, \, 1, \, 2, \, 3, \, 4\}$$”_ è __non affidabile__, perché i risultati dei casi di test non sono tutti coerenti (e quindi il test $$T1=\{0,1\}$$ non ha successo mentre $$T2=\{0, 3\}$$ sì), ma __valido__ perché esiste un test che rileva i malfunzionamenti.
- _"i sottoinsieme finiti di $$D$$ con almeno un valore maggiore di $$18$$”_ è __affidabile__, perché i risultati dei casi di test sono tutti coerenti, e __valido__ perché rileva i malfunzionamenti.

In questo caso la ricerca di un criterio valido e affidabile era semplice perché conoscevamo già l'anomalia.
Tuttavia, lo stesso non si può dire di un qualunque programma $$P$$ in quanto __non si conoscono i malfunzionamenti a priori__ e dunque è molto più difficile trovare criteri validi e affidabili.

#### Conclusione

L'obiettivo sarebbe quindi quello di trovare un _criterio valido e affidabile_ sempre.
Tuttavia ciò è purtroppo impossibile in quanto un criterio di questo tipo selezionerebbe test ideali, che sappiamo non esistere.

Immaginiamo infatti di avere un _criterio valido e affidabile_ e che un test selezionato da esso __non abbia successo__.
Sapendo che:

- non avendo successo allora non sono stati trovati errori,
- essendo il criterio affidabile allora tutti gli altri test selezionati da quel criterio non troveranno errori,
- essendo il criterio valido allora se ci fosse stato un errore almeno uno dei test lo avrebbe trovato

allora il programma è __corretto__, ovvero abbiamo trovato un test che quando non ha successo implica la correttezza del programma: in poche parole, un _test ideale_.
Esiste quindi un altro modo per implicare la correttezza di un programma:

$$
\boxed{
    \operatorname{affidabile}(C, \, P) \land \operatorname{valido}(C, \, P) \land T \in C \land \lnot\operatorname{successo}(T, \, P)
    \Longrightarrow
    \operatorname{ok}(P, \, D)
}
$$

In conclusione, trovare un criterio che sia __contemporaneamente__ affidabile e valido significherebbe trovare un criterio che selezioni __test ideali__ che sappiamo non esistere per la _tesi di Dijkstra_.
Dovremo dunque accontentarci di criteri che garantiscano solo una delle due caratteristiche.

### Utilità di un test

Abbandonata la vana speranza di un criterio di selezione universalmente valido che permetta di testare alla perfezione qualunque programma vediamo ora cosa significa _utilizzare_ un criterio di selezione per costruire un test.
Come sappiamo un test altro non è che un insieme di casi di test, specifici input appartenenti al dominio del programma: un criterio di selezione governa dunque quanti e quali casi di test vengono aggiunti al test che si sta costruendo.

Possiamo quindi ora farci una domanda: quali sono le __caratteristiche__ che __rendono utile__ un caso di test, ovvero che rendono "possibile" o "probabile" che il caso di test evidenzi un malfunzionamento causato da un'anomalia?
Ebbene, un caso di test utile deve:

- __eseguire il comando che contiene l'anomalia__ – non è altrimenti possibile che il malfunzionamento si manifesti;
- l'esecuzione del comando che contiene l'anomalia deve portare il sistema in uno
__stato scorretto__, o per meglio dire __inconsistente__;
- lo stato inconsistente deve propagarsi fino all'uscita del codice in esame in modo da __produrre un output diverso da quello atteso__;

Un buon criterio di selezione dovrà quindi selezionare test contenenti casi di test utili: ma quanti dovrebbe contenerne?
Per capire ciò si può utilizzare un metro di misura legato alle caratteristiche del codice: a ogni criterio è infatti possibile associare una __metrica__ che misuri la __copertura__ del test che si sta costruendo e che ci permetta di decidere _quando smettere di aggiungere casi di test_, _quali casi di test è opportuno aggiungere_ e di _confrontare la bontà di test diversi_.
Aggiungeremo infatti solo casi di test che permettano di aumentare la metrica di copertura, e test in grado di garantire una copertura maggiore saranno inerentemente migliori di test con una copertura minore.

### Criteri noti

Esploriamo quindi ora una serie di criteri di selezione, elencandone pro e contro, esplicitandone la metrica di copertura utilizzata e infine confrontandoli tra di loro per comprenderne le relazioni.

#### Criterio di copertura dei comandi

_Un test $$\ T$$ soddisfa il __criterio di copertura dei comandi__ se e solo se ogni comando eseguibile del programma è eseguito in corrispondenza di almeno un caso di test $$t \in T$$._ \\
La metrica è dunque la frazione di __comandi eseguibili su quelli eseguiti__ dall'intero test.

Consideriamo per esempio il seguente programma in pseudocodice:

<table>
<thead>
<tr>
    <th colspan="2">Esempio 1: copertura dei comandi</th>
</tr>
<tr>
    <td style="width: 50%" align="center">Pseudocodice</td>
    <td style="width: 50%" align="center">Diagramma di flusso di esecuzione</td>
</tr>
</thead>
<tbody>
<tr>
<td markdown="1">
```c
01  void main(){
02      float x, y;
03      read(x);
04      read(y);
05      if (x != 0)
06          x = x + 10;
07      y = y / x;
08      write(x);
09      write(y);
10  }
```
</td>
<td markdown="1">
{% responsive_image path: 'assets/13_criteri-copertura-esempio-1.png' %}
</td>
</tr>
</tbody>
</table>

È possibile ricostruire un __diagramma di flusso di esecuzione__ del codice trasformando ogni comando in un nodo del diagramma: _coprire tutti i comandi_ significa quindi visitare tutti i nodi raggiungibili.

Applicare il _criterio di copertura dei comandi_ significa quindi trovare un insieme di casi di test in cui _per ogni nodo esiste un caso di test che lo attraversa_.

Nel nostro esempio il singolo caso di test $$ \langle 3, \, 7 \rangle$$ risulterebbe quindi sufficiente, dato che la sua esecuzione permette di _coprire_ tutti i comandi del programma.
Tuttavia, pur massimizzando la metrica di copertura dei comandi tale test non è in grado di rilevare l'anomalia alla riga 7, in cui viene fatta una divisione senza prima controllare che il divisore sia diverso da zero.

Soddisfare il criterio di copertura dei comando __non garantisce__ dunque la correttezza del programma.
Come sappiamo infatti un'anomalia non sempre genera un malfunzionamento, per cui eseguire semplicemente tutte le righe di codice raggiungibili non assicura di rilevare eventuali errori.

#### Criterio di copertura delle decisioni

_Un test $$\ T$$ soddisfa il __criterio di copertura delle decisioni__ se e solo se ogni decisione (effettiva) viene resa sia vera che falsa in corrispondenza di almeno un caso di test $$t \in T$$_. \\
La metrica è quindi la frazione delle __decisioni totali possibili__ presenti nel codice che sono state rese __sia vere che false__ nel test.

Dovendo attraversare ogni possibile flusso di controllo il criterio di copertura delle decisioni __implica il criterio di copertura dei comandi__.
Estraendo il codice in un diagramma di flusso, infatti, è possibile coprire tutte le decisioni se e solo se ogni arco (_e quindi ogni nodo_) viene attraversato.
Non è invece vero l'inverso.

<table>
<thead>
<tr>
    <th colspan="2">Esempio 2: copertura delle decisioni</th>
</tr>
<tr>
    <td style="width: 50%" align="center">Pseudocodice</td>
    <td style="width: 50%" align="center">Diagramma di flusso di esecuzione</td>
</tr>
</thead>
<tbody>
<tr>
<td markdown="1">
```c
01  void main(){
02      float x, y;
03      read(x);
04      read(y);
05      if (x != 0 && y > 0)
06          x = x + 10;
07      else
08          y = y / x
09      write(x);
10      write(y);
11  }
```
</td>
<td markdown="1">
{% responsive_image path: 'assets/13_criteri-copertura-esempio-2.png' %}
</td>
</tr>
</tbody>
</table>

Dall'esempio sopra, un test che soddisfi il suddetto criterio potrebbe includere $$\{ \langle 3, \, 7 \rangle, \, \langle 3, \, -2 \rangle \}$$.
Nonostante sia un criterio _"migliore"_ del precedente, la copertura delle decisioni __non garantisce__ la correttezza del programma: nell'esempio il caso $$\langle 0, \, 5 \rangle$$ eseguirebbe comunque una divisione per zero.

#### Criterio di copertura delle condizioni

_Un test $$\ T$$ soddisfa il __criterio di copertura delle condizioni__ se e solo se ogni singola condizione (effettiva) viene resa sia vera che falsa in corrispondenza di almeno un caso di test $$\ t \in T$$_. \\
Similmente ai criteri precedenti, la metrica è quindi la percentuale delle __condizioni__ che sono state rese __sia vere che false__ su quelle per cui è possibile farlo.

Sebbene simile, si tratta di un criterio diverso da quello di copertura delle decisioni: in caso di condizioni composte, come per esempio `x != 0 && y < 3`, la copertura delle decisioni imporrebbe che l'_intera condizione_ sia resa sia vera che falsa, mentre la copertura delle condizioni richiede di rendere vere e false le singole _condizioni atomiche_ `x != 0` e `y < 3` in almeno un caso di test. \\
Come vedremo nell'esempio, ciò non impone quindi di seguire tutti i percorsi sul diagramma di flusso e fa sì che questo criterio __non implica__ il soddisfacimento di nessuno dei precedenti.

<table>
<thead>
<tr>
    <th colspan="2">Esempio 3: copertura delle condizioni</th>
</tr>
<tr>
    <td style="width: 50%" align="center">Pseudocodice</td>
    <td style="width: 50%" align="center">Diagramma di flusso di esecuzione</td>
</tr>
</thead>
<tbody>
<tr>
<td markdown="1">
```c
01  void main(){
02      float x, y;
03      read(x);
04      read(y);
05      if (x != 0 || y > 0)
06          y = y / x;
07      else
08          y = (y + 2) / x
09      y = y / x;
10      write(x);
11      write(y);
12  }
```
</td>
<td markdown="1">
{% responsive_image path: 'assets/13_criteri-copertura-esempio-3.png' %}
</td>
</tr>
</tbody>
</table>

Nell'esempio sopra, il test $$ \{ \langle 0, \, 5 \rangle , \, \langle 5, \, -5 \rangle \} $$ __soddisfa il criterio di copertura della condizioni__ \\
(`x != 0` è falsificato da $$\langle 0, \,5 \rangle$$ e verificato da $$\langle 5, \, -5 \rangle$$, mentre `y > 0` è verificato da $$\langle 0, \, 5 \rangle$$ e falsificato da $$\langle 5, \, -5 \rangle$$), ma __la decisione è sempre vera__.

Sono infatti presenti anomalie alla riga 6 (possibile divisione per zero) e alla riga 8 (overflow e divisione per zero), ma i comandi contenuti nella riga 8 non sono coperti.
In questo caso più che mai, quindi, la copertura delle condizioni __non garantisce__ la correttezza del programma.

#### Criterio di copertura delle decisioni e condizioni

_Un test $$\ T$$ soddisfa il __criterio di copertura delle decisioni e delle condizioni__ se e solo se __ogni decisione__ vale sia vero che falso e __ogni condizione__ che compare nelle decisioni del programma vale sia vero che falso per diversi casi di test $$\ t \in T$$_.

È – intuitivamente – l'__intersezione__ del criterio di copertura delle decisioni con il criterio di copertura delle condizioni, per cui il soddisfacimento di questo criterio __implica__ sia il criterio di copertura delle condizioni che quello di copertura delle decisioni (e quindi dei comandi).

Nell'esempio 3, il test $$\{ \langle 0, \, -5 \rangle, \, \langle 5, \, 5 \rangle \}$$ soddisfa il criterio di copertura delle decisioni e condizioni e rileva l'anomalia alla riga 8 ma non quella alla riga 6.
__Non garantisce__ quindi neanche in questo caso la correttezza del programma.

#### Criterio di copertura delle condizioni composte

_Un test $$\ T$$ soddisfa il __criterio di copertura delle condizioni composte__ se e solo se ogni possibile composizione delle condizioni base vale sia vero che falso per diversi casi di test $$\ t \in T$$_.

Viene cioè testata ogni possibile combinazione di valori delle condizioni atomiche quando queste sono aggregate in condizioni composte: riprendendo per esempio la condizione `x != 0 && y < 3`, vengono testati separatamente i casi $$\langle V, V\rangle$$, $$\langle V, F\rangle$$, $$\langle F, V\rangle$$ e $$\langle F, F\rangle$$. \\
È quindi facile notare che __questo criterio implica il precedente__ (criterio di copertura delle decisioni e condizioni), implicando a sua volta il criterio di copertura delle decisioni, delle condizioni e dei comandi.

Data la __natura combinatoria__ di questo criterio, all'aumento del numero di condizioni di base _il numero di casi di test_ cresce però troppo rapidamente, motivo per cui il soddisfacimento di questo criterio è considerato __non applicabile__ in pratica.
Inoltre, dato che le condizioni di base potrebbero non risultare indipendenti tra loro, potrebbero esistere __combinazioni non fattibili__ che non avrebbe alcun senso testare.

#### Criterio di copertura delle condizioni e delle decisioni modificate

Non volendo testare tutte le combinazioni di condizioni, ci si rende presto conto che certe combinazioni sono __più rilevanti__ di altre: se modificando una sola condizione atomica si riesce a modificare l'esito della decisione, allora è molto significativa – indipendentemente dalla sua dimensione.
Se invece l'esito della decisione non varia, allora la modifica può essere considerata neutra o meno significativa. \\
Il criterio così ottenuto prende il nome di __criterio di copertura delle condizioni e delle decisioni modificate__.

Si dà quindi importanza nella selezione delle combinazioni al fatto che la modifica di una singola condizione base porti a __modificare l'esito della decisione__.
Per ogni condizione base devono quindi esistere due casi di test che modificano il valore di una sola condizione base e che portino a un diverso esito della decisione: in questo modo, inoltre, il criterio __implica quello di copertura delle condizioni e delle decisioni__.

Si può dimostrare che se si hanno $$N$$ condizioni base __sono sufficienti $$N+1$$ casi di test__ per soddisfare questo criterio, decisamente meno di quelli richiesti dal criterio delle condizioni composte.

#### Implicazioni tra criteri di copertura

{% responsive_image path: 'assets/13_criteri-copertura-implicazione.png' %}

Ecco dunque uno schema delle implicazioni tra i vari criteri di copertura.
Come si vede, il criterio delle condizioni composte va considerato troppo oneroso e quindi non applicabile, mentre gli altri criteri possono invece essere utilizzati anche nell'ambito di progetti di dimensioni reali.

### Altri criteri

I criteri visti finora __non considerano i cicli__ e possono essere soddisfatti da test che percorrono ogni ciclo al più una volta.
Molti errori però si verificano durante __iterazioni successive alla prima__, come per esempio quando si superano i limiti di un array.

Occorre quindi sviluppare dei criteri che tengano conto anche delle iterazioni e stimolino i cicli un numero di volte sufficiente.

<table>
<thead>
<tr>
    <th colspan="2">Esempio 4: copertura delle iterazioni</th>
</tr>
<tr>
    <td style="width: 50%" align="center">Pseudocodice</td>
    <td style="width: 50%" align="center">Diagramma di flusso di esecuzione</td>
</tr>
</thead>
<tbody>
<tr>
<td markdown="1">
```c
01  void main() {
02      float a, b, x, y;
03      read(x);
04      read(y);
05      a = x;
06      b = y;
07      while (a != b) {
08          if (a > b)
09              a = a - b;
10          else
11              b = b - a;
12      }
13      write(a);
14  }
```
</td>
<td markdown="1">
{% responsive_image path: 'assets/13_criteri-copertura-esempio-4.png' %}
</td>
</tr>
</tbody>
</table>

#### Criterio di copertura dei cammini

_Un test $$\ T$$ soddisfa il __criterio di copertura dei cammini__ se e solo se ogni cammino del grafo di controllo del programma viene percorso per almeno un caso di $$t \in T$$_. \\
La metrica è quindi il rapporto tra i __cammini percorsi__ e __quelli effettivamente percorribili__.

Questo criterio è molto generale ma è spesso impraticabile, anche per programmi semplici: la presenza di cicli imporrebbe infatti di testare tutti gli infiniti cammini che li attraversano un numero arbitrario di volte. Il criterio è quindi considerato __non applicabile__ in pratica.

#### Criterio di $$n$$-copertura dei cicli

_Un test $$\ T$$ soddisfa il __criterio di $$\bf{\it{n}}$$-copertura__ se e solo se ogni cammino del grafo contenente al massimo un numero d'iterazioni di ogni ciclo non superiore a $$n$$ viene percorso per almeno un caso di test $$\ t \in T$$._

La definizione sopra non significa che il test deve eseguire $$n$$ volte un ciclo, ma che per ogni numero $$k$$ compreso tra 0 e $$n$$ deve esistere un caso di test che esegue tale ciclo $$k$$ volte.
Si sta quindi __limitando il numero massimo di percorrenze__ dei cicli. \\
Di conseguenza, al crescere di $$n$$ il numero di test aumenta molto rapidamente.
Inoltre, fissare $$n$$ a livello di programma può non essere un'azione così semplice: il numero d'iterazioni che necessita un ciclo per essere testato a fondo può essere __molto differente__ a seconda del caso.

Per cercare di minimizzare il numero di test spesso il criterio applicato è quello di __$$\bf{2}$$-copertura dei cicli__.
Si tratta infatti del numero minimo che permette comunque di testare tutte le casistiche principali:

- zero iterazioni;
- una iterazione;
- _più di una_ iterazione.

Il caso $$n = 2$$ è cioè il minimo per considerare casistiche non banali: dando uno sguardo all'esempio sopra, infatti, con $$n = 1$$ il ciclo (`while`) sarebbe stato indistinguibile da una semplice selezione (`if`); testando due iterazioni si incominciano a testare le vere caratteristiche del ciclo.
Esso permette cioè di testare non solo i comandi che compongono il ciclo, ma anche sue le pre/post-condizioni ed eventuali invarianti.

A differenza del criterio di copertura dei cammini, il criterio di $$n$$-copertura è considerato __applicabile__ a programmi reali.

#### Mappa finale delle implicazioni tra criteri di selezione

Aggiungendo i criteri di copertura che considerano esplicitamente i cicli si ottiene il seguente schema di implicazione tra tutti i criteri di selezione:

{% responsive_image path: assets/13_implicazioni-estese-criteri-copertura.png %}

# Analisi statica

Come abbiamo detto nella lezione precedente, il testing dell'esecuzione del programma non è però l'unica cosa che possiamo fare per aumentare la fiducia nostra e del cliente nella correttezza del programma.
Un'altra importante iniziativa in tal senso è l'ispezione tramite varie tecniche del _codice_ del programma, attività che prende il nome di __analisi statica__.

L'analisi statica si basa cioè sull'esame di un __insieme finito di elementi__ (_le istruzioni del programma_), contrariamente all'analisi dinamica che invece considera un insieme infinito (_gli stati delle esecuzioni_).
È un'attività perciò __meno costosa del testing__, poiché non soffre del problema dell'_"esplosione dello spazio degli stati"_.

Considerando solamente il codice "statico" del programma, questa tecnica non ha la capacità di rilevare anomalie dipendenti da particolari valori assunti dalle variabili a runtime.
Si tratta nondimeno di un'attività estremamente utile, che può aiutare a individuare numerosi errori e inaccortezze.

## Compilatori

Prima di trasformare il codice sorgente in eseguibile, i compilatori fanno un'attività di analisi statica per identificare errori sintattici (o presunti tali) all'interno del codice.

Il lavoro dei compilatori si può dividere solitamente in __quattro tipi di analisi__ (gli esempi sono presi dal compilatore di Rust, caratteristico per la quantità e qualità di analisi svolta durante la compilazione):

- __analisi lessicale__: identifica i token appartenenti o meno al linguaggio, permettendo di individuare possibili errori di battitura;

  ```txt
  error: expected one of `!`, `.`, `::`, `;`, `?`, `{`, `}`, or an operator, found `ciao`
  --> src/main.rs:2:9
    |
  2 |     BRO ciao = "mondo";
    |           ^^^^ expected one of 8 possible tokens
  ```

- __analisi sintattica__: controlla che i token identificati siano in relazioni _sensate_ tra di loro in base alla grammatica del linguaggio, scovando così possibili errori di incomprensione del linguaggio;

  ```txt
  error: expected `{`, found keyword `for`
  --> src/main.rs:2:14
    |
  2 |     if !expr for;
    |              ^^^ expected `{`
    |
  ```

- __controllo dei tipi__: nei linguaggi tipizzati, individua violazioni di regole d'uso dei tipi ed eventuali incompatibilità tra tipi di dati;

  ```txt
  error[E0308]: mismatched types
  --> src/main.rs:2:24
    |
  2 |     let name: String = 42;
    |               ------   ^^- help: try using a conversion method: `.to_string()`
    |               |        |
    |               |        expected struct `String`, found integer
    |               expected due to this

  For more information about this error, try `rustc --explain E0308`.
  ```

- __analisi flusso dei dati__: si cercano di rilevare problemi relativi all'_evoluzione dei valori_ associati alle variabili, come per esempio porzioni di codice non raggiungibili.

  ```txt
  error: equal expressions as operands to `!=`
  --> src/main.rs:2:8
    |
  2 |     if 1 != 1 {
    |        ^^^^^^
    |
  ```

Se i primi tre tipi di analisi sono abbastanza facili da comprendere, l'ultimo merita una maggiore attenzione, motivo per cui gli dedichiamo il prossimo paragrafo.

## Analisi Data Flow

Nata nell'ambito dell'__ottimizzazione dei compilatori__, che per migliorare le proprie performance ricercavano porzioni di codice non raggiungibile da non compilare, l'__analisi del flusso di dati__ è stata più avanti imbracciata dall'ingegneria del software per ricercare e prevenire le cause di errori simili. \\
Parlando di flusso dei dati si potrebbe pensare a un'analisi prettamente dinamica come il testing, ma l'insieme dei controlli statici che si possono fare sul codice per comprendere come vengono _utilizzati_ i valori presenti nel programma è invece particolarmente significativo.

È possibile infatti analizzare staticamente il tipo delle operazioni eseguite su una variabile e l'__insieme dei legami di compatibilità__ tra di esse per determinare se il valore in questione viene usato in maniera _semanticamente sensata_ all'interno del codice. \\
Nello specifico, le operazioni che possono essere eseguite su un __dato__ sono solamente di tre tipi:

<!-- KaTeX op macro definitions -->
<div style="display: none; margin: 0;">
$$
\require{color}
% Regular operations
\def\op#1{
  \fcolorbox{black}{white}{$\vphantom{d} \sf{#1}$}
}
\def\d{\op{d} \,}
\def\a{\op{a} \,}
\def\u{\op{u} \,}
% Erroneous operations
\def\opR#1{
  \fcolorbox{black}{orangered}{$\vphantom{d} \color{white}{\sf{#1}}$}
}
\def\dR{\opR{d} \,}
\def\aR{\opR{a} \,}
\def\uR{\opR{u} \,}
% Subscript operations
\def\Op#1#2{
  \fcolorbox{black}{white}{$\vphantom{d_6} \sf{#1}_{#2}$}
}
\def\D#1{\Op{d}{#1} \,}
\def\A#1{\Op{a}{#1} \,}
\def\U#1{\Op{u}{#1} \,}
% Warning subscript operations
\def\OpW#1#2{
  \fcolorbox{black}{orange}{$\vphantom{d_6} \sf{#1}_{#2}$}
}
% Green subscript operations
\def\OpG#1#2{
  \fcolorbox{black}{lightgreen}{$\vphantom{d_6} \sf{#1}_{#2}$}
}
\def\DG#1{\OpG{d}{#1} \,}
\def\AG#1{\OpG{a}{#1} \,}
\def\UG#1{\OpG{u}{#1} \,}
% Error
\def\Err{
  \color{red}{\sf{ERROR}}
}
\def\err{
  \, \Err
}
$$
</div>

- $$\op{d}$$ (__definizione__): il comando __assegna un valore__ alla variabile; anche il passaggio del dato come parametro ad una funzione che lo modifica è considerata un'operazione di (ri)definizione;

- $$\op{u}$$ (__uso__): il comando __legge il contenuto__ di una variabile, come per esempio l'espressione sul lato destro di un assegnamento;

- $$\op{a}$$ (__annullamento__): al termine dell'esecuzione del comando il valore della variabile __non è significativo/affidabile__.
  Per esempio, dopo la _dichiarazione senza inizializzazione_ di una variabile e al termine del suo _scope_ il valore è da considerarsi inaffidabile.

Dal punto di vista di ciascuna variabile è possibile ridurre una qualsiasi sequenza d'istruzioni (_ovvero un cammino sul diagramma di flusso_) a una sequenza di definizioni, usi e annullamenti.

### Regole

Fatta questa semplificazione è allora possibile individuare la presenza di anomalie nell'uso delle variabili definendo alcune __regole di flusso__: alcune di queste devono essere necessariamente rispettate in un programma corretto (1 e 3), mentre altre hanno più a che fare con la semantica dell'uso di un valore (2).

<ol>

<li markdown="1">
  L'**uso di una variabile** deve essere **sempre preceduto** in ogni sequenza **da una definizione senza annullamenti intermedi**.

  $$
  \a\u\err
  $$

</li>
<li markdown="1">
  La **definizione di una variabile** deve essere **sempre seguita** da **un uso**, **prima** di un suo **annullamento** o nuova **definizione**.

  $$
  \d\a\err \\
  \d\d\err
  $$

</li>
  <li markdown="1">
  L'**annullamento di una variabile** deve essere **sempre seguito** da **una definizione**, **prima** di un **uso** o **altro annullamento**.
  
  $$
  \a\a\err
  $$

</li>
</ol>

Riassumendo, $$\a\op{u}$$, $$\d\op{a}$$, $$\d\op{d}$$ e $$\a\op{a}$$ sono sequenze che identificano __situazioni anomale__, anche se non necessariamente dannose: se per esempio usare una variabile subito dopo averla annullata rende l'esecuzione del programma non controllabile, un annullamento subito dopo una definizione non crea nessun problema a runtime, ma è altresì indice di un possibile errore concettuale.

<table align="center" style="width: 50%">
<tr>
  <th></th>
  <th markdown="1">$$\a$$</th>
  <th markdown="1">$$\d$$</th>
  <th markdown="1">$$\u$$</th>
</tr>
<tr>
  <th markdown="1">$$\a$$</th>
  <th markdown="1">$$\Err$$</th>
  <th markdown="1"></th>
  <th markdown="1">$$\Err$$</th>
</tr>
<tr>
  <th markdown="1">$$\d$$</th>
  <th markdown="1">$$\Err$$</th>
  <th markdown="1">$$\Err$$</th>
  <th markdown="1"></th>
</tr>
<tr>
  <th markdown="1">$$\u$$</th>
  <th markdown="1"></th>
  <th markdown="1"></th>
  <th markdown="1"></th>
</tr>
</table>

#### Esempio

Consideriamo la seguente funzione C con il compito di scambiare il valore di due variabili:

```c
void swap(int &x1, int &x2) {
    int x1;
    x3 = x1;
    x3 = x2;
    x2 = x1;
}
```

Analizzando il codice, le sequenze per ogni variabile sono le seguenti:

| Variabile | Sequenza | Anomalie |
|-|-|-|
| `x1` | $$\aR\uR\u\a$$ | `x1` viene usata 2 volte senza essere stata prima definita |
| `x2` | $$\dots \d\u\op{d} \dots$$ | Nessuna |
| `x3` | $$\dots \d\dR\opR{d} \dots$$ | `x3` viene definita più volte senza nel frattempo essere stata usata |

Come si vede, in un codice sintatticamente corretto l'analisi Data Flow ci permette quindi di scovare un errore semantico osservando le sequenze di operazioni sulle sue variabili.

### Sequenze Data Flow

Abbiamo accennato più volte al concetto di "sequenza" di operazioni su una variabile.
Più formalmente, definiamo __sequenza__ di operazioni per la variabile $$\mathtt{a}$$ secondo il cammino $$p$$ la concatenazione della tipologia delle istruzioni che coinvolgono tale variabile, e la indichiamo con $$\operatorname{P}(p, \, \mathtt{a})$$.

Considerando per esempio il seguente programma C:

```c
01  void main() {
02      float a, b, x, y;
03      read(x);
04      read(y);
05      a = x;
06      b = y;
07      while (a != b)
08          if (a > b)
09              a = a - b;
10          else
11              b = b - a;
12      write(a);
13  }
```

possiamo dire che:

$$
\begin{align*}
&\operatorname{P}([1, 2, 3, 4, 5, 6, 7, 8, 9, 7, 12, 13], \, \mathtt{a}) \\
&= \A{2} \D{5} \U{7} \U{8} \U{9} \D{9} \U{7} \U{12} \A{13}
\end{align*}
$$

Eseguendo questo tipo di operazione su tutte le variabili e per tutti i cammini del programma si potrebbe verificare la presenza eventuali anomalie, ma come sappiamo __i cammini sono potenzialmente infiniti__ quando il programma contiene cicli e decisioni: per scoprire quali percorsi segue effettivamente l'esecuzione del programma dovremmo eseguirlo e quindi uscire dal campo dell'analisi statica.

#### Espressioni regolari

Tuttavia non tutto è perduto: un caso di cammini contenenti __cicli__ e __decisioni__ è possibile rappresentare un insieme di sequenze ottenute dal programma $$P$$ utilizzando delle __espressioni regolari__.
Con $$\operatorname{P}([1 \rightarrow], \, \mathtt{a})$$ si indica infatti l'espressione regolare che rappresenta __tutti i cammini__ che partono dall'istruzione $$1$$ per la variabile $$\mathtt{a}$$.

Questo perché nelle espressioni regolari è possibile inserire, oltre che una serie di parentesi che isolano sotto-sequenze, anche due simboli molto particolari:

- la __pipe__ (\|), che indica che i simboli (o le sotto-sequenze) alla propria destra e alla propria sinistra si _escludono_ a vicenda: _una e una sola_ delle due è presente;
- l'__asterisco__ (\*), che indica che il simbolo (o la sotto-sequenza) precedente può essere _ripetuto da 0 a $$n$$ volte_.

Grazie a questi simboli è possibile rappresentare rispettivamente decisioni e cicli.
Prendendo per esempio il codice precedente, è possibile costruire $$\operatorname{P}([1 \rightarrow], \, \mathtt{a})$$ come:

$$
\begin{align*}
&\A{2} \D{5} & & &&&  && && & & \\
&\A{2} \D{5} &\U{7} &\Big( &\phantom{\U8} &&\textit{while body} &&\phantom{\U{7}} &&\Big)* &\quad \quad \U{12} &\A{13} \\
&\A{2} \D{5} &\U{7} &\Big( &\U{8} &&\textit{if body} &&\phantom{\U{7}} &&\Big)* &\quad \quad \U{12} &\A{13} \\
&\A{2} \D{5} &\U{7} &\Big( &\U{8} &&\Big(\, \U{9} \D{9} \Big | \: \U{11} \Big) && &&\Big)* &\quad \quad \U{12} &\A{13} \\
&\A{2} \D{5} &\OpW{u}{7} \, &\Big( \, &\U{8} &&\Big(\, \U{9} \D{9} \Big | \: \U{11} \Big)
  &&\OpW{u}{7} \,
&&\Big)* &\quad \quad \U{12} &\A{13}
\end{align*}
$$

Osserviamo come $$\OpW{u}{7}$$ si ripeta due volte: questo può rendere _fastidioso_ ricercare errori, per via della difficoltà di considerare cammini multipli.
Comunque sia, una volta ottenuta un'espressione regolare è facile verificare l'eventuale presenza di errori applicando le solite regole (nell'esempio non ce n'erano).

Bisogna però fare attenzione a un'aspetto: le espressioni regolari così costruite rappresentano __tutti i cammini__ possibili del programma, ma __non tutti e i soli__!
Trattandosi di oggetti puramente matematici, infatti, le espressioni regolari sono necessariamente _più generali_ di qualunque programma: esse non tengono infatti conto degli _effetti_ che le istruzioni hanno sui dati e delle relative proprietà che si possono inferire. \\
Riprendendo a esempio l'espressione regolare di cui sopra, essa contiene la sequenza nella quale il ciclo viene eseguito _infinite volte_, ma osservando il programma è facile indovinare che tale comportamento non sia in realtà possibile: diminuendo progressivamente $$\mathtt{a}$$ e $$\mathtt{b}$$ a seconda di chi sia il maggiore si può dimostrare che prima o poi i due convergeranno allo stesso valore permettendo così di uscire dal ciclo.

In effetti, uno stesso programma può essere rappresentato tramite __un numero infinito di espressioni regolari__ valide.
Si potrebbe addirittura argomentare che l'espressione regolare

$$
\Big ( \, \u \Big | \: \d \Big | \: \a \Big)*
$$

possa rappresentare qualsiasi programma. \\
Allontanandosi però dai casi estremi, si dimostra essere impossibile scrivere un algoritmo che dato un qualsiasi programma riesca a generare un'espressione regolare che rappresenti __tutti e soli__ i suoi cammini possibili senza osservare i valori delle variabili.
Bisogna dunque accontentarsi di trovare espressioni regolari che rappresentino __al meglio__ l'esecuzione del programma, ovvero con il minor numero di cammini impossibili rappresentati.

Nell'analisi Data Flow tramite espressioni regolari è quindi necessario tenere conto che il modello generato è un'__astrazione pessimistica__: se viene notificata la presenza di un errore non si può essere certi che esso ci sia veramente, in quanto esso potrebbe derivare da un cammino non percorribile.

## Analisi statica e Testing

Oltre ad essere un processo utile di per sé per il rilevamento di potenziali errori, l'__analisi statica__ può anche contribuire a guidare l'attività di __testing__. \\
Per capire come, osserviamo che a partire dall'analisi statica è possibile fare le seguenti osservazioni:

- perché si presenti un malfunzionamento dovuto a una anomalia in una _definizione_, deve esserci un _uso_ che si serva del valore assegnato;
- un ciclo dovrebbe essere ripetuto (di nuovo) se verrà _usato_ un valore _definito_ alla iterazione precedente.

L'analisi statica può quindi aiutare a __selezionare i casi di test__ basandosi sulle _sequenze definizione-uso_ delle variabili, costruendo cioè dei nuovi criteri di copertura.

### Terminologia

Per rendere più scorrevole la spiegazione dei prossimi argomenti introduciamo innanzitutto un po' di terminologia.

Dato un nodo $$i$$ del diagramma di flusso (_un comando/riga del programma_), chiamiamo $$\operatorname{def}(i)$$ l'__insieme delle variabili definite in__ $$\bf{i}$$.

Data invece una variabile $$x$$ e un nodo $$i$$, chiamiamo $$\operatorname{du}(x, \, i)$$ l'insieme dei nodi $$j$$ tali che:

- $$x \in \operatorname{def}(i)$$, ovvero la variabile $$x$$ è __definita__ in $$i$$;
- $$x$$ è __usata__ nel nodo $$j$$;
- __esiste un cammino__ da $$i$$ a $$j$$ __libero da definizioni__ di $$x$$, ovvero che se seguito non sovrascrive il valore di $$x$$.

Si tratta cioè dell'__insieme di nodi $$\bf{j}$$ che _potrebbero_ usare il valore di $$\bf{x}$$ definito in $$\bf{i}$$__.

### Criteri di copertura derivati dall'analisi statica

#### Criterio di copertura delle definizioni

_Un test $$\ T$$ soddisfa il __criterio di copertura delle definizioni__ se e solo se per ogni nodo $$i$$ e ogni variabile $$x \in \operatorname{def}(i)$$, $$T$$ include un caso di test che esegue un cammino libero da definizioni da $$i$$ ad __almeno uno__ degli elementi di $$\operatorname{du}(i, x).$$_

Ci si vuole cioè assicurare di testare tutte le definizioni, assicurandosi che funzionino osservando almeno un uso del valore da loro assegnato.
Matematicamente si può dire che:

$$
\begin{align*}
T \in C_{def} \Longleftrightarrow& \forall i \in P, \  \forall x \in \operatorname{def}(i), \ \exists j \in \operatorname{du}(i, \, x) \:, \\
& \: \exists t \in T \ \text{che esegue un cammino da $i$ a $j$ senza ulteriori definizioni di $x$}.
\end{align*}
$$

Riconsideriamo l'esempio già visto in precedenza, considerando la variabile $$\mathtt{a}$$:

```c
01  void main() {
02      float a, b, x, y;
03      read(x);
04      read(y);
05      a = x;
06      b = y;
07      while (a != b)
08          if (a > b)
09              a = a - b;
10          else
11              b = b - a;
12      write(a);
13  }
```

Partiamo definendo gli insiemi dei nodi degli usi $$\operatorname{du}(i, \, \mathtt a)$$:

1. $$\operatorname{du}(5, \, \mathtt a)$$ = $$\{7, \, 8, \, 9, \, 11, \, 12\}$$;
2. $$\operatorname{du}(9, \, \mathtt a)$$ = $$\{7, \, 8, \, 9, \, 11, \, 12\}$$.

È solo __un caso__ il fatto che in questo esempio tali insiemi siano uguali. \\
Comunque sia, l'obiettivo è _per ognuna delle due definizioni_ ottenere un __uso__ di tale definizione:

1. Per la prima definizione la soluzione è banale, a riga 7 la variabile $$\mathtt a$$ viene letta sempre:
$$\D{5}\U{7}$$.
2. Per la seconda, invece, è necessario scegliere un valore tale per cui il flusso di esecuzione entri almeno una volta nel ciclo ed esegua almeno una volta la riga 9:
$$\D{9}\U{7}$$.

Un test che soddisfa totalmente il criterio può essere il seguente:

$$
T = \{ \langle 8, \, 4 \rangle \}.
$$

Come si vede, il criterio di copertura delle definizioni non copre tutti i comandi e di conseguenza __non implica il criterio di copertura dei comandi__.

#### Criterio di copertura degli usi

_Un test $$\ T$$ soddisfa il __criterio di copertura degli usi__ se e solo se per ogni nodo $$i$$ e ogni variabile $$x$$ appartenente a $$\operatorname{def}(i)$$, $$T$$ include un caso di test che esegue un cammino libero da definizioni da $$i$$ ad __ogni elemento__ di $$\operatorname{du}(i, \, x).$$_

Sembra simile al precedente, con la differenza che ora bisogna coprire __tutti__ i potenziali usi di una variabile definita.
Questo appare ancora più chiaro osservando la formula matematica:

$$
\begin{align*}
T \in C_{path} \Longleftrightarrow& \forall i \in P, \  \forall x \in \operatorname{def}(i), \ \forall j \in \operatorname{du}(i, \, x) \:, \\
& \: \exists t \in T \ \text{che esegue un cammino da $i$ a $j$ senza ulteriori definizioni di $x$}.
\end{align*}
$$

Si noti però che il criterio di copertura degli usi __non implica il criterio di copertura delle definizioni__, perché nel caso in cui non esistano $$j \in \operatorname{du}(i, \, x)$$ l'uso del $$\forall$$ è più _"permissivo"_ del $$\exists$$ del criterio precedente: quest'ultimo richiedeva infatti che per ogni definizione esistesse almeno un uso, mentre il criterio di copertura degli usi non pone tale clausola (_se non ci sono usi il $$\forall$$ è sempre vero_).
Viene quindi da sé che questo criterio non copre neanche il criterio di copertura dei comandi.

Riconsideriamo nuovamente il programma in C visto in precedenza come esempio:

```c
01  void main() {
02      float a, b, x, y;
03      read(x);
04      read(y);
05      a = x;
06      b = y;
07      while (a != b)
08          if (a > b)
09              a = a - b;
10          else
11              b = b - a;
12      write(a);
13  }
```

Come prima, consideriamo la variabile $$\mathtt a$$ e i relativi insieme dei nodi degli usi per ogni sua definizione:

1. $$\operatorname{du}(5, \, \mathtt a)$$ = $$\{7, \, 8, \, 9, \, 11, \, 12\}$$;
2. $$\operatorname{du}(9, \, \mathtt a)$$ = $$\{7, \, 8, \, 9, \, 11, \, 12\}$$.

Per ogni definizione occorre coprire __tutti gli usi__:

<style>
  #criterio-usi-tabella {
    text-align: center;
  }
  #criterio-usi-tabella p {
    margin-bottom: 0;
  }
</style>

<table id="criterio-usi-tabella" style="text-align: center;">
<tr>
  <th style="width: 50%" markdown="1">
    $$\operatorname{du}(5, \, \mathtt a)$$
  </th>
  <th markdown="1">$$\operatorname{du}(9, \, \mathtt a)$$</th>
</tr>
<tr>
  <td markdown="1">$$\D{5}\UG{7}\UG{8}\UG{11}\U{7}\UG{12}$$
  </td>
  <td markdown="1">$$\dots \, \D{9} \UG7 \UG8 \UG9 \dots$$
  </td>
</tr>
<tr>
  <td markdown="1">$$\dots \, \D5 \U7 \U8 \UG9 \dots$$
  </td>
  <td markdown="1">$$\dots \, \D9 \U7 \U8 \UG{12} \dots$$
  </td>
</tr>
<tr>
  <td></td>
  <td markdown="1">$$\dots \, \D9 \U7 \U8 \UG{11} \dots$$
  </td>
</tr>
</table>

Un test che soddisfa totalmente il criterio può essere il seguente:

$$
T = \{ \langle 4, \,  8 \rangle, \, \langle 12, \, 8 \rangle, \, \langle 12, \, 4 \rangle \}.
$$

Questo esempio permette di notare qualcosa sulla natura dei cicli: dovendo testare ogni percorso al loro interno è necessario fare almeno due iterazioni.
Può quindi sorgere un dubbio: è meglio che le due iterazioni siano fatte nello stesso caso di test o in casi test separati? Ovvero, è meglio __minimizzare__ i __casi di test__ o le __iterazioni per caso__? \\
Opinione diffusa è quella secondo cui è preferibile __minimizzare le iterazioni__: partizionando le casistiche in diversi casi di test è possibile rilevare con più precisione gli errori, riducendo il tempo di debug.
In alcune situazioni però aumentare il numero di iterazioni può diminuire il tempo di esecuzione totale dei test, in quanto dovendo riavviare il programma per ciascun caso di test la somma dei tempi di startup può diventare significativa per software molto massicci.

#### Criterio di copertura dei cammini DU

Nel criterio precedente si richiedeva di testare _un_ cammino da ogni definizione ad ogni suo uso, ma come sappiamo i cammini tra due istruzioni di un programma possono essere molteplici.
Potrebbe dunque sorgere l'idea di testarli _tutti_: da questa intuizione nasce il __criterio di copertura dei cammini DU__.

$$
\begin{align*}
T \in C_{pathDU} \Longleftrightarrow& \forall i \in P, \  \forall x \in \operatorname{def}(i), \ \forall j \in \operatorname{du}(i, \, x), \\
&\forall \text{ cammino da $i$ a $j$ senza ulteriori definizioni di $x$} \\
& \exists t \in T \ \text{che lo esegue}.
\end{align*}
$$

Questo criterio può essere __utile da ipotizzare__, ma a causa dell'esplosione combinatoria del numero dei cammini è considerato __impraticabile__ (_"sopra la barra rossa"_).

### Oltre le variabili

L'analisi del flusso dati si può estendere anche su altri _"oggetti"_, non solo variabili. \\
Per esempio, è possibile prevedere le seguenti operazioni su un __file__:

- $$\op{a}$$ (__apertura__): specializzata in _per lettura_ o _per scrittura_;
- $$\op{c}$$ (__chiusura__);
- $$\op{l}$$ (__lettura__);
- $$\op{s}$$ (__scrittura__).

Date queste operazioni si possono individuare una serie di regole, come per esempio:

1. $$\op{l}$$, $$\op{s}$$ e $$\op{c}$$ devono essere precedute da $$\op{a}$$ senza $$\op{c}$$ intermedie;
2. $$\op{a}$$ deve essere seguita da $$\op{c}$$ prima di un'altra $$\op{a}$$;
3. legami tra tipo di apertura (per lettura o per scrittura) e relative operazioni.

È interessante notare il __legame__ tra l'attività di analisi del flusso di dati e i diagrammi UML a stati finiti: un _oggetto_ risponde a una certa _tipologia di eventi_, può essere in diversi _stati_ e in certi _stati_ non sono ammesse alcune _operazioni_.
Si noti come nessuna delle due discipline entra comunque nel merito del valore delle variabili, relegato ad un'analisi a runtime.

#### Criterio di _copertura del budget_

Molto spesso nei contesti reali l'unico criterio applicato è quello di __copertura del budget__: si continuano a creare casi di test finché non sono finite le risorse (tempo e soldi).
Questa tecnica ovviamente non fornisce alcuna garanzia sull'efficacia dei test, ed è sicuramente sconsigliata.

# Tecniche di review

## Beebugging

Talvolta può capitare che il team di testing **non trovi errori** nel programma sotto osservazione: o il programma è effettivamente corretto (raro) o la review non viene svolta in maniera corretta.

Un metodo efficace per risolvere questo problema è possibile utilizzare il **beebugging**, ovvero inserire deliberatamente $$n$$ errori nel codice prima di mandare il programma al team di testing. 

Il vantaggio ovvio di questa tecnica è l'**incentivo** per il team di testing a continuare a cercare errori.

La metrica utilizzata è la **percentuale di errori trovati** (di quelli inseriti artificialmente), che può fornire un'indicazione del numero di errori totali rimanenti da trovare.
Se per esempio il team di sviluppo ha aggiunto 10 bug _"artificiali"_ e durante il testing ne vengono trovati 8 più 2 non noti, si può supporre che il team di review riesce a trovare l'_80% degli errori_ e che quindi ce ne è ancora un altro _reale_ da trovare.

È anche possibile che gli errori immessi artificialmente siano **troppo facili** o **troppo difficili** da trovare - è quindi azzardato arrivare a una conclusione come quella sopra.

## Analisi mutazionale

Una evoluzione del beebugging è l'**analisi mutazionale**.
Dato un programma $$P$$ e un insieme di casi di test $$T$$, viene generato un insieme di programmi $$\Pi$$ _simili_ al programma $$P$$ in esame.

Ci si aspettano due cose:
- se $$P$$ è corretto allora i programmi in $$\Pi$$ _**devono essere sbagliati**_;
- per almeno un caso di test i programmi devono quindi produrre un risultato diverso.

I tre passi da seguire per l'analisi mutazionale sono:
1. **analisi** delle classi e generazione dei mutanti; 
2. **selezionare** dei casi di test, in base alla metrica; 
3. **esecuzione** dei casi di test, pensando anche alle performance;

### Criterio di copertura dei mutanti

Formalizzando la tecnica come _criterio di copertura_, si può dire che
_un test $$\ T$$ soddisfa il **criterio di copertura dei mutanti** se e solo se per ogni mutante $$\pi \in \Pi$$ esiste almeno un caso di test $$t \in T$$ la cui esecuzione produca per $$\pi$$ un risultato diverso da quelllo prodotto da $$P$$_.

La metrica è la **frazione di mutanti $$\pi$$ riconosciuta come diversa** da $$P$$ sul totale di mutanti generati.

### Generazione dei mutanti

Nel caso ideale si vorrebbero avere dei mutanti simili al programma di partenza con **differenze minime**, che introducono potenziali anomalie.
I mutanti sono **potenzialmente infiniti**, ma facili da automatizzare.

Per mantenere la suite di test *eseguibile in tempi ragionevoli*, il numero di mutanti non deve essere troppo elevato: un centinaio è una buona stima, ma un migliaio sarebbe auspicabile.
Visto il numero limitato, è necessario concentrarsi quindi sulla loro "__qualità__", in modo che trovino un errore.

#### Operatori mutanti

Gli **operatori mutanti** sono delle funzioni (o piccoli programmi) che dato un programma $$P$$ generano uno o più mutanti $$\pi$$.
Essi operano eseguendo piccole **modifiche sintattiche** che modifichino la **semantica del programa** senza causare errori di compilazione.

Esistono numerosi **problemi di prestazioni**, in quanto per ogni mutante occorre modificare il codice, ricompilarlo, controllare che non si sovrapponga allo spazio di compilazione delle classi di altri mutanti, ecc...
I tool moderni lavorano quindi sull'**eseguibile** (nel caso di Java sul bytecode) per diminuire il lavoro da fare per ogni mutante ma stando attenti a non fare modifiche che non sarebbero state mai generate da nessun compilatore Java.

##### CLASSI DI OPERATORI

Si distinguono operatori in **classi** in base agli oggetti su cui operano.
- **costanti**, **variabili**, per esempio scambiando l'occorrenza di una con l'altra;
- **operatori** ed **espressioni**, per esempio `<` in `<=`, oppure `true` in `false`;
- **comandi**, per esempio un `while` in `if`, facendolo eseguire una sola volta.

Possono essere anche specifici su alcuni tipi di applicazioni, come:
- __sistemi concorrenti__: operano principalmente sulle primitive di sincronizzazione – come eseguire una `notify()` invece che una `notifyAll()`;
- __sistemi object orientend__: operano principalmente sulle interfacce dei moduli.

#### High Order Mutation

Nella variante **HOM** (**High Order Mutation**) si applicano modifiche a **codice già modificato**.
La giustificazione per tale tecnica è che esistono alcuni casi in cui trovare errori dopo aver applicato più modifiche è *più difficile* rispetto ad applicarne solo una.
Può essere che un errore mascheri parzialmente lo stato inconsinstente dell'altro rendendo più difficile il rilevamento di malfunzionamenti. 

### Risultati

Generalmente nel testing gli unici due _outcomes_ sono _risultato corretto_ o _non corretto_ e la metrica è una misura della correttezza del programma.
Il discrimante delle tecniche di analisi mutazionale è invece il numero di casi di test che forniscono un risultato ***diverso*** da quello di $$P$$, indipendentemente dalla correttezza (di entrambi).

Trovare errori con queste tecniche (specialmente l'HOM) misura quindi il **livello di approfondimento** dei casi di test e **non** la **correttezza** del programma.

Trascindere dalla *correttezza* dei risultati ha anche aspetti positivi: per eseguire l'analisi mutazionale non è quindi necessario avere i comportamenti corretti (o l'__oracolo__). 
Si può quindi misurare la bontà dei casi di test **automatizzando la loro creazione**: come già detto precedentemente, occorre però vigilare sulla **profilerazione del numero di esecuzioni** da effettuare per compleare un test – un caso di test dà origine a $$n+1$$ esecuzioni dove $$n$$ è il numero di mutanti.

Il seguente diagramma di flusso visualizza le attività (**facilmente automatizzabili**) svolte durante l'analisi.
{% responsive_image path: 'assets/13_analisi-mutazionale-schema.png' %}

Questo approccio benché semplice **non garantisce la terminazione**, perché:
- quando si estrae un valore casuale, c'è sempre il rischio di **estrarre sempre lo stesso valore**;
- si potrebbe essere _particolarmente sfortunati_ e **non trovare il valore corretto**;
- **esistono infinite varianti** di programmi che svolgono la stessa funzione, anche se non sono sintatticamente identici. 
Di conseguenza, una modifica sintattica potrebbe non avere alcun effetto sul funzionamento del programma.

Per verificare la validità del test, è necessario controllare il **numero di mutanti generati**: se questo numero è elevato, il test non è affidabile. 
In alternativa, è possibile _"nascondere"_ i mutanti, a patto che non sia richiesta una copertura totale. 
In questo modo, è possibile **analizzare programmi** che sono **funzionalmente uguali ma sintatticamente diversi**, al fine di dimostrarne l'equivalenza o scoprire casi in cui essa non è valida.

# Object oriented testing

I programmi dei **linguaggi procedurali** sono composti da funzioni e procedure che possono essere trattate (e quindi testate) indipendentemente, a meno di variabili globali (che è comunque un bad pattern).

Nei **linguaggi object oriented** (**OO**) invece gli oggetti sono l'unione di metodi e stato. 
Testare solo i metodi perde di senso, in quanto non si considera il contesto (lo **stato**) in cui opera.

L'**unità testabile** si sposta quindi dalla procedura alla **classe**.

## Ereditarietà

_Ha senso testare i metodi di default di un'interfaccia?_ \\
_o è meglio testare quei metodi in una classe concreta che implementa tale interfaccia?_

A causa del **collegamento dinamico**, non è nemmeno sicuro che eseguire lo stesso metodo nella classe base significa eseguire le stesse istruzioni nella classe ereditata.

In generale, non si eredita l'attività di testing ma si possono ereditare i casi di test e l'oracolo: è quindi opportuno **rieseguire** i casi di test anche nelle sottoclassi.

Per rispondere alle domande sopra, **dipende**: se è possibile creare un'_"interfaccia pura"_ avente come unico scopo il testing del metodo specifico allora si può procedere, altrimenti ha senso testare solo le classi concrete che la implementano.

Dal punto di vista teorico, appunto, il **collegamento dinamico** rende difficile stabilire staticamente tutti i possibili cammini di esecuzione, complicando la determinazione dei criteri di copertura.

## Testare una classe

Per **testare una classe**: 
- la **si isola** utilizzando più _stub_ possibili per renderla eseguibile indipendentemente dal contesto; 
- si implementano eventuali **metodi astratti** (stub); 
- si aggiunge una funzione per permettere di estrarre ed esaminare lo stato dell'oggetto e quindi **bypassare l'incapsulamento**.
- costruiamo una classe driver che permetta di istanziare oggetti e chiamare metodi secondo il **criterio di copertura** scelto.

Quale criterio di copertura scegliamo?

### Copertura della classe

I **criteri classici** visti precedentemente (comandi, decisioni, ...) continuano a valere ma **non sono sufficienti**.
Per testare completamente una classe occorre considerare lo **stato dell'oggetto**, magari utilizzando una **macchina a stati** con gli _stati possibili_ della classe e le _transazioni_, ovvero le chiamate di metodi che cambiano lo stato.

Il seguente diagramma rappresenta una macchina a stati di una classe avente due metodi: $$\mathtt{m1}$$ e $$\mathtt{m2}$$.

{% responsive_image path: 'assets/13_criteri-copertura-grafo.png' %}

Alcuni criteri di copertura che si possono ipotizzare sono:

- **coprire tutti i nodi**: per ogni nodo deve esistere almeno un caso di test che lo copra;
- **coprire tutti gli archi**: per ogni stato e per ogni metodo deve esistere almeno un caso di test che lo copra;
- **coprire tutte le coppie di archi input/output**: per ogni _cammino precedente_ di e per ogni stato e per ogni metodo deve esistere almeno un caso di test che lo copra;
- **coprire tutti i cammini identificabili nel grafo**: _"sopra la linea rossa"_, al di fuori del fattibile.

#### Tipo di testing: white o black box?

Il diagramma precedente rappresenta sì il codice considerato ma è ancora un'**astrazione**: non è nota la parte di codice che rappresenta lo stato o che implementa uno specifico metodo, l'unica conoscenza sono le relazioni tra i vari stati.
È quindi da considerarsi in generale testing **black box**.

In caso il diagramma degli stati non sia presente, con un'attività di **reverse engineering** si può tentare con un'euristica (ad un livello di astrazione variabile) ad **estrarre informazioni sugli stati**.

Non importa se le informazioni estratte non sono comprensibili ad un umano, una volta passate a un tool di testing automatico si passa in una situazione di testing **white box**.

# Testing funzionale

Il **test funzionale** è un tipo di test che si concentra sulla verifica del comportamento del programma dal punto di vista dell'**utente finale**, senza considerare il suo funzionamento interno. 
In altre parole, il test funzionale è un approccio **black box**, in cui non si ha o non comunque non si sfrutta la conoscenza del codice sorgente.

Spesso può essere l'**unico approccio possibile** (come nel caso di validazione del lavoro di un committente esterno) ma delle volte si sceglie volontariamente di farlo, concentrandosi sul **dominio delle informazioni** invece che sulla struttura di controllo.

Il test funzionale (che rimane sempre rispetto alle **specifiche** e non ai requisiti) permette di identificare errori che **non possono essere individuati** con criteri strutturali, come funzionalità non implementate, flussi di esecuzione dimenticati o errori di interfaccia e di prestazioni. 

## Tecniche

Le tecniche di test funzionale si possono raggruppare in:

- __metodi basati su grafi__: oltre a ciò visto in precedenza, si può lavorare anche sui diagrammi di sequenza; 
- __suddivisioni del dominio in classi di equivalenza__: si possono raggruppare i valori del dominio che causano lo stesso comportamento in classi d'equivalenza. 
Occorre fare attenzione a non fare l'inverso, ovvero a concentrarsi su soli valori appartenenti ad una classe di equivalenza ignorando il resto;
- __analisi dei valori limite (test di frontiera)__: tra i possibili valori, quelli _"a cavallo"_ tra una categoria e l'altra possono più facilmente causare malfunzionamenti;
- __collaudo per confronto__: confrontare la nuova versione del programma con la vecchia, assicurandosi che non siano presenti regressioni. 
Non solo si possono confrontare gli eseguibili, ma anche _specifiche formali eseguibili_ che rappresentino le caratteristiche importanti del software;

### Testing delle interfacce

Per interfacce non si intendono le interfacce Java o le _signature_, ma come più sistemi dialogano e **collaborano** insieme.
Esistono diversi tipi di interfacce:
- a __invocazione di parametri__;
- a __condivisione di memoria__;
- a __metodi sincroni__; 
- a __passaggio di messaggi_.

Tipi di errore più comuni sono:
- __sbaglio nell'uso dell'interfaccia__: come ordine o tipo dei parametri errati o assunzioni sbagliate (precondizioni, contratti) circa ciò che la funzione richiede;
- __errori di tempistica o di sincronizzazione__.

### Classi di equivalenza

L'obiettivo è di suddividere il dominio in **gruppi di valori** tali per cui i loro componenti riescano a **stimolare il programma nella stessa maniera**, pur fornendo risultati differenti.

Si possono vedere le classi di equivalenza anche dal punto di vista di **classi di equivalenza di errori**: per esempio, un certo insieme di valori causerà errori per via del fatto che sono negativi, o troppo grandi.
Quest'ultime sono solitamente più _"stabili"_ rispetto alle precedenti in quanto il risultato (l'errore) è lo stesso o molto simile.

Una **classe di equivalenza** è quindi un **insieme di _stati validi_ (o non validi) per i dati in input e un insieme di stati validi per i dati di output.
Un _dato_ può essere un valore un valore, un intervallo, un insieme di valori correlati, ...

Per fare un esempio si può considerare un **codice PIN di 4 cifre**: dovrebbero esistere almeno due classi di equivalenza: 
1. __PIN corretto__;
2. __numero di 4 cifre qualsiasi diverso da PIN__. 

Se ci si aspetta invece che i valori ricadano in un intervallo (come $$[100, \, 700]$$), si può definire una classe di equivalenza valida e due non valide:
1. __numero tra 100 e 700__;
2. __numero minore di 100__;
3. __numero maggiore di 700__.

### Test di frontiera

La tecnica dei **test di frontiera** è _complementare_ alle classi di equivalenza: gli errori tendono ad accumularsi ai limiti del dominio. 
Non si selezionano quindi _elementi a caso_ all'interno della classe,  ma uno **ai confini**.

### Category partition

La tecnica della **category partition** è un metodo per caratterizzare e identificare le classi di equivalenza. \\
Può essere utilizzato a **vari livelli**: test d'unità, di integrazione e o funzionale.

È composta da diversi passi
1. **analisi delle specifiche**: in questa vengono identificate le _unità funzionali individuali_ che possono essere verificate singolarmente; non necessariamente sono un'unica classe, è sufficiente che siano componenti facilmente separabili dal resto, sia a livello di testing che di categorie.
Per ogni unità vengono identificate delle caratteristiche (__categorie__) dei parametri e dell'ambiente;
2. **scegliere dei valori**: per ogni categoria, occorre scegliere quali sono i _valori sensati_ su cui fare riferimento;
3. **determinare eventuali vincoli tra le scelte**, non sempre indipendenti;
4. **scrivere test e documentazione**. 

### Esempio con comando `find`

Tentiamo di utilizzare la tecnica del _category partition_ sul comando `find`. \\
Le specifiche sono le seguenti:

> **Syntax**: `find <pattern> <file>`
> 
> The find command is used to locate one or more instances of a given pattern in a file.
> All lines in the file that contain the pattern are written to standard output.
> A line containing the pattern is written only once, regardless of the number of times the pattern occur in it.
> 
> The pattern is any sequence of characters whose length does not exceed the maximum length of a line in the file.
> To include a blank in the pattern, the entier pattern must be enclosed in quotes (`"`).
> To include a quotation mark in the pattern, two quotes (`""`) in a row must be used.

#### PASSO 1 – analizzare le specifiche

I parametri sono due: `pattern` e `file`.

Le caratteristiche possono essere di due tipi: __esplicite__, ovvero quelle ricavabili direttamente dalle specifiche e __implicite__, ovvero quelle che vengono dalla nostra conoscenza del dominio di applicazione e che quindi non devono essere specificate.

<style>
  #category-partition-find-table ul {
    margin-bottom: 0;
  }
</style>

<table id="category-partition-find-table">
<tr>
  <th>Oggetto</th>
  <th>Caratteristiche esplicite</th>
  <th>Caratteristiche implicite</th>
</tr>
<tr>
  <th markdown="1">`pattern`
  </th>
  <td markdown="1">
- lunghezza del pattern;
- pattern tra doppi apici;
- pattern contenente spazi;
- pattern contenente apici.
</td>
  <td markdown="1">
- pattern tra apici con/senza spazi;
- più apici successivi inclusi nel pattern.
</td>
</tr>
  <th markdown="1">`file` \\
(nome)
  </th>
  <td style="text-align: center;"><i>(nessuna)</i></td>
  <td markdown="1">
- caratteri nel nome ammissibili o meno;
- file esistente (con permessi di lettura) o meno.
</td>
<tr>
  <th markdown="1">`file` \\
(contenuto)
  </th>
  <td markdown="1">
- numero occorrenze del pattern nel file;
- massimo numero di occorrenze del pattern in una linea;
- massima lunghezza linea.
</td>
  <td markdown="1">
- pattern sovvrapposti;
- tipo del file.
</td>
</tr>
</table>

È importante _esplicitare le specifiche implicite_ perché **le specifiche non sono mai complete**.

#### PASSO 2 – scegliere dei valori

In questa fase vanno identificati tutti e i soli casi significativi per ogni categoria identificata; è importante quindi avere **esperienza** (_know-how_) nel dominio d'applicazione. 

Per esempio, per le classi d'equivalenza del parametro `pattern` scegliamo:
- __lunghezza del pattern__: vuoto (frontiera), un solo carattere, più caratteri, più lungo di almeno una linea del file (frontiera?);
- __presenza di apici__: pattern tra apici, pattern non tra apici, pattern tra apici errati;
- __presenza di spazi__: nessuno, uno, molti;
- __presenza di apici interni__: nessuno, uno, molti.

È interessante notare il _pattern_ già visto "__nessuno__, __uno__, __molti__" spesso utile in questa fase.

#### PASSO 3 – determinare i vincoli tra le scelte

In teoria si dovrebbero testare **tutte le combinazioni** delle caratteristiche elencate sopra, facendo il prodotto cartesiano.
Nella pratica, ciò porterebbe a 1944 casi di test (decisamente **troppi**).

Ci sono inoltre moltissime caratteristiche d'ambiente che **non sono state considerate**: versione del sistema operativo, browser, tipo di architettura, eccetera.

Una tecnica, tra l'altro, per testare tali **configurazioni d'ambiente** è il ***beta testing***: il programma viene distribuito in un *ambiente variegato* (a differenza dell'**alpha testing** al di fuori dell'azienda) e si ricevano feedback dai primi utenti.

Il numero di configurazioni per cui testare la procedura esplode molto rapidamente. 
Un approccio per **ridurle** è il ***pairwise testing***, che riduce l'insieme delle configurazioni a combinazioni di coppie di tutti i valori.
È quindi presente almeno un caso di test _per ogni coppia ipotizzabile_ di valori.

In rete e in Java sono presenti diversi [**strumenti**](https://www.pairwise.org/tools.html) che permettono di creare casi di test combinati con il metodo _pairwise_.
Molti strumenti permettono anche di specificare ***constraint*** per la generazione delle coppie, escludendo particolari caratteristiche (come _OS != "macOS"_ $$\land$$ _"browser" == "Safari"_).

Ci sono diverse tecniche per definire tali constraint:
- **proprietà**: si possono fissare alcune caratteristiche (come _NotEmpty_ o _Quoted_) per potersi riferire successivamente;
- **se**: si può limitare l'uso di un valore solo ai casi in cui è definita una proprietà. Per esempio, è inutile testare il caso _"il file non esiste"_ se la proprietà _NotEmpty_ si manifesta;
- **single**: alcune caratteristiche prese singolarmente anche se combinate con altre generano lo stesso risultato. Per esempio, se il file non contiene occorrenze del pattern cercato il risultato del programma è indipendente dal tipo di pattern cercato;
- **error**: alcune caratteristiche generano semplicemente errore, come se si omette un parametro.

#### PASSO 4 – scrivere i test

Fissati i vincoli e i calcoli combinatori iterativamente si procede ad enumerare tutti i casi di test generati continuando ad aggiungere vincoli fino ad arrivare ad un **numero ragionevole**.

Infine, occorre trovare **valori specifici** per le caratteristiche considerate: questa operazione è solitamente molto facile, anche con tool automatici.

Al termine della procedura, possiamo analizzare due criticità:
- individuare le **caratteristiche significative** può essere difficile e si può sbagliare, anche utilizzando pattern come _zero_, _uno_, _molti_;
- una volta generati i casi di test serve comunque un **oracolo** che possa dare la risposta giusta. \\
Esistono delle tecniche di **property-based testing** che piuttosto di analizzare i risultati considerano particolari proprietà che dovrebbero sempre valere, o invarianti.

## Object orientation e testing funzionale

Il testing funzionale si basa sulle **funzionalità** del codice e non sui dettagli implementativi, quindi l'OOP **non dovrebbe cambiare niente**.
Questa affermazione è in effetti vera nel testing **black box**, ma nei **test d'integrazione** non più. 

Nei linguaggi procedurali i test di integrazione sono scritti seguendo logiche solitamente **bottom-up** o **top-down** seguendo una qualche forma di **albero di decomposizione** dei vari componenti. \\
Nell'OOP invece, la situazione è **molto più caotica**: le relazioni tra le classi sono spesso cicliche e non gerarchiche (tranne per l'ereditarietà &mdash; la relazione meno interessante).

Relazioni interessanti in questa fase sono infatti _associazioni_,_aggregazioni_ o _dipendenze_, ma rendono complicato identificare il **sottoinsieme di classi da testare**.
Per fare ciò si possono comunque utilizzare alcuni strumenti già visti:
- nei diagrammi degli **use cases e scenari** si possono testare i componenti citati;
- nei **sequence diagram** si possono testare le classi protagoniste delle interazioni a scambio di messaggi descritte;
- per gli **state diagram** abbiamo già visto sopra.

# Software inspection

Un'altra classe di tecniche di verifica e convalida è la **software inspection**, ovvero tecniche manuali per individuare e 
correggere gli errori basati su una attività di gruppo come la *pair programming* vista a laboratorio.

Le tecniche di software inspection sono molto interessanti in quanto hanno **pochi requisiti** e l'unico **tool** richiesto è l'**umano**, che deve ispezionare il codice, spesso in riunioni di gruppo (5-6 persone).

Oltre ad un eseguibile, l'**oggetto sotto ispezione** può essere un codice che non funziona o specifiche formali o informali.
Si può fare quindi durante tutte le fasi del ciclo di vita di un software.

## Fagan code inspection

La **Fagan code inspection** è una metodologia sviluppata da Michael Fagan alla IBM negli anni '70. 
La metodologia prevede che un **gruppo di esperti** esegua una serie di passi per verificare il codice sorgente, al fine di individuare eventuali errori, incongruenze o altri problemi. \\
È **la più diffusa** tra le tecniche di ispezione, nonché la più rigorosa e definita.

### Ruoli

Essendo un'attività di gruppo, nella software inspection vengono identificati alcuni ruoli.

- **Moderatore**: è colui che coordina i meeting e sceglie i partecipanti, ha la responsabilità di mantenere e far rispettare le regole. 
È di solito preso da un altro processo/progetto in modo da non avere conflitti di interessi. 
- **Readers e Testers**: non sono persone diverse, semplicemente a seconda dei momenti i partecipanti possono coprire uno di questi due ruoli: i primi leggono il codice al gruppo, mentre i secondi cercano difetti. 
La lettura del codice è una vera e propria _parafrasi_ di esso, ovvero una interpretazione del codice spiegando quello che fa ma seguendo comunque la struttura di esso.
- **Autore**: è colui che ha scritto il codice sotto ispezione; è un partecipante passivo che risponde a eventuali domande. 
È simile al ruolo del _cliente_ nell'eXtreme Programming: pronto a rispondere a qualsiasi domanda per accelerare il lavoro degli altri.

### Processo

Secondo la tecnica **Fagan** di ispezione del codice, il processo si articola nel seguente modo.

1.  **Planning**: in questa prima fase il moderatore sceglie i partecipanti, si definiscono i loro ruoli e il tempo da dedicare alla ispezione fissando anche i vari incontri.
2.  **Overview**: viene fornito a tutti i partecipanti materiale sul progetto per permettere di costruire un background all'interno del gruppo in ottica della riunione vera e propria.
3.  **Preparation**: i partecipanti _"offline"_ comprendono il codice e la sua struttura autononamente sulla base anche del materiale distribuito nella fase precedente;
4.  **Inspection**: la vera e propria fase di ispezione. 
In questa fase si verifica che il codice soddisfi le regole definite in precedenza e si segnalano eventuali problemi o anomalie. 
Durante l'ispezione, il gruppo di esperti esamina il codice riga per riga, confrontandolo con le specifiche e cercando di individuare errori, incongruenze o altri problemi.
5.  **Rework**: una volta individuati i problemi, l'autore del codice si occupa di correggere i difetti individuati.
6.  **Follow-up**: possibile re-ispezione del nuovo codice ottenuto dopo la fase precedente.

#### Ispezione

Durante la fase di ispezione, l'obiettivo è **trovare e registrare** i difetti, **senza coreggerli**: la tentazione di correggere i difetti è sicuramente fortissima ma non è compito dei partecipanti farlo. 
I partecipanti sono tutti con le proprie idee e preferenze e metterli d'accordo può non essere facile. \\
Sarà infatti l'autore a correggere successivamente i problemi.

Sono previste **al massimo** 2 sessioni di 2 ore al giorno durante le quali lavorare approssimativamente a **150 linee di codice all'ora**.
Quest'ultimo vincolo è **molto indicativo** in quanto cambia in base al linguaggio, al progetto, all'attenzione ai dettagli richiesta e alla complessità.

Una possibilità prevista in questa fase è anche quella di fare _"test a mano"_.

### Checklist

A **differenza del testing** dove a partire dai malfunzionamenti si risale ai difetti e dunque agli sbagli commessi, il _thought-process_ per le **checklist** è inverso: **si parte dagli _sbagli_** che più frequentemente hanno portato ad inserire determinate anomalie nel codice e si controlla che nessuno di questi sia stato commesso nuovamente.

In letteratura è reperibile la **conoscenza** di tutto ciò che è meglio evitare poiché in passato ha portato più volte ad avere anomalie nel codice.
Tale conoscenza è raccolta in **checklist comuni** per i vari linguaggi.

Inoltre, l'ispezione del codice funziona così bene anche perché tali checklist possono essere **redatte internamente** all'azienda, in base all'**esperienza** passata e alla storia di un determinato progetto. \\
Man mano che il progetto va avanti, l'**incontro di un nuovo sbaglio** si traduce in un nuovo item nella checklist. 

#### Esempio NASA

La NASA nel suo <a href="../assets/13_nasa-software-inspection.pdf"><i>Software Formal Inspections Guidebook</i></a> (1993) ha formalizzato circa **2.5 pagine di checklist** per C e 4 per FORTRAN.

Sono divise in _functionality_, _data usage_, _control_, _linkage_, _computation_, _maintenance_ e _clarity_.

Di seguito sono elencati alcuni esempi.

> - [ ] Does each module have a single function?
> - [ ] Does the code match the Detailed Design?
> - [ ] Are all constant names upper case?
> - [ ] Are pointers not `typecast` (except assignment of `NULL`)?
> - [ ] Are nested `#include` files avoided?
> - [ ] Are non-standard usage isolated in subroutines and well documented?
> - [ ] Are there sufficient comments to understand the code?

### Struttura di incentivi

Per un gruppo lavorare bene, occorre prevedere delle **dinamiche positive** di incentivi.

Innanzitutto, è importante sottolineare che i difetti trovati **non devono essere utilizzati** per la valutazione del personale.
Il programmatore non deve essere incentivato a nascondere i difetti.

Dall'altra parte si possono considerare per la valutazione del personale i difetti trovati **dopo l'ispezione**, in modo da essere incentivati a trovarli tutti durante.

### Variante: _active_ design reviews

Purché il processo di ispezione funzioni al meglio **le persone** coinvolte **devono partecipare**, ma per come era stato strutturato Fagan qualche anno dopo si accorse che un revisore poteva essere presente ma non partecipare, rimanendo in silenzio e pensando ad latro.

Innanzitutto, per sopperire a questo problema i partecipanti vanno **scelti** tra persone di adeguata esperienza e sopratutto assicurando che nel team vi siano revisori per diversi aspetti nel progetto.

L'**autore** è inoltre incentivato a leggere e porre gli item delle checklist all'attenzione dei revisore, chiedendo diverse domande.
I revisori sono quindi costretti a partecipare.

## Automazione

L'ispezione del codice è una tecnica manuale ma esistono **strumenti di supporto automatici** in grado di velocizzare notevolmente il lavoro, per esempio per:
- **controlli banali**, come la formattazione.
In fase di ispezione manuale si controlla il risultato del controllo automatico; 
- **riferimenti**: checklist e standard in formati elettronici facilmente consultabili e compilabili;
- **aiuti alla comprensione del codice**: ovvero tool che permettono di navigare e leggere il codice con maggiore facilità e spesso utilizzati durante attività di _reengineering_;
- **annotazione e comunicazioni** del team, come l'email;
- **guida al processo e rinforzo**: non permettere di chiudere il processo se non sono stati soddisfatti alcuni requisiti (come la necessità di approvazione prima di mergiare una PR).

## Funziona?

Prove empriche dicono di **sì** e anche che è _cost-effective_.
Perché? 
- esiste un __processo rigoroso e dettagliato__;
- si basa sull'**accumulo dell'esperienza** automigliorandosi con il tempo (vedi le _checklist_);
- gli **incentivi sociali funzionano**; 
- a differenza del testing è possibile con la mente umana **astrarre il dominio completo** dei dati; 
- è applicabile anche a **programmi incompleti**;

La software inspection funziona così bene che è utilizzata come _baseline_ per valutare altre tecniche di verifica e convalida.

### Limiti

Il **livello del test** può essere solo all'unità, in quanto la mente umana ha difficoltà a lavorare in situazioni in cui sono presenti molte informazioni contemporaneamente in assenza di astrazioni e indirettezze;

Inoltre la software inspection **non è incrementale**: la fase di follow-up non è così efficace, in quanto è necessario ricominciare l'ispezione da capo.

__Legge di Fagan (L17)__.
> Le ispezioni aumentano in maniera significativa la produttività, qualità e la stabilità del progetto.

## Confronto con le altre tecniche di V/C

Nell'[articolo consigliato](https://web.archive.org/web/20060920113729/http:/www2.umassd.edu/SWPI/ISERN/ISERN-98-10.pdf) dal prof è presente una **tabella di confronto** di molti studi per tutte le varie tecniche di verifica e convalida.
La metrica è la percentuale media di difetti individuati.

{% responsive_image path: assets/13_tabella-confronto-tecniche-vc.png %}

Come si può notare, a seconda dello studio _"vince"_ l'una o l'altra tecnica; inoltre, la somma delle percentuali per ogni riga non è 100%.
Si possono fare quindi delle osservazioni:
- l'efficiacia di una tecnica dipende dalla **tipologia dei progetti**;
- **non è detto** che tecniche diverse trovino **gli stessi errori**: l'ispezione potrebbe aver trovato una certa tipologia di errore mentre il testing funzionale un'altra;
- le diverse tecniche controllano diversamente aspetti diversi, da **diversi punti di osservazione**.

Confrontare le varie tecniche non è necessariamente una perdita di tempo, lo è sicuramente **confrontare solo i numeri**: un indicatore di ciò è la varietà dei risultati da parte di studi diversi.

Tra l'altro, dal riassunto della tabella sopra si **perdono** informazioni sulle **modalità di rilevazione** attribuendole ad espressioni generiche (come _comunemente_, _in media_, _progetti junior_, ...).

In conclusione, non c'è una risposta semplice e **non c'è una tecnica migliore** rispetto alle altre.

### Combinazione di tecniche

Una domanda che sorge spontanea è chiedersi cosa può succedere se si **combinano insieme** le varie tecniche.

Il professore è convinto che applicando tutte e quattro le tecniche qui descritte &mdash; anche se solo in modo superficiale &mdash;
il risultato è sicuramente **più performante** delle tecniche applicate singolarmente. \\
Sono per lo stesso motivo sono valide e funzionanti le **tecniche agili**: dando tutte un contributo, insieme producono risultati di qualità.

{% responsive_image path: assets/13_tabella-tecniche-vc-insieme.png %}

Il maggior miglioramento delle prestazioni globali lo si trova quando **ogni tecnica controlla aspetti differenti**.

__Legge di Hetzel-Meyer (L20)__.
> Una combinazione di diversi metodi di V/C supera qualsiasi metodo singolo.

## Gruppi di tester autonomi
 
È convinzione comune che **colui che ha sviluppato il codice** sia la persona meno adatta a testarlo. \\
Di conseguenza, si preferisce che il testing sia affidato ad un **gruppo di tester autonomi**.

__Legge di Weinberg (L23)__
> Uno sviluppatore non è adatto a testare il suo codice.

### Vantaggi

Avere un gruppo di tester autonomo porta a numerosi vantaggi, che si possono dividere in **tecnici** e **psicologici**.

Per quanto riguarda gli **aspetti tecnici** si ha:
- una **maggiore specializzazione**;
- una **maggiore conoscenze delle tecniche di V/C** e degli strumenti: chi fa il _tester_ di lavoro acquisisce competenze specifiche sui tool e sugli strumenti di testing (spesso complessi), copertura e mutazioni.

Invece, riguardo gli **aspetti psicologici** si ha:
- un maggiore **distacco dal codice**: a causa dell'assenza di modelli mentali precedenti su come il software dovrebbe operare si ha una maggiore attenzione agli aspetti trascurati o dimenticati;
- **indipendenza nella valutazione**: una persona che testa il proprio codice è incentivata a _non_ trovare molti errori in quanto potrebbe suggerire un lavoro di dubbia qualità in fase di sviluppo. 
Un gruppo specializzato nel testing è invece incentivato a trovarne il più possibile in quanto se valutati lo saranno sulla base di quanti ne trovano.

### Svantaggi

Ci sono tuttavia anche **svantaggi** ad avere un gruppo di tester autonomo.
Innanzitutto, i problemi più ovvi sono legati all'**aspetto tecnico**: il fatto che i tester diventino specializzati nel testing significa che **perderanno** con il tempo la **capacità di progettare** e **codificare**, oltre ad una **minore conoscenza** dei requisiti del progetto.

Nell'analisi di Elisabeth Hendrickson denominata "[**Better testing &mdash; worse quality?**](https://web.archive.org/web/20220526084408/http:/testobsessed.com/wp-content/uploads/2011/04/btwq.pdf)" viene analizzata la tecnica sotto un nuovo **punto di vista psicologico**: come è possibile che un maggior investimento nel team di testing porti a un calo delle prestazioni in termini di numero di errori nel codice?

La risposta la si può trovare nella _**responsabilità**_: seppur vero che l'attività di testing è compito del tester, è anche vero che è lo sviluppatore stesso che ha il compito di fare **test di unità** &mdash; il team di testing dovrebbe occuparsi solo di quello funzionale o di integrazione.
A fronte di un aumento del personale nel team di testing, il team di sviluppo quando vicino a una deadline **sposta la responsabilità** di trovare gli errori al primo, **abbassando la qualità del codice**.

Il team di testing troverà gli errori riconsegnando il codice agli sviluppatori che possono correggerli, ma **si perde tempo** e risorse.

Inoltre, possono essere presenti **pressioni negative** sul team di sviluppo in quanto quest'ultimi possono sentersi sotto costante valutazione da parte del team di testing.

### Possibili alternative

Una possibile soluzione alle criticità è **ruotare il personale**: su progetti diversi una persona ricopre ruoli diversi.
Questo approccio ha diversi vantaggi, tra cui:
- **evitare pressioni negative**: ricoprendo diversi ruoli in diversi progetti, il personale non si dovrebbe sentire _giudicato_ o _giudicante_;
- **evitare il progressivo depauperamento tecnico** dovuto ad all'eccessiva specializzazione;
- **evitare lo svuotamento dei ruoli**.

C'è da considerare comunque che **aumentano i costi di formazione** (per via del raddoppio delle responsabilità individuali) e le **difficoltà di pianificazione** (può succedere che una persona debba a un certo punto lavorare a più progetti contemporaneamente). 

Un'altra tecnica è la **condivisione del personale**: permette di **sopperire** alla **scarsa conoscenza del prodotto** in esame ma, oltre alle **criticità** individuate precedentemente, aumenta le difficoltà nella **gestione dei ruoli**.

## Modelli statistici

Al professore questo argomento **non piace molto** (e come biasimarlo): riconosce però che non essendo il suo campo potrebbero essere positivi.

Si cerca una **correlazione statistica** tra **metriche** (come lunghezza del codice, tipo di linguaggio, ...) e:
- **presenza di errori** (per classi);
- **numero di errori** (per classi).

È quindi possibile **predire la distribuzione degli errori** per uno specifico modulo.

Occorre **porre attenzione** alle conclusioni di queste statistiche.
Utilizzare i risultati di tali modelli statistici come indicazioni sul fatto che su determinati moduli vada fatta più attività di testing rispetto ad altri potrebbe inizialmente sembrare la **soluzione più logica**.
Tuttavia, tali risultati non considerano i test e le correzioni aggiunte successivamente e quindi **non cambiano**: codice _"scritto male"_ secondo il modello rimane scritto male.

Con ciò in mente, si cita la legge di Pareto/Zipf. 

__Legge di Pareto/Zipf (L24)__
> Circa l'80% dei difetti proviene dal 20% dei moduli.

Potrebbe essere vero, ma è difficile sfruttare questa nozione in quanto non sono conosciuti in principio i **moduli particolarmente problematici**, e il testing è necessario in ogni caso anche in tutti gli altri.

## Debugging

Il debugging è l'insieme di tecniche che mirano a **localizzare** e **rimuovere** le anomalie che sono la causa di malfunzionamenti riscontrati nel programma.
Non è utilizzato per _rilevare_ malfunzionamenti.

Il debugging richiede una **comprensione approfondita del codice** e del funzionamento del programma e può essere un processo complesso e articolato.
Tuttavia, può contribuire in modo significativo a migliorare la qualità e la stabilità del codice, oltre che a _risolvere_ malfunzionamenti.

L'attività è quindi definita per un **programma** e **un insieme di dati che causano malfunzionamenti**.
Si basa infatti sulla **riproducibilità** del malfunzionamento, verificando prima che non sia dovuto in realtà a specifiche in errate.

>"Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it".
--- Brian W Kernighan

È importante dunque scrivere codice **più semplice possibile** in modo tale da poterne fare anche il debugging laddove necessario.

### Problemi

L'attività di debugging è particolarmente complessa anche perché non è sempre possibile individuare con precisione la **relazione anomalia-malfunzionamento**.
Non è un legame banale, in quanto potrebbero esserci anomalie che prima di manifestarsi sotto forma di malfunzionamenti abbiano avuto molte evoluzioni.

Inoltre, **non esiste una relazione biunivoca** tra anomalie e malfunzionamenti: non è detto che un'anomalia causa un unico  malfunzionamento, ma nemmeno che un malfunzionamento sia causato da un'unica anomalia.

Un altro problema è dovuto al fatto che la **correzione di anomalie** non garantisce affatto un software migliore o con meno errori: per correggere un'anomalia è necessario per forza di cose anche modificare il codice sorgente, ma ogni volta che viene fatto si aprono nuove possibilità di introdurre **nuove anomalie** e bug nel codice stesso.

### Tecnica naïve

È la tecnica maggiormente utilizzata e consiste nell'introdurre nel modulo in esame **comandi di uscita** (_print_) che stampino il valore intermedio assunto dalle variabili.

Nonostante sia **facile da applicare**, secondo il professore è una tecnica molto debole: non solo **richiede la modifica del codice** (e quindi la _rimodifica_ al termine) ma è **poco flessibile** in quanto richiede una nuova compilazione per ogni stato esaminato.

Può andare bene nei casi in cui il codice è progettato talmente bene e il modulo è così **ben isolato** che basta scrivere una unica _print_ da cui si è in grado di risalire all'anomalia: scenario troppo irrealistico.

C'è da considerare comunque che con questa tecnica viene testato un **programma diverso**, in quanto ha presente delle _print_ aggiuntive apparentemente innocue e senza effetti collaterali. 

#### Tecnica naïve avanzata

Un miglioramento parziale si può ottenere sfruttando le **funzionalità del linguaggio** oppure alcuni tool, come:
- `#ifdef` e `gcc -D` per il C
- **librerie di logging** (con diverso livello); 
- **asserzioni**: possono essere viste anche come _oracoli interni_ al codice, segnalando facilmente stati illegali.

Resta comunque una **tecnica naïve** in quanto si sta ancora modificando il codice in modo che fornisca informazioni aggiuntive.

### Dump di memoria

Consiste nel produrre una **immagine esatta** della **memoria** dopo un passo di esecuzione: scrivere su un file il contenuto intero della memoria a livello di linguaggio macchina.

    Segmentation fault (core dumped)

Nei sistemi a 32 bit, la dimensione dei dump può arrivare fino a 4GB.

Non richiede modifica del codice, ma è spesso **difficile da gestire** a causa della differenza tra la rappresentazione astratta dello stato (legata alle strutture dati del linguaggio utilizzato) e la rappresentazione fornita dallo strumento.
Viene prodotta una **enorme mole di dati** molto spesso inutile.
 
### Debugging simbolico

Il debugger simbolico fornisce **informazioni sullo stato** utilizzando gli **stessi simboli** per cui le locazioni di memoria sono state definite e quindi rendendo utile l'attività di **ispezione dello stato**.

In aggiunta, i debugger simbolici forniscono **ulteriori strumenti** (*watch* o *spy monitor*) che permettono di visualizzare il 
comportamento del programma in maniera selettiva. 

È possibile inserire **breakpoint** e **watchpoint** su linee di codice eventualmente in base al valore di variabili, scegliendo anche la granularità del successivo passo di esecuzione:
- **singolo**;
- **dentro una funzione**;
- **drop/reset del frame**: vengono scartate le variabili nel frame d'esecuzione ritornando ad una situazione precedente.

#### Debugging per prova

È possibile istruire il debugger per **esaminare automaticamente** gli stati ottenuti in modo da verificarne la correttezza.
Utilizzando **watch condizionali** è possibile aggiungere **asserzioni a livello di monitor**.

Ad esempio, è possibile chiedere al _monitor_ (l'_esecutore_ del programma) di controllare che gli indici di un array siano sempre interni all'intervallo di definzione.

#### Altre funzionalità

Inoltre, nei debugger moderni si può:
- __modificare il contenuto di una variabile__ (o zona di memoria) a runtime;
- __modificare il codice__: nonostante non sia sempre possibile, può essere comodo per esempio dopo tante iterazioni di un ciclo;
- __rappresentazioni grafiche__ dei dati: strutture dinamiche come puntatori, alberi e grafi possono essere rappresentate graficamente per migliorare la comprensione dello stato.

### Automazione

**L'attività di debugging, può essere automatizzata?**

Andreas Zeller nel suo [Debugging Book](http://debuggingbook.org/) tratta questo argomento proponendo alcune soluzioni.

I due concetti principali sono i seguenti:
- __shrinking input__: dato un **input molto grande** e complesso che causa un malfunzionamento, strumenti automatici possono provare a ridurlo il più possibile in modo da semplificare il debugging;
- __differential debugging__: dato lo stesso input, in maniera automatica vengono esplorati gli stati del programma mutando ad ogni iterazione piccole porzioni di codice.

Quest'ultima proposta è simile al comando **`git bisect`** di Git: data una versione vecchia in cui il bug non è presente, una versione nuova in cui lo è e un oracolo che stabilisce se il bug è presente o meno, Git esegue una **ricerca dicotomica** per trovare la versione che ha introdotto il problema.
