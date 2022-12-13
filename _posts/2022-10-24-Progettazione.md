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
Questo concetto si collega all'aspetto __contract-based__ del metodo Agile: le _pre-condizioni_ di un metodo di una classe figlia devono essere ugualmente o meno restrittive del metodo della classe padre.
Al contrario, le _post-condizioni_ di un metodo della classe figlia non possono garantire più di quello che garantiva il metodo nella classe padre.
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
I seguenti sono dei segnali che ci permettono di capire che qualcosa non va:
- Codice duplicato: Posso farlo per arrivare velocemente al verde ma poi lo devo togliere con il refactoring, siccome se ho codice duplicato vuol dire che quei pezzi di codice hanno qualcosa in comune ed è possibile fattorizzare.
- Metodi troppo lunghi: sono poco leggibili e poco riusabili.
- Troppi livelli di indentazione: anche qui abbiamo una scarsa leggibilità e riusabilità, quando ho tanti livelli di indentazione a causa di cicli per esempio è facile fattorizzare il codice.
- Troppi attributi: suggerisce che la classe non rispetta la single responsability, ovvero fa troppe cose.
- Lunghezza sequenze di _if-else_ o _switch_
- Classe troppo grande
- Lista parametri troppo lunga
- numeri _magici_: Quando si hanno delle costanti numeriche all'interno del codice non si capisce cosa rappresentano, essendo adimensionali e non danno informazioni. Allora bisogna dargli un nome per fare in modo che si capisca a cosa serve.
- Commenti: Se sono presenti vuol dire che il codice non era abbastanza chiaro.
- Nomi oscuri o inconsistenti: bisogna dare dei nomi sensati a metodi/classi/variabili.
- Codice morto: Non deve essere presente del codice irraggiungibile o commentato nel programma, perché avendo a disposizione il versioning da cui possiamo riprenderlo in caso di necessità, non è necessario averlo nel risultato finale.
- Getter e setter: Vediamo nel principio di __Tell don't ask__.

## <a href="https://martinfowler.com/bliki/TellDontAsk.html">Principio Tell-Don't-Ask</a>
Il principio tell don't ask dice che piuttosto di __chiedere__ ad un oggetto dei dati e fare delle operazioni con quei dati è meglio __dire__ a questo oggetto cosa fare con i dati che contiene, quindi per esempio piuttosto che farsi dare i dati da una classe e cercare di stampare una stringa creata con quei dati in un certo formato è meglio dire all'oggetto di utilizzare il metodo toString che ci restituisce una stringa con la rappresentazione dello stato dell'oggetto, e noi semplicemente la stampiamo.

## Chiarimento estrazione delle interfacce (interface segregation)
Queste interfacce possono nascere in due modi, tramite un approccio up front oppure down front, ovvero partendo direttamente a scrivere l'interfaccia oppure scrivendo il codice e cercare di capire successivamente se possiamo estrarre una classe (quest'ultimo modo si adatta di più al TDD).
Facciamo quindi un esempio (dal basso) per capire quando possiamo estrarre un'interfaccia.

```java
public static List<Card> drawCards(Deck deck, int number) {
    List<Card> result = new ArrayList<>();
    for (int i = 0; i < number && !deck.isEmpty(); i++) {
        result.add(deck.draw());
    }
    return result;
}
```

prendiamo per esempio un metodo drawCards che prende come parametri un deck e un intero, le uniche cose che conosciamo di deck sono che è in grado di dirci se è vuoto (isEmpty) e che sa pescare una carta dal mazzo (draw), questo ci suggerisce che Deck può implementare un'interfaccia mette a disposizione queste capacità.
Quindi è possibile modificare il codice in questo modo passando a drawCards non un deck ma un qualunque oggetto che è in grado di fare quelle due operazioni, quindi un elemento che implementa CardSource (quindi viene sfruttato il polimorfismo qui).

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

Notiamo come dobbiamo specificare __staticamente__ che Deck implementi CardSource, ovvero devo forzare la dichiarazione del fatto che Deck è un sottotipo di CardSource (java è strong typed) e quindi posso mettere un oggetto Deck ovunque sia richiesto un oggetto CardSource. 
In altri linguaggi tipo GO abbiamo una maggiore dinamicità perché non abbiamo bisogno di specificare nel codice che un oggetto è sottotipo di qualcos'altro, ci basta solo che implementi il metodo con lo stesso nome, però così facendo il check che l'oggetto passato ad una funzione che richiede un oggetto avente quelle capacità avviene a runtime e non prima.

