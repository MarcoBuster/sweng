---
layout: post
title: "[12] Verifica e convalida"
date:   2022-11-23 14:30:00 +0200
toc: true
---

# Terminologia

## Verifica e convalida

Verifica e convalida sono due termini con un significato apparentemente molto simile ma che celano in realtà una differenza non banale tra loro:
- per _verifica (della correttezza)_ si intende l'attività di confronto del software con le __specifiche__ (formali) prodotte dall'analista;
- per _convalida (dell'affidabilità)_ si intende l'attività di confronto del software con i __requisiti__ (informali) posti dal committente.

Ci sono quindi due punti critici che vanno a sottolineare maggiormente questa differenza:
- requisiti e specifiche sono spesso __formulati diversamente__.
Solitamente i _requisiti_, essendo scritti dal committente, sono formulati in un linguaggio più vicino al dominio di quest'ultimo.
Diversamente, le _specifiche_ sono scritte in un linguaggio più vicino al dominio dello sviluppatore, spesso in maniera formale e poco ambigua;
- è facile che i requisiti __cambino__ in corso d'opera mentre le specifiche rimangano congelate; questo aspetto dipende molto dai contratti tra committente e il team di sviluppo.

La definizione dei _requisiti_ forniti dal cliente è immediata ma informale: scrivere dei test che li _convalidano_ può risultare molto complicato.
Invece, è più semplice validare le _specifiche_ attraverso test in quanto sono scritte dal team di sviluppo e sono quindi più formali e complete.

Ad ogni modo, nelle attività di verifica e convalida si cercano degli __errori__, ma la parola "errore" stessa può assumere molti significati a seconda del contesto.
È quindi importante capire di quale _errore_ si sta parlando, introducendo termini diversi, come _malfunzionamento_ e _difetto_.

N.B: Esistono dei glossari e vocabolari di terminologia comune redatti dalla IEEE, ad esempio [Systems and software engineering —
Vocabulary]({{ site.baseurl }}/assets/12_ieee-vocabulary.pdf) che possono essere addottati dagli sviluppatori come standard in modo da snellire la comunicazione tra di loro.

## Malfunzionamento (guasto/failure)

Un malfunzionamento è uno __scostamento__ dal corretto funzionamento del programma.

__Non dipende dal codice__ e in generale non ci si accorge di esso osservando il codice ma solo da un punto di vista più esterno, utilizzando il programma.
Il malfunzionamento potrebbe riguardare sia le specifiche (quindi relativo alla fase di _verifica_) che i requisiti (fase di _convalida_, ovvero "non rispetta le aspettative").
Secondo il vocabolario citato in precedenza:

> __failure:__ 
> 1. termination of the ability of a product to perform a required function or its inability to perform within previously specified limits.
ISO/IEC 25000:2005, Software Engineering — Software product Quality Requirements and Evaluation (SQuaRE) — Guide to SQuaRE.4.20.
> 2. an event in which a system or system
component does not perform a required function within specified limits.
> 
>_NOTE: A failure may be produced when a fault is encountered_

### Esempio

Di seguito è illustrato un esempio di malfunzionamento.
```java
static int raddoppia(int par) {
    int risultato;
    risultato = (par * par);
    return risultato;
}

static void main(String[] args) {
    int risultato = raddoppia(3);
    System.out.println(risultato);  // 9
}
```
La funzione dovrebbe ritornare il doppio del numero in ingresso, ma se passiamo 3 in argomento verrà ritornato 9.

## Difetto (anomalia/fault)
Un difetto è il __punto del codice__ che causa il verificarsi del malfunzionamento.

È __condizione necessaria__ (ma non sufficiente) per la verifica di un malfunzionamento.

> __fault:__
> 1. a manifestation of an error in software.
> 2. an incorrect step, process, or data definition in a computer
program. 
> 3. a defect in a hardware device or component. Syn: bug
> 
> _NOTE: A fault, if encountered, may cause a failure._

Nell'esempio di codice precedente, il difetto è in `risulato = (par * par)`.

Il _difetto_ è condizione _non sufficiente_ per il verificarsi di un _malfunzionamento_: ad esempio, __non si verificano malfunzionamenti__ in caso l'argomento passato sia 0 oppure 2.
Il raddoppio in quei casi avverrebbe in maniera corretta. 

Un altro esempio di tale è proprietà è il caso in cui esistono _"più anomalie che si compensano"_: se si sta utilizzando una libreria per operazioni su temperature in gradi Fahrenheit, ponendo il caso che stia partendo da gradi Celsius, dovrà essere effettuata una conversione.
Se in questa conversione è presente un'anomalia che però si riflette allo stesso modo in fase di riconversione per restituire il risultato, le due anomalie combinate non si manifestano in un malfunzionamento.

## Sbaglio (mistake)

Uno sbaglio è la causa di un’anomalia. 
Si tratta in genere di un errore umano.

>__mistake:__
>1. a human action that produces an incorrect result
> 
>_NOTE: The fault tolerance discipline distinguishes between a human action (a mistake), its manifestation (a hardware
or software fault), the result of the fault (a failure), and the amount by which the result is incorrect (the error)._


Relativamente all'esempio precedente, possibili sbagli possono essere:
- __errori di battitura__ (scrivere `*` invece di `+`);
- __concettuali__ (non sapere cosa vuol dire _raddoppiare_);
- relativi alla __padronanza del linguaggio__ (credere che `*` sia il simbolo dell’addizione).

### Esempio notevole: _il caso Ariane 5_

<iframe width="560" height="315" src="https://www.youtube.com/embed/PK_yguLapgA?start=67" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[Wikipedia: Ariane 5 notable launches](https://en.wikipedia.org/wiki/Ariane_5#Notable_launches 'Ariane 5 - Notable Launches')

Il 4 giugno 1996 il primo volo di prova del razzo Ariane 5 è fallito a causa di un problema al software di controllo che ha portato all'autodistruzione del missile.

Il _malfunziamento_ è palese: il razzo è esploso e chiaramente non era il comportamento richiesto.

Qual era l'_anomalia_? Il malfunziamento si è verificato per una eccezione di overflow, sollevatosi durante una conversione da un 64 bit float a un 16 bit signed int che indicava il valore della velocità orizzontale. 
Questo ha bloccato sia l'unità principale che il backup dell'unità stessa.

Lo _sbaglio_? Tale eccezione non veniva gestita perché questa parte del software era stata ereditata da Ariane 4, modello di razzo antecedente a Ariane 5, la cui traiettora faceva sì che non si raggiungessero mai velocità orizzontali non rappresentabili con int 16 bit. 
La variabile incriminata non veniva protetta per gli _"ampi margini di sicurezza"_ (a posteriori, non così ampi).

Il comportamento della variabile non era mai stato analizzato con i dati relativi alla traiettoria da seguire.

# Tecniche di verifica e convalida
## Classificazione delle tecniche

Nell'ambito della _verifica e convalida_ è possibile le tecniche di analisi in due categorie:
- __tecniche statiche__, basate sull'analisi degli elementi sintattici del codice. \\
Ad esempio: metodi formali, analisi del dataflow e modelli statistici;
- __tecniche dinamiche__, basate sull'esecuzione del programma eseguibile. \\
Ad esempio: testing e debugging.

In generale, __è più facile determinare tecniche dinamiche__ rispetto alle tecniche statiche.
Per contro, una volta ideate le __tecniche statiche sono più veloci__ nell'analizzare il codice e più complete dato che le tecniche dinamiche lavorano sui possibili stati del programma - che possono essere infiniti.

Come si possono confrontare queste tecniche?

{% responsive_image path: 'assets/12_classificazione-tecniche-di-verifica-e-convalida.jpg' %}

Nell'immagine sopra è possibile osservare una _piramide immaginaria a 3 dimensioni_ che riassume dove si posizionano le tecniche di verifica e convalida relativamente le une con le altre.
La cima della piramide rappresenta il __punto ideale__ a cui tendere, nel quale è possibile affermare di esser riusciti a verificare perfettamente una proprietà arbitraria attraverso una prova logica (dal lato statico) o una ricerca esaustiva su tutti gli stati del problema (dal lato dinamico).

Tale punto ideale è __praticamente impossibile__ da raggiungere per la stragrande maggioranza dei problemi che siamo interessati a risolvere. 
Bisogna scegliere da quale versante iniziare la scalata della piramide: __lato verde__ (con uno statico) o __lato blu__ (con un approccio dinamico)?

Più ci si posiziona verso il basso, più si degenera in:
- __estrema semplificazione delle proprietà__ (in basso a sinistra): si stanno in qualche modo _rilassando_ eccessivamente gli obiettivi che si vogliono raggiungere.

    Ad esempio, se si vuole dimostrare che si sta usando un puntatore in maniera corretta e nel farlo si sta semplicemente controllando che non valga `null`, è _cambiata_ la proprietà che si vuole come obiettivo (controllare che un puntatore non valga `null` __non significa che__ lo si stia usando nel modo corretto);
- __<span id="innaccuratezza_pessimistica">estrema inaccuratezza pessimistica</span>__ (in basso al centro): è dovuta all'approccio pessimistico che ha come mantra:
> _"Se non riesco a dimostrare l'assenza di un problema assumo che il problema sia presente"_

    Ad esempio, si manifesta nei compilatori quando non riescono a dimostrare che una determinata funzione ritorni un valore per tutti i possibili cammini (magari perchè i `return` sono compresi in un costrutto ```if  else if```);
- __estrema <span id="innaccurettezza_ottimistica">inaccuratezza ottimistica</span>__ (in basso a destra): è dovuta all'approccio ottimistico che ha come mantra:
> _"Se non riesco a dimostrare la presenza di un problema assumo che questo non sia presente"_

    È una possibile deriva degli approcci legati al testing: con esso si cercano malfunzionamenti, se a seguito dei test non ne vengono trovati allora si assume che il programma funzioni correttamente.

## Metodi formali

L'approccio dei metodi formali tenta di dimostrare l'_assenza_ di anomalie nel prodotto finale. \\
Si possono utilizzare diverse tecniche (spiegate nelle lezioni successive), come:
- analisi di dataflow;
- dimostrazione di correttezza delle specifiche logiche.

Questo approccio soffre di _<a href="#innaccuratezza_pessimistica">inaccuratezza pessimistica</a>_.

## Testing

Il testing è l'insieme delle tecniche che si prefiggono di rilevare malfunzionamenti. \\
Attraverso il testing non si può dimostrare la correttezza ma solo aumentare la _fiducia_ dei clienti rispetto all'affidabilità del prodotto.

Le tecniche di testing possono essere molto varie e si raggruppano in:
- __white box__: si ha accesso al codice da testare e si possono cercare anomalie guardandolo da un punto di vista interno;
- __black box__: non si ha accesso al codice ma è possibile testare e cercare malfunzionamenti tramite le interfacce esterne;
- __gray box__: non si ha accesso al codice ma si ha solo un'idea dell'implementazione ad alto livello. \\
Per esempio, in un modello <big>M</big>ODEL <big>V</big>IEW <big>C</big>ONTROLLER ci si può aspettare che certe stimilazioni portino a chiamate al database mentre altre no.

Questo approccio soffre di _<a href="#innaccuretezza_ottimistica">inaccuratezza ottimistica</a>_.

## Debugging

Dato un _programma_ e un _malfunzionamento noto_, il debugging permette di localizzare le _anomalie_ che causano malfunzionamenti.
A differenza del testing, infatti, è richiesta la conoscenza a priori di un malfunzionamento prima di procedere con il debugging.

Molto spesso viene usato il debugging al posto del __testing__, almeno a livello di terminologia: questo è un problema perché il debugging non è fatto per la "grande esecuzione" ma al contrario per esaminare in maniera granulare (a volte anche passo passo per istruzioni macchina) una determinata sezione dell'esecuzione con lo scopo di trovare l'anomalia che provoca un malfunzionamento.
Se si usassero le tecniche di debugging per effettuare il testing il tempo speso sarebbe enorme.

Due possibili approcci al debugging sono:
- partendo da una malfunzionamento _noto_ e _riproducibile_ si avvia una procedura di analisi basata sulla __produzione degli stati intermedi__ dell'esecuzione del programma: _passo passo_ (a livello a piacere, da istruzione macchina a chiamata di funzione) si controllano tutti gli stati di memoria alla ricerca di uno inconsistente;
- ___divide-et-impera___: il codice viene smontato sezione per sezione e componente per componente in modo da poter trovare il punto in cui c'è l'anomalia. 
Si possono mettere breakpoint o _"print tattiche"_.
