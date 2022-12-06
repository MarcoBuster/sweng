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

Dato un programma e un malfunzionamento noto, il debugging è una tecnica che ci permette di localizzare le __anomalie__ che causano malfunzionamenti.

## Correttezza

Quando un programma si definisce corretto?

- consideriamo un generico programma $$P$$ come una funzione da un insieme di dati $$D$$ (dominio) a un insieme di dati $$R$$ (codominio);
- $$P(d)$$ indica l'esecuzione di $$P$$ su un dato in ingresso $$d \in D$$;
- il risultato $$P(d)$$ è corretto se soddisfa le specifiche, altrimenti è scorretto;
- $$\operatorname{ok}(P, \, d)$$ indicherà la correttezza di $$P$$ per il dato $$d$$;

allora...

$$
P \text{ è } \textit{corretto} \Leftrightarrow \forall d \in D \: \operatorname{ok}(P, \, d)
$$

### Test

- un test $$T$$ per un programma $$P$$ è un sottoinsieme del dominio $$D$$;
- un elemento $$t$$ di un test $$T$$ è detto _caso di test_;
- l'esecuzione di un test consiste nell'esecuzione del programma $$\forall t \in T$$;
- un programma __passa__ o __supera__ un test:

$$
\operatorname{ok}(P, \, T) \Leftrightarrow \forall t \in T \: \operatorname{ok}(P, \, t)
$$

- un test $$T$$ ha successo se rileva uno o più malfunzionamenti presenti nel programma $$P$$

$$
\operatorname{successo}(T, \, P) TODO  
$$

#### Test ideale

$$T$$ è _ideale_ per $$P$$ se e solo se $$\operatorname{ok}(P, \, T) \Rightarrow \operatorname{ok}(P, \, D)$$ cioè se il superamento del test implica la correttezza del programma.

In generale, è __impossibile trovare un test ideale__.

> Il test di un prorgamma può rilevare la presenza di malfunzionamenti ma non dimostrarne l'assenza
> 
> ~ __Tesi di Dijkstra__

Non esiste quindi un algoritmo che dato un programma arbitrario $$P$$ generi un test ideale finito (il caso $$T = D$$ non va considerato).

```java
class Trivial {
    static int sum(int a, int b) {
        return a + b;
    }
}
```

Perché è impossibile trovare un test ideale esaustivo? 

In Java un int è espresso su 32 bit, quindi il dominio ha di cardinalità $$ 2^{32} \cdot 2^{32} = 2^{64} \sim 2 \cdot 10^{19}$$.
Considerando un tempo di 1 nanosecondo per ogni test, ci dovremmo mettere più di 600 anni.

#### Criterio di selezione

Come faccio a scegliere un sottoinsieme del dominio _intelligente_ cercando di approssimare il test ideale? 

Un _criterio di selezione_ si dice __affidabile__ se presi due test $$T_1$$ e $$T_2$$ in base al criterio $$C$$ allora o entrambi hanno sucecsso o nessuno dei due ha successo.

$$
\operatorname{affidabile}(C, \, P) \Leftrightarrow [\forall T_1 \in C, \, \forall T_2 \in C \: \operatorname{successo}(T_1, \, P) \Leftrightarrow \operatorname{successo}(T_2, P)]
$$

... __valido__ se qualora $$P$$ non sia corretto, allora esiste almeno un test $$T$$ selezionato in base al criterio $$C$$ che ha successo per il programma $$P$$

$$
\operatorname{valido}(C, \, P) \Leftrightarrow (\lnot \operatorname{ok}(P, \, D) \Rightarrow \exists T \in C ..................)
$$

__Esempio__: dato il codice
```java
static int raddoppia(int par) {
    int risultato;
    risultato = (par * par);
    return risultato;
}
```
un criterio che seleziona...
- _"sottoinsiemi di $$\{0, \, 2\}$$"_ è ___affidabile__ ma non valido_;
- _"i sottoinsiemi di $$\{0, \, 1, \, 2, \, 3, \, 4\}$$"_ è _non affidabile ma __valido___;
- _"sottoinsieme finiti di $$D$$ con almeno un valore maggiore di $$18$$"_ è ___affidabile e valido___.... 

    ma siamo davvero sicuri????

<!-- aggiungere slide 65 (osservazioni) -->

<!-- caratteristiche caso di test (slide 67) -->

<!-- anche slide 66 -->

<!-- e 68 -->

Un test $$T$$ soddisfa il criterio di __copertura dei comandi__ se e solo se ogni comando eseguibile del programam è eseguito in corrispondenza di almeno un caso di test $$t \in T$$.

