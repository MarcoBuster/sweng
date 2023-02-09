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

Finora abbiamo esplorato tecniche più o meno _automatiche_ per la ricerca di errori, che stimolavano il programma con specifici input o ne analizzavano il codice per individuare potenziali anomalie. \\
Tuttavia, alcuni tipi di errori non possono essere rilevati con questi metodi: si tratta soprattutto errori legati a _incomprensione delle specifiche_.
Del resto, attività come il testing richiedono che il programmatore fornisca l'output "corretto" che si aspetta dal programma che viene confrontato con quello effettivo per scovare eventuali differenze: se chi scrive il codice non comprende in primo luogo _cosa_ dovrebbe fare il suo software non c'è modo di individuare l'errore.

Per questo motivo molto spesso il codice viene sottoposto ad un'attività di __review__, in cui un operatore umano ne analizza la struttura e il funzionamento: egli sarà chiaramente in grado di cogliere una serie di __errori semantici__ che sfuggono alla comprensione dei tool automatici di test.
Spesso questa mansione viene svolta da un __team di testing__ separato dal team di sviluppo: non solo questo promuove l'effettiva ricerca di errori (_mentre gli sviluppatori avrebbero tutto l'interesse di non trovarne nessuno_), ma sottopone il software a uno sguardo esterno più critico e imparziale.

Anche per la review esistono una serie di tecniche: vediamone quindi le principali.

## Bebugging

Talvolta può capitare che il team di testing __non trovi errori__ nel programma sotto osservazione.
Oltre ad essere scoraggiante per chi esegue la review questo è spesso indice del fatto che tale attività non viene svolta in maniera corretta, poiché raramente un programma è effettivamente corretto al 100% dopo la prima scrittura.

Un metodo efficace per risolvere questo problema è il cosiddetto __bebugging__, una tecnica secondo la quale gli sviluppatori __inseriscono deliberatamente $$\bf{n}$$ errori__ nel codice prima di mandarlo in analisi al team di testing, a cui viene comunicato il numero $$n$$ di errori da trovare.
L'ovvio vantaggio di questa tecnica è l'__incentivo__ per il team di testing a continuare a cercare errori, facendo sì che durante la ricerca ne vengano scovati molti altri non ancora noti.

La metrica utilizzata per valutare l'efficacia del testing tramite questa tecnica è dunque la __percentuale di errori trovati__ tra quelli inseriti artificialmente, che può fornire un'indicazione della frazione di errori che il team di testing è in grado di trovare.
Se per esempio il team di sviluppo ha aggiunto 10 bug _"artificiali"_ e durante il testing ne vengono trovati 8 più 2 non noti, si può supporre che il team di review riesce a trovare l'_80% degli errori_ e che quindi ce ne è ancora un altra porzione di errori _reali_ da scovare. \\
Bisogna però essere molto cauti nel fare considerazioni di questo tipo: è possibile che gli errori immessi artificialmente siano __troppo facili__ o __troppo difficili__ da trovare, per cui conviene sempre prendere tutto con le pinze.

## Analisi mutazionale

Una evoluzione del bebugging è l'__analisi mutazionale__.
Dato un programma $$P$$ e un test $$T$$ (_insieme di casi di test_), viene generato un insieme di programmi $$\Pi$$ _simili_ al programma $$P$$ in esame: tali programmi prendono il nome di __mutanti__. \\
Si esegue poi il test $$T$$ su ciascun mutante: se $$P$$ era corretto i programmi in $$\Pi$$ __devono essere sbagliati__, ovvero devono produrre un __risultato diverso__ per almeno un caso di test $$t \in T$$.
Se così non fosse, infatti, vorrebbe dire che il programma $$P$$ non viene opportunamente testato nell'aspetto in cui si discosta dal mutante che non ha sollevato errori, per cui non si può essere sicuri della sua correttezza.
Non viene cioè testata la correttezza del programma, ma piuttosto __quanto il test è approfondito__.

Si può quindi valutare la capacità di un test di rilevare le differenze introdotte nei mutanti tramite un nuovo criterio di copertura, che prende il nome di __criterio di copertura dei mutanti__.

### Criterio di copertura dei mutanti

_Un test $$\ T$$ soddisfa il __criterio di copertura dei mutanti__ se e solo se per ogni mutante $$\pi \in \Pi$$ esiste almeno un caso di test $$t \in T$$ la cui esecuzione produca per $$\pi$$ un risultato diverso da quello prodotto da $$P$$_.

La metrica di valutazione di questo criterio è la __frazione di mutanti $$\pi$$ riconosciuta come diversa__ da $$P$$ sul totale di mutanti generati.
Se non tutti i mutanti vengono scovati sarà necessario aggiungere dei casi di test che li riconoscano.

I tre passi da seguire per costruire un test tramite l'analisi mutazionale sono quindi:

1. __analisi__ delle classi e generazione dei mutanti;
2. __selezionare__ dei casi di test da aggiungere a $$T$$, in base alla metrica di cui sopra;
3. __esecuzione__ dei casi di test sui mutanti, pensando anche alle performance;

Analizziamo ciascuno di tali step in maggior dettaglio.

### Generazione dei mutanti

Idealmente i mutanti generati dovrebbero essere il __meno differenti possibile__ dal programma di partenza, ovvero dovrebbe esserci __un mutante per ogni singola anomalia__ che sarebbe possibile inserire nel programma.

Questo richiederebbe però di generare __infiniti__ mutanti, mentre per mantenere la suite di test _eseguibile in tempi ragionevoli_ il numero di mutanti non dovrebbe essere troppo elevato: un centinaio è una buona stima, ma un migliaio sarebbe auspicabile. \\
Visto il numero limitato è necessario dunque concentrarsi sulla "__qualità__" dei mutanti generati, dove i mutanti sono tanto più buoni quanto più permettono di scovare degli errori.
Per questo motivo vengono creati degli specifici _operatori_ che dato un programma restituiscono dei mutanti _utili_.

#### Operatori mutanti

Come già accennato, gli __operatori mutanti__ sono delle funzioni (_o piccoli programmi_) che dato un programma $$P$$ generano un insieme di mutanti $$\Pi$$.
Essi operano eseguendo piccole __modifiche sintattiche__ che modifichino la __semantica del programma__ senza però causare errori di compilazione.

Tali operatori si distinguono in __classi__ in base agli oggetti su cui operano:

- __costanti__ e __variabili__, per esempio scambiando l'occorrenza di una con l'altra;
- __operatori__ ed __espressioni__, per esempio trasformando `<` in `<=`, oppure `true` in `false`;
- __comandi__, per esempio trasformando un `while` in `if`, facendo così eseguire il ciclo una sola volta.

Alcuni operatori possono essere anche specifici su alcuni tipi di applicazioni, come nel caso di:

- operatori per __sistemi concorrenti__: operano principalmente sulle primitive di sincronizzazione – come eseguire una `notify()` invece che una `notifyAll()`;
- operatori per __sistemi object-oriented__: operano principalmente sulle interfacce dei moduli.

Poiché la generazione dei mutanti è un'attività tediosa, il compito di applicare questi operatori viene spesso affidato a tool automatici.
Esistono però numerosi __problemi di prestazioni__, in quanto per ogni mutante occorre modificare il codice, ricompilarlo, controllare che non si sovrapponga allo spazio di compilazione delle classi di altri mutanti e fare una serie di altre operazioni che comportano un pesante overhead.
Per questo motivo i tool moderni lavorano spesso sull'__eseguibile__ in sé (_sul bytecode nel caso di Java_): sebbene questo diminuisca il lavoro da fare per ogni mutante è possibile che il codice eseguibile così ottenuto sia un programma che non sarebbe possibile generare tramite compilazione.
Si espande quindi l'universo delle possibili anomalie anche a quelle _non ottenibili_, un aspetto che bisognerà tenere in considerazione nella valutazione della metrica di copertura.

#### High Order Mutation

Normalmente i mutanti vengono generati introducendo una _singola modifica_ al programma originale.
Nella variante __HOM__ (__High Order Mutation__) si applicano invece modifiche a __codice già modificato__.

La giustificazione per tale tecnica è che esistono alcuni casi in cui trovare errori dopo aver applicato più modifiche è _più difficile_ rispetto ad applicarne solo una.
Può essere che un errore mascheri parzialmente lo stato inconsistente dell'altro rendendo più difficile il rilevamento di malfunzionamenti, cosa che porta a generare test ancora più approfonditi.

### Automatizzare l'analisi mutazionale

Generalmente nel testing gli unici due _outcomes_ sono _risultato corretto_ o _non corretto_ e la metrica è una misura della correttezza del programma.
Il discriminante delle tecniche di analisi mutazionale è invece il numero di casi di test che forniscono un risultato ___diverso___ da quello di $$P$$, indipendentemente dalla correttezza (di entrambi).

Come già detto, trovare errori con queste tecniche (specialmente l'HOM) misura quindi il __livello di approfondimento__ dei casi di test e __non__ la __correttezza__ del programma di partenza. \\
Prescindere dalla _correttezza_ dei risultati ha però un aspetto positivo: per eseguire l'analisi mutazionale non è necessario conoscere il comportamento corretto del programma, eliminando la necessità di un _oracolo_ che ce lo fornisca.
Si può quindi misurare la bontà di un insieme casi di test __automatizzando la loro creazione__: come già detto precedentemente, occorre però vigilare sulla __proliferazione del numero di esecuzioni__ da effettuare per completare il test – un caso di test dà infatti origine a $$n+1$$ esecuzioni, dove $$n$$ è il numero di mutanti.

Il seguente diagramma di flusso visualizza quindi l'attività __facilmente automatizzabile__ di analisi mutazionale:

{% responsive_image path: 'assets/13_analisi-mutazionale-schema.png' %}

Benché semplice, questo algoritmo __non garantisce la terminazione__ per una serie di motivi:

- quando si estrae un caso di test casuale, c'è sempre il rischio di __estrarre sempre lo stesso__;
- si potrebbe essere _particolarmente sfortunati_ e __non trovare un caso di test utile__ in tempo breve;
- __esistono infinite varianti__ di programmi __funzionalmente identici__ ma __sintatticamente diversi__, ovvero che svolgono la stessa funzione anche se sono diversi: una modifica sintattica potrebbe non avere alcun effetto sul funzionamento del programma, come per esempio scambiare `<` con `<=` in un algoritmo di ordinamento.
  In tal caso, nessun nuovo caso di test permetterebbe di coprire il mutante, in quanto esso restituirebbe sempre lo stesso output del programma originale.

Spesso viene quindi posto un timeout sull'algoritmo dipendente sia dal tempo totale di esecuzione, sia dal numero di casi di test estratti.

Per verificare la validità del test, è necessario controllare il __numero di mutanti generati__: se questo numero è elevato, il test non era affidabile.
In alternativa, è possibile _"nascondere"_ i mutanti, a patto che non sia richiesta una copertura totale.
In questo modo, è possibile __analizzare programmi__ che sono __funzionalmente uguali ma sintatticamente diversi__, al fine di dimostrarne l'equivalenza o scoprire casi in cui essa non è valida.

# Object-oriented testing

Finora abbiamo trattato i programmi come funzioni matematiche da un dominio di input a un dominio di output.
Questo è tutto sommato vero per quanto riguarda i __linguaggi procedurali__: un programma in tale paradigma è composto da un insieme di funzioni e procedure che preso un dato in ingresso ne restituiscono uno in uscita.
A meno di eventuali variabili globali condivise (il cui uso è comunque sconsigliato), tali funzioni sono indipendenti l'una dall'altra, e possono quindi essere _testate indipendentemente_ come fossero dei piccoli sotto-programmi.

La situazione cambia per quanto riguarda invece i __linguaggi object oriented__ (__OO__), che introducono i concetti di classe e istanza: in tali linguaggi gli oggetti sono l'__unione di metodi e stato__.
Le tecniche di testing viste finora smettono quindi di funzionare: la maggior parte delle volte testare i metodi isolatamente come funzioni da input ad output perde di senso, in quanto non si considera il contesto (lo _stato_ dell'oggetto associato) in cui essi operano.

Bisogna dunque sviluppare una serie di tecniche di test specifiche per i linguaggi orientati agli oggetti, in cui l'__unità testabile__ si sposti dalle procedure alle __classi__.

## Ereditarietà e collegamento dinamico

Prima di capire _come_ è possibile testare un'intera classe, affrontiamo due punti critici che derivano dal funzionamento intrinseco dei linguaggi a oggetti: l'__ereditarietà__ e il __collegamento dinamico__.

Partiamo dal primo e immaginiamo di avere una classe già completamente testata.
Creando ora una sottoclasse di tale classe originale può sorgere un dubbio: _visto che i metodi ereditati sono già stati testati nella classe genitore ha senso testarli nella classe figlia?_
Un quesito simile sorge nel caso di metodi di default appartenenti a un'interfaccia: _ha senso testare i metodi di default direttamente nell'interfaccia o è meglio testarli nelle classi concrete che implementano tale interfaccia?_ \\
Il consenso degli esperti è di __testare nuovamente tutti i metodi ereditati__: nelle sottoclassi e nelle classi che implementano delle interfacce con metodi di default tali metodi opereranno infatti in __nuovi contesti__, per cui non vi è alcuna certezza che funzionino ancora a dovere.
Inoltre, a causa del collegamento dinamico non è nemmeno sicuro che eseguire lo stesso metodo nella classe base significa eseguire le stesse istruzioni nella classe ereditata. \\
In generale dunque non si eredita l'attività di testing, ma si possono invece ereditare i casi di test e i relativi valori attesi (_l'oracolo_): è perciò opportuno __rieseguire__ i casi di test anche nelle sottoclassi.

Un altro motivo per cui il testing object-oriented differisce fortemente da quello per linguaggi funzionali è la preponderanza del __collegamento dinamico__, attraverso il quale le chiamate ai metodi vengono collegate a runtime in base al tipo effettivo degli oggetti.
Dal punto di vista teorico, infatti, tale meccanismo rende difficile stabilire staticamente tutti i possibili cammini di esecuzione, complicando la determinazione dei criteri di copertura.

## Testare una classe

Entriamo ora nel vivo della questione.
Per __testare una classe__:

- la __si isola__ utilizzando più _classi stub_ possibili per renderla eseguibile indipendentemente dal contesto;
- si implementano eventuali __metodi astratti__ o non ancora implementati (stub);
- si aggiunge una funzione per permettere di estrarre ed esaminare lo stato dell'oggetto e quindi __bypassare l'incapsulamento__;
- si costruisce una classe driver che permetta di istanziare oggetti e chiamare i metodi secondo il __criterio di copertura__ scelto.

Ebbene sì, sono stati progettati dei criteri di copertura specifici per il testing delle classi.
Vediamo dunque di cosa si tratta.

### Copertura della classe

I __criteri classici__ visti precedentemente (comandi, decisioni, ...) continuano a valere ma __non sono sufficienti__.
Per testare completamente una classe occorre considerare lo __stato dell'oggetto__: in particolare, è comodo utilizzare una __macchina a stati__ che rappresenti gli _stati possibili_ della classe e le relative _transazioni_, ovvero le chiamate di metodi che cambiano lo stato.

Tale rappresentazione potrebbe esistere nella documentazione o essere creato specificatamente per l'attività di testing.
Il seguente diagramma rappresenta per esempio una macchina a stati di una classe avente due metodi, $$\mathtt{m1}$$ e $$\mathtt{m2}$$.

{% responsive_image path: 'assets/13_criteri-copertura-grafo.png' %}

Ottenuta una rappresentazione di questo tipo, alcuni criteri di copertura che si possono ipotizzare sono:

- __coprire tutti i nodi__: per ogni __stato__ dell'oggetto deve esistere almeno un caso di test che lo raggiunge;
- __coprire tutti gli archi__: per ogni stato e per ogni metodo deve esistere almeno un caso di test che esegue tale metodo trovandosi in tale stato;
- __coprire tutte le coppie di archi input/output__: per ogni stato e per ogni coppia di archi entranti e uscenti deve esistere almeno un caso di test che arriva nello stato tramite l'arco entrante e lo lascia tramite l'arco uscente (consideriamo anche _come_ siamo arrivati nello stato);
- __coprire tutti i cammini identificabili nel grafo__: spesso i cammini in questione sono infiniti, cosa che rende l'applicazione di questo criterio infattibile (_"sopra la linea rossa"_).

#### Tipo di testing: white o black box?

Abbiamo assunto che il diagramma degli stati facesse parte delle specifiche del progetto.
Se così fosse, allora il testing appena descritto assume una connotazione __black box__:  il diagramma rappresenta sì la classe ma è ancora una sua __astrazione__, che non considera il codice effettivo che rappresenta lo stato o che implementa uno specifico metodo ma solo le relazioni tra i vari stati.

In caso il diagramma degli stati non sia però fornito, il testing delle classi è comunque possibile!
Attraverso tecniche di __reverse engineering__ guidate da certe euristiche (che operano ad un livello di astrazione variabile) è possibile ad __estrarre informazioni sugli stati__ di una _classe già scritta_; spesso tali informazioni non sono comprensibili per un essere umano, motivo per cui esse vengono piuttosto utilizzate da vari tool di testing automatico.
In questo caso, però, il testing assume caratteristiche __white box__, in quanto il codice che implementava la classe era già noto prima di iniziare a testarlo.

# Testing funzionale

Introduciamo ora una nuova attività di testing che parte da presupposti completamente diversi rispetto a quelli del test strutturale.

Il __test funzionale__ è infatti un tipo di test che si concentra sulla verifica del comportamento del programma dal punto di vista dell'__utente finale__, senza considerare il suo funzionamento interno.
In altre parole, il test funzionale è un approccio __black box__ in cui non si ha (o non comunque non si sfrutta) la conoscenza del codice sorgente.

Talvolta questo può essere l'__unico approccio possibile__ al testing, come nel caso di validazione del lavoro di un committente esterno; altre volte invece si decide volontariamente di farlo, concentrandosi sul __dominio delle informazioni__ invece che sulla struttura di controllo. \\
Il test funzionale, che prende in considerazione le __specifiche__ (e non i requisiti) del progetto per discriminare un comportamento corretto da uno scorretto, permette infatti di identificare errori che __non possono essere individuati__ con criteri strutturali, come per esempio funzionalità non implementate, flussi di esecuzione dimenticati o errori di interfaccia e di prestazioni.

## Tecniche

Le tecniche di test funzionale si possono raggruppare in:

- __metodi basati su grafi__: oltre alle tecniche già viste in precedenza, si può per esempio lavorare anche sui diagrammi di sequenza;
- __suddivisioni del dominio in classi di equivalenza__: si possono raggruppare i valori del dominio che causano lo stesso comportamento in classi d'equivalenza, così da testare tutti i _comportamenti distinti_ piuttosto che tutti i possibili valori del dominio.
Occorre fare attenzione a non fare l'inverso, ovvero a concentrarsi sui soli valori appartenenti ad una classe di equivalenza ignorando il resto;
- __analisi dei valori limite (test di frontiera)__: si testano, tra tutti i possibili valori del dominio, quelli _"a cavallo"_ tra una categoria e l'altra, in quanto essi possono più facilmente causare malfunzionamenti;
- __collaudo per confronto__: si confronta la nuova versione del programma con la vecchia, assicurandosi che non siano presenti regressioni.
Non solo si possono confrontare gli eseguibili, ma anche _specifiche formali eseguibili_ che rappresentino le caratteristiche importanti del software;

Non tutte le metodologie di testing funzionale ricadono però in una di queste categorie, e la più notevole è sicuramente il __testing delle interfacce__, di cui diamo un assaggio prima di passare a parlare di classi di equivalenza.

### Testing delle interfacce

Questa tecnica mira a testare come i vari sotto-sistemi del programma dialoghino e __collaborino__ tra loro: per "interfacce" non si intendono infatti le `interface` Java o le _signature_, ma l'insieme di funzionalità che permettono l'interoperabilità dei componenti. \\
Esistono in particolare diversi tipi di interfacce:

- a __invocazione di parametri__;
- a __condivisione di memoria__;
- a __metodi sincroni__;
- a __passaggio di messaggi__.

Le interfacce aderenti a ciascuna categoria possono essere analizzate in modi diversi alla ricerca di anomalie.
Gli sbagli più comuni sono per esempio __errori nell'uso dell'interfaccia__, come il passaggio di parametri in ordine o tipo errato oppure assunzioni sbagliate circa ciò che le funzionalità richiedono (_precondizioni_), ed __errori di tempistica o di sincronizzazione__ tra componenti.

### Classi di equivalenza

La tecnica delle classi di equivalenza si pone l'obiettivo di dividere il dominio del programma in __classi di dati__, ovvero gruppi di valori di input che _dovrebbero_ __stimolare il programma nella stessa maniera__.
Non si tratta quindi di classi di equivalenza degli output, ovvero valori che dati in pasto al programma forniscono lo stesso risultato, quanto piuttosto valori che dati in pasto al programma forniscono un risultato diverso ma _prodotto nello stesso modo_.

Una volta individuate le classi di dati l'obiettivo sarebbe quindi di estrarre da esse casi di test in modo da testare il funzionamento del programma in tutti suoi funzionamenti standard. \\
In realtà, dunque, si cercano di individuare casi di test che rivelino eventuali __classi di equivalenza di errori__, ovvero insiemi di valori che generano malfunzionamenti per lo stesso motivo.
Classi di equivalenza di questo tipo sono solitamente più _"stabili"_ rispetto alle normali classi di equivalenza in quanto il risultato ottenuto, ovvero l'errore, è spesso lo stesso o molto simile.

Volendo dare una definizione più formale, _una __classe di equivalenza__ rappresenta un insieme di __stati validi o non validi__ per i dati in input e un insieme di stati validi per i dati di output_, dove per dato si intendono valori, intervalli o insiemi di valori correlati. \\
È importante comprendere anche i possibili _stati non validi_ in quanto bisogna testare che il programma reagisca bene all'input mal formattato.
Ogni dominio avrà quindi almeno due classi di equivalenza:

- la classe degli __input validi__
- la classe degli __input non validi__

Per fare un esempio si può considerare un programma che chiede in input un __codice PIN di 4 cifre__.
Il suo dominio può quindi essere suddiviso in due semplici classi di equivalenza:

1. PIN corretto;
2. tutti i numeri di 4 cifre diversi dal PIN.

Volendo fare un altro esempio, se ci si aspetta che i valori in input ricadano in un intervallo, per esempio $$[100, \, 700]$$), si possono definire la classe di equivalenza valida $$x \in [100, 700]$$ e la classe di equivalenza non valida $$x \notin [100, 700]$$.
Per voler aumentare la granularità si può però spezzare la classe degli input non validi in due, ottenendo una classe valida e due non valide:

1. $$x \in [100, 700]$$;
2. $$x < 100$$;
3. $$x > 700$$.

Come si vede, la scelta delle classi di equivalenza da considerare non è univoca, e richiede un minimo di conoscenza di dominio.
Alternativamente esistono delle tecniche standard di individuazione delle classi di equivalenza a partire dalle specifiche che prendono il nome di __category partition__.

### Test di frontiera

La tecnica dei __test di frontiera__ è _complementare_ a quella delle classi di equivalenza.
Partendo dal presupposto che gli errori tendono ad accumularsi sui __casi limite__, ovvero quelli la cui gestione è più particolare, questa tecnica suggerisce di selezionare come casi di test non valori a caso all'interno delle classi di equivalenza, ma i valori presenti __al confine__ tra di loro.

### Category partition

La tecnica di __category partition__ è un metodologia che permette di caratterizzare e identificare le classi di equivalenza del dominio di un problema a partire dalle sue specifiche.
Può essere utilizzata a __vari livelli__ a seconda che si debbano realizzare test di unità, test di integrazione e o test funzionali.

Il metodo è composto da una serie di passi in sequenza:

1. __analisi delle specifiche__: in questa fase vengono identificate le _unità funzionali individuali_ che possono essere verificate singolarmente; non necessariamente sono un'unica classe, è sufficiente che siano componenti facilmente separabili dal resto, sia a livello di testing che concettuale.
Per ogni unità vengono quindi identificate delle caratteristiche (__categorie__) dei parametri e dell'ambiente in cui opera;
2. __scegliere dei valori__: per ogni categoria, occorre scegliere quali sono i _valori sensati_ su cui fare riferimento;
3. __determinare eventuali vincoli tra le scelte__, che non sono sempre indipendenti;
4. __scrivere test e documentazione__.

Per capire meglio ciascuna di tali fasi vediamo un'esempio di utilizzo della tecnica di _category partition_ prendendo come soggetto il comando `find` della shell Linux.

#### PASSO 1 – analizzare le specifiche

Per prima cosa analizziamo le specifiche del comando:

> __Syntax__: `find <pattern> <file>`
>
> The find command is used to locate one or more instances of a given pattern in a file.
> All lines in the file that contain the pattern are written to standard output.
> A line containing the pattern is written only once, regardless of the number of times the pattern occur in it.
>
> The pattern is any sequence of characters whose length does not exceed the maximum length of a line in the file.
> To include a blank in the pattern, the entire pattern must be enclosed in quotes (`"`).
> To include a quotation mark in the pattern, two quotes (`""`) in a row must be used.

Vista la relativa semplicità, `find` è un'unità funzionale individuale che può essere verificata separatamente.
Bisogna dunque individuarne i parametri: come è chiaro dalla sintassi essi sono due, il `pattern` da cercare e il `file` in cui farlo.

Ora, ciascuno di tali parametri può possedere determinate caratteristiche, ed è nostro compito in questa fase comprenderle ed estrarle. \\
Tali caratteristiche possono essere di due tipi: __esplicite__, ovvero quelle ricavabili direttamente dalla lettura specifiche, e __implicite__, ovvero quelle che provengono dalla nostra conoscenza del dominio di applicazione e che quindi non vengono specificate.

Tornando al nostro caso di studio possiamo per esempio ottenere la seguente tabella:

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
- pattern sovrapposti;
- tipo del file.
</td>
</tr>
</table>

È importante _esplicitare le caratteristiche implicite_ dei parametri dell'unità funzionale perché __le specifiche non sono mai complete__ e solo così possiamo disporre di tutti gli elementi su cui ragionare nelle fasi successive.

Si presti poi attenzione alla distinzione fatta tra il _nome_ del file e il suo _contenuto_: il primo infatti è un __parametro__ che viene passato al comando per iniziarne l'esecuzione, mentre il secondo fa parte dell'__ambiente__ in cui il comando opera ed è dunque soggetto ad una sottile distinzione concettuale.

##### <big>ALPHA E BETA TESTING</big>

Spesso, però, analizzare le specifiche non basta per comprendere tutte le variabili che entrano in gioco durante l'esecuzione di un programma.
Bisogna infatti ricordare che ci sono moltissime altre caratteristiche d'ambiente che ancora __non sono state considerate__: la versione del sistema operativo, del browser, il tipo di architettura della macchina su cui gira il programma eccetera.

Spesso, quindi, la fase di testing funzionale si divide in due fasi:

- __alpha testing__: l'unità funzionale viene testata in-house, ovvero su una macchina all'interno dello studio di sviluppo.
In questa fase si considerano soprattutto le caratteristiche legate alle specifiche di cui sopra;
- __beta testing__: per testare varie _configurazioni d'ambiente_ una versione preliminare del programma viene distribuito in un _ambiente variegato_ per osservare come esso si comporta sulle macchine di diversi utenti.

Per il momento, però, consideriamo solo la fase di alpha testing e le categorie ad essa relative.

#### PASSO 2 – scegliere dei valori

Individuate le caratteristiche dei parametri e delle variabili d'ambiente da cui l'unità funzionale dipende, che prendono il nome di __categorie__, si passa quindi alla seconda fase.

In questa fase si devono identificati __tutti e i soli__ _casi significativi_ per ogni categoria, ovvero quei valori della stessa che si ritiene abbia senso testare; poiché si tratta di un compito molto soggettivo è importante in questa fase avere __esperienza__ (_know-how_) nel dominio d'applicazione.

Per capire meglio di cosa stiamo parlando ritorniamo al nostro esempio e consideriamo il parametro `pattern`.
Per ciascuna delle sue categorie possono essere individuati vari casi significativi:

- __lunghezza del pattern__: vuoto, un solo carattere, più caratteri, più lungo di almeno una linea del file;
- __presenza di apici__: pattern tra apici, pattern non tra apici, pattern tra apici errati;
- __presenza di spazi__: nessuno spazio nel pattern, uno spazio nel pattern, molti spazi nel pattern;
- __presenza di apici interni__: nessun apice nel pattern, un apice nel pattern, molti apici nel pattern.

È interessante notare il _mantra_ già visto del "__nessuno__, __uno__, __molti__", spesso molto utile in questa fase.

#### PASSO 3 – determinare i vincoli tra le scelte

Trovati tutti i valori significativi delle categorie dell'unità funzionale come possiamo costruire i casi di test da utilizzare per verificarne la correttezza?

Si potrebbe pensare di testare __tutte le combinazioni__ di valori significativi, facendo cioè il prodotto cartesiano tra le categorie.
Nella pratica, però, ciò risulterebbe in un numero esagerato di casi di test: già solo nel nostro semplice esempio questi sarebbero ben 1944, decisamente __troppi__.

Nel tentativo di evitare quest'esplosione combinatoria ci si accorge però che spesso le anomalie sorgono dall'interazione di __coppie__ di caratteristiche indipendentemente dal valore assunto da tutte le altre: per esempio, un problema potrebbe presentarsi se si usa il browser _Edge_ sul sistema operativo _Linux_, indipendentemente da caratteristiche quali la dimensione dello schermo, l'architettura del processore eccetera. \\
Per ridurre il numero di casi di test si sviluppa quindi la tecnica del ___pairwise testing___, che riduce l'insieme delle configurazioni da testare a tutte le combinazioni di coppie di valori.
È quindi presente almeno un caso di test _per ogni coppia ipotizzabile_ di valori: in rete e in Java sono presenti diversi [__strumenti__](https://www.pairwise.org/tools.html) che permettono di creare casi di test combinati con il metodo _pairwise_.

Un'ulteriore tentativo di ridurre il numero di casi di test prevede di definire una serie di ___vincoli___ per la generazione delle coppie, escludendo particolari combinazioni di caratteristiche: così, per esempio si potrebbe escludere la coppia "OS == MacOs" e "browser == Edge" perché sfruttando la conoscenza di dominio sappiamo che tale browser non è disponibile sul suddetto sistema operativo. \\
Volendo essere più precisi, la creazione di vincoli prevede un passaggio intermedio: vengono definite una serie di __proprietà__ (es. _NotEmpty_ o _Quoted_ per l'esempio su `find`) e si creano dei vincoli logici a partire da esse.
I vincoli seguono poi una struttura tra le seguenti:

- __se__: si può limitare l'uso di un valore solo ai casi in cui è definita una proprietà. Per esempio, è inutile testare il caso _"il file non esiste"_ se la proprietà _NotEmpty_ si manifesta;
- __single__: alcune caratteristiche prese singolarmente anche se combinate con altre generano lo stesso risultato. Per esempio, se il file non contiene occorrenze del pattern cercato il risultato del programma è indipendente dal tipo di pattern cercato;
- __error__: alcune caratteristiche generano semplicemente errore, come per esempio se si omette un parametro.

#### PASSO 4 – scrivere i test

Fissati i vincoli e fatti i calcoli combinatori si procede ad enumerare iterativamente tutti i casi di test generati continuando ad aggiungere vincoli fino ad arrivare ad un __numero ragionevole__.

Ovviamente, i casi di test avranno poi bisogno di __valori specifici__ per le caratteristiche: non basta dire "pattern con apici all'interno", bisogna creare un pattern aderente a questa descrizione!
Fortunatamente questa operazione è solitamente molto facile, anche con tool automatici.

#### Conclusioni

Per quanto intuitiva e utile, la tecnica di category partition presenta due criticità:

- individuare i __casi significativi__ delle varie caratteristiche può essere difficile e si può sbagliare, anche utilizzando mantra come "_zero_, _uno_, _molti_";
- una volta generati i casi di test serve comunque un "__oracolo__" che fornisca la risposta giusta, ovvero quella che ci si attende dall'esecuzione sul caso di test.
L'attività non è dunque _completamente_ automatizzabile.

Va però detto che esistono delle tecniche di __property-based testing__ che cercano di eliminare la necessità di un oracolo considerando particolari proprietà che dovrebbero sempre valere durante l'esecuzione (invarianti) piuttosto che analizzare il risultato dell'esecuzione dei casi di test per determinare la correttezza del programma.

## Object orientation e testing funzionale

Trattandosi di un approccio __black box__ che ragiona sulle __funzionalità__ e non sui dettagli implementativi, l'introduzione del paradigma a oggetti __non dovrebbe cambiare nulla__ per quanto riguarda il testing funzionale.
Se questa affermazione è vera per quanto riguarda la verifica di singole unità funzionali, lo stesso non si può dire nel caso di __test di integrazione__.

Nei linguaggi procedurali i test di integrazione sono infatti scritti secondo logiche alternativamente __bottom-up__ o __top-down__: esiste cioè un punto di partenza dal quale partire ad aggregare le componenti, seguendo cioè una qualche forma di __albero di decomposizione__ del programma. \\
Per quanto riguarda la programmazione a oggetti, invece, la situazione è __molto più caotica__: le relazioni tra le classi sono spesso cicliche e non gerarchiche (tranne per l'ereditarietà &mdash; la relazione meno interessante), in una serie di _inter-dipendenze_ che rendono difficoltoso individuare un punto da cui partire a integrare.

Relazioni interessanti in questa fase sono infatti _associazioni_,_aggregazioni_ o _dipendenze_, ma rendono complicato identificare il __sottoinsieme di classi da testare__.
Per fare ciò si possono comunque utilizzare alcuni strumenti già visti:

- si può partire dai diagrammi degli __use cases e scenari__ per testare i componenti citati;
- si possono osservare i __sequence diagram__ per testare le classi protagoniste delle interazioni a scambio di messaggi descritte;
- si possono infine usare gli __state diagram__ nella modalità che abbiamo già descritto.

# Software inspection

Un'altra classe di tecniche di verifica e convalida è la __software inspection__, ovvero tecniche manuali per individuare e correggere gli errori basati su una attività di gruppo in cui si analizza il codice insieme passo passo: si pensi per esempio alla tecnica di _pair programming_ già ampiamente citata parlando di XP.

Le tecniche di software inspection sono molto interessanti in quanto hanno __pochi requisiti__ e l'unico __tool__ richiesto è un essere __umano__ che si prenda la briga ispezionare il codice, spesso in riunioni di gruppo da 5-6 persone.

Trattandosi di una tecnica umana essa è molto __flessibile__: l'__oggetto sotto ispezione__ può essere una porzione di codice non funzionante, una serie di specifiche formali o informali o direttamente l'eseguibile compilato.
La software inspection può quindi essere eseguita durante tutte le fasi del ciclo di vita di un programma.

## Fagan code inspection

La __Fagan code inspection__ è una metodologia sviluppata da Michael Fagan alla IBM negli anni '70.
La metodologia prevede che un __gruppo di esperti__ esegua una serie di passi per verificare la correttezza del codice sorgente al fine di individuare eventuali errori, incongruenze o altri problemi. \\
È __la più diffusa__ tra le tecniche di ispezione, nonché la più rigorosa e definita.

### Ruoli

Essendo un'attività di gruppo, nella Fagan code inspection vengono identificati diversi ruoli:

- __Moderatore__: è colui che coordina i meeting, sceglie i partecipanti e ha la responsabilità di far rispettare le regole di cui parleremo tra poco.
  È di solito una persona che lavora ad un progetto diverso da quello in esame in modo da evitare conflitti di interessi.
- __Readers e Testers__: non sono persone diverse, semplicemente a seconda dei momenti i partecipanti possono coprire uno di questi due ruoli: i primi leggono il codice al gruppo, mentre i secondi cercano difetti al suo interno.
  La lettura del codice è una vera e propria _parafrasi_ di esso, ovvero un'interpretazione del codice nella quale si spiega quello che fa ma seguendo comunque la sua struttura.
- __Autore__: è colui che ha scritto il codice sotto ispezione; è un partecipante passivo che risponde solo a eventuali domande.
  È simile al ruolo del _cliente_ nell'eXtreme Programming: pronto a rispondere a qualsiasi domanda per accelerare il lavoro degli altri.

### Processo

Definiti i ruoli, secondo la tecnica __Fagan__ di ispezione del codice il processo si articola come segue:

1. __Planning__: in questa prima fase il moderatore sceglie i partecipanti, si definiscono i loro ruoli e il tempo da dedicare alla ispezione, pianificando anche i vari incontri.
2. __Overview__: viene fornito a tutti i partecipanti materiale sul progetto per permettere loro di farsi un'idea del contesto in cui l'oggetto dell'ispezione si inserisce in ottica della riunione vera e propria.
3. __Preparation__: i partecipanti _"offline"_ comprendono il codice e la sua struttura autonomamente sulla base anche del materiale distribuito nella fase precedente;
4. __Inspection__: la vera e propria fase di ispezione.
  In questa fase si verifica che il codice soddisfi le regole definite in precedenza e si segnalano eventuali problemi o anomalie.
  Durante l'ispezione, il gruppo di esperti esamina il codice riga per riga, confrontandolo con le specifiche e cercando di individuare errori, incongruenze o altri problemi.
5. __Rework__: una volta individuati i problemi, l'autore del codice si occupa di correggere i difetti individuati.
6. __Follow-up__: possibile re-ispezione del nuovo codice ottenuto dopo la fase precedente.

Se la maggior parte delle fasi è abbastanza autoesplicativa, è bene dare uno sguardo più approfondito all'attività di ispezione vera e propria.

#### Ispezione

Durante la fase di ispezione, l'obiettivo è __trovare e registrare__ i difetti __senza correggerli__: la tentazione di correggere i difetti è sicuramente fortissima ma non è compito dei partecipanti alla riunione farlo.
Ciascuno di loro potrebbe infatti avere le proprie idee e preferenze e metterli d'accordo potrebbe non essere facile: si preferisce quindi che sia l'autore del codice a correggere successivamente i problemi trovati.

Per evitare ulteriormente di perdere tempo sono previste _al massimo_ 2 sessioni di ispezione di 2 ore al giorno, durante le quali lavorare approssimativamente a __150 linee di codice all'ora__.
Quest'ultimo vincolo è __molto variable__ in quanto cambia in base al linguaggio, al progetto, all'attenzione ai dettagli richiesta e alla complessità.

Una possibilità prevista in questa fase è anche quella di fare _"test a mano"_: si analizza
il flusso di controllo del programma su una serie di casi di test così da verificarne il funzionamento.

Ancora più prominente è però l'uso di una serie di __checklist__, di cui parliamo nel prossimo paragrafo.

#### Checklist

Rispetto all'attività di testing, che a partire dai malfunzionamenti permetteva di risalire ai difetti e dunque agli sbagli commessi, il _thought-process_ per le __checklist__ è inverso: __si parte dagli _sbagli___ che più frequentemente hanno portato ad inserire determinate anomalie nel codice e si controlla che nessuno di questi sia stato commesso nuovamente.

In letteratura è reperibile la __conoscenza__ di tutto ciò che è meglio evitare poiché in passato ha portato più volte ad avere anomalie nel codice.
Tale conoscenza è raccolta in __checklist comuni__ per i vari linguaggi.

Inoltre, l'ispezione del codice funziona così bene anche perché tali checklist possono essere __redatte internamente__ all'azienda, in base all'esperienza passata e alla storia di un determinato progetto. \\
Man mano che il progetto va avanti, l'__individuazione di un nuovo sbaglio__ si traduce in un'__evoluzione della checklist__: dalla prossima ispezione si controllerà di non aver commesso lo stesso errore.

##### <big>Esempio NASA</big>

La NASA nel suo <a href="../assets/13_nasa-software-inspection.pdf"><i>Software Formal Inspections Guidebook</i></a> (1993) ha formalizzato circa __2.5 pagine di checklist__ per C e 4 per FORTRAN.

Sono divise in _functionality_, _data usage_, _control_, _linkage_, _computation_, _maintenance_ e _clarity_.

Di seguito sono elencati alcuni esempi dei punti di tali checklist:

> - [ ] Does each module have a single function?
> - [ ] Does the code match the Detailed Design?
> - [ ] Are all constant names upper case?
> - [ ] Are pointers not `typecast` (except assignment of `NULL`)?
> - [ ] Are nested `#include` files avoided?
> - [ ] Are non-standard usage isolated in subroutines and well documented?
> - [ ] Are there sufficient comments to understand the code?

### Struttura di incentivi

Perché l'ispezione del codice come è stata descritta funzioni bene, occorre prevedere una serie di __dinamiche positive__ di incentivi al suo interno.

In particolare, è importante sottolineare che i difetti trovati __non devono essere utilizzati__ per la valutazione del personale: questo evita che i programmatori nascondano i difetti nel proprio codice, minando la qualità del prodotto.

Dall'altro canto si possono invece considerare per la __valutazione di readers e tester__ i difetti trovati durante l'ispezione, in modo che questi siano incentivati a fare l'ispezione più accurata possibile.

### Variante: _active_ design reviews

Purché il processo di ispezione funzioni al meglio __le persone__ coinvolte __devono partecipare__, ma per come abbiamo descritto l'attività di Fagan Code Inspection nulla vieterebbe ai revisori non preparati di essere presenti ma non partecipare, rimanendo in silenzio e pensando ad altro.

Innanzitutto, per sopperire a questo problema i partecipanti andrebbero __scelti__ tra persone di adeguata esperienza e sopratutto assicurando che nel team vi siano revisori per diversi aspetti nel progetto.

Qualora questo non bastasse, una variante del processo che prende il nome di __active design review__ suggerisce che sia l'__autore__ a leggere le checklist e sollevare questioni all'attenzione dei revisori, chiedendo diverse domande.
Essendo presi direttamente in causa, i revisori saranno quindi costretti a partecipare.

## Automazione

Sebbene l'ispezione del codice sia una tecnica manuale esistono diversi __strumenti di supporto automatici__ in grado di velocizzare notevolmente il lavoro.
Alcuni di questi tool possono aiutare con:

- __controlli banali__, come la formattazione; in fase di ispezione manuale si controllerà poi il risultato del controllo automatico;
- __riferimenti__: checklist e standard in formati elettronici facilmente consultabili e compilabili;
- __aiuti alla comprensione del codice__: tool che permettono di navigare e leggere il codice con maggiore facilità e spesso utilizzati durante attività di _re-engineering_;
- __annotazione e comunicazioni__ del team, come l'email;
- __guida al processo e rinforzo__: non permettere di chiudere il processo se non sono stati soddisfatti alcuni requisiti (_come la necessità di approvazione prima del merge di una pull request_).

## Pro e contro

Finito di descrivere il processo di ispezione del software possiamo chiederci: funziona?
Prove empiriche parrebbero suggerire che la risposta sia __sì__ e evidenziano anche che tale tecnica è particolarmente _cost-effective_.

I vantaggi dell'uso di questa tecnica di verifica e convalida sono infatti numerosi:

- Esiste un __processo rigoroso e dettagliato__;
- Si basa sull'__accumulo dell'esperienza__, auto-migliorandosi con il tempo (vd. _checklist_);
- Il processo integra una serie di __incentivi sociali__ che spingono l'autore del codice ad analizzarlo in modo critico;
- A differenza del testing è possibile per la mente umana __astrarre il dominio completo__ dei dati, considerando quindi in un certo senso tutti i casi di test;
- È applicabile anche a __programmi incompleti__.

La software inspection funziona così bene che è spesso utilizzata come _baseline_ per valutare altre tecniche di verifica e convalida.

Questo non significa però che essa sia esente da __limiti__. \\
Innanzitutto il test può essere fatto __solo a livello di unità__ in quanto la mente umana ha difficoltà a lavorare in situazioni in cui sono presenti molte informazioni contemporaneamente in assenza di astrazioni e indirettezze.
Inoltre la software inspection __non è incrementale__: spesso infatti la fase di follow-up non è così efficace, in quanto il codice è cambiato talmente tanto che è necessario ricominciare l'ispezione da capo.

Ciò non toglie però che, come afferma la __Legge di Fagan (L17)__:
> Le ispezioni aumentano in maniera significativa la produttività, qualità e la stabilità del progetto.

## Confronto tra tecniche di verifica e convalida

Numerosi studi hanno provato a confrontare l'efficacia di varie tecniche di testing, con particolare riferimento a testing strutturale, testing funzionale e software inspection.
Un [articolo](https://web.archive.org/web/20060920113729/http:/www2.umassd.edu/SWPI/ISERN/ISERN-98-10.pdf) del 2004 riporta in una __tabella di confronto__ i risultati di alcuni di questi studi, considerando come metrica di valutazione delle tecniche di verifica e convalida la _percentuale media di difetti individuati_.

{% responsive_image path: assets/13_tabella-confronto-tecniche-vc.png %}

Come si può notare, a seconda dello studio appare più efficace l'una o l'altra tecnica; inoltre, la somma delle percentuali per ogni riga non è 100%, il che significa che alcuni difetti non possono essere rilevati da nessuna delle tre tecniche. \\
Nonostante ciò, si possono fare una serie di osservazioni: innanzitutto, l'efficacia di una  o dell'altra tecnica dipende dalla __tipologia del progetto__ su cui viene esercitata.
Inoltre, __non è detto__ che tecniche diverse trovino __gli stessi errori__: l'ispezione potrebbe aver trovato una certa tipologia di errore mentre il testing funzionale un'altra; le diverse tecniche controllano infatti diversamente aspetti differenti del programma, osservandolo da __diversi punti di vista__.

Confrontare le varie tecniche non è dunque necessariamente una perdita di tempo, mentre lo è sicuramente __confrontare solo i numeri__, come la varietà di risultati diversi ottenuti dai parte di studi diversi.
Tra l'altro, dal riassunto della tabella si __perdono__ informazioni sulle __modalità di rilevazione__ dei dati, attribuendole ad espressioni generiche (come _comunemente_, _in media_, _progetti junior_, ...).

In conclusione, non c'è una risposta semplice al confronto e __non esiste una tecnica _sempre_ migliore__ rispetto alle altre.

### Combinare le tecniche

Una domanda che sorge spontanea è chiedersi quindi cosa può succedere se si __combinano insieme__ diverse tecniche di verifica e convalida.

Diversi [studi](https://web.archive.org/web/20070221162909/http://www2.umassd.edu/SWPI/TechnicalReview/r4094.pdf) mostrano che applicando tutte e quattro le tecniche qui descritte &mdash; anche se solo in modo superficiale &mdash; il risultato è sicuramente __più performante__ delle tecniche applicate singolarmente.

{% responsive_image path: assets/13_tabella-tecniche-vc-insieme.png %}

Anche se una certa percentuale di errori può essere rilevata senza alcuna tecnica formale di verifica e convalida, semplicemente usando il software, si può infatti notare ciascuna tecnica presa singolarmente migliora tale percentuale e che la __combinazione__ di tecniche diverse la incrementa ulteriormente.
Questo perché tendenzialmente __ogni tecnica controlla aspetti differenti__ e le rispettive aree di controllo si sovrappongono poco: è dunque conveniente applicare superficialmente ciascuna tecnica piuttosto che una sola tecnica in modo molto approfondito.

In conclusione, come afferma la __Legge di Hetzel-Meyer (L20)__:
> Una combinazione di diversi metodi di V/C supera qualsiasi metodo singolo.

## Gruppi di test autonomi

È convinzione comune che colui che ha sviluppato un pezzo di codice sia la persona meno adatta a testarlo, come afferma la __Legge di Weinberg (L23)__:

> Uno sviluppatore non è adatto a testare il suo codice.

Di conseguenza, si preferisce spesso che il testing sia affidato ad un __gruppo di tester autonomi__.
Questo implica infatti una serie di vantaggi, sia __tecnici__ che e __psicologici__:

- __Aspetti tecnici__:
  - __maggiore specializzazione__: si evita così di richiedere che i propri sviluppatori siano anche esperti di testing;
  - __maggiore conoscenze delle tecniche di verifica e convalida__ e dei relativi tool: chi fa il _tester_ di lavoro acquisisce competenze specifiche sui tool e sugli strumenti di testing (spesso complessi), oltre che sui concetti di copertura e mutazioni.
- __Aspetti psicologici__:
  - __distacco dal codice__: a causa dell'assenza di modelli mentali precedenti su come il software dovrebbe operare, un tester esterno pone maggiore attenzione agli aspetti spesso trascurati o dimenticati;
  - __indipendenza nella valutazione__: una persona che testa il proprio codice è incentivata a _non_ trovare molti errori in quanto potrebbe suggerire un lavoro di dubbia qualità in fase di sviluppo.
  Un gruppo specializzato nel testing è invece incentivato a trovarne il più possibile per giustificare il loro impiego.

Ci sono tuttavia anche una serie di __svantaggi__ legati all'avere un gruppo di tester autonomo.
Innanzitutto, i problemi più ovvi sono legati all'__aspetto tecnico__: il fatto che i tester diventino specializzati nel testing significa che __perderanno__ con il tempo la __capacità di progettare__ e __codificare__, oltre a possedere una __minore conoscenza dei requisiti__ del progetto.

Nell'analisi di Elisabeth Hendrickson denominata "[__Better testing &mdash; worse quality?__](https://web.archive.org/web/20220526084408/http:/testobsessed.com/wp-content/uploads/2011/04/btwq.pdf)" viene analizzata poi la tecnica sotto un __punto di vista psicologico__: come è possibile che un maggior investimento nel team di testing porti a un calo delle prestazioni in termini di numero di errori nel codice?

La risposta pare dipendere dal concetto di ___responsabilità___: seppur vero che l'attività di testing è compito del tester, è anche vero che è lo sviluppatore stesso che ha il compito di fare __test di unità__ del proprio codice &mdash; il team di testing dovrebbe occuparsi solo di quello funzionale o di integrazione.
Spesso però, a fronte di un aumento del personale nel team di testing e specialmente quando una deadline è vicina, il team di sviluppo tende a __spostare la responsabilità__ di trovare gli errori ai tester, __abbassando la qualità del codice__. \\
Il team di testing troverà sì gli errori, riconsegnando il codice agli sviluppatori per correggerli, ma questo passaggio ulteriore implica una notevole __perdita di tempo__ e risorse.

Inoltre, la presenza di un team di testing dedicato può generare __pressioni negative__ sul team di sviluppo: ogni sviluppatore potrebbe sentirsi sotto costante valutazione da parte del team di testing.

### Possibili alternative

Una possibile soluzione alle criticità appena evidenziate consisterebbe nella __rotazione del personale__: una stessa persona potrebbe ricoprire il ruolo di sviluppatore per un progetto e di tester per un altro.
Questo approccio mostra diversi vantaggi, tra cui:

- __evitare pressioni negative__: ricoprendo diversi ruoli in diversi progetti, il personale non si dovrebbe sentire _giudicato_ o _giudicante_;
- __evitare il progressivo depauperamento tecnico__ dovuto ad all'eccessiva specializzazione;
- __evitare lo svuotamento dei ruoli__.

C'è però da considerare un certo __aumento dei costi di formazione__ per via del raddoppio delle responsabilità individuali e un parallelo __aumento della difficoltà di pianificazione__: potrebbe succedere che la stessa persona debba lavorare a più progetti contemporaneamente, dovendo quindi dividere il proprio tempo e le proprie competenze.

Un'altra possibile alternativa consiste nella __condivisione del personale__, che prevede che siano gli stessi sviluppatori a occuparsi del testing: ciò permette di __sopperire__ al problema di __scarsa conoscenza del software__ in esame e del relativo dominio applicativo ma, oltre a far riemergere le __criticità__ individuate precedentemente, aumenta le __difficoltà nella gestione dei ruoli__.

# Modelli statistici di distribuzione degli errori

Negli ultimi tempi si stanno sviluppando una serie di __modelli statistici__ sulla distribuzione degli errori nel codice che dovrebbero teoricamente aiutare l'attività di testing guidandola verso le porzioni di sorgente che _più probabilmente_ potrebbero presentare difetti.

Tali modelli propongono infatti una __correlazione statistica__ tra una serie di __metriche__ quali la lunghezza del codice, il tipo di linguaggio, il grado massimo di indentamento etc. e:

- __la presenza di errori__ per categoria di errore;
- __il numero di errori__ per categoria di errore.

L'idea sarebbe quindi di __predire la distribuzione e il numero di errori__ all'interno di uno specifico modulo del software in esame.

Occorre però __fare attenzione__ alle conclusioni di queste statistiche.
Utilizzare i risultati di tali modelli statistici come indicazioni sul fatto che su determinati moduli vada fatta più attività di testing rispetto ad altri potrebbe inizialmente sembrare la __soluzione più logica__.
Tuttavia, tali risultati non considerano l'attività di testing già effettuata e le correzioni successive e quindi __non cambiano__: codice inizialmente _"scritto male"_ secondo il modello rimarrà per sempre scritto male, anche se testato estensivamente.

Con ciò in mente, si cita spesso la __Legge di Pareto/Zipf (L24)__:
> Circa l'80% dei difetti proviene dal 20% dei moduli.

Sebbene tale affermazione è indubbiamente probabilmente vera, è difficile sfruttare questa nozione in quanto non sono conosciuti in principio i __moduli particolarmente problematici__, e il testing è comunque necessario anche in tutti gli altri.

# Debugging

Il debugging è l'insieme di tecniche che mirano a __localizzare__ e __rimuovere__ le anomalie che sono la causa di malfunzionamenti riscontrati nel programma.
Come già detto, esso non è invece utilizzato per _rilevare_ tali malfunzionamenti.

Il debugging richiede una __comprensione approfondita del codice__ e del funzionamento del programma e può essere un processo complesso e articolato.
Tuttavia, può contribuire in modo significativo a migliorare la qualità e la stabilità del codice, oltre che a _risolvere_ malfunzionamenti.

Trattandosi di ricerca delle anomalie che generano malfunzionamenti noti, l'attività è definita per un __programma__ e __un insieme di dati che causano malfunzionamenti__.
Essa si basa infatti sulla __riproducibilità__ del malfunzionamento, verificando prima che non sia dovuto in realtà a specifiche in errate.

Si tratta di un'attività molto complicata, come fa notare Brian W. Kernighan nella sua famosa citazione:

>"Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it".

È dunque importante scrivere codice __più semplice possibile__ in modo tale da poterne fare un altrettanto semplice debugging laddove necessario.

## Perché è così difficile?

L'attività di debugging è particolarmente complessa soprattutto perché non è sempre possibile individuare con precisione la __relazione anomalia-malfunzionamento__.
Non è un legame banale, in quanto potrebbero esserci anomalie che prima di manifestarsi sotto forma di malfunzionamenti abbiano avuto molte evoluzioni.

Inoltre, __non esiste una relazione biunivoca__ tra anomalie e malfunzionamenti: non è detto che un'anomalia causi un unico  malfunzionamento, ma nemmeno che un malfunzionamento sia causato da un'unica anomalia.

Un altro problema è dovuto al fatto che la __correzione di anomalie__ non garantisce affatto un software migliore o con meno errori: per correggere un'anomalia è necessario per forza di cose anche modificare il codice sorgente, ma ogni volta che viene fatto si apre la possibilità di introdurre __nuove anomalie__ nel codice stesso.

## Tecnica naïve

La tecnica di debugging maggiormente utilizzata dai programmatori consiste nell'introdurre nel modulo in esame una serie di __comandi di output__ (es. _print_) che stampino su console il valore intermedio assunto dalle sue variabili.
Questo permetterebbe di osservare l'evoluzione dei dati e, si spera, di comprendere la causa del malfunzionamento a partire da tale storia.

Nonostante sia __facile da applicare__, si tratta in realtà di una tecnica __molto debole__: non solo essa __richiede la modifica del codice__ (e quindi una _rimozione_ di tali modifiche al termine), ma è __poco flessibile__ in quanto richiede una nuova compilazione per ogni stato esaminato. \\
Bisogna inoltre considerare che questa tecnica testa un __programma diverso__ da quello originale che presenta delle _print_ aggiuntive solo _apparentemente_ innocue e senza effetti collaterali.

L'unico scenario (irrealistico) in cui la tecnica potrebbe essere considerata sufficiente
sarebbe nel caso in cui il codice sia progettato talmente bene e il modulo così ben isolato che basterebbe scrivere un'unica _print_ per risalire all'anomalia.

### Tecnica naïve avanzata

Un miglioramento parziale alla tecnica appena descritta si può ottenere sfruttando le __funzionalità del linguaggio__ oppure alcuni tool specifici per il debug, come per esempio:

- `#ifdef` e `gcc -D` per il linguaggio C;
- __librerie di logging__ (con diverso livello), che permettono peraltro di rimuovere i messaggi di log in fase di produzione del codice;
- __asserzioni__, ovvero check interni al codice di specifiche proprietà: possono essere visti anche come _"oracoli" interni_ al codice che permettono di segnalare facilmente stati illegali.

Ciò non toglie che la tecnica sia comunque __naïve__, in quanto si sta ancora modificando il codice in modo che fornisca informazioni aggiuntive.

## Dump di memoria

Una tecnica lievemente più interessante è quella dei __dump di memoria__, che consiste nel produrre un'__immagine esatta__ della __memoria__ del programma dopo un passo di esecuzione: si scrive cioè su un file l'intero contenuto della memoria a livello di linguaggio macchina (_nei sistemi a 32 bit, la dimensione dei dump può arrivare fino a 4GB_).

```txt
Segmentation fault (core dumped)
```

Sebbene questa tecnica non richieda la modifica del codice, essa è spesso __difficile da applicare__ a causa della differenza tra la rappresentazione astratta dello stato (legata alle strutture dati del linguaggio utilizzato) e la rappresentazione a livello di memoria di tale stato.
Viene inoltre prodotta una __enorme mole di dati__ per la maggior parte inutili.

## Debugging simbolico

Il prossimo passo è invece il cosiddetto __debugging simbolico__, un'attività che utilizza __tool__ specifici di debugging per semplificare la ricerca delle anomalie che causano il malfunzionamento in esame.
Tali strumenti permettono di __osservare in tempo reale l'esecuzione del programma__, sollevando una cortina e rendendo possibile analizzare l'evoluzione del valore delle variabili passo per passo: questi tool non alterano il codice ma _come_ esso è eseguito.

A tal proposito, i debugger simbolici forniscono informazioni sullo stato delle variabili utilizzando lo __stesso livello di astrazione__ del linguaggio utilizzato per scrivere il codice: gli stati sono cioè rappresentati con __stessi simboli__ per cui le locazioni di memoria sono state definite (_stesse strutture dati_), rendendo quindi utile e semplice l'attività di __ispezione dello stato__.

In aggiunta, i debugger simbolici forniscono __ulteriori strumenti__ che permettono di visualizzare il comportamento del programma in maniera selettiva, come per esempio _watch_ e _spy monitor_.

Per regolare il flusso del programma è poi possibile inserire __breakpoint__ e __watchpoint__ su certe linee di codice che ne arrestino l'esecuzione in uno specifico punto, eventualmente rendendoli dipendenti dal valore di variabili.
Volendo poi riprendere l'esecuzione si può invece scegliere la granularità del successivo passo:

- __singolo__: si procede alla linea successiva;
- __dentro una funzione__: si salta al codice eseguito dalle funzioni richiamate sulla riga corrente;
- __drop/reset del frame__: vengono scartate le variabili nel frame d'esecuzione ritornando ad una situazione precedente.

### Debugging per prova

Molti debugging simbolici permettono non solo di visualizzare gli stati ottenuti, ma anche di  __esaminarli automaticamente__ in modo da verificarne la correttezza.

In particolare, utilizzando __watch condizionali__ è possibile aggiungere __asserzioni a livello di monitor__, verificando così che certe proprietà continuino a valere durante l'intera esecuzione. \\
Così, per esempio, è possibile chiedere al _monitor_ (l'_esecutore_ del programma) di controllare che gli indici di un array siano sempre interni all'intervallo di definizione.

### Altre funzionalità dei debugger

Ma non finisce qui! I debugger moderni sono strumenti veramente molto interessanti, che permettono per esempio anche di:

- __modificare il contenuto di una variabile__ (o zona di memoria) a runtime;
- __modificare il codice__: nonostante non sia sempre possibile, può essere comodo per esempio dopo tante iterazioni di un ciclo;
- ottenere __rappresentazioni grafiche__ dei dati: strutture dinamiche come puntatori, alberi e grafi possono essere rappresentate graficamente per migliorare la comprensione dello stato.

## Automazione

Visti tutti questi fantastici tool può sorgere una domanda: __l'attività di debugging può essere automatizzata?__

Andreas Zeller tratta questo argomento in maniera approfondita nel suo [Debugging Book](http://debuggingbook.org/), proponendo alcune direzioni di sviluppo di ipotetici strumenti di debugging automatico. \\
I due concetti principali della trattazione sono i seguenti:

- __shrinking input__: dato un __input molto grande__ e complesso che causa un malfunzionamento, strumenti automatici possono aiutare a ridurlo il più possibile in modo da semplificare il debugging;
- __differential debugging__: dato lo stesso input, in maniera automatica vengono esplorati gli stati del programma mutando ad ogni iterazione piccole porzioni di codice per individuare dove è più probabile che si trovi l'anomalia.

Purtroppo per il momento la prospettiva di debugger automatici è ancora lontana. \\
Tuttavia, esiste già qualcosa di simile, vale a dire il comando __`git bisect`__ di Git: data una versione vecchia in cui il bug non è presente, una versione nuova in cui esso si è manifestato e un oracolo che stabilisce se il bug è presente o meno, Git esegue una __ricerca dicotomica__ per trovare la versione che ha introdotto il problema.
Sebbene non sia proprio la stessa cosa, si tratta sicuramente di uno strumento utile.