Un problema della troppa dinamicità (duck typing) è che se i metodi che deve implementare un oggetto non hanno dei nomi abbastanza specifici possiamo avere dei problemi, per esempio in un programma per il gioco del tennis se una funzione richiede un oggetto che implementa il metodo play, e riceve in input un oggetto che non centra nulla con il tennis (per esempio un oggetto giocatoreDiScacchi) che ha il metodo play, avremo degli errori, perché è un play che fa cose diverse da quelle che ci si aspetta.

Torniamo ora all'interface segregation, ora che abbiamo visto che la classe Deck implementa l'interfaccia CardSource, nulla ci vieta di fare in modo che implementi altre interfaccie, come si vede nell'immagine sotto. Al metodo precedente interessa solo che Deck abbia le capacità viste prima e specificate in CardSource, se poi implementa anche altre interfaccie al metodo non interessa.

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

Notiamo ora nell'immagine dell'interfaccia CardSource che ci sono dei commenti javadoc, che specificano valore di ritorno e precondizioni, questo è il principio del __contract based design__, ovvero noi abbiamo un "contratto" in cui diciamo che è possibile richiamare il metodo draw solo se sono sicuro che no sia vuoto, altrimenti non garantisco il funzionamento del mio metodo, se poi chi lo usa non aderisce a questo contratto è un problema del chiamante (per specificare il contratto posso usare delle asserzioni o il @pre, la differenza è che il primo in fase di sviluppo mi avvisa se non sto rispettando il contratto, poi nella fase di deployment questi assert vengono rimossi, mentre nel secondo caso ho solo un commento, quindi non fa nessun controllo). Si potrebbe pensare che basti fare questo controllo all'interno del metodo draw ma questo sarebbe un approccio differente chiamato __programmazione difensiva__, ovvero non faccio assunzioni su ciò che mi viene dato e controllo io che l'input rispetti le condizioni di cui ho bisogno.

Abbiamo detto che una classe che implementa un'interfaccia deve implementare tutti i metodi dell'interfaccia, però abbiamo un'altra possibilità, ovvero quella di mettere la classe che implementa come classe astratta, ovvero una classe da cui non si possono istanziare oggetti.
Usando questo modo è come dire che la classe non è ancora completa, e quindi non ancora utilizzabile, però possiamo usare questo modo dell'abstract anche per classi complete ma che non ha senso che vengano istanziate. Un esempio è la classe Subject e l'interfaccia Observer di java, la classe Subject non è stata messa abstract ma non aveva alcun senso istanziarla, era necessario creare un sottotipo di Subject. Questo caso è un buon esempio di situazione in cui sarebbe stato necessario mettere la parola chiave abstract a Subject anche se era una classe completa ma non aveva senso istanziarla.

Le interfacce diminuiscono leggermente le performance, però migliorano estremamente la generalità (che aiutano l'espandibilità ed evolvibilità del programma), quindi vale la pena di perdere leggermente in efficienza.

### Esempio nella libreria standard Java
Un esempio di ciò che abbiamo visto fino ad ora è quello usato nella libreria standard di java, infatti se noi abbiamo una classe Deck che ha come attributo una lista di carte, e vogliamo mettere a disposizione un metodo che mescola il deck, ci basterà sfruttare Collections.shuffle che accetta come parametro una lista di qualcosa (List<?> list). Infatti non è necessario conoscere le carte per poterle mescolare, quindi possiamo dire che non abbiamo bisogno di sapere cosa contiene la lista per poter cambiare la loro posizione all'interno di essa.
La stessa cosa si può dire se vogliamo ordinare il mazzo di carte? no perché dobbiamo aver bisogno di un criterio per comparare gli elementi, quindi il metodo sort di collection dovrà prendere come parametro una lista di T con il vincolo che questo T estenda l'interfaccia comparable di qualcosa antenato di T (quindi T deve avere un metodo compareTo usabile, presente in T o in un suo antenato), in altre parole sort ha bisogno che gli elementi della lista da ordinare siano confrontabili tra di loro.
```java
public static <T extends Comparable<? super T>> void sort(List<T> list)
```
Comparable è un altro esempio di interface segregation, è un'interfaccia tirata fuori per specificare che un oggetto ha bisogno della caratteristica di essere comparabile.

Digressione: la classe Collections era l'unico modo per definire dei metodi sulle interfacce (es: dare la possibilità di avere dei metodi sulle collezioni, ovvero liste, mappe, ecc), questo andrà a sparire siccome ora esistono i metodi di default.

## polimorfismo e loose coupling
Passando ora al polimorfismo vediamo come viene affiancato dal concetto di __loose coupling__, ovvero la capacità di una variabile o parametro di accettare l'assegnazione di oggetti aventi tipo diverso da quello della variabile/parametro, a patto però che sia un sottotipo.

```java
Deck deck = new Deck();

CardSource source = deck;

List<Card> cards;
cards = drawCards(deck, 5);
```