Notare: nella definizione si parla di _comandi eseguibili_, ovvero la frazione di comandi eseguiti su quelli eseguibili.
    


## Statico vs Dinamico

- Le tecniche statiche sono basate sull’ANALISI DEL CODICE
    - Modelli formali
    - Analisi del dataflow
    - Modelli statistici
    - In pratica andiamo ad analizzare il codice a priori
- Tecniche dinamiche sono basate sull’esecuzione del codice e dagli stati raggiungibili durante l’esecuzione
    - Testing
    - Debugging
    - Si cerca di provare tutti gli stati possibili
        - Ma questo a volte non è possibile perché il numero può esplodere

## CLASSIFICAZIONE delle tecniche

≤≤ Disegno di una piramide>>

## Metodi Formali

- Tecniche che si prefiggono di provare l’assenza di anomalie nel prodotto finale

Ad esempio:

- Analisi del dataflow
- Dimostrazione di correttezza delle specifiche logiche

***INACCURATEZZA PESSIMISTICA: se non si riesce a dimostrare l’assenza di un problema dico che non va bene***

## Testing

- Tecniche che si prefiggono di rilevare malfunzionamenti O fornire fiducia nel prodotto
    - **WhiteBox**
        - Posso testare vedendo il componente in maniera trasparente
    - **BlackBox**
        - Non posso testare vedendo il componente al suo interno. Vedo solo input e output.
    - **GrayBox**
        - Conosco ‘a metà’

***********************************************************************************************************************************************************************INACCURATEZZA OTTIMISTICA: se non si riescono a dimostrare la presenza di problemi dico che va bene***********************************************************************************************************************************************************************

## Debugging

- Tecniche che si prefiggono di localizzare le anomalie che causano malfunzionamenti rilevati in precedenza
    - Approccio incrementale: permette di limitare la parte in cui ricercare il difetto
    - Produzione degli stati intermedi dell’esecuzione del programma

# Correttezza di un programma

- Consideriamo un programma $P$ come una funzione da un insieme di dati $D$ (dominio) a un insieme di dati $R$ (codominio)
- $P(d)$ indica l’esecuzione di $P$ sul dato in ingresso $d \in D$
- $ok(P,D)$  indica la correttezza di $P$ per il dato $d$

$P$  è corretto $\iff$ [……]

Qui iniziamo con un po’ di formalità, recupera.

## Test ideale:

diciamo che un test è ideale sse il superamento del test implica la correttezza del programma.

**************************Generalmente è impossibile trovare un test ideale.**************************

### Tesi di Dijkstra

- Il test di un programma può rilevare la presenza di malfunzionamenti
- Non esiste un algoritmo che dato un programma arbitrario P generi un …………….

Dato che è improponibile eseguire esaustivamente tutti i test possibili, devo avere dei criteri di selezione dei test che spero approssimi il più possibile al test ideale

### Criterio affidabile

Si dice affidabile un criterio che se presi T1 e T2 in base al criterio C allora o hanno entrambi successo o nessuno dei due ha successo

### Criterio di validità

Un criterio C si dice valido se qualora P non sia corretto allora esiste almeno un T selezionato in base a C che ha successo per il programma P

**************************************************************************************************************************************************************Se un criterio è valido e affidabile allora se un test appartenente al criterio passa implica che il programma sia corretto**************************************************************************************************************************************************************

Ma SAPPIAMO che questo non è possibile.

## Quindi come ragioniamo?

Un caso di test per poter portare a evidenziare un malfunzionamento causato da una anomalia deve soddisfare tre requisiti:

1. eseguire il comando che contiene l’anomalia
2. l’esecuzione del comando contenente l’anomalia deve portare il sistema in uno stato scorretto
3. lo stato scorretto deve propagarsi fino all’uscita del codice in esame, in modo da produrre un output

[…….]

In pratica dobbiamo capire quanto “coprire” i casi che possiamo testare.

Devo decidere quando smettere, quali test è opportuno aggiungere e come confrontare la bontà di test differenti.

### Copertura dei comandi:

**Un test T soddisfa il criterio di copertura dei comandi sse ogni comando eseguibile del programma è eseguita in corrispondenza di almeno un caso di test t contenuto in T.**

### Copertura delle decisioni

**Un test T soddisfa il criterio di copertura delle decisioni sse ogni decisione effettiva viene resa sia vera che falsa[…]**

La metrica è la frazione delle decisioni che sono state rese sia vere che false su quele per cui è possibile farlo.

⚠️Copertura delle decisioni ⇒ Copertura dei comandi ⚠️

### To be continued…