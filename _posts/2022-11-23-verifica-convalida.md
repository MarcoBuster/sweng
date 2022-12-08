---
layout: post
title: "[12] Veriifica e convalida"
date:   2022-11-23 14:30:00 +0200
toc: true
---

# Introduzione

## Terminologia

### Verifica e convalida

Verifica e convalida sono due termini con un significato apparentemente molto simile ma che celano in realtà una differenza non banale tra loro:

>Per _convalida_ intendiamo il confronto del software con i __requisiti__ (informali) posti dal committente

>Per _verifica_ intendiamo il confronto del software con le __specifiche__ (formali) prodotte dall'analista

Ci sono quindi due punti critici che vanno a sottolineare maggiormente questa differenza:

- Requisiti e specifiche sono spesso formulati in maniera diversa
    - Molto spesso i requisiti, essendo scritti dal committente, sono scritti in un linguaggio più vicino al dominio di quest'ultimo piuttosto che di uno sviluppatore. Diversamente, le specifiche sono scritte in un linguaggio più vicino al dominio dello sviluppatore, solitamente in maniera formale (ma non sempre), sicuramente in maniera poco ambigua

- I requisiti è facile che cambino, mentre le specifiche sono più congelate (dipende però molto dai contratti tra committente e team di sviluppo)

Più in generale, possiamo dire che se nella verifica la parte di formalizzazione è più difficile a favore di un'operazione di confronto con il test più semplice, per quanto riguarda la convalida è l'inverso (ovvero, non essendoci alcuna formalizzazione è tipicamente più difficile confrontare il proprio software direttamente con i requisiti del committente)

Ad ogni modo, nelle attività di verifica e convalida andiamo a cercare degli _errori_, ma la parola "errore" stessa può assumere molti significati a seconda del contesto. Diventa quindi importante capire di quale errore stiamo parlando, andando ad introdurre termini diversi (N.B: esistono dei glossari e vocabolari di terminologia comune redatti dalla IEEE, ad esempio [Systems and software engineering —
Vocabulary](http://pros.lib.unimi.it/login?url=https://ieeexplore.ieee.org/document/5733835 'Systems and software engineering —
Vocabulary') (da accedere usando le credenziali di ateneo) che possono essere addottati dagli sviluppatori come standard in modo da snellire la comunicazione tra di loro).

### Malfunzionamento (guasto/failure)

È lo scostamento da quello che dovrebbe essere il corretto funzionamento di un programma. Non dipende dal codice e in generale non mi accorgo di esso osservando il codice, ma da un punto di vista più esterno, ovvero utilizzando il programma. Potrebbe essere sia un malfunzionamento rispetto le specifiche (quindi riguardante la fase di verifica, ovvero la correttezza vera e propria) sia un malfunzionamento riguardante i requisiti (quindi riguardante la fase di verifica, ovvero che "non rispetta le aspettative"). Secondo l'_ISO/IEC/IEEE International Standard - Systems and software engineering -- Vocabulary_:

> __failure:__ 
>1. termination of the ability of a product to perform a required function or its inability to perform within
previously specified limits. ISO/IEC 25000:2005, Software Engineering — Software product Quality
Requirements and Evaluation (SQuaRE) — Guide to SQuaRE.4.20.
>2. an event in which a system or system
component does not perform a required function within specified limits

>_NOTE: A failure may be produced when a fault is encountered_

#### Esempio di malfunzionamento:
```java
static int radoppia (int par) {
    int risultato;
    risultato = (par * par);
    return risultato;
} 
```
la funzione dovrebbe ritornare il doppio del numero in ingresso, ma se gli passiamo 3 ritorna 9.


### Difetto (anomalia/fault)
È il punto del codice che causa il verificarsi del malfunzionamento.
È legato al codice ed è condizione necessaria (ma non sufficiente) perché si verifichi un malfunzionamento.
Nell'esempio del codice precedente, il difetto è la linea 3.
Abbiamo detto che è condizione non sufficiente per il verificarsi di un malfunzionamento: ad esempio sempre sfruttando l'esempio precedente, pur essendo presente l'anomalia a linea 3 il malfunzionamento non si verifica nei casi in cui l'argomento passato sia 0 o 2. Il raddoppio in quei casi avverrebbe in maniera corretta. Altri esempi invece possono essere "più anomalie che si compensano": se sto utilizzando una libreria per operazioni su temperature in gradi Fahrenheit, ponendo il caso che stia partendo da gradi Celsius, dovrò effettuare una conversione. Se in questa conversione ho un'anomalia che però si riflette allo stesso modo quando riconverto per restituire il risultato, le due anomalie combinate non si manifestano in un malfunzionamento.

> __fault:__
>1. a manifestation of an error in software.
>2. an incorrect step, process, or data definition in a computer
program. 3. a defect in a hardware device or component. Syn: bug

>_NOTE: A fault, if encountered, may cause a failure._

### Sbaglio (Mistake)

È la causa di un’anomalia. In genera si tratta di un errore umano (concettuale, battitura, scara conoscenza del linguaggio…)
Ad esempio:
        - Errori di battitura (quindi nell'esempio in java presentato scrivere * invece di +)
        - Concettuale (non sapere cosa vuol dire _raddoppiare_)
        - Padronanza del linguaggio (Credere che * fosse il simbolo dell’addizione)

>__mistake:__
>1. a human action that produces an incorrect result

>_NOTE: The fault tolerance discipline distinguishes between a human action (a mistake), its manifestation (a hardware
or software fault), the result of the fault (a failure), and the amount by which the result is incorrect (the error)._

### Esempio notevole: il caso Ariane 5

<iframe width="560" height="315" src="https://www.youtube.com/embed/PK_yguLapgA?start=67" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[Wikipedia: Ariane 5 notable launches](https://en.wikipedia.org/wiki/Ariane_5#Notable_launches 'Ariane 5 - Notable Launches')

Il malfunziamento è palese: il razzo è esploso e chiaramente non era il comportamento richiesto.

Qual era l'anomalia? Il malfunziamento si è verificato per una eccezione di overflow, sollevatosi durante una conversione di 64 bit float a un 16 bit signed int del valore della velocità orizzontale. 
Questo ha bloccato sia l'unità principale che il backup dell'unità stessa.

Lo sbaglio? Tale eccezione non veniva gestita perché questa parte del software era stata ereditata da Ariane 4, la cui traiettora faceva sì che non si raggiungessero mai velocità orizzontali non rappresentabili con int 16 bit. 
La variabile incriminata non veniva protetta per gli _"ampi margini di sicurezza"_ (a posteriori, non così ampi).

Il comportamento della variabile non era mai stato analizzato con i dati relativi alla traiettoria da seguire.

## Tecniche di verifica o convalida: statiche vs dinamiche

Le tecniche statiche sono basate sull'analisi degli elementi sintattici del codice, ad esempio attraverso l'uso di metodi formali, analisi del data flow o modelli statistici.

Diversamente le tecniche dinamiche sono basate sull'esecuzione del programma eseguibile, quindi ad esempio attraverso pratiche di testing e debugging.

In generale è più facile determinare tecniche dinamiche mentre le tecniche statiche sono più difficili da ideare. Per contro, una volta ideate le tecniche statiche sono più veloci nell'analizzare il codice e più complete dato che le tecniche dinamiche lavorano sui possibili stati del programma (ma gli stati possibili possono essere infiniti).

Come possiamo confrontare queste tecniche?

{% responsive_image path: 'assets/12_Classificazione-tecniche-di-verifica-e-convalida.png' %}

In questa immagine possiamo osservare una piramide immaginaria a 3 dimensioni che riassume dove si posizionano le tecniche di verifica e convalida le une con le altre. Possiamo osservare come la cima della piramide rappresenterebbe il punto ideale a cui tendere, in cui nel caso mi trovassi potrei dire che posso verificare perfettamente una proprietà arbitraria attraverso una prova logica (dal lato statico) o una ricerca esaustiva su tutti gli stati del problema (dal lato dinamico).

Questa cima è praticamente impossibile da raggiungere per la stragrande maggioranza dei problemi che siamo interessati a risolvere. Dobbiamo scegliere da quale versante iniziare la scalata della piramide: lato blu (ovvero con un approccio dinamico) o lato verde (con un approccio statico)?

Più siamo posizionati in basso, più siamo vicini alla degnerazione in:
- Estrema _semplificazione delle proprietà_ (in basso a sinistra)
    - Se ad esempio voglio dimostrare che sto usando un puntatore in maniera corretta e nel farlo sto semplicemente controllando che non valga `null`, sto _cambiando_ la proprietà che voglio come obiettivo (controllare che un puntatore non valga `null` __non significa che__ lo stia usando nel modo corretto)
- Estrema _inaccuratezza pessimistica_ (in basso al centro)
    - È dovuta all'approccio pessimistico che ha come mantra:
    > _"Se non riesco a dimostrare l'assenza di un problema assumo che il problema sia presente"_
    - Si manifesta ad esempio nei compilatori quando non riescono a dimostrare che una determinata funzione ritorni un valore per tutti i possibili cammini (magari perchè i return sono compresi in un costrutto ```if  else if```).
- Estrema _inaccuratezza ottimistica_ (in basso a sinistra)
    - È dovuta all'approccio ottimistico che ha come mantra:
    > _"Se non riesco a dimostrare la presenza di un problema assumo che questo non sia presente"_
    - Possibile dervi degli approcci legati al testing: con il testing sto cercando dei malfunzionamenti, se a seguito dei test non trovo malfunzionamenti allora assumo che il programma funzioni correttamente.

### Metodi formali

L'approccio dei metodi formali tenta di dimostrare l'_assenza_ di anomalie nel prodotto finali.
Posso utilizzare, per esempio:
- analisi di dataflow
- dimostrazione di correttezza delle specifiche logiche.

Soffrono di _inaccuratezza pessimistica_

### Testing

Il testing è l'insieme delle tecniche che si prefiggono di rilevare malfunzionamenti o, nel caso questi non vengano trovati, aumentare la fiducia nel prodotto.

Attraverso il testing non può dimostrare la correttezza ma solo aumentare la fiducia.

Esistono diversi tipi di testing:
- __white box__: abbiamo accesso al codice da testare e possiamo cercare anomalie guardandolo da un punto di vista interno.
- __black box__: non abbiamo accesso al codice ma è possibile testare e cercare malfunzionamenti tramite le interfacce esterne.
- __gray box__: non abbiamo accesso al codice ma solo un'idea dell'implementazione ad alto livello. Per esempio in un modello Model View Controller ci possiamo aspettare che certe stimolazioni portino a chiamate al database mentre altre no.

L'approccio del testing soffre di _inaccuratezza pessimistica_

### Debugging

Se il testing ha come compiito di scoprire un malfunzionamento dato un programma, il debugging invece, dato un programma e un malfunzionamento noto, ci permette di localizzare le _anomalie_ che causano malfunzionamenti.

Molto spesso viene usato il debugging al posto del testing, almeno a livello di terminologia: questo è un problema perché il debugging non è fatto per la "grande esecuzione" ma al contrario per esaminare in maniera granulare (a volte anche passo passo per istruzioni macchina) una determinata sezione dell'esecuzione allo scopo trovare l'anomalia che provoca un malfunzionamento. Se si usassero le tecniche di debugging per effettuare il testing il tempo speso sarebbe enorme.

Possiamo portare ad esempio 2 possibili approcci per il debugging:

- Produzione degli stati intermedi dell'esecuzione del programma:
    - Devo partire quindi da un malfunzionamento che deve essere:

        - Noto
        - Riproducibile

        In modo da poter avviare una procedura di analisi.
- Divide et impera:
    - Smonto il codice sezione per sezione, componente per componente in modo da poter trovare il punto in cui c'è l'anomalia

## Correttezza

Quando un programma si definisce corretto?

Consideriamo un generico programma $P$ come una funzione da un insieme di dati $D$ (dominio) a un insieme di dati $R$ (codominio);

$P(d)$ indica l'esecuzione di $P$ su un dato in ingresso $d \in D$;

il risultato $P(d)$ è corretto se soddisfa le specifiche, altrimenti è scorretto;

$\operatorname{ok}(P, \, d)$ indicherà la correttezza di $P$ per il dato $d$;

allora...

$$
P \text{ è } \textit{corretto} \Leftrightarrow \forall d \in D \: \operatorname{ok}(P, \, d)
$$

### Test

un test $T$ per un programma $P$ è un sottoinsieme del dominio $D$;

un elemento $t$ di un test $T$ è detto _caso di test_;

l'esecuzione di un test consiste nell'esecuzione del programma $\forall t \in T$;

un programma __passa__ o __supera__ un test:

$$
\operatorname{ok}(P, \, T) \Leftrightarrow \forall t \in T | \operatorname{ok}(P, \, t)
$$

un test $T$ _ha successo_ se rileva uno o più malfunzionamenti presenti nel programma $P$

$$
\operatorname{successo}(T, \, P) \Leftrightarrow \exist t \in T | \neg\operatorname{ok}(P,\,t) 
$$

### Test ideale

$T$ è _ideale_ per $P$ se e solo se $\operatorname{ok}(P, \, T) \Rightarrow \operatorname{ok}(P, \, D)$ ovvero se il superamento del test implica la correttezza del programma.

In generale, è __impossibile trovare un test ideale__.

> __Tesi di Dijkstra__:
>
> _Il test di un prorgamma può rilevare la presenza di malfunzionamenti ma non dimostrarne l'assenza._
>
>_Non esiste quindi un algoritmo che dato un programma arbitrario $P$ generi un test ideale finito (il caso $T = D$ non va considerato)._

Perché è impossibile trovare un test ideale esaustivo? 
Vediamo il seguente esempio:
```java
class Trivial {
    static int sum(int a, int b) {
        return a + b;
    }
}
```



In Java un int è espresso su 32 bit, quindi il dominio ha di cardinalità $2^{32} \cdot 2^{32} = 2^{64} \sim 2 \cdot 10^{19}$.
Considerando un tempo di 1 nanosecondo per ogni test, ci dovremmo mettere più di 600 anni.

### Criterio di selezione

Come faccio a scegliere un sottoinsieme del dominio _intelligente_ cercando di approssimare il test ideale? Quali caratteristiche ci interessa che abbia il criterio che usiamo per selezionare questo sottoinsieme?

#### Affidabilità
Un _criterio di selezione_ si dice __affidabile__ se presi due test $T_1$ e $T_2$ in base al criterio $C$ allora o entrambi hanno sucecsso o nessuno dei due ha successo.

$$
\operatorname{affidabile}(C, \, P) \Leftrightarrow [\forall T_1 \in C, \, \forall T_2 \in C \: \operatorname{successo}(T_1, \, P) \Leftrightarrow \operatorname{successo}(T_2, P)]
$$


#### Validità
Un _criterio di selezione_ si dice __valido__ se qualora $P$ non sia corretto, allora esiste almeno un test $T$ selezionato in base al criterio $C$ che ha successo per il programma $P$

$$
\operatorname{valido}(C, \, P) \Leftrightarrow (\lnot \operatorname{ok}(P, \, D) \Rightarrow \exists T \in C \ | \ successo(T,\,P))
$$

__Esempio__: dato il codice
```java
static int raddoppia(int par) {
    int risultato;
    risultato = (par * par);
    return risultato;
}
```
un criterio che seleziona:
- _"sottoinsiemi di $\{0, \, 2\}$"_ è ___affidabile__ ma non valido_;
- _"i sottoinsiemi di $\{0, \, 1, \, 2, \, 3, \, 4\}$"_ è _non affidabile ma __valido___;
- _"sottoinsieme finiti di $D$ con almeno un valore maggiore di $18$"_ è ___affidabile e valido___ 

Ma siamo davvero sicuri?

Se il test non ha successo, ci è utile avere un criterio valido ed affidabile?
- Il fatto che il test non abbia avuto successo implica che non ci siano stati errori
- Il fatto che il criterio sia affidabile implica che tutti gli altri test che possiamo trovare per quel criterio non trovo errori
- Il fatto che il criterio sia valido, se ci fosse stato un errore almeno uno dei test lo avrebbe dovuto trovare

Quindi siamo __sicuri__ che il programma è corretto:
$$
\operatorname{affidabile}(C,P) \wedge \operatorname{valido}(C,P) \wedge T \in C \wedge \neg\operatorname{successo}(T,P)
$$
$$
\Longrightarrow
$$
$$
\operatorname{ok}(P,D)
$$

Ma trovare un criterio che sia _contemporaneamente_ affidabile e valido significherebbe trovare un criterio che selezioni _test ideali_ che sappiamo non esistere per la _tesi di Dijkstra_

#### Utilità di un test

Quali sono le caratteristiche che rendono utile un caso di test, ovvero che rendono "possibile" o "probabile" che il caso di test mi trovi l'errore?

- Eseguire il comando che contiene l'anomalia (altrimenti non è possibile che il malfunzionamento si manifesti)
- L'esecuzione del comando che contiene l'anomalia deve portare il sistema in uno stato inconsistente
- Lo stato inconsistente dell'output deve propagarsi fino all'uscita del codice in esame in modo da produrre un output diverso da quello atteso

Possiamo utilizzare un metro di misura legato alle caratteristiche del codice: ad ogni criterio è possibile associare una metrica che misuri la _copertura_ del codice rispetto ad uno specifico test (ovvero la percentuale di codice che vado ad "utilizzare" in tutto il test) e che ci permetta di decidere quando smettere di testare, decidere quali altri casi di test è opportuno aggiungere o confrontare la _bontà_ di Test diversi


## Criteri noti

### Criterio di copertura dei comandi

Un test $T$ soddisfa il criterio di __copertura dei comandi__ se e solo se ogni comando eseguibile del programma è eseguito in corrispondenza di almeno un caso di test $t \in T$.

#### Esempio
```c
void main(){
    float x,y;
    read(x);
    read(y);
    if (x!=0)
        x = x+10;
    y = y/x;
    write(x);
    write(y);
}
```

Posso ricostruire un diaramma di flusso di esecuzione del codice trasformando ogni comando in un nodo del diagramma:

{% responsive_image path: 'assets/12_flowChart.png' %}

Dire che voglio _coprire tutti i comandi_, avendo trasformato ogni comando in un nodo, significa voler passare per tutti i nodi raggiungibili.

Applicare il _criterio di copertura dei comandi_ significa quindi trovare un insieme dei casi di test per il cui per ogni nodo esiste un caso di test che passa per quel nodo.

Il caso di test $<3,7>$ risulterebbe quindi sufficiente, dato che soddisfa il criterio di copertura dei comandi al 100%

Questo però _non mi garantisce che il programma si corretto,_ perchè ci sono dei malfunzionamenti che non sono stati trovati, ad esempio il caso di testing $<0,7>$ che provoca una divisione per 0.


### Criterio di copertura delle decisioni

Un test T soddisfa il criterio di copertura delle decisioni se e solo se ogni decisione effettiva viene resa sia vera che falsa in corrispondenza di almeno un caso di test t contenuto in T

La metrica è la percentuale delle decisioni totali possibili presenti nel codice che sono state rese sia vere che false nel test.

Si noti come il criterio di copertura delle decisioni implichi il criterio di copertura dei comandi: andando ad estrarre il codice in un diagramma di flusso, io copro tutte le decisioni se e solo se attraverso ogni arco presente nel flusso. Considerando un grafo connesso per il diagramma di flusso, se io attraverso tutti gli archi allora ho attraversato tutti i possibili nodi. Non è invece vero l'inverso.

#### Esempio
Riprendendo l'esempio precedente, se volessi applicare il criterio di copertura delle decisioni dovrei utilizzare almeno due casi di test, ad esempio $<3,7>$ e $<0,5>$, che se compresi nello stesso test mi restituiscono una copertura delle decisioni pari al 100%.

Ma non tutti i malfunzionamenti vengono trovati, ad esempio a riga 6 è possibile che ad x sia assegnato un valore tale per cui se sommo 10 ottengo un overflow.

### Criterio di copertura delle condizioni

Un test T soddisfa il criterio di _copertura delle condizioni_ se e solo se ogni singola condizione (effettiva) viene resa sia vera che falsa in corrispondenza di almeno un caso di test t contenuto in T

Similmente ai test precedenti, la metrica è la percentuale delle condizioni che sono state rese sia vere che false su quelle per cui è possibile farlo.

Si noti come questo criterio non implichi i criteri precedenti

#### Esempio

Modifichiamo un po' l'esempio usato fino ad'ora:

```c
void main(){
    float x,y;
    read(x);
    read(y);
    if (x!=0 || y>0)
        y = y/x;
    else
        y = (y+2)/x
    y = y/x;
    write(x);
    write(y);
}
```

{% responsive_image path: 'assets/12_flowChart-2.png' %}


Prendendo come Test i casi $<0,5>$ e $<5,-5>$ soddisfo al 100% il criterio di copertura delle condizioni (`x!=0` è falsificato da $<0,5>$ e verificato da $<5,-5>$, mentre `y>0` è verificato da $<0,5>$ e falsificato da $<5,-5>$), ma la decisione è sempre vera.

Ci sono quindi anomalie sia alla riga 6 (possibile divisione per 0) che alla riga 8(Overflow e divisione per 0), ma quelle alla riga 8 non verrebbero scoperte dato che non viene coperta.

### Criterio di copertura delle decisioni e condizioni

È intuitivamente l'intersezione del Criterio di copertura delle decisioni con quello di copertura delle condizioni.

### Criterio di copertura delle condizioni composte

Un test T soddisfa il criterio di copertura delle condizioni composte se e solo se ogni possibile composizione delle condizioni base vale sia vero che falso per diversi casi di test in T

Si noti come questo criterio comporti il precedente (Criterio di copertura delle decisioni e condizioni)

Data la natura combinatoria di questo criterio, all'aumento del numero di condizioni di base il numero di casi di test cresce __troppo rapidamente__. Inoltre dato che le condizioni di base potrebbero non riusltare indipendenti tra loro, potrebbero esistere combinazioni non fattibili che non sarebbe opportuno testare.

### Criterio di copertura delle condizioni e delle decisioni modificate

Ci si è accorti che certe combinazioni sono "più vicine o più lontane ad altre": se modificando una sola condizione base riesco a modificare la decisione, allora quella modifica è una modifica molto significativa indipendentemente da quanto sia grande. Se invece la decisione rimane la stessa, posso ipotizzare che quella modifcia sia più neutra e meno significativa.

Si va quindi a dare importanza, nella selezione delle combinazioni, al fatto che la modifica di una singola condizione base porti a modificare la decisione. Per ogni condizione base devono quindi esistere 2 casi di test che modificano il valore di una sola condizione base e che modificano il valore della decisione

È inoltre dimostrabile che se ho $N$ condizioni base sono sufficienti $N+1$ casi di test per coprire il criterio.

