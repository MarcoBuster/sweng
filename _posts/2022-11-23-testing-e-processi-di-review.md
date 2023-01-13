---
layout: post
title: "[13] Testing e Processi di review"
date: 2022-11-23 14:40:00 +0200
toc: true
---

# Testing

La maggior parte dei problemi che si verificano durante lo sviluppo di un progetto sono causati da _problemi di comunicazione_. 
Ci possono essere incomprensioni quando le informazioni passano da una figura all'altra, come quando ci si interfaccia tra cliente, analista e programmatore.
Il programmatore dovrà adattare il proprio linguaggio per farsi comprendere dal cliente prestando maggiore attenzione alla formalità e alla chiarezza della comunicazione con il passare del tempo.
Più i concetti sono spiegati chiaramente, più è difficile incorrere in problemi successivi: è quindi necessario fare attenzione alla __terminologia__ utilizzata.

Quando un programma si definisce ___corretto___?

Considerando un generico programma $$P$$ come una funzione da un insieme di dati $$D$$ (dominio) a un insieme di dati $$R$$ (codominio) allora
- $$P(d)$$ indica l'__esecuzione__ di $$P$$ su un dato in ingresso $$d \in D$$,
- il risultato $$P(d)$$ è __corretto__ se soddisfa le specifiche, altrimenti è scorretto,
- $$\operatorname{ok}(P, \, d)$$ indica la __correttezza__ di $$P$$ per il dato $$d$$

quindi

$$
\boxed{P \text{ è } \textit{corretto} \Longleftrightarrow \forall d \in D \: | \operatorname{ok}(P, \, d)}.
$$

In conclusione, _un programma **è corretto** quando **per ogni dato** del dominio vale $$\operatorname{ok}(P, \, d)$$_.

La correttezza del programma è indicata con $$\operatorname{ok}(P, \, D) = P \text{ è } \textit{corretto}$$.


## Definizioni

_Un **test** è un sottoinsieme del dominio dei dati_ e _un singolo **caso di test** è un elemento di esso_. \\
Un test sono quindi __più stimolazioni__, mentre un caso di test è una __singola stimolazione__.

Matematicamente:
* un test $$T$$ per un programma $$P$$ è un sottoinsieme del suo dominio $$D$$;
* un elemento $$t$$ di un test $$T$$ è detto _caso di test_;
* l'esecuzione di un test consiste nell'esecuzione del programma $$\forall t \in T \subseteq D$$.

Un programma $$P$$ supera (o _passa_) un test $$T$$ se:

$$
\operatorname{ok}(P, \, T) \Longleftrightarrow \forall t \in T \: |  \operatorname{ok}(P, \, t).
$$

Quindi, _un programma è **corretto per un test** quando **per ogni caso di test** è **corretto**_.

_Un test $$\, T$$ ha **successo** se rileva uno o più malfunzionamenti presenti nel programma $$P$$_:

$$
\operatorname{successo}(T, \, P) \Longleftrightarrow \exists t \in T \: | \: \lnot \operatorname{ok}(P, \, t) .
$$

### Test ideale

Se un test non rileva alcun malfunzionamento __non significa che il programma sia corretto__: il test è un'attività ottimistica e non ga
Nel caso in cui il test non rilevi alcun malfunzionamento, non vuol dire che il mio programma sia corretto: come visto nella lezione precedente, il test è un'attività ottimistica.

_Un test $$T$$ è **ideale** per $$P$$ se e solo se_

$$\operatorname{ok}(P, \, T) \Rightarrow \operatorname{ok}(P, \, D)$$

_ovvero se il superamento del test **implica la correttezza del programma**_.

In generale, è **_impossibile_ trovare un test ideale**.

> __Tesi di Dijkstra__:
>
> _Il test di un programma può rilevare la presenza di malfunzionamenti ma non dimostrarne l'assenza._
>
> _Non esiste quindi un algoritmo che dato un programma arbitrario $$P$$ generi un test ideale finito \\
> (il caso $$T = D$$ non va considerato)._

Perché è impossibile trovare un test ideale esaustivo? 
Vediamo il seguente esempio:
```java
static int sum(int a, int b) {
    return a + b;
}
```

In Java un int è espresso su 32 bit, quindi il dominio ha di cardinalità $$2^{32} \cdot 2^{32} = 2^{64} \sim 2 \cdot 10^{19}$$.
Considerando un tempo di 1 nanosecondo per ogni caso di test, il tempo totale è più di 600 anni.

_Il **test esaustivo** è quindi **impraticabile**._

## Criteri di selezione

Come è possibile scegliere un _sottoinsieme del dominio_ approssimando il _test ideale_? \\
Quali caratteristiche dovrebbe avere il __criterio__ scelto per selezionare tale sottoinsieme?

### Proprietà

#### Affidabilità
_Un criterio di selezione si dice **affidabile** se presi due test $$T_1$$ e $$T_2$$ in base a un criterio $$C$$ allora \\
o entrambi hanno successo o nessuno dei due ha successo_.

$$
\boxed{
    \operatorname{affidabile}(C, \, P) \Longleftrightarrow \left [
        \forall T_1 \in C, \, \forall T_2 \in C \: | \operatorname{successo}(T_1, \, P) \Leftrightarrow \operatorname{successo}(T_2, \, P) 
    \right ]
}
$$


#### Validità
_Un criterio di selezione si dice **valido**_ _se qualora $$P$$ non sia corretto, allora esiste almeno un test $$T$$ selezionato in base al criterio $$C$$ che ha successo e quindi rileva uno o più malfunzionamenti per il programma $$P$$:_

