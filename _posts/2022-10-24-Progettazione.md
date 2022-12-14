---
layout: post
title: "[07] Progettazione"
date:   2022-10-24 14:30:00 +0200
toc: true
---

# Progettazione

## Introduzione

Durante le lezioni, per discutere di progettazione siamo partiti da un esempio di programma in C che stampa una canzone.
Il [codice considerato](https://paste.studentiunimi.it/paste/JS+VOUKO#Rj3CMN-TmbNu3zeTleTTM0JdjjROWeVySXTgzG6aWKY) è talmente illeggibile che Jekyll rifiuta di compilare se lo si prova ad includere in un file Markdown.

Successivamente abbiamo scomposto il codice per renderlo logicamente più sensato e facilmente modificabile, sono state __estratte le parti comuni__ e spostate in una funzione apposita, mentre le __parti mutabili sono state salvate in alcune strutture dati__; la canzone viene così stampata tramite un ciclo. 
In questo modo scrivendo un codice più semplice siamo stati in grado di creare una soluzione più generale e più aperta ai cambiamenti.

```java
public class TwelveDaysOfChristmas {
    static String[] days = {"first", "second", ..., "twelfth"};
    static String[] gifts = { "a partdrige in a pear tree", "two turtle doves", ... };

    static String firstLine(int day) {
        return "On the " + days[day] +
               " day of Christmas my true love gave to me:\n";
    }

    static String allGifts(int day) {
        if (day == 0) {
            return "and " + gifts[0];
        } else {
            return gifts[day] + "\n" + allGifts(day-1);
        }
    }

    public static void main(String[] args) {
        System.out.println(firstLine(0));
        System.out.println(gifts[0]);
        for (int day == 1; day < 12; day++) {
            System.out.println(firstLine(day));
            System.out.println(allGifts(day));
        }
    }
}
```

È importante quindi __adottare la soluzione più semplice__ (che __non è quella più stupida__!) e una misura convenzionale per dire quanto una cosa è semplice - almeno in Università - si esprime in termini del tempo dedicato dal programmatore all'implementazione.
Tale misura si sposa bene con il __TDD__, che richiede __brevi iterazioni__ di circa 10 minuti: se la feature attuale richiede più tempo è opportuno ridurre la portata scomponendo il problema.

## Refactoring
Durante il refactoring è opportuno rispettare le seguenti regole:
- le __modifiche al codice non devono modificare le funzionalità__:
il refactoring DEVE essere invisibile al cliente;
- __non possono essere aggiunti test aggiuntivi__ rispetto alla fase verde appena raggiunta.

Se la fase di refactoring sta richiedendo troppo tempo allora è possibile fare rollback all'ultima versione verde e __pianificare meglio__ l'attività di refactoring, per esempio scomponendolo in più step.
Vale la regola del _"do it twice"_: il secondo approccio a un problema è solitamente più veloce e migliore.

### Motivazioni

Spesso le motivazioni dietro un refactoring sono:
- precedente __design molto complesso e poco leggibile__, a causa della velocità del passare ad uno _scenario verde_;
- __preparare il design di una funzionalità__ che non si integra bene in quello esistente; dopo aver raggiunto uno _scenario verde_ in una feature, è possibile che la feature successiva sia difficile da integrare. 
In questo caso, se il _refactoring_ non è banale è bene fermarsi, tornare indietro e evolvere il codice per facilitare l'iterazione successiva (__design for change__). 
- presenza di __debito tecnico__ su lavoro fatto in precendenza, ovvero debolezze e "scorciatoie" che ostacolano notevolmente evoluzioni future: _"ogni debito tecnico lo si ripaga con gli interessi"_.

## Design knowledge

La design knowledge è la __conoscenza del design__ architetturale di un progetto. 
È possibile utilizzare:
- la __memoria__: non è efficace perché nel tempo si erode, specialmente in coppia;
- i __documenti di design__ (linguaggio naturale o diagrammi): se non viene aggiornato di pari passo con il codice rimane disallineato, risultando più dannoso che d'aiuto.
- le __piattaforme di discussione__ (version control, issue management): possono aiutare ma le informazioni sono sparse in luoghi diversi e di conseguenza difficili da reperire e rimane il problema di mantenere aggiornate queste informazioni.
- gli __UML__: tramite diagrammi UML si è cercato di sfruttare l'approccio ___generative programming___, ovvero la generazione automatica del codice a partire da specificazioni di diagrammi.
Con l'esperienza si è visto che non funziona.
- il __codice__ stesso: tramite la lettura del codice è possibile capire il design ma è difficile rappresentare le ragioni della scelta.

È bene sfruttare tutte le tecniche sopra proposte __combinandole__, partendo dal codice. \
È inoltre importante scrivere documentazione per spiegare le ragioni dietro le scelte effettuate e non le scelte in sé, che si possono dedurre dal codice.

### Condivisione

Per condividere tali scelte di design (il _know how_) è possibile sfruttare:
- __metodi__: con pratiche (come Agile) o addirittura l'object orientation stessa, che può essere un metodo astratto per condividere scelte di design.
- __design pattern__: fondamentali per condividere scelte di design, sono utili anche per generare un vocabolario comune (sfruttiamo dei nomi riconosciuti da tutti per descrivere i ruoli dei componenti) e aiutano l'implementazione (i pattern hanno delle metodologie note per essere implementati). 
I pattern non si concentrano sulle prestazioni di un particolare sistema ma sulla generalità e la riusabilità di soluzioni a problemi comuni;
- __principi__: per esempio i principi SOLID.

## Conoscenze preliminari di concetti e termini

Prima di proseguire è bene richiamare concetti e termini fondamentali presumibilmente visti durante il corso di Programmazione II.

### Object orientation

Per essere definito _object oriented_, un linguaggio di programmazione deve soddisfare tre proprietà:
- __ereditarietà__: ovvero la possibilità di poter spiegare una classe come _differenza_ da un'altra classe.
- __polimorfismo__: quando una classe può assumere diverse forme in base alle interfacce che implementa. 
Il prof fa l'esempio del _tennista scacchista_: in un torneo di tennis è poco utile sostituire una persona che gioca a tennis ed è brava con gli scacchi (quindi una classe che implementa entrambe le interfacce) con una che gioca a scacchi.
Il collegamento tra capacità e oggetto è fatto __a tempo di compilazione__: non è importante quindi se la capacità non è ancora definita;
- __collegamento dinamico__: in Java il tipo concreto degli oggetti e quindi quale metodo chiamare viene risolto durante l'esecuzione. 
In C++ occorre esplicitare questo comportamento utilizzando la keyword `virtual`.

### <a style="color: darkgreen">SOLID</a> principles

Abbiamo 5 parti che compongono questo principio:
1. __<a style="color: darkgreen"><big>S</big></a>INGLE RESPONSIBILITY__: una classe, un solo scopo.
Così facendo le classi rimangono semplici e si agevola la riusabilità.
2. __<a style="color: darkgreen"><big>O</big></a>PEN-CLOSE PRINCIPLE__:
le classi devono essere aperte ai cambiamenti (_opened_) ma senza modificare le parti già consegnate e in produzione (_closed_).
Il refactoring è comunque possibile, ma deve essere preferibile estendere la classe attuale.
3. __<a style="color: darkgreen"><big>L</big></a>ISKOV SUBSTITUTION PRINCIPLE__:
c'è la garanzia che le caratteristiche eredidate dalla classe padre continuinino ad esistere nelle classi fibre.
Questo concetto si collega all'aspetto __contract-based__ del metodo Agile: le _precondizioni_ di un metodo di una classe figlia devono essere ugualmente o meno restrittive del metodo della classe padre.
Al contrario, le _postcondizioni_ di un metodo della classe figlia non possono garantire più di quello che garantiva il metodo nella classe padre.
Fare _casting_ bypassa queste regole.
4. __<a style="color: darkgreen"><big>I</big></a>NTERFACE SEGREGATION__:
più le capacità e competenze di una classe sono frammentate in tante interfacce più è facile utilizzarla in contesti differenti.
In questo modo un client non dipende da metodi che non usa. 
Meglio quindi avere __tante interfacce specifiche__ e piccole (composte da pochi metodi), piuttosto che poche, grandi e generali. 
5. __<a style="color: darkgreen"><big>D</big></a>EPENDENCY INVERSION__:
il codice dal quale una classe dipende non deve essere più __concreto__ di tale classe.
Per esempio, se il _telaio della FIAT 500_ dipende da uno specifico motore, è possibile utilizzarlo solo per quel specifico motore.
Se invece il telaio dipende da _un_ concetto di motore non c'è questa limitazione.
In conlusione, le classi concrete devono tendenzialmente dipendere da classi astratte e non da altre classi concrete.

### Reference escaping

Il _reference escaping_ è una violazione dell'incapsulamento. 

Può capitare, per esempio: 
- quando un getter ritorna un riferimento a un segreto;
```java
public Deck {
    private List<Card> cards;
        
    public List<Card> getCards() {
        return this.cards;
    }
}
```
- quando un setter assegna a un segreto un riferimento che gli viene passato;
```java
public Deck {
    private List<Card> cards;

    public setCards(List<Card> cards) {
        this.cards = cards;
    }
}
```

- quando il costruttore assegna al segreto un riferimento che gli viene passato;
```java
public Deck {
    private List<Card> cards;

    public Deck(List<Card> cards) {
        this.cards = cards;
    }
}
```

### Encapsulation e information hiding

__Legge di Parnas (L8)__.
> Solo ciò che è nascosto può essere cambiato liberamente e senza pericoli.

Lo stato mostrato all'esterno non può essere modificato, mentre quello nascosto sì.

Questo principio serve per __facilitare la comprensione del codice__ e renderne più facile la modifica parziale senza fare danni.

### Immutabilità

Una classe è immutabile quando non c'è modo di modificare lo stato di ogni suo oggetto dopo la creazione.

Per assicurare tale proprietà è necessario:
- __non fornire metodi di modifica__ allo stato;
- avere tutti gli __attributi privati__ per i tipi potenzialmente mutabili (come `List<T>`);
- avere tutti gli __attributi final__ se non già privati;
- assicurare l'__accesso esclusivo__ a tutte le parti non mutabili, ovvero non avere reference escaping.

## Code smell

I _code smell_ sono dei segnali che suggeriscono problemi nella progettazione del codice. 
Di seguito ne sono elencati alcuni:
- __codice duplicato__: si può fare per arrivare velocemente al verde ma è da togliere togliere con il refactoring. 
Le parti di codice in comune possono quindi essere fattorizzate.
- __metodi troppo lunghi__: sono poco leggibili e poco riusabili;
- __troppi livelli di indentazione__: scarsa leggibilità e riusabilità, è bene fattorizzare il codice;
- __troppi attributi__: suggerisce che la classe non rispetta la single responsability, ovvero fa troppe cose;
- __lunghe sequenze di _if-else_ o _switch___;
- __classe troppo grande__;
- __lista parametri troppo lunga__;
- __numeri _magici___: è importante assegnare alle costanti numeriche all'interno del codice un nome per comprendere meglio il loro scopo;
- __commenti che spiegano cosa fa il codice__: indicazione che il codice non è abbastanza chiaro;
- __nomi oscuri o inconsistenti__;
- __codice morto__: nel programma non deve essere presente del codice irraggiungibile o commentato. Utilizzando strumenti di versioning è possibile riaccedere a codice precedentemente scritto con facilità.
- __getter e setter__: vedi principio di __tell don't ask__.

## <a href="https://martinfowler.com/bliki/TellDontAsk.html">Principio Tell-Don't-Ask</a>

{% responsive_image path: 'assets/07_tell-dont-ask.png' %}

> Non chiedere i dati, ma dì cosa vuoi che si faccia sui dati

Il responsabile di un'informazione è anche responsabile di tutte le operazioni su quell'informazione.

Il principio tell don't ask che piuttosto di __chiedere__ ad un oggetto dei dati e fare delle operazioni con quei dati è meglio __dire__ a questo oggetto cosa fare con i dati che contiene. 

#### Esempio

Per esempio, se desideriamo stampare il contenuto di tutte le carte in un mazzo possiamo partire da questo codice.

```java
class Main {
    public static void main(String[] args) {
        Deck deck = new Deck();
        Card card = new Card();

        card.setSuit(Suit.DIAMONDS);
        card.setRank(Rank.THREE);
        deck.getCards().add(card);
        deck.getCards().add(new Card());    // <-- !!!

        System.out.println("There are " + deck.getCards().size() + " cards:");
        for (Card currentCard : deck.getCards()) {
            System.out.println(
                currentCard.getRank() + 
                " of " + 
                currentCard.getSuit()
            );
        }
    }
}
```

All'interno del ciclo reperiamo gli attributi della carta e li utilizziamo per stampare le sue informazioni.
Inoltre, nella riga evidenziata viene aggiunta una carta senza settare i suoi attributi. 
La responsabilità della gestione dell'informazione della carta è quindi __erroneamente delegata__ alla classe chiamante.

Per risolvere, è possibile trasformare la classe `Card` nel seguente modo:

```java
class Card {
    private Suit suit;
    private Rank rank;

    public Card(@NotNull Suit s, @NotNull Rank r) {
        suit = s;
        rank = r;
    }

    @Override
    public String toString() {
        return rank + " of " + suit;
    }
}
```

l'informazione viene ora interamente gestita dalla classe `Card`, che la gestisce nel metodo `toString()` per ritornare la sua rappresentazione testuale.


## Interface segregation

Le interfacce possono _"nascere"_ tramite due approcci: 
- __up front__: scrivere direttamente l'interfaccia;
- __down front__: scrivere il codice e quindi tentare di estrarne un'interfaccia.

L'approccio down-front si adatta meglio al TDD ed è illustrato nel seguente esempio.

## Esempio con gerarchia Card / Deck

In questo esempio sono trattati numerosi principi, come l'_interface segreagation_, _linking dinamico/statico_, _implementazione di interfacce multiple_ e il _contract based design_ vs la _programmazione difensiva_.

### Interface segregation all'opera

```java
public static List<Card> drawCards(Deck deck, int number) {
    List<Card> result = new ArrayList<>();
    for (int i = 0; i < number && !deck.isEmpty(); i++) {
        result.add(deck.draw());
    }
    return result;
}
```

Consideriamo il metodo `drawCards` che prende come parametri un `Deck` e un intero. \\
Le __uniche competenze__ riconosciute a `Deck` sono l'indicazione _se è vuoto_ (`isEmpty()`) e il _pescare una carta_ dal mazzo (`draw()`).
`Deck` può quindi __implementare un'interfaccia__ che mette a disposizione queste capacità.

È possibile modificare il metodo in modo da accettare un qualunque oggetto in grado di eseguire le operazioni sopra elencate, ovvero che implementi l'interfaccia __`CardSource`__. 

<a id="cardsource" style="display:none;"></a>

```java
public interface CardSource {
    /**
     * @return The next available card.
     * @pre !isEmpty()
     */
    Card draw();

    /**
     * @return True if there is no card in the source
     */
    boolean isEmpty();
}
```

```java
public class Deck implements CardSource { ... }
```

```java
public static List<Card> drawCards(CardSource deck, int number) {
    List<Card> result = new ArrayList<>();
    for (int i = 0; i < number && !deck.isEmpty(); i++) {
        result.add(deck.draw());
    }
    return result;
}
```

### Collegamento statico e dinamico

Notare come è necessario specificare __staticamente__ che `Deck` implementi `CardSource`, ovvero devo forzare la dichiarazione del fatto che `Deck` è un _sottotipo_ di `CardSource` (Java è strong typed) e quindi posso mettere un oggetto `Deck` ovunque sia richiesto un oggetto `CardSource`. \\
In altri linguaggi tipo __Go__ c'è una __maggiore dinamicità__ perché non c'è bisogno di specificare nel codice che un oggetto è sottotipo di qualcos'altro, è sufficiente solo che implementi un metodo con la stessa signature.
Il controllo che l'oggetto passato ad una funzione abbia le capacità necessarie avviene a runtime e non prima.

Un problema della troppa dinamicità (__duck typing__) è che se i metodi di un oggetto non hanno dei nomi abbastanza specifici si possono avere dei problemi. 
Per esempio, in un programma per il gioco del tennis se una funzione richiede un oggetto che implementa il metodo `play()`, e riceve in input un oggetto che non c'entra nulla con il tennis (per esempio un oggetto di tipo `GiocatoreDiScacchi`) che ha il metodo `play()`, si possono avere degli effetti indesiderati.

### _Loose coupling_
Il _loose coupling_ è la capacità di una variabile o un parametro di accettare l'assegnamento di oggetti aventi tipo diverso da quello della variabile o parametro, a patto che sia un sottotipo.

```java
Deck deck = new Deck();

CardSource source = deck;

List<Card> cards;
cards = drawCards(deck, 5);
```

### Interfacce multiple

Tornando all'esempio, la classe `Deck` (che implementa `CardSource`) __può implementare anche altre interfacce__, come `Shuffable` o `Iterable<Card>`. 
Al metodo precedente interessa solo che Deck abbia le capacità specificate in `CardSource`, se poi implementa anche altre interfaccie è ininfluente.

{% plantuml style="width:100%" %}

class Client1
class Client2
class Client3

interface Iterable<Card> << interface >> {
    + {abstract} Iterator<Card> iterator()
}

class Deck implements Iterable, Shuffable, CardSource {
    + void shuffle()
    + Card draw()
    + boolean isEmpty()
    + Iterator<Card> iterator()
}

interface Shuffable << interface >> {
    + {abstract} void shuffle()
}

interface CardSource << interface >> {
    + {abstract} Card draw()
    + {abstract} boolean isEmpty()
}

Client2 ..> Iterable
Client1 ..> Shuffable
Client3 ..> Iterable
Client3 ..> CardSource

hide empty fields
hide empty methods

{% endplantuml %}

### _Contract-based_ design vs programmazione difensiva

Tornando alla <a href="#cardsource">specificazione</a> dell'interfaccia di `CardSource`, è possibile notare dei commenti in formato Javadoc che specificano le __precondizioni__ e le __postcondizioni__ (il valore di ritorno) del metodo. Secondo il ___contract-based_ design__, esiste un _"contratto"_ tra chi implementa un metodo e chi lo chiama.

Per esempio, considerando il metodo `draw()`, __è responsabilità del chiamante__ verificare il soddisfacimento delle precondizioni (_"il mazzo non è vuoto"_) prima di invocare il metodo.
Se `draw()` viene chiamato quando il mazzo è vuoto ci troviamo in una situazione di __violazione di contratto__ e può anche esplodere la centrale nucleare.

Per specificare il contratto si possono utilizzare delle __asserzioni__ o il `@pre` nei __commenti__. 
Le prime sono particolarmenti utili in fase di sviluppo perché interrompono l'esecuzione del programma in caso di violazione, ma vengono solitamente rimosse in favore delle seconde nella fase di deployment.

Un'altro approccio è la __programmazione difensiva__ che al contrario delega la responsabilità del soddisfacimento delle precondizioni al _chiamato_, e non al chiamato. 

### Classi astratte

Una classe astratta che implementa un'interfaccia __non deve necessariamente implementarne__ tutti i metodi, ma può delegarne l'implementazione alle sottoclassi impedendo l'istanziamento di oggetti del suo tipo.

Le interfacce diminuiscono leggermente le performance, però migliorano estremamente la generalità (che aiutano l'espandibilità ed evolvibilità del programma), quindi vale la pena di perdere leggermente in efficienza.

È possibile utilizzare le __classi astratte__ anche per classi complete, ma che __non ha senso che siano istanziate__.
Un buon esempio sono le classi _utility_ della libreria standard di Java.

#### Classe utility della libreria standard di Java

Un esempio è __`Collections.shuffle(List<?> list)`__ che accetta una lista omogenea di elementi e la mischia.
Il _tipo_ degli elementi è volutamente ignorato in quanto non è necessario conoscerlo per mischiarli.

Per l'__ordinamento__, invece, è necessario conoscere il tipo degli oggetti in quanto bisogna confrontarli tra loro per poterli ordinare.
La responsabilità della comparazione è però delegata all'oggetto, che deve aderire all'interfaccia `Comparable<T>`.

__`Collections.sort(...)`__ ha, infatti, la seguente signature:
```java
public static <T extends Comparable<? super T>> void sort(List<T> list)
```

La notazione di generico __aggiunge dei vincoli__ su `T`, ovvero il tipo degli elementi contenuti nella lista:
- `T extends Comparable<...>` significa che `T` deve estendere - e quindi implementare - l'interfaccia `Comparable<...>`;
- `Comparable<? super T>` significa che tale interfaccia può essere implementata su un antenato di `T` (o anche `T` stesso).

`Comparable` è un altro esempio di _interface segregation_: serve per specificare che un oggetto ha bisogno della caratteristica di essere comparabile.

__Digressione__: la classe Collections era l'unico modo per definire dei metodi sulle interfacce (es: dare la possibilità di avere dei metodi sulle collezioni, ovvero liste, mappe, ecc), ma ora si possono utilizzare i metodi di default.

# Progettazione 2

<!-- da unire con la lezione precedente? -->


## Come si identificano le classi e le relazioni?

### Noun extraction
In questa fase vengono estratti tutti i sostantivi o frasi sostantivizzate.
...

## Esempio

// inserire testo da slide 123

## Criteri di _sfoltimento_

Dato un testo con dei sostantivi evidenziati, quali sono i criteri di sfoltimento? 

- Ridondanza: sinonimi, nomi diversi per lo stesso concetto. Nell'esempio: _library member_ e _member of the library_, _loan_ e _short term loan_. 
- Vaghezzza: nomi generici. Nell'esmepio: _items_
- Nomi di eventi e operazioni
- Metalinguaggio: per esempio, le _"rules"_ indicate sono forse meglio da considerare come configurazioni e non come classi in sé.
- Esterne al sistema. Esempio: _libreria_, _week_.
- Attributi. Per esempio, il nome del lavoratore in libreria è un attributo non una classe.

Alla fine di questa fase, avremo una lista di classi _"certe"_ e incerte (_lista grigia_).

