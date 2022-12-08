---
layout: post
title: "[12] Verifica e Convalida - Introduzione"
date:   2022-11-23 14:30:00 +0200
toc: true
---

# Terminologia

## Verifica e convalida

Verifica e convalida sono due termini con un significato apparentemente molto simile ma che celano in realtà una differenza non banale tra loro:

>Per _convalida_ intendiamo il confronto del software con i __requisiti__ (informali) posti dal committente

>Per _verifica_ intendiamo il confronto del software con le __specifiche__ (formali) prodotte dall'analista

Ci sono quindi due punti critici che vanno a sottolineare maggiormente questa differenza:

- Requisiti e specifiche sono spesso formulati in maniera diversa
    - Molto spesso i requisiti, essendo scritti dal committente, sono scritti in un linguaggio più vicino al dominio di quest'ultimo piuttosto che di uno sviluppatore. Diversamente, le specifiche sono scritte in un linguaggio più vicino al dominio dello sviluppatore, solitamente in maniera formale (ma non sempre), sicuramente in maniera poco ambigua

- I requisiti è facile che cambino, mentre le specifiche sono più congelate (dipende però molto dai contratti tra committente e team di sviluppo)

Più in generale, possiamo dire che se la parte di formalizzazione è più difficile a favore di un'operazione di confronto con il test più semplice per quanto riguarda la _verifica_, per nella _convalida_ è l'inverso (ovvero, non essendoci alcuna formalizzazione è tipicamente più difficile confrontare il proprio software direttamente con i requisiti del committente)

Ad ogni modo, nelle attività di verifica e convalida andiamo a cercare degli _errori_, ma la parola "errore" stessa può assumere molti significati a seconda del contesto. Diventa quindi importante capire di quale errore stiamo parlando, andando ad introdurre termini diversi (N.B: esistono dei glossari e vocabolari di terminologia comune redatti dalla IEEE, ad esempio [Systems and software engineering —
Vocabulary](http://pros.lib.unimi.it/login?url=https://ieeexplore.ieee.org/document/5733835 'Systems and software engineering —
Vocabulary') (da accedere usando le credenziali di ateneo) che possono essere addottati dagli sviluppatori come standard in modo da snellire la comunicazione tra di loro).

## Malfunzionamento (guasto/failure)

È lo scostamento da quello che dovrebbe essere il corretto funzionamento di un programma. Non dipende dal codice e in generale non mi accorgo di esso osservando il codice, ma da un punto di vista più esterno, ovvero utilizzando il programma. Potrebbe essere sia un malfunzionamento rispetto le specifiche (quindi riguardante la fase di verifica, ovvero la correttezza vera e propria) sia un malfunzionamento riguardante i requisiti (quindi riguardante la fase di verifica, ovvero che "non rispetta le aspettative"). Secondo l'_ISO/IEC/IEEE International Standard - Systems and software engineering -- Vocabulary_:

> __failure:__ 
>1. termination of the ability of a product to perform a required function or its inability to perform within
previously specified limits. ISO/IEC 25000:2005, Software Engineering — Software product Quality
Requirements and Evaluation (SQuaRE) — Guide to SQuaRE.4.20.
>2. an event in which a system or system
component does not perform a required function within specified limits

>_NOTE: A failure may be produced when a fault is encountered_

### Esempio di malfunzionamento:
```java
static int raddoppia (int par) {
    int risultato;
    risultato = (par * par);
    return risultato;
} 
```
la funzione dovrebbe ritornare il doppio del numero in ingresso, ma se passiamo 3 in argomento verrà ritornato 9.


## Difetto (anomalia/fault)
È il punto del codice che causa il verificarsi del malfunzionamento.
È legato al codice ed è condizione necessaria (ma non sufficiente) perché si verifichi un malfunzionamento.
Nell'esempio del codice precedente, il difetto è la linea 3.
Abbiamo detto che è condizione non sufficiente per il verificarsi di un malfunzionamento: ad esempio sempre sfruttando l'esempio precedente, pur essendo presente l'anomalia a linea 3 il malfunzionamento non si verifica nei casi in cui l'argomento passato sia 0 o 2. Il raddoppio in quei casi avverrebbe in maniera corretta. Altri esempi invece possono essere "più anomalie che si compensano": se sto utilizzando una libreria per operazioni su temperature in gradi Fahrenheit, ponendo il caso che stia partendo da gradi Celsius, dovrò effettuare una conversione. Se in questa conversione ho un'anomalia che però si riflette allo stesso modo quando riconverto per restituire il risultato, le due anomalie combinate non si manifestano in un malfunzionamento.

> __fault:__
>1. a manifestation of an error in software.
>2. an incorrect step, process, or data definition in a computer
program. 3. a defect in a hardware device or component. Syn: bug

>_NOTE: A fault, if encountered, may cause a failure._

## Sbaglio (Mistake)

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

# Tecniche di verifica o convalida: statiche vs dinamiche

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

## Metodi formali

L'approccio dei metodi formali tenta di dimostrare l'_assenza_ di anomalie nel prodotto finali.
Posso utilizzare, per esempio:
- analisi di dataflow
- dimostrazione di correttezza delle specifiche logiche.

Soffrono di _semplificazione delle proprietà_

## Testing

Il testing è l'insieme delle tecniche che si prefiggono di rilevare malfunzionamenti o, nel caso questi non vengano trovati, aumentare la fiducia nel prodotto.

Attraverso il testing non può dimostrare la correttezza ma solo aumentare la fiducia.

Esistono diversi tipi di testing:
- __white box__: abbiamo accesso al codice da testare e possiamo cercare anomalie guardandolo da un punto di vista interno.
- __black box__: non abbiamo accesso al codice ma è possibile testare e cercare malfunzionamenti tramite le interfacce esterne.
- __gray box__: non abbiamo accesso al codice ma solo un'idea dell'implementazione ad alto livello. Per esempio in un modello Model View Controller ci possiamo aspettare che certe stimolazioni portino a chiamate al database mentre altre no.

L'approccio del testing soffre di _inaccuratezza pessimistica_

## Debugging

Se il testing ha come compiito di scoprire un malfunzionamento dato un programma, il debugging invece, dato un programma e un malfunzionamento noto, ci permette di localizzare le _anomalie_ che causano malfunzionamenti.

Molto spesso viene usato il debugging al posto del testing, almeno a livello di terminologia: questo è un problema perché il debugging non è fatto per la "grande esecuzione" ma al contrario per esaminare in maniera granulare (a volte anche passo passo per istruzioni macchina) una determinata sezione dell'esecuzione allo scopo trovare l'anomalia che provoca un malfunzionamento. Se si usassero le tecniche di debugging per effettuare il testing il tempo speso sarebbe enorme.

Possiamo portare ad esempio 2 possibili approcci per il debugging:

- Produzione degli stati intermedi dell'esecuzione del programma:
    - Devo partire quindi da un malfunzionamento che deve essere __noto__ e __riproducibile__ in modo da poter avviare una procedura di analisi.
- Divide et impera:
    - Smonto il codice sezione per sezione, componente per componente in modo da poter trovare il punto in cui c'è l'anomalia