$$
\boxed{
    \operatorname{valido}(C, \, P) \Longleftrightarrow \left [ 
        \lnot \operatorname{ok}(P, \, D) \Rightarrow \exists T \in C \: | \operatorname{successo}(T,\,P) 
    \right ]
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
Un criterio che seleziona

* _"i sottoinsiemi di $$\{0, \, 2\}$$”_ è **affidabile**, perché il programma funziona sia con $$0$$ sia con $$2$$, ma **non valido**, perché sappiamo che il programma non è corretto e non viene trovato nessun malfunzionamento;
* _"i sottoinsiemi di $$\{0, \, 1, \, 2, \, 3, \, 4\}$$”_ è **non affidabile**, perché i risultati dei casi di test non sono tutti coerenti, ma **valido** perché rileva i malfunzionamenti.
* _"i sottoinsieme finiti di $$D$$ con almeno un valore maggiore di $$18$$”_ è **affidabile**, perché i risultati dei casi di test sono tutti coerenti, e **valido** perché rileva i malfunzionamenti.

#### Conclusione

L'obiettivo è scegliere un _criterio valido e affidabile_ ma ciò non è possibile, in quanto **non si conoscono i malfunzionamenti a priori** (in tal caso il test non avrebbe senso di esistere). 

Ma se il test __non ha successo__, è utile avere un _criterio valido e affidabile_?
Sapendo che:
- non avendo successo allora non sono stati trovati errori,
- essendo il criterio affidabile allora tutti gli altri test trovati per quel criterio non troveranno errori,
- essendo il criterio valido allora se ci fosse stato un errore almeno uno dei test lo avrebbe trovato

allora un programma è __corretto__ anche quando:

$$
\boxed{
    \operatorname{affidabile}(C, \, P) \land \operatorname{valido}(C, \, P) \land T \in C \land \lnot\operatorname{successo}(T, \, P)
    \Longrightarrow
    \operatorname{ok}(P, \, D)
}
$$

Trovare un criterio che sia __contemporaneamente__ affidabile e valido significherebbe trovare un criterio che selezioni __test ideali__ che sappiamo non esistere per la _tesi di Dijkstra_.

### Utilità di un test

Quali sono le __caratteristiche__ che __rendono utile__ un caso di test, ovvero che rendono "possibile" o "probabile" che il caso di test trovi l'errore?
Di seguito sono elencati alcuni esempi:
- __eseguire il comando che contiene l'anomalia__ – non è altrimenti possibile che il malfunzionamento si manifesti;
- l'esecuzione del comando che contiene l'anomalia deve portare il sistema in uno \\
__stato inconsistente__;
- lo stato inconsistente dell'output deve propagarsi fino all'uscita del codice in esame in modo da __produrre un output diverso da quello atteso__;

È possibile utilizzare un metro di misura legato alle caratteristiche del codice: a ogni criterio è possibile associare una **metrica** che misuri la **copertura del codice** rispetto a uno specifico test (ovvero la percentuale di codice "utilizzata" in tutto il test) e che ci permetta di decidere quando smettere di testare, decidere quali altri casi di test è opportuno aggiungere o confrontare la bontà di test diversi.

### Criteri noti

#### Criterio di copertura dei comandi

_Un test $$\ T$$ soddisfa il __criterio di copertura dei comandi__ se e solo se ogni comando eseguibile del programma è eseguito in corrispondenza di almeno un caso di test $$t \in T$$._

Consideriamo il seguente programma in pseudocodice.

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

Applicare il _criterio di copertura dei comandi_ significa quindi trovare un insieme di casi di test in cui \\
_per ogni nodo esiste un caso di test che passa per quel nodo_.

Il caso di test $$ \langle 3, \, 7 \rangle$$ risulterebbe quindi sufficiente, dato che soddisfa il criterio di copertura dei comandi.

Soddisfare tale criterio **non garantisce** la correttezza del programma. \\
Nell'esempio considerato, il caso di test $$\langle 0, \, 7 \rangle$$ provoca una divisione per zero.

#### Criterio di copertura delle decisioni

_Un test $$\ T$$ soddisfa il **criterio di copertura delle decisioni** se e solo se ogni decisione (effettiva) viene resa sia vera che falsa in corrispondenza di almeno un caso di test $$t \in T$$_.

La metrica è la percentuale delle **decisioni totali possibili** presenti nel codice che sono state rese \\
**sia vere che false** nel test.

Il criterio di copertura delle decisioni **implica il criterio di copertura dei comandi**.
Estraendo il codice in un diagramma di flusso, è possibile coprire tutte le decisioni se e solo se ogni arco (_e quindi ogni nodo_) viene attraversato.
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
Nonostante sia un criterio _"migliore"_ del precedente, la copertura delle decisioni __non garantisce__ la correttezza del programma: nell'esempio il caso $$\langle 0, \, 5 \rangle$$ eseguirebbe una divisione per zero.

#### Criterio di copertura delle condizioni

_Un test $$\ T$$ soddisfa il __criterio di copertura delle condizioni__ se e solo se ogni singola condizione (effettiva) viene resa sia vera che falsa in corrispondenza di almeno un caso di test t contenuto in T_

Similmente ai criteri precedenti, la metrica è la percentuale delle __condizioni__ che sono state rese __sia vere che false__ su quelle per cui è possibile farlo.

Si noti come questo criterio __non implica__ il soddisfacimento di criteri precedenti.

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
(`x != 0` è falsificato da $$\langle 0, \,5 \rangle$$ e verificato da $$\langle 5, \, -5 \rangle$$, mentre `y>0` è verificato da $$\langle 0, \, 5 \rangle$$ e falsificato da $$\langle 5, \, -5 \rangle$$), ma __la decisione è sempre vera__.

Sono infatti presenti anomalie alla riga 6 (possibile divisione per zero) e alla riga 8 (overflow e divisione per zero), ma i comandi contenuti nella riga 8 non sono coperti.

#### Criterio di copertura delle decisioni e condizioni

_Un test $$\ T$$ soddisfa il **criterio di copertura delle decisioni e delle condizioni** se e solo se **ogni decisione** vale sia vero che falso e **ogni condizione** che compare nelle decisioni del programma vale sia vero che falso per diversi casi di test $$t \in T$$_.

È – intuitivamente – l'**intersezione** del criterio di copertura delle decisioni con il criterio di copertura delle condizioni.

Nell'esempio 3, il test $$\{ \langle 0, \, -5 \rangle, \, \langle 5, \, 5 \rangle \}$$ soddisfa il criterio di copertura delle decisioni e condizioni.

#### Criterio di copertura delle condizioni composte

_Un test $$\ T$$ soddisfa il **criterio di copertura delle condizioni composte** se e solo se ogni possibile composizione delle condizioni base vale sia vero che falso per diversi casi di $$t \in T$$_

Si noti come __questo criterio implichi il precedente__ (criterio di copertura delle decisioni e condizioni).

Data la __natura combinatoria__ di questo criterio, all'aumento del numero di condizioni di base _il numero di casi di test_ cresce troppo rapidamente. 
Inoltre dato che le condizioni di base potrebbero non risultare indipendenti tra loro, potrebbero esistere __combinazioni non fattibili__ inopportune da testare.

#### Criterio di copertura delle condizioni e delle decisioni modificate

Certe combinazioni sono __più rilevanti__ di altre: se modificando una sola combinazione base si riesce a modificare l'esito della decisione, allora è molto significativa – indipendentemente dalla sua dimensione.
Se invece l'esito della decisione non varia, allora la modifica può essere considerata neutra o meno significativa.

Si dà quindi importanza nella selezione delle combinazioni al fatto che la modifica di una singola condizione base porti a __modificare l'esito della decisione__.
Per ogni condizione base devono quindi esistere due casi di test che modificano il valore di una sola condizione base e che portino a un diverso esito della decisione.

Si può dimostrare che se si hanno $$N$$ condizioni base __sono sufficienti $$N+1$$ casi di test__ per il criterio.

#### Implicazioni tra criteri di copertura

{% responsive_image path: 'assets/13_criteri-copertura-implicazione.png' %}

Il criterio delle condizioni composte va considerato troppo oneroso e quindi non applicabile. \\
Gli altri criteri possono essere invece applicati.

### Altri criteri

I criteri visti finora **non considerano i cicli** e possono essere soddisfatti da test che percorrono ogni ciclo al più una volta. 
Molti errori però si verificano durante __iterazioni successive alla prima__, come per esempio quando si superano i limiti di un array.

Occorre quindi criteri che tengano conto anche delle iterazioni.

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

_Un test $$\ T$$ soddisfa il **criterio di copertura dei cammini** se e solo se ogni cammino del grafo di controllo del programma viene percorso per almeno un caso di $$t \in T$$_.

La metrica è il rapporto tra i __cammini percorsi__ e __quelli effettivamente percorribili__.

Questo criterio è molto generale ma è spesso impraticabile, anche per programmi semplici. \\
È quindi considerato **non applicabile**.

#### Criterio di $$n$$-copertura dei cicli

_Un test soddisfa il **criterio di $$n$$-copertura** se e solo se ogni cammino del grafo contenente al massimo un numero d'iterazioni di ogni ciclo non superiore a $$n$$ viene percorso per almeno un caso di test._

La definizione sopra non significa che il test deve eseguire $$n$$ volte un ciclo, ma che per ogni numero $$k$$ compreso tra 0 e $$n$$ deve esistere un caso di test che esegue tale ciclo $$k$$ volte.
Si sta quindi **limitando il numero massimo di percorrenze** dei cicli. \\
Di conseguenza, al crescere di $$n$$ il numero di test aumenta molto rapidamente.
Inoltre, fissare $$n$$ a livello di programma può non essere un'azione così semplice: il numero d'iterazioni che necessita un ciclo per essere testato a fondo può essere __molto differente__ tra cicli diversi.

Per cercare di minimizzare il numero di test, può essere sufficiente coprire solamente le casistiche: 
- zero iterazioni; 
- una iterazione;
- _molte_ iterazioni.

Nell'esempio sopra, il caso $$n = 2$$ è il minimo per considerare casistiche non banali: infatti, con $$n = 1$$ il ciclo (`while`) sarebbe stato indistinguibile da una semplice selezione (`if`); testando due iterazioni si incomincia a testare le caratteristiche del ciclo.

A differenza del criterio di copertura dei cammini, è considerato **applicabile**.

# Analisi statica

L'analisi statica si base sull'esame di un **insieme finito di elementi** (*le istruzioni del programma*) contrariamente all'analisa dinamica che considera un insieme infinito (*gli stati delle esecuzioni*). 
È un'attività **meno costosa del testing**, poiché non soffre del problema della _"esplosione dello spazio degli stati"_. 

Non considerando i valori specifici delle variabili, non ha la capacità di rilevare anomalie dipendenti da particolari valori assunti a runtime.

## Complilatori

I compilatori fanno analisi statica per fornire un eseguibile e per identificare errori sintattici nel codice.

Il lavoro dei compilatori si può dividere solitamente in **quattro fasi**.
I seguenti esempi sono presi dal compilatore di Rust, caratteristico per la quantità e qualità di analisi svolta durante la compilazione.

- **analisi lessicale**: identifica i token appartenenti o non al linguaggio;
  ```
  error: expected one of `!`, `.`, `::`, `;`, `?`, `{`, `}`, or an operator, found `ciao`
  --> src/main.rs:2:9
    |
  2 |     BELLA ciao = "mondo";
    |           ^^^^ expected one of 8 possible tokens
  ```
- **analisi sintattica**: controlla che i token identificati siano in una posizione _sensata_ per la grammatica del linguaggio;
  ```
  error: expected `{`, found keyword `for`
  --> src/main.rs:2:14
    |
  2 |     if !expr for;
    |              ^^^ expected `{`
    |
  ```
* **controllo dei tipi**: nei linguaggi tipizzati, individua regole d'uso e incompatibilità dei tipi di dati;
  ```
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
* **analisi flusso dei dati**: si cercano di rilevare problemi relativi alle evoluzioni dei valori associati alle variabili, come codice non raggiungibile.
  ```
  error: equal expressions as operands to `!=`
  --> src/main.rs:2:8
    |
  2 |     if 1 != 1 {
    |        ^^^^^^
    |
  ```

## Analisi Data Flow

I primi utilizzi sono stati fatti nel campo dell'**ottimizzazione dei compilatori**: quest'ultimi sono per esempio _"contenti"_ di non compilare codice non raggiungibile.
L'ingegneria del software deve occuparsi di trovare e prevenire le cause di questi errori.

Il flusso dei dati sarebbe una analisi prettamente  dinamica, ma il sottoinsieme dei controlli statici è significativo.

È possibile identificare staticamente il tipo di ogni operazione eseguita su una variabile e il loro **insieme dei legami di compatibilità**.

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

Nel caso dei **dati**, definiamo tre semplici operazioni:
* $$\op{d}$$ (**definizione**): il comando assegna un valore alla variabile;
anche assegnare un parametro a una funzione che lo modifica è considerata un'operazione di (ri)definizione;
* $$\op{u}$$ (**uso**): il comando legge il contenuto di una variabile, come l'espressione sul lato destro di un assegnamento; 
* $$\op{a}$$ (**annullamento**): al termine dell'esecuzione del comando il valore della variabile non è significativo/affidabile.
Per esempio, alla _prima dichiarazione_ di una variabile e al termine del suo scope il suo valore è da considerarsi inaffidabile.

È possibile ridurre una qualsiasi sequenza d'istruzioni a una sequenza di $$\op{d}$$efinizioni, $$\op{u}$$si e \\
$$\op{a}$$nnullamenti (operazioni).

### Regole

È possibile individuare la presenza di anomalie definendo alcune **regole di flusso** che devono essere rispettate in un programma corretto.

<ol>

<li markdown="1">
  L'**uso di una variabile** deve essere **sempre preceduto** in ogni sequenza **da una definizione** \\
  **senza annullamenti intermedi**.

  $$
  \a\u\err
  $$

</li>
<li markdown="1">
  La **definizione di una variabile** deve essere **sempre seguita** da **un uso**, **prima** di un suo **annullamento** o **definizione**. 

  $$
  \d\a\err \\
  \d\d\err
  $$

</li>
  <li markdown="1">
  L'**annullamento di una variabile** deve essere **sempre seguito** da **una definizione**, **prima** di un **uso** o di un **altro annullamento**
  
  $$
  \a\a\err
  $$

</li>
</ol>

Riassumendo, $$\a\op{u}$$, $$\d\op{a}$$, $$\d\op{d}$$ e $$\a\op{a}$$ sono sequenze che identificano **situazioni anomale**.

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

Consideriamo il seguente programma in C. 

```c
void swap(int &x1, int &x2) {
    int x1;
    x3 = x1;
    x3 = x2;
    x2 = x1;
}
```
Le sequenze per ogni variabile sono le seguenti.

| Variabile | Sequenza | Anomalie |
|-|-|-|
| `x1` | $$\aR\uR\u\a$$ | `x1` viene usata 2 volte senza essere stata prima definita |
| `x2` | $$\dots \d\u\op{d} \dots$$ | Nessuna |
| `x3` | $$\dots \d\dR\opR{d} \dots$$ | `x3` viene definita più volte senza nel frattempo essere stata usata |

### Sequenze

Consideriamo il seguente programma C.

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

Definiamo $$\operatorname{P}(p, \, \texttt{a})$$ come la **sequenza** ottenuta per la variabile $$\texttt a$$ eseguendo il cammino $$p.$$

Per esempio, considerando il codice sopra. 

$$
\begin{align*}
&\operatorname{P}([1, 2, 3, 4, 5, 6, 7, 8, 9, 7, 12, 13], \, \texttt{a}) \\
&= \A{2} \D{5} \U{7} \U{8} \U{9} \D{9} \U{7} \U{12} \A{13}
\end{align*}
$$

Eseguendo questo tipo di operazione su tutte le variabili si potrebbero verificare le eventuali anomalie, ma \\
__i cammini sono potenzialmente infiniti__: per scoprirli dovremmo eseguire il programma e quindi uscire dal campo dell'analisi statica.

#### Espressioni regolari

In caso di cammini contenenti __cicli__ e __decisioni__ è possibile rappresentare $$P$$ utilizzando __espressioni regolari__. 
Con $$\operatorname{P}([1 \rightarrow], \, \mathtt{a})$$ si indicano tutti i cammini che partono dall'istruzione $$1$$ per la variabile $$\mathtt{a}$$.

Dal codice precedente, è possibile definire $$\operatorname{P}([1 \rightarrow], \, \mathtt{a})$$ come:

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

Osserviamo come $$\OpW{u}{7}$$ si ripeta due volte: questo può rendere _fastidioso_ ricercare errori, per via della difficoltà a considerare cammini multipli.

È comunque facilmente verificabile l'**assenza di errori** nell'espressione regolare sopra.

<!-- non ho capito le motivazioni -->
L'espressione regolare rappresenta **tutti i cammini** del programma, ma non **_tutti e i soli_**:
- DA FARE: motivazione A **(DO NOT MERGE)**
- DA FARE: motivazione B **(DO NOT MERGE)**

È impossibile scrivere un algoritmo che dato un qualsiasi programma riesca a generare un'espressione regolare che rappresenti **tutti e i soli** cammini, senza osservare i valori delle variabili. \\
Il modello generato è quindi un'__astrazione pessimistica__.

L'espressione reoglare sopra __non è l'unico modo possibile__ per rappresentare il programma. \\
Si può anzi argomentare che l'espressione regolare

$$
\Big ( \, \u \Big | \: \d \Big | \: \a \Big)*
$$

possa rappresentare qualsiasi programma.

## Analisi statica e Testing

Ma cosa c'entra l'**analisi statica** con il **testing**?

Dall'analisi statica è possibile arrivare per esempio alle seguenti osservazioni:
- purché si presenti un malfunzionamento dovuto a una anomalia in una _definizione_, deve essere _usato_ il valore che è stato assegnato;
- un ciclo dovrebbe essere ripetuto (di nuovo) se verrà _usato_ un valore _definito_ alla iterazione precedente.

L'analisi statica può quindi aiutare a **selezionare i casi di test** basandosi sulle _sequenze definizione-uso_ delle variabili.

### Terminologia

Dato un comando $$i$$, si definisce $$\operatorname{def}(i)$$ come l'**insieme delle variabili** definite in $$i$$.

Data una variabile $$x$$ e un comando $$i$$, si definisce $$\operatorname{du}(x, \, i)$$ come l'**insieme dei nodi** $$j$$ tali che:
- $$x \in \operatorname{def}(i)$$: \\
la variabile $$x$$ è **definita** in $$i$$;
- $$x$$ è **usata** in $$j$$;
- **esiste un cammino** da $$i$$ a $$j$$, **libero da definizioni** di $$x$$: \\
è necessario controllare che $$x$$ non sia stata sovrascritta nei nodi intermedi.

### Criteri di copertura

#### Criterio di copertura delle definizioni

_Un test $$\ T$$ soddisfa il **criterio di copertura delle definizioni** se e solo se per ogni nodo $$i$$ e ogni variabile $$x \in \operatorname{def}(i)$$, $$T$$ include un caso di test che esegue un cammino libero da definizioni da $$i$$ ad almeno uno degli elementi di $$\operatorname{du}(i, x).$$_

Più formalmente:

$$
\begin{align*}
T \in C \Longleftrightarrow& \forall i \in P, \  \forall x \in \operatorname{def}(i), \ \exists j \in \operatorname{du}(i, \, x) \\
&| \: \exists t \in T \ \text{che esegue un cammino da $i$ a $j$ senza ulteriori definizioni di $x$}.
\end{align*}
$$

Riconsideriamo l'__esempio__ già visto in precendenza, considerando la variabile $$\texttt{a}$$.

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

Partiamo definendo gli insiemi dei nodi degli usi $$\operatorname{du}(i, \, \mathtt a)$$. 
1. $$\operatorname{du}(5, \, \mathtt a)$$ = $$\{7, \, 8, \, 9, \, 11, \, 12\}$$;
2. $$\operatorname{du}(9, \, \mathtt a)$$ = $$\{7, \, 8, \, 9, \, 11, \, 12\}$$.

È solo **un caso** il fatto che in questo esempio siano uguali.

L'obiettivo è _per ognuna delle due definizioni_ ottenere un __uso__ di tale definizione.

1. Per la prima definizione la soluzione è banale, a riga 7 la variabile $$\mathtt a$$ viene letta:
$$\D{5}\U{7}$$.
2. Per la seconda, invece, è necessario scegliere un valore tale per cui il flusso di esecuzione entri almeno una volta nel ciclo: 
$$\D{9}\U{7}$$.

Un test che soddisfa totalmente il criterio può essere il seguente:

$$
T = \{ \langle 8, \, 4 \rangle \}.
$$

Il criterio di copertura delle definizioni non copre tutti i comandi e di conseguenza **non implica il criterio di copertura dei comandi**.

#### Criterio di copertura degli usi

_Un test $$\ T$$ soddisfa il **criterio di copertura degli usi** se e solo se per ogni nodo $$i$$ e ogni variabile $$x$$, appartenente a $$\operatorname{def}(i)$$, $$T$$ include un caso di test che esegue un cammino libero da definizioni da $$i$$ ad \\
**ogni elemento** di $$\operatorname{du}(i, \, x).$$_

Più formalmente:

$$
\begin{align*}
T \in C \Longleftrightarrow& \forall i \in P, \  \forall x \in \operatorname{def}(i), \ \forall j \in \operatorname{du}(i, \, x) \\
&| \: \exists t \in T \ \text{che esegue un cammino da $i$ a $j$ senza ulteriori definizioni di $x$}.
\end{align*}
$$

Per ogni definizione di una variabile, **tutti i suoi possibili usi** devono essere coperti.

Il criterio di copertura degli usi **non implica** il criterio di copertura dei comandi, perché nel caso in cui non esistano $$j \in \operatorname{du}(i, \, x)$$, l'uso del $$\forall$$ è più _"permissivo"_ del $$\exists$$ del criterio precedente.
Vien da sé che questo criterio non copre anche il criterio di copertura dei comandi.

Come **esempio**, riconsideriamo il programma in C visto in precedenza.

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

Riconsideriamo la variabile $$\mathtt a$$ e i relativi insieme dei nodi degli usi.

1. $$\operatorname{du}(5, \, \mathtt a)$$ = $$\{7, \, 8, \, 9, \, 11, \, 12\}$$;
2. $$\operatorname{du}(9, \, \mathtt a)$$ = $$\{7, \, 8, \, 9, \, 11, \, 12\}$$.

Per ogni definizione occorre coprire __tutti gli usi__.

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

Uno spunto di discussione proposto dal professore è se è meglio __minimizzare__ i __casi di test__ o le __iterazioni per caso__.
Opinione diffusa è preferire **minimizzare le iterazioni** in modo da poter rilevare con più precisione gli errori, riducendo il numero di istruzioni.
In alcune situazioni però aumentare il numero di iterazioni può diminuire il tempo di esecuzione totale dei test.

#### Criterio di copertura dei cammini DU

Esistono diversi cammini che soddisfano il criterio precedente.
Questo criterio richiede che siano selezionati _tutti_.

$$
\begin{align*}
T \in C \Longleftrightarrow& \forall i \in P, \  \forall x \in \operatorname{def}(i), \ \forall j \in \operatorname{du}(i, \, x), \\
&\forall \text{cammino da $i$ a $j$ senza ulteriori definizioni di $x$} \\
&| \: \exists t \in T \ \text{che lo esegue}.
\end{align*}
$$

Questo criterio può essere **utile da ipotizzare**, ma è considerato **impraticabile** (_"sopra la barra rossa"_).

#### Beebugging

Il problema è che può capitare che non si trovino errori, ciò può dipendere dal fatto che il programma è corretto oppure dal fatto che chi sta testando non lo sta facendo nella maniera corretta.
Per risolvere questo problema si può usare il beebugging, che consiste nel inserire deliberatamente $$n$$ errori dentro il codice prima di mandare il programma a chi lo deve testare. 
Questo è un incentivo per il team di testing, perché sa che ci sono degli errori e deve solo trovarli. La metrica che viene utilizzata è la percentuale di errori trovati.

_Quello che si cerca di fare è di trovare tutti gli errori inseriti per cercare nel frattempo di trovarne di nuovi._ 

#### Analisi mutazionale

Partendo da un programma e un test vengono aggiunti degli errori al programma per verificare se il test li trova.
Vengono generate delle mutazioni, 
per esempio, 
viene generato un insieme di programmi $$II$$ _simili_ al programma $$P$$ in esame e su di essi viene eseguito lo stesso test $$T$$ previsto per il programma $$P$$.

Cosa ci si aspetta?
* se $$P$$ è corretto allora i programmi in $$II$$ devono essere sbagliati
* per almeno un caso di test devono quindi produrre un risultato diverso

_Un test $$T$$ soddisfa il criterio di copertura dei mutanti se e solo se per ogni mutante $$π \in II$$ esiste almeno un caso di test in $$T$$ la cui esecuzione produca per $$π$$ un risultato diverso da quello prodotto da $$P$$._

La metrica è la frazione di mutanti riconosciuta come diversa da $$P$$ sul totale di mutanti generati.

Quello che deve essere fatto è l'analisi delle classi e la generazioni dei mutanti, successivamente la selezione dei casi di test e infine l'esecuzione.

Nel caso ideale si vorrebbero avere dei mutanti simili al programma di partenza, con delle differenze minime, cioè, praticamente identici dappertutto tranne dove sono stati aggiunti gli errori.
I mutanti sono virtualmente infiniti, ma facili da automatizzare.

Gli **operatori mutanti** sono delle funzioni che, dato $$P$$, generano uno o più mutanti. I più semplici effettuano modifiche sintattiche che comportino modifiche semantiche, ma non errori sintattici bloccati in compilazione.

Nella variante **HOM** _(Hing Order Mutation)_ può venire fatta più di una modifica e a volte sono più difficili da identificare le modifiche prese singolarmente.

Tra le **classi di operatori** si distinguono rispetto all'oggetto su cui operano:

* _costanti_, _variabili_, es. scambiando l'occorrenza di una con l'altra
* _operatori_ ed _espressioni_, es. `<` in `<=`, oppure `true` in `false`
* _comandi_, es. un `while` in `if`

Vediamo con uno schema come ci si può comportare per capire quali sono i problemi:
{% responsive_image path: 'assets/13_analisi-mutazionale-schema.png' %}

Il problema di questo approccio è che non garantisce la terminazione, ovvero non c'è un modo sicuro per stabilire quando il processo di analisi è completato. Ciò è dovuto a diversi fattori:
- Quando si estrae un valore casuale, c'è sempre il rischio di estrarre sempre lo stesso valore.
- Si potrebbe essere particolarmente sfortunati e non trovare il valore corretto.
- Esistono infinite varianti di programmi che svolgono la stessa funzione, anche se non sono sintatticamente identici. Di conseguenza, una modifica sintattica potrebbe non avere alcun effetto sul funzionamento del programma.

Per verificare se il test è valido, è necessario controllare il numero di mutanti generati. Se questo numero è elevato, il test non è affidabile. In alternativa, è possibile "nascondere" i mutanti, a patto che non sia richiesta una copertura totale. In questo modo, è possibile analizzare programmi che sono funzionalmente uguali ma sintatticamente diversi, al fine di dimostrare l'equivalenza o scoprire casi in cui essa non è valida.

#### Analis mutazionale in un linguaggio OO

In un linguaggio OOP, l'analisi mutazionale viene spesso utilizzata per verificare la robustezza e la qualità delle classi e degli oggetti definiti nel codice sorgente. Ad esempio, si potrebbero apportare modifiche alle proprietà o ai metodi di una classe e verificare come queste modifiche influiscono sugli oggetti creati a partire da questa classe. Oppure, si potrebbe modificare il comportamento di un oggetto in modo da verificare se questo influisce sulla correttezza del programma nel suo insieme.

Inoltre, l'analisi mutazionale può essere utilizzata per verificare la robustezza delle relazioni di ereditarietà e polimorfismo all'interno di un programma OOP. Ad esempio, si potrebbero apportare modifiche alle proprietà o ai metodi di una superclasse e verificare come queste modifiche influiscono sulla correttezza delle sottoclassi che ne ereditano le proprietà e i metodi. Oppure, si potrebbe modificare il comportamento di un oggetto polimorfo in modo da verificare se questo influisce sulla correttezza del programma nel suo insieme.

### OO testing e ereditarietà

Il testing di oggetti (OO testing) è un tipo di testing specifico per i programmi scritti utilizzando i principi della programmazione a oggetti (OOP). Si concentra sulla verifica della correttezza del comportamento degli oggetti e delle loro interazioni all'interno del programma.

Per eseguire il testing di oggetti, è spesso necessario creare dei casi di test che simulino determinate situazioni e interazioni tra gli oggetti. Ad esempio, si potrebbero creare casi di test che verifichino il comportamento di un oggetto quando viene invocato uno dei suoi metodi, o che verifichino la correttezza delle relazioni di ereditarietà tra le diverse classi del programma.

L'ereditarietà è un concetto chiave della programmazione a oggetti, che permette di creare una gerarchia di classi e di ereditare proprietà e metodi da una classe base (chiamata superclasse) a una classe derivata (chiamata sottoclasse). In questo modo, è possibile definire un comportamento comune per un gruppo di classi e personalizzarlo per ogni classe specifica.

Durante il testing di oggetti, è importante verificare la correttezza delle relazioni di ereditarietà all'interno del programma. Ad esempio, si potrebbero creare casi di test che verifichino se gli oggetti di una sottoclasse ereditano correttamente le proprietà e i metodi della superclasse, o che verifichino se il comportamento della sottoclasse è coerente con quello della superclasse. Inoltre, è importante verificare che le modifiche apportate alla superclasse non abbiano effetti indesiderati sulle sottoclassi.

### OO testing e collegamento dinamico

Il collegamento dinamico è un concetto legato alla programmazione a oggetti che si riferisce alla capacità di un programma di decidere quali metodi o proprietà utilizzare in base al tipo di oggetto con cui si lavora.

In un linguaggio OOP, il collegamento dinamico viene solitamente implementato attraverso il polimorfismo, cioè la capacità di un oggetto di assumere diverse forme e di essere trattato come un'istanza di diverse classi a seconda del contesto. Ad esempio, se un oggetto è un'istanza di una sottoclasse di una determinata superclasse, può essere trattato come un'istanza della superclasse o della sottoclasse a seconda del contesto.

Durante il testing di oggetti, è importante verificare che il collegamento dinamico funzioni correttamente. Ad esempio, si potrebbero creare casi di test che verifichino se un oggetto polimorfo viene trattato come un'istanza della superclasse o della sottoclasse corretta a seconda del contesto, o che verifichino se gli oggetti di diverse classi possono essere utilizzati in modo intercambiabile in determinate situazioni. Inoltre, è importante verificare che le modifiche apportate a una classe non abbiano effetti indesiderati sugli oggetti di altre classi che ne ereditano le proprietà o i metodi.

### Class testing

Il testing di oggetti è una tecnica utilizzata per verificare la correttezza del comportamento degli oggetti e delle loro interazioni all'interno di un programma scritto utilizzando i principi della programmazione a oggetti (OOP).

Una delle strategie utilizzate in questo tipo di testing è la costruzione di classi stub e driver. Una classe stub è una classe fittizia che viene utilizzata per sostituire una classe reale in un determinato contesto di test. Ad esempio, si potrebbe utilizzare una classe stub per sostituire una classe che dipende da una risorsa esterna, come un database o un servizio web, in modo da poter eseguire il test in modo indipendente dal contesto esterno.

Una volta costruita la classe stub, è importante implementare eventuali metodi astratti (cioè metodi che devono essere definiti dalle sottoclassi ma non hanno un comportamento predefinito nella superclasse). In questo modo, sarà possibile utilizzare la classe stub per eseguire il test senza che sorga un'eccezione per la mancanza di implementazione dei metodi astratti.

Inoltre, può essere utile aggiungere una funzione che permetta di estrarre e esaminare lo stato dell'oggetto, al fine di bypassare l'incapsulamento (cioè la protezione delle proprietà e dei metodi di un oggetto da accessi esterni non autorizzati). Questa funzione può essere utilizzata per verificare che l'oggetto si comporti in modo coerente durante il test.

Infine, si può creare una classe driver che permetta di istanziare oggetti e di chiamare i loro metodi secondo il criterio di copertura scelto (ad esempio, per verificare che tutti i metodi vengano eseguiti almeno una volta durante il test). In questo modo, sarà possibile eseguire il test in modo automatizzato e riprodurre facilmente i risultati.

### Copertura della classe

La copertura della classe è un concetto legato al testing di oggetti che si riferisce alla quantità di codice di una classe che viene eseguita durante un test. Più in generale, la copertura di un programma indica quante parti del codice vengono eseguite durante i test.

Per determinare la copertura di una classe, è importante considerare lo stato dell'oggetto. Lo stato dell'oggetto è l'insieme delle proprietà e dei valori che assumono in un determinato momento. A seconda dello stato dell'oggetto, alcuni metodi potrebbero essere eseguiti o meno, o potrebbero avere comportamenti differenti.

Una volta definito lo stato dell'oggetto, è possibile definire in modo "statico" cosa è lo stato dell'oggetto. Ad esempio, si potrebbero considerare come stati dell'oggetto i valori di alcune proprietà, o il risultato di alcuni metodi. In questo modo, sarà possibile determinare quali casi di test sono necessari per coprire tutti gli stati dell'oggetto.

In alcuni casi, potrebbe esistere una rappresentazione dello stato dell'oggetto come una macchina a stati, che descrive gli stati possibili dell'oggetto e le transizioni tra questi stati. In questo modo, sarà possibile determinare quali casi di test sono necessari per coprire tutte le transizioni possibili.

In generale, il testing di oggetti mira a coprire il maggior numero possibile di stati dell'oggetto e di transizioni tra questi stati, al fine di garantire la correttezza del comportamento dell'oggetto e delle sue interazioni all'interno del programma. Tuttavia, è importante notare che la copertura completa potrebbe non essere sempre possibile o auspicabile, a causa della complessità del programma o dei costi associati al testing. Di conseguenza, è importante valutare attentamente quali casi di test sono necessari per garantire una copertura adeguata della classe senza essere troppo onerosi da un punto di vista del tempo o dei costi.

Inoltre, è importante tenere presente che la copertura della classe non è l'unico criterio per valutare la qualità del testing. Ad esempio, è importante anche verificare che i casi di test siano indipendenti l'uno dall'altro e che il codice sia testato in modo adeguato anche in situazioni di errore o di eccezione. Inoltre, è importante considerare anche altre metriche, come la qualità del codice o la robustezza del programma, per valutare la qualità del testing nel suo insieme.

### Criteri di copertura

I criteri di copertura sono delle strategie utilizzate per determinare quali parti di un programma devono essere testate. In particolare, i criteri di copertura possono essere utilizzati per definire quali casi di test sono necessari per coprire il maggior numero possibile di stati dell'oggetto e di transizioni tra questi stati.
{% responsive_image path: 'assets/13_criteri-copertura-grafo.png' %}

In riferimento a un diagramma, i criteri di copertura possono includere:

- Coprire tutti i nodi: questo criterio prevede di creare un caso di test per ogni nodo del diagramma, al fine di verificare che tutte le parti del codice siano eseguite almeno una volta;
- Coprire tutti gli archi: questo criterio prevede di creare un caso di test per ogni arco del diagramma, al fine di verificare che tutte le transizioni tra gli stati dell'oggetto siano eseguite almeno una volta;
- Coprire tutte le coppie di archi in/out: questo criterio prevede di creare un caso di test per ogni coppia di archi in/out (cioè per ogni arco che entra in un nodo e per ogni arco che esce da un nodo). In questo modo, si potranno verificare tutte le possibili combinazioni di transizioni tra gli stati dell'oggetto;
- Coprire tutti i cammini identificabili nel grafo: questo criterio prevede di creare un caso di test per ogni cammino identificabile nel grafo, cioè per ogni sequenza di archi che porta da un nodo ad un altro. In questo modo, si potranno verificare tutte le possibili combinazioni di transizioni tra gli stati dell'oggetto.

In generale, i criteri di copertura più completi sono anche quelli che richiedono più tempo e risorse per essere implementati, pertanto è importante valutare attentamente quali criteri di copertura sono più adeguati per il proprio programma e per il proprio obiettivo di testing.

#### Tipi di test: white o black box

I tipi di test possono essere classificati in base alla conoscenza che si ha del sistema che si sta testando. I due tipi principali di test sono i test white box e i test black box.

I test white box, anche noti come test di integrazione o di glass box, sono dei test in cui il tester ha conoscenza del funzionamento interno del sistema che si sta testando. In questo tipo di test, il tester può utilizzare questa conoscenza per creare casi di test che verifichino il comportamento del sistema in modo più accurato e dettagliato.

I test black box, invece, sono dei test in cui il tester non ha conoscenza del funzionamento interno del sistema che si sta testando. In questo tipo di test, il tester si basa solo sull'interfaccia del sistema e sui requisiti specificati per creare i casi di test. I test black box sono più adatti per verificare il comportamento del sistema dal punto di vista dell'utente finale, senza dover considerare il funzionamento interno del sistema.

In generale, entrambi i tipi di test sono importanti e possono essere utilizzati in modo complementare per garantire la qualità di un sistema. Ad esempio, i test white box possono essere utilizzati per verificare il funzionamento interno del sistema, mentre i test black box possono essere utilizzati per verificare il comportamento del sistema dal punto di vista dell'utente finale.

### Test funzionale

Il test funzionale è un tipo di test che si concentra sulla verifica del comportamento del sistema dal punto di vista dell'utente finale, senza considerare il funzionamento interno del sistema. In altre parole, il test funzionale è un approccio black box, in cui non si ha conoscenza del codice sorgente del sistema che si sta testando.

Uno dei principali vantaggi del test funzionale è che può essere l'unico approccio possibile in alcune situazioni, ad esempio quando si sta testando il lavoro di un fornitore esterno. In questo caso, non si ha accesso al codice sorgente e si deve quindi basare il test solo sull'interfaccia del sistema e sui requisiti specificati.

I dati di test per il test funzionale possono essere derivati dalle specifiche del sistema, cioè dai requisiti funzionali che descrivono il comportamento atteso del sistema. In questo modo, si può concentrare l'attenzione sul dominio delle informazioni invece che sulla struttura di controllo del codice.

Il test funzionale permette di identificare errori che non possono essere individuati con criteri strutturali, come funzionalità non implementate o flussi di esecuzione dimenticati. Inoltre, il test funzionale si pone come obiettivo anche di trovare errori di interfaccia e di prestazioni del sistema.

In generale, il test funzionale è un tipo di test molto utile per verificare il comportamento del sistema dal punto di vista dell'utente finale e per individuare errori che potrebbero altrimenti essere trascurati. Tuttavia, è importante notare che il test funzionale non garantisce la correttezza del codice sorgente del sistema e può quindi essere utilizzato in modo complementare ad altri tipi di test, come i test strutturali o i test di integrazione, per garantire la qualità del sistema nel suo insieme.

#### Tecniche di testing

Ci sono diverse tecniche di testing che possono essere utilizzate per verificare la qualità di un sistema. Ecco una panoramica di alcune tecniche comunemente utilizzate:

- Metodi basati sui grafi: come abbiamo già visto, i metodi basati sui grafi si basano sulla rappresentazione grafica delle sequenze di istruzioni e delle decisioni presenti nel programma. Utilizzando questi grafi, è possibile individuare i punti del programma che richiedono maggiore attenzione durante il testing e creare casi di test per coprire questi punti. Ad esempio, la tecnica _BUGS_ è un metodo basato sui grafi;
- Suddivisioni del dominio in classi di equivalenza: la tecnica delle category partition (suddivisioni del dominio in classi di equivalenza) consiste nel suddividere il dominio delle possibili input del sistema in classi di equivalenza, cioè in gruppi di input che dovrebbero comportarsi in modo simile. Utilizzando questa tecnica, è possibile individuare casi di test che coprano il maggior numero possibile di classi di equivalenza, garantendo così una copertura accurata del sistema;
- Analisi dei valori limite (test di fronitiera): la tecnica dei test di fronitiera consiste nell'analizzare i valori limite del sistema, cioè i valori di input che si trovano al confine tra due classi di equivalenza o che rappresentano limiti estremi del sistema. Utilizzando questa tecnica, è possibile verificare il comportamento del sistema in presenza di input particolari o estremi, che potrebbero non essere stati considerati durante il testing normale. I test di fronitiera sono particolarmente utili per individuare errori di gestione delle condizioni limite o per verificare il comportamento del sistema in presenza di input insoliti o imprevisti;
- Collaudo per confronto: il collaudo per confronto consiste nel verificare il comportamento di un sistema confrontando i risultati ottenuti con quelli attesi. Questa tecnica è particolarmente utile quando il sistema ha un comportamento noto o documentato, ad esempio quando si sta testando una nuova implementazione di un algoritmo già esistente. Utilizzando il collaudo per confronto, è possibile verificare che il sistema funzioni correttamente e che i risultati ottenuti siano coerenti con le aspettative.

In generale, queste sono solo alcune delle tecniche di testing che possono essere utilizzate per verificare la qualità di un sistema. Ognuna di queste tecniche può essere utilizzata in modo complementare alle altre e può essere adattata alle specifiche esigenze di un dato progetto. È importante scegliere la tecnica o le tecniche più adatte in base alle caratteristiche del sistema che si sta testando e ai requisiti specificati.

### Testing delle interfacce

Il testing delle interfacce è una fase importante del processo di testing di un sistema, che mira a verificare il corretto funzionamento delle interfacce tra componenti o sottosistemi. Esistono diverse tipologie di interfacce che possono essere testate, ognuna delle quali presenta caratteristiche e sfide specifiche. Ecco alcune informazioni sui tipi di interfacce e sui tipi di errore che possono essere riscontrati durante il testing delle interfacce:

Tipi di interfacce:

- A invocazione di parametri: in questo tipo di interfaccia, un componente invoca una funzione o un metodo di un altro componente passando come parametri i valori necessari per l'esecuzione della funzione;
- A condivisione di memoria: in questo tipo di interfaccia, i componenti condividono una zona di memoria per scambiarsi informazioni;
- A metodi sincroni: in questo tipo di interfaccia, i componenti comunicano tra loro attraverso metodi sincroni, cioè metodi che richiedono l'attesa della risposta prima di continuare l'esecuzione;
- A passaggio di messaggi: in questo tipo di interfaccia, i componenti comunicano tra loro attraverso il passaggio di messaggi, cioè di pacchetti di informazioni scambiati attraverso una rete o un altro canale di comunicazione.


Tipi di errore:

- Sbaglio nell'uso dell'interfaccia: durante il testing delle interfacce, è possibile riscontrare errori legati all'uso improprio dell'interfaccia da parte di un componente. Ad esempio, può accadere che un componente invochi una funzione con un ordine o un tipo di parametri non corretti, o che faccia assunzioni sbagliate circa ciò che la funzione si attende. Questi errori possono causare malfunzionamenti o crash del sistema;
- Errori di tempistica e sincornizzazione: Questi errori possono verificarsi quando i componenti coinvolti nell'interfaccia non rispettano i tempi o le sequenze di esecuzione previsti, causando conflitti o malfunzionamenti. Ad esempio, può accadere che un componente invochi una funzione prima che un altro componente abbia terminato l'elaborazione di una richiesta precedente, causando un errore di sincronizzazione. Oppure, può accadere che un componente richieda una risposta entro un determinato tempo, ma che l'altro componente non riesca a fornire la risposta entro i tempi previsti, causando un errore di tempistica. È importante prestare particolare attenzione a questi errori durante il testing delle interfacce, in modo da garantire il corretto funzionamento del sistema.

### Classi di Equivalenza

Le classi di equivalenza sono una tecnica di testing basata sulla suddivisione del dominio dei dati in ingresso in classi di dati, dalle quali derivare i casi di test. L'obiettivo di questa tecnica è quello di individuare casi di test che possano rivelare eventuali classi di errori, cioè insiemi di errori che si verificano in modo analogo per dati appartenenti a una stessa classe.

In pratica, le classi di equivalenza rappresentano un insieme di stati validi o non validi per i dati in input, e un insieme di stati validi per i dati in output. Ad esempio, una classe di equivalenza potrebbe rappresentare un insieme di valori che il sistema deve elaborare in modo corretto, oppure un intervallo di valori che il sistema deve considerare come non validi.

Un dato può appartenere a una classe di equivalenza se è un valore, un intervallo, un insieme di valori corretti o un insieme di valori non corretti. Ad esempio, un dato potrebbe appartenere alla classe di equivalenza dei numeri interi positivi, oppure alla classe di equivalenza dei caratteri alfabetici maiuscoli.

Utilizzando le classi di equivalenza, è possibile definire i casi di test in modo più efficace e individuare gli errori del sistema in modo più mirato. Tuttavia, è importante notare che le classi di equivalenza non sono sempre facili da individuare e che possono variare a seconda delle specifiche del sistema che si sta testando.

#### Suddivisione in classi

La suddivisione in classi di equivalenza può essere effettuata in base a diverse variabili, come ad esempio il tipo di valore atteso o l'intervallo di valori validi.
Nel caso in cui ci si aspetti un valore specifico, vengono definite due classi di equivalenza: una classe valida, che rappresenta i valori corretti, e una classe non valida, che rappresenta i valori non corretti. Ad esempio, se il sistema deve accettare come input un codice PIN di 4 cifre, le classi di equivalenza potrebbero essere:
- Classe valida: tutti i codici PIN di 4 cifre corretti;
- Classe non valida: tutti i codici PIN di lunghezza diversa da 4 cifre.

Nel caso in cui ci si aspetti un valore in un intervallo, vengono definite tre classi di equivalenza: una classe valida, che rappresenta i valori compresi nell'intervallo, e due classi non valide, che rappresentano i valori al di fuori dell'intervallo. Ad esempio, se il sistema deve accettare come input un numero intero compreso tra 100 e 700.

### Test di frontiera

Il test di frontiera è una tecnica di testing che si basa sulla selezione dei casi di test che esercitano i valori limite del sistema, cioè i valori di input o di output che si trovano al confine tra due classi di equivalenza. L'obiettivo di questa tecnica è quello di individuare gli errori che tendono ad accumularsi ai limiti del dominio, cioè gli errori che si verificano per valori di input o di output estremi.

Gli errori ai limiti del dominio possono essere causati da diverse ragioni. Ad esempio, potrebbero essere dovuti a una implementazione scorretta dei limiti del sistema, a una mancata gestione degli errori o a una scarsa tolleranza agli errori. Per questo motivo, è importante prestare particolare attenzione ai test di frontiera, in modo da individuare gli errori che potrebbero verificarsi ai limiti del dominio.

Il test di frontiera è complementare alla tecnica delle classi di equivalenza, poiché non si seleziona a caso un elemento della classe, ma si sceglie un elemento ai confini della classe. Ad esempio, se si definisce una classe di equivalenza che rappresenta gli interi compresi tra 1 e 10, il test di frontiera potrebbe consistere nella selezione dei valori 1 e 10, che rappresentano i confini della classe. In questo modo, è possibile verificare come il sistema gestisce gli input ai limiti del dominio.

### Category partition

La category partition (partizione per categorie) è una tecnica di testing basata sulla suddivisione del dominio dei dati in categorie di equivalenza. Questa tecnica è particolarmente utile per la definizione dei casi di test a diversi livelli di granularità, come ad esempio i test di unità, di integrazione o di sistema.

La category partition è composta da diversi passi:
- Analizzare le specifiche: in questa fase, si analizzano le specifiche del sistema e si individuano le unità funzionali che possono essere verificate singolarmente. Per ogni unità, si identificano le caratteristiche (categorie) dei parametri e dell'ambiente;
- Scegliere dei valori (scelte) per le categorie: in questa fase, si definiscono i valori che appartengono a ogni categoria. Ad esempio, si potrebbero definire le categorie "numeri interi positivi", "numeri interi negativi" e "numeri interi nulli";
- Determinare eventuali vincoli tra le scelte: in questa fase, si analizzano eventuali vincoli tra le scelte effettuate per ogni categoria. Ad esempio, si potrebbe verificare se esistono vincoli tra il numero;
- Scrivere test e documentazione: in questa fase, si scrivono i casi di test e la relativa documentazione. Ad esempio, si potrebbero definire i casi di test per ogni categoria, specificando i valori di input e le aspettative di output per ogni caso. Inoltre, si potrebbe includere nella documentazione informazioni sui vincoli tra le categorie e su eventuali altre considerazioni rilevanti.

La tecnica della category partition è molto utile per la definizione dei casi di test, poiché permette di suddividere il dominio dei dati in categorie di equivalenza e di individuare gli errori del sistema in modo più mirato. Inoltre, questa tecnica è adattabile a diverse situazioni e può essere utilizzata a diversi livelli di granularità, a seconda delle esigenze del progetto.

### Test funzionale e OO?

Come ci siamo posti la domanda per il testing strutturale anche qui ci chiediamo come si relazionano il testing funzionale
e l'object orientation?

Il testing funzionale si basa sulle funzionalità del software e non sul suo codice interno, quindi non dovrebbe essere influenzato dall'utilizzo dell'Object Orientation. Tuttavia, un'analisi più approfondita potrebbe mostrare che ci sono eccezioni a questa regola.
In senso stretto, il testing funzionale è un metodo di test che si concentra sulle funzionalità del software, verificando che esso soddisfi i requisiti specificati dall'utente, utilizzando un approccio black-box. In questo caso, l'utilizzo dell'Object Orientation non ha un grande impatto sul lavoro del tester.

Il testing funzionale non si limita solo a verificare il software dal punto di vista dell'utente, ma può anche essere eseguito su codice noto, ad esempio durante la fase di integrazione del software. In questa fase, si vuole verificare come i vari componenti del sistema interagiscono tra loro e come essi contribuiscono alla costruzione del sistema finale.

I test di integrazione possono essere eseguiti utilizzando diverse logiche, ma nella maggior parte dei casi si segue una logica bottom-up o top-down. La logica bottom-up consiste nell'iniziare il test dai componenti più semplici e di base del sistema, verificando che essi funzionino correttamente prima di passare ai componenti più complessi. La logica top-down consiste nell'iniziare il test dai componenti più alti del sistema e di lavorare verso quelli più bassi, verificando che essi funzionino correttamente in relazione all'intero sistema.

In entrambi i casi, è importante utilizzare una qualche forma di albero di composizione dei vari componenti per organizzare e pianificare i test di integrazione. È importante notare che una combinazione di entrambe le logiche bottom-up e top-down può essere utilizzata per ottenere una maggiore copertura dei test e una maggiore sicurezza del sistema.

Nel caso del testing orientato agli oggetti, una delle principali differenze rispetto al testing funzionale è che non esiste una struttura gerarchica ben definita per organizzare i componenti del sistema. Durante la fase di integrazione, questo può causare problemi nell'identificazione delle relazioni tra le classi e nella pianificazione dei test.
Le relazioni tra le classi possono essere complesse e cicliche, e non sempre sono basate sull'ereditarietà. In questa fase, le relazioni più importanti da testare sono quelle di associazione, aggregazione e dipendenza. Tuttavia, queste relazioni possono rendere più difficile individuare il sottoinsieme di classi da testare e pianificare i test in modo efficace.

Anche se non esiste una struttura gerarchica ben definita nel testing orientato agli oggetti, è comunque possibile identificare e testare i componenti del sistema in modo efficace utilizzando gli strumenti giusti.

- I casi d'uso e gli scenari sono utili per identificare i flussi di lavoro del sistema e per identificare le relazioni tra le classi.
- I diagrammi di sequenza possono essere utilizzati per identificare le relazioni tra le classi e per verificare la copertura dei thread dei messaggi.
- I diagrammi di stato possono essere utilizzati per identificare le diverse condizioni del sistema e per verificare la corretta transizione tra queste condizioni.

Utilizzando questi strumenti, è possibile identificare i cluster significativi del sistema e pianificare i test in modo efficace per garantire la qualità del software.

### Software inspection

La software inspection è una classe di tecniche manuali per individuare e correggere gli errori nel software. Queste tecniche si basano su un'attività di gruppo, come ad esempio la pair programming, che è stata vista in laboratorio.

Queste tecniche sono molto interessanti perché hanno pochi requisiti e non richiedono l'utilizzo di strumenti o software. Il "tool" utilizzato in queste tecniche è l'occhio umano. Durante le riunioni di gruppo, gli sviluppatori esaminano il codice sorgente alla ricerca di errori. A differenza di altre tecniche come il testing, la software inspection gode di una certa flessibilità. L'oggetto di ispezione può essere sia codice sorgente che compilato e può essere esteso anche alle fasi di progettazione e raccolta dei requisiti, comprese le specifiche formali e non formali.

La Fagan code inspection è una metodologia sviluppata da Michael Fagan alla IBM negli anni '70 per individuare e correggere gli errori nel codice sorgente. La metodologia prevede che un gruppo di esperti esegua una serie di passi rigorosi e ben definiti per esaminare il codice alla ricerca di eventuali errori, incongruenze o altri problemi. Essa è la metodologia di ispezione del codice più diffusa e utilizzata.

#### Ruoli

La software inspection è un'attività di gruppo in cui vengono identificati diversi ruoli per i partecipanti:

- **Moderatore**: è la persona che coordina i meeting e sceglie i partecipanti, ha la responsabilità di mantenere e far rispettare le regole e di solito non ha interessi nello specifico processo o progetto.
- **Readers e Testers**: nquesti due ruoli non sono necessariamente ricoperti da persone diverse, ma dipendono dalle fasi del processo. I readers leggono il codice al gruppo, mentre i testers cercano eventuali difetti. La lettura del codice è una vera e propria parafrasi di esso, interpretazione del codice spiegando quello che fa ma seguendo comunque la struttura di esso.
- **Autore**: colui che ha scritto il codice sotto ispezione, è un partecipante passivo che risponde a eventuali domande. È simile al ruolo del cliente nell'eXtreme Programming, pronto a rispondere a qualsiasi domanda per accelerare il lavoro degli altri.

#### Processo

Abbiamo visto come vengono identificati i ruoli per i partecipanti alla software inspection. Vediamo ora come si articola il processo di ispezione del codice in sé:

1.  **Planning**: in questa prima fase, il moderatore sceglie i partecipanti, definisce i loro ruoli e fissa il tempo da dedicare alla ispezione, pianificando anche i vari incontri;
2.  **Overview**: fase in cui si fornisce a tutti i partecipanti del materiale sul progetto, in modo che possano costruirsi un background sul progetto stesso e risparmiare tempo durante la riunione vera e propria;
3.  **Preparation**: attività svolta offline per la comprensione del codice o della struttura del sistema, basandosi sul materiale distribuito durante la fase di overview;
4.  **Inspection**: vera e propria fase di ispezione. In questa fase si esegue un'ispezione dettagliata del codice, verificando che esso soddisfi le regole definite in precedenza e segnalando eventuali problemi o anomalie. Durante l'ispezione, il gruppo di esperti esamina il codice riga per riga, confrontando il codice con le specifiche e cercando di individuare errori, incongruenze o altri problemi;
5.  **Rework**: una volta individuati i problemi, l'autore del codice si occupa di correggerli;
6.  **Followup**: possibile re-ispezione del nuovo codice ottenuto dopo la fase di rework, per verificare che i problemi siano stati corretti.

#### Ispezione

La fase di ispezione ha come obiettivo quello di trovare e registrare il maggior numero di difetti presenti nel codice, senza però correggerli. È importante capire l'importanza di questo obiettivo e rispettarlo, poiché la tentazione di correggere i difetti è molto forte, ma non è compito dei partecipanti farlo. Inoltre, essendo i partecipanti spesso capi progetto, ciascuno con le proprie idee e preferenze, metterli d'accordo su come correggere i difetti può essere complesso.

La fase di ispezione consiste in al massimo 2 sessioni di 2 ore al giorno, durante le quali si lavora approssimativamente a 150 righe di codice all'ora. Questo limite è molto indicativo poiché può variare a seconda del linguaggio utilizzato e della complessità del progetto.

L'approccio utilizzato consiste nel parafrasare linea per linea il codice, al fine di comprendere la semantica del codice sorgente sotto ispezione a partire dallo stesso e nel mentre registrare il maggior numero di difetti possibile. Un'altra possibilità è quella di eseguire un "test a mano" del codice, ovvero simulare l'esecuzione del codice per individuare eventuali problemi.

#### Checklist

La checklist è uno strumento utilizzato durante la fase di ispezione del codice per aiutare a individuare eventuali anomalie. A differenza del testing, dove si parte dai malfunzionamenti per risalire ai difetti e agli errori commessi, nell'ispezione si parte dalle cause più comuni degli errori per verificare che questi non siano stati commessi nel codice.

L'ispezione si concentra sui motivi per cui le anomalie vengono inserite nel codice e man mano che si raccolgono nuovi errori, questi vengono inseriti in una checklist. Questa checklist viene creata basandosi sull'esperienza, sulla storia e sulla conoscenza acquisita in passato e serve per evitare di ripetere gli stessi errori in futuro.

Ovviamente vi è già una conoscenza nota a priori, reperibile dalla letteratura, sugli errori da evitare perché hanno portato spesso a anomalie nel codice. Questa conoscenza viene raccolta in checklist comuni per i vari linguaggi.

Tuttavia, l'ispezione del codice è una tecnica efficace soprattutto per la sua capacità di apprendere dall'esperienza e dalla storia di un determinato progetto. Mentre un progetto progredisce, la checklist si evolve man mano che vengono incontrati nuovi errori. Ciò significa che la checklist è personalizzata per ogni progetto e può essere continuamente aggiornata per migliorare la qualità del codice.

#### Checklist - esempio NASA

_From "Software Formal Inspections Guidebook", Office of Safety and Mission Assurance, NASA-GB-A302 August 1993_

Circa 2.5 pagine per it C, 4 per FORTRAN

Divise in: Functionality, Data Usage, Control, Linkage, Computation, Maintenance, Clarity

- Esempio:

  - Does each module have a single function?

  - Does the code match the Detailed Design?

  - Are all constant names upper case?

  - Are pointers not typecast (except assignment of NULL)?

  - Are nested "#include" files avoided?

  - Are non-standard usage isolated in subroutines and well documented?

  - Are there sufficient comments to understand the code?

#### Incentive structure

Per garantire che l'ispezione del codice sia efficace, è importante che ci sia una struttura di incentivi positiva all'interno del gruppo. I difetti individuati durante l'ispezione non devono essere utilizzati per valutare il personale, poiché ciò potrebbe incoraggiare gli sviluppatori a nascondere i difetti. Invece, i difetti trovati dopo l'ispezione devono essere presi in considerazione per la valutazione del personale, in modo che gli sviluppatori siano incentivati a trovare tutti i difetti durante l'ispezione.

Inoltre è importante che ci sia una comunicazione aperta e trasparente all'interno del gruppo e che l'ispezione sia vista come un'opportunità per migliorare il codice e non come un'occasione per criticare o giudicare il lavoro degli altri. In questo modo, si crea un ambiente collaborativo e positivo in cui tutti i membri del gruppo lavorano insieme per migliorare la qualità del codice.


#### Variante: Active Design Reviews

L'Active Design Reviews è una variante della metodologia di ispezione del codice sviluppata da Michael Fagan alla IBM negli anni '70. Questa variante è stata introdotta per migliorare il processo di ispezione, poiché l'efficacia di questa tecnica dipende dalla partecipazione attiva di tutti i membri del team.

L'Active Design Reviews mira a coinvolgere tutti i partecipanti, anche quelli che potrebbero non essere adeguatamente preparati. Per questo, il processo prevede che l'autore del codice legga e ponga le checklist ai revisori, ponendo loro anche domande per incoraggiare la partecipazione attiva. Inoltre, si sceglie un team di revisori con esperienze diverse per diversi aspetti del progetto, in modo che ognuno possa contribuire con la propria conoscenza.

Inoltre, è importante notare che i difetti trovati durante l'ispezione non devono essere utilizzati per la valutazione del personale, in modo che gli sviluppatori non siano incentivati a nascondere i difetti. Invece, i difetti trovati dopo l'ispezione devono essere presi in considerazione per la valutazione del personale, in modo da incentivare il team a trovare tutti i difetti durante l'ispezione.

#### Automazione dell'ispezione

Sebbene sia una tecnica manuale esistono tool di supporto per:

- Automatizzazione di controlli banali (e.g., formattazione)

- Riferimenti: Checklists, Standard con esempi, formati elettronici più facilmente consultabile e compilabili

- Aiuti alla comprensione del codice quindi tool comuni a quelli di attività di reengineering

  - Evidenziazione di parti rilevanti

  - Navigazione nel codice

  - Diversi tipi di rappresentazione dei dati e delle architetture

- Annotazioni & comunicazioni

- Guida al processo e rinforzo: non permettere di chiudere il processo se non sono soddisfatti alcuni

Vedi: Reengineering vs reverse engineering

#### Funziona?

Principalmente sì. La pratica ci dice che è cost-effective. Perché?

- Processo rigoroso e dettagliato

- Basato su accumulo di esperienza (es. Checklist) si auto migliora il prof è molto convinto di questo punto

- Aspetti sociali del processo (riguardo all'autore soprattutto): tenere conto delle dinamiche di incentivi e non disturbanti

- Si considera l'intero dominio dei dati: a differenza del testing dove è impossibile fare del testing esaustivo, con la mente umana riusciamo spesso ad astrarre e trattare l'intero dominio dei dati contemporaneamente.

- E applicabile anche a programmi incompleti

#### Limiti

- Limitazioni nella correzione: l'obiettivo principale dell'ispezione è quello di individuare gli errori, ma non di correggerli immediatamente. Ciò può causare una ripetizione delle stesse problematiche e un aumento dei costi di manutenzione.

- Tempo richiesto: l'ispezione richiede molto tempo e impegno, sia per la preparazione che per l'esecuzione del processo stesso. Ciò può rappresentare un problema per progetti con tempi stretti o budget limitati.

- Dipendenza dalle capacità umane: l'ispezione è una tecnica basata sull'intelligenza umana, quindi dipende dalle capacità e dall'esperienza dei partecipanti. Ciò può rendere il processo meno affidabile rispetto ad altre tecniche automatizzate.

#### Conclusione: Fagans's Law L17

Inspections significantly increase productivity, quality, and project stability.

### Confronto tra le varie tecniche
#### È un confronto sensato?

Forse vale la pena estendere la domanda sul fatto se l'ispezione funzioni o meno a tutte altre tecniche viste finora,
magari anche confrontandole?

[Link consignliato dal prof](https://web.archive.org/web/20060920113729/http:/www2.umassd.edu/SWPI/ISERN/ISERN-98-10.pdf)

{% responsive_image path: assets/13_tabella-confronto-tecnicheV&V.png %}

La tabella mostra i risultati di diversi studi sull'efficacia delle tecniche di verifica e validazione, dove una tecnica risulta essere più efficace di altre in base agli autori degli studi. Tuttavia, è importante fare ulteriori osservazioni. L'efficacia di una tecnica dipende dalla tipologia dei progetti e non è detto che le tecniche trovino gli stessi errori. Le diverse tecniche controllano cose diverse e in modo diverso, partendo da punti di osservazione diversi. Pertanto, confrontare le percentuali di errori trovati tra le diverse tecniche può essere complesso e non sempre significativo. La tabella è stata inclusa solo per evidenziare che il confronto tra le tecniche è una questione su cui si può e si deve ragionare, ma non c'è una risposta banale e non c'è una tecnica che è migliore in tutto rispetto alle altre.

#### E se le mettessimo insieme? Hetzel-Meyer's Law L20

La legge di Hetzel-Meyer L20 sostiene che l'utilizzo combinato di diverse tecniche di verifica e convalida produce risultati migliori rispetto all'utilizzo di una singola tecnica. Questo è stato dimostrato attraverso l'applicazione di diverse tecniche come testing, ispezione del codice, esame formale e analisi di sicurezza in combinazione. Come per le metodologie agili, l'unione di diversi pezzi di pratiche ben eseguite produce risultati di qualità.

{% responsive_image path: assets/13_tabella-tecnicheV&V-insieme.png %}

**Hetzel-Meyer's Law L20**: A combination of different V&V methods outperforms any single method alone.

### Chi è che fa il testing?

In generale c'è la convinzione che colui che ha sviluppato il codice sia la persona meno adatta a testarlo. Di conseguenza
si preferisce che il testing sia effettuato da quello che è un gruppo di testing autonomo.

#### Vantaggi di un gruppo di test autonomo

Avere un gruppo di test autonomo presenta numerosi vantaggi, sia dal punto di vista tecnico che psicologico.

In termini di aspetti tecnici, un gruppo di test autonomo offre maggiore specializzazione e conoscenza delle tecniche e degli strumenti di testing, come tool complessi, librerie di testing, tool di copertura e mutazioni.

In termini di aspetti psicologici, il fatto che il testing sia effettuato da un gruppo autonomo significa che esso è distaccato dal codice, il che permette un testing indipendente dalla conoscenza del codice stesso e una maggiore attenzione agli aspetti spesso trascurati. Ciò aiuta a individuare anomalie che altrimenti potrebbero essere mancate.

Inoltre, se il testing non è effettuato dallo sviluppatore stesso, si può ottenere una maggiore indipendenza nella valutazione. Infatti, una persona che testa il proprio codice potrebbe essere meno propensa a individuare eventuali problemi, poiché ciò potrebbe far apparire il proprio lavoro di qualità inferiore. Al contrario, un gruppo specializzato nel testing è incentivato a trovare il maggior numero possibile di problemi, poiché verrà valutato sulla base della quantità di problemi individuati.

#### Svantaggi di un gruppo di testing autonomo

Ci sono anche alcuni svantaggi nell'avere un gruppo di test autonomo. Uno dei principali è legato alla perdita progressiva di capacità di progettazione e codifica dei tester, a causa della loro specializzazione. Inoltre, i tester potrebbero avere una minore conoscenza dei requisiti del progetto.

Dal punto di vista psicologico, l'aumento delle risorse del team di testing può portare ad una diminuzione delle prestazioni in termini di errori nel codice. Ciò può essere sorprendente, ma può essere causato dalla mancata chiarezza delle responsabilità, con gli sviluppatori che tendono a scaricare sui tester la responsabilità di trovare gli errori, consegnando così codice di qualità inferiore. Ciò può causare anche un ambiente lavorativo negativo, con gli sviluppatori che si sentono sotto pressione e sotto valutazione dal team di test.

Quando si investe di più nel gruppo di testing uno dei problemi principali sono le responsabilità. Seppure vero che il testing
sia compito dei tester è anche vero che è lo sviluppatore stesso che solitamente ha il compito di fare
quello che è il testing di unità mentre i tester fanno altre forme di testing come quello funzionale o d'integrazione. 
A fronte di aumento di personale il team di testing funziona sicuramente meglio ma quasi come conseguenza il team di sviluppo
quando vicino a deadline sposta tutta la responsabilità di trovare errori su quest'ultimo, iniziando quindi a consegnare 
codice di qualità più bassa. Il team di testing troverà gli errori e riconsegnerà il codice agli sviluppatori che possono
correggerli, tuttavia questa è una perdita di tempo e risorse (si accumulano ritardi).

Inoltre ci possono essere pressioni negative sul team di sviluppo in quanto si potrebbe creare un ambiente tossico dove 
gli sviluppatori si sentono sotto valutazione da parte del team di testing.

[https://web.archive.org/web/20220526084408/http://testobsessed.com/wp-content/uploads/2011/04/btwq.pdf](https://web.archive.org/web/20220526084408/http:/testobsessed.com/wp-content/uploads/2011/04/btwq.pdf)

#### Possibili alternative

Ci sono alcune alternative per evitare i svantaggi legati ad un gruppo di test autonomo.

Una possibile alternativa è la rotazione del personale, dove le persone ricoprono ruoli diversi su progetti diversi. Ciò permette di evitare la progressiva perdita di capacità di progettazione e codifica dei tester, evitare il svuotamento dei ruoli e di avere una maggiore conoscenza del prodotto in esame. Tuttavia, questa alternativa aumenta i costi di formazione, in quanto più persone devono essere capaci di ricoprire più ruoli, e aumenta le difficoltà di pianificazione, poiché progetti diversi possono sovrapporsi e una persona potrebbe trovarsi a coprire ruoli diversi contemporaneamente in progetti diversi, rischiando di non essere in grado di performare al meglio in nessuno.

Un'altra possibile alternativa è la condivisione del personale, dove le persone ricoprono più ruoli all'interno di uno stesso progetto. Ciò permette di supplire alla scarsa conoscenza del prodotto in esame, ma aumenta le difficoltà di gestione dei ruoli.

### Modelli statistici

Il modello statistico è una tecnica che utilizza i dati per analizzare la relazione tra diverse variabili e prevedere eventi futuri. Il professore potrebbe non essere un esperto in questo campo, ma riconosce che i modelli statistici possono essere utili per analizzare i dati del progetto.

In particolare, i modelli statistici possono essere utilizzati per trovare relazioni tra metriche come il numero di righe di codice, il tipo di processo, il tipo di linguaggio e la presenza o il numero di errori. Ciò può aiutare a prevedere la distribuzione degli errori per modulo, permettendo di identificare le aree del progetto che necessitano maggiore attenzione.

In generale, l'utilizzo di modelli statistici può aiutare a trovare e misurare le correlazioni tra le metriche e la presenza/numero di errori, permettendo di prendere decisioni

I modelli statistici possono essere utili per identificare le aree del progetto che necessitano maggiore attenzione, tuttavia è importante essere consapevoli dei limiti delle conclusioni derivate da tali analisi. Utilizzare i risultati dei modelli per concentrare maggiormente le attività di test su alcuni moduli, potrebbe sembrare logico, ma non sempre è la soluzione migliore.

Anche dopo aver testato i moduli con maggiore attenzione e corretto gli errori trovati, le conclusioni del modello potrebbero non cambiare. Ciò può essere dovuto alle caratteristiche della struttura dei moduli stessi, che rendono più probabile la presenza di errori.

In questi casi, un'attività di refactoring, ovvero la riscrittura o la modifica della struttura dei moduli, può essere la soluzione migliore per ridurre la probabilità di errori in futuro. Tuttavia, questo è un processo che richiede tempo e risorse e spesso non viene eseguito a causa dei vincoli di progetto.

**Pareto/Zipf Laws L24**  
Approximately 80 per cent of defects come from 20 per cent of modules.

È vero, i modelli statistici possono indicare le aree del progetto che necessitano maggiore attenzione, ma spesso non è possibile identificare in anticipo quali sono questi moduli specifici. Ciò significa che è necessario testare tutti i moduli del progetto per assicurarsi che funzionino come previsto. Ciò può essere un processo lungo e complesso, ma è importante per garantire la qualità del software e prevenire eventuali problemi futuri. Tuttavia, l'utilizzo di modelli statistici può aiutare a concentrare le attività di test sui moduli più probabilmente soggetti ad errori, rendendo il processo più efficiente.

### Debugging

Il debugging è l'insieme di tecniche utilizzate per individuare e correggere gli errori (noti come "bug") che causano un malfunzionamento del software. È importante notare che il debugging non deve essere utilizzato per rilevare i malfunzionamenti, ma solo per localizzarli e correggerli una volta che sono già stati individuati.

L'attività di debugging è specifica per un programma e un insieme di dati che causano malfunzionamenti. Si basa sulla riproducibilità del malfunzionamento, ovvero sulla capacità di riprodurre lo stesso errore in condizioni controllate. Inoltre, è importante verificare che il malfunzionamento non sia causato da specifiche errate o da problemi di altro tipo, come ad esempio una configurazione del sistema non corretta.

Il debugging richiede una comprensione profonda del codice e del funzionamento del programma, e può essere un processo complesso e articolato. Tuttavia, può contribuire in modo significativo a migliorare la qualità e la stabilità del codice.

Come sottolineato dalla citazione di Brian W Kernighan, "Debugging è il doppio difficile rispetto alla scrittura del codice in primo luogo. Pertanto, se scrivete il codice il più astutamente possibile, siete, per definizione, non abbastanza intelligenti per debuggarlo".

Per questo motivo, è importante scrivere codice il più semplice possibile in modo da poterlo facilmente debugga. Ciò aiuta a ridurre i tempi di debugging, aumentando la velocità e l'efficienza del processo, e migliorando la qualità e la stabilità del codice.

#### Problemi

Il debugging può essere un'attività complessa a causa di alcuni problemi specifici. Uno dei problemi più comuni è stabilire una relazione tra l'anomalia e il malfunzionamento. Le anomalie possono evolversi prima di manifestarsi sotto forma di malfunzionamenti, rendendo difficile stabilire un legame preciso tra le due cose. Inoltre, non esiste una relazione univoca tra anomalie e malfunzionamenti, poiché un'anomalia può causare più di un malfunzionamento o viceversa.

Un altro problema è che la correzione delle anomalie non garantisce necessariamente un software migliore o con meno errori. Quando si correggono anomalie, si deve modificare il codice sorgente, aprendo la possibilità di introdurre nuovi bug e anomalie nel codice stesso.

Per affrontare questi problemi, esistono diverse tecniche di debugging che possono essere utilizzate, come la ricerca di codice, la tracciatura, il debugging passo-per-passo e la verifica dei registri. È importante utilizzare le tecniche più appropriate in base al tipo di problema e al contesto specifico.

Vediamo le tecniche che abbiamo a disposizione.

#### Tecnica naïve

Consiste nell'introdurre nel modulo in esame comandi di uscita che stampino il valore intermedio assunto dalle variabili.

-   facile da applicare (bastano un compilatore e un esecutore);
-   richiede la modifica del codice (e quindi la sua rimodifica una volta individuata la anomalia);
-   poco flessibile (modifica e compilazione per ogni nuovo stato).

Può andare bene in pochi casi laddove il codice è progettato talmente bene e il modulo è così ben isolato che basta 
scrivere una unica printf da cui si è in grado di risalire all'anomalia: scenario un po' troppo idealistico.

#### Tecnica naïve avanzata

Un miglioramento parziale si può ottenere sfruttando funzionalità del linguaggio oppure alcuni tool:

- Utilizzare costrutti come #ifdef e -D (in C)
- Usare librerie di logging (con messaggi differenziati)
- Usare asserzioni: possono essere viste come oracoli interni al codice, sono la valutazione di uno stato non una sua
  rappresentazione e permettono di avere un riscontro solo laddove lo stato non è valido.

Resta comunque una tecnica naïve in quanto stiamo ancora modificando il codice in modo tale che ci fornisca informazioni
aggiuntive.

#### Dump di memoria

Consiste nel produrre una immagine esatta della memoria dopo un passo di esecuzione: scrivere su un file il contenuto 
intero della memoria a livello di linguaggio macchina.

Non richiede modifica del codice, ma è spesso difficile da gestire per la differenza tra la rappresentazione astratta 
dello stato (legata alle strutture dati del linguaggio utilizzato) e la rappresentazione fornita dallo strumento.

#### Debugging simbolico

Gli stati intermedi sono prodotti usando una rappresentazione compatibile con quella del linguaggio usato, in termini 
quindi di variabili e nello stesso domino di astrazione di come l'abbiamo scritto. Gli stati sono rappresentati come 
strutture dati e valori a esse associati. 
I debugger simbolici forniscono ulteriori strumenti (*watch* o *spy monitor*) che permettono di visualizzare il 
comportamento del programma in maniera selettiva. È possibile inserire breakpoint e watch su variabili.

È possibile anche scegliere e gestire la granularità del passo di esecuzione:

- Singolo passo;

- entrare dentro a una funzione;

- drop/reset del frame.

Inoltre, si può:

-   modificare il contenuto di una variabile (o zona di memoria)
-   modificare il codice, anche se non è sempre possibile. Necessita ricompilazione ma poi si prosegue dal punto in cui ci si era interrotti
-   Rappresentazioni grafiche dei dati

#### È possibile automatizzare il debugging?

<http://debuggingbook.org/>

Delta (differential) debugging

Andreas Zeller