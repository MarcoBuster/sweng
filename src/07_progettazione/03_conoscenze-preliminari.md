# Conoscenze preliminari

Prima di proseguire è bene richiamare concetti e termini fondamentali presumibilmente visti durante il corso di Programmazione II.

## Object orientation

Per essere definito _object oriented_, un linguaggio di programmazione deve soddisfare tre proprietà:
- __ereditarietà__: ovvero la possibilità di poter definire una classe ereditando proprietà e comportamenti di un'altra classe.
- __polimorfismo__: quando una classe può assumere diverse forme in base alle interfacce che implementa. 
Il prof fa l'esempio del _tennista scacchista_: in un torneo di tennis è poco utile sostituire una persona che gioca a tennis ed è brava con gli scacchi (quindi una classe che implementa entrambe le interfacce) con una che gioca a scacchi.
Il collegamento tra capacità e oggetto è fatto __a tempo di compilazione__: non è importante quindi se la capacità non è ancora definita;
- __collegamento dinamico__: in Java il tipo concreto degli oggetti e quindi il problema di stabilire _quale metodo chiamare_ viene risolto durante l'esecuzione. 
In C++ occorre esplicitare questo comportamento utilizzando la keyword `virtual`.

## <a style="color: darkgreen">SOLID</a> principles

Ci sono 5 parti che compongono questo principio:
1. __<span style="color: darkgreen"><big>S</big></span>INGLE RESPONSIBILITY__: una classe, un solo scopo.
Così facendo, le classi rimangono semplici e si agevola la riusabilità.
2. __<span style="color: darkgreen"><big>O</big></span>PEN-CLOSE PRINCIPLE__:
le classi devono essere aperte ai cambiamenti (_opened_) ma senza modificare le parti già consegnate e in produzione (_closed_).
Il refactoring è comunque possibile, ma deve essere preferibile estendere la classe attuale.
3. __<span style="color: darkgreen"><big>L</big></span>ISKOV SUBSTITUTION PRINCIPLE__:
c'è la garanzia che le caratteristiche eredidate dalla classe padre continuinino ad esistere nelle classi figlie.
Questo concetto si collega all'aspetto __contract-based__ del metodo Agile: le _precondizioni_ di un metodo di una classe figlia devono essere ugualmente o meno restrittive del metodo della classe padre.
Al contrario, le _postcondizioni_ di un metodo della classe figlia non possono garantire più di quello che garantiva il metodo nella classe padre.
Fare _casting_ bypassa queste regole.
4. __<span style="color: darkgreen"><big>I</big></span>NTERFACE SEGREGATION__:
più le capacità e competenze di una classe sono frammentate in tante interfacce più è facile utilizzarla in contesti differenti.
In questo modo un client non dipende da metodi che non usa. 
Meglio quindi avere __tante interfacce specifiche__ e piccole (composte da pochi metodi), piuttosto che poche, grandi e generali. 
5. __<span style="color: darkgreen"><big>D</big></span>EPENDENCY INVERSION__:
il codice dal quale una classe dipende non deve essere più __concreto__ di tale classe.
Per esempio, se il _telaio della FIAT 500_ dipende da uno specifico motore, è possibile utilizzarlo solo per quel specifico motore.
Se invece il telaio dipende da _un_ concetto di motore, non c'è questa limitazione.
In conlusione, le classi concrete devono tendenzialmente dipendere da classi astratte e non da altre classi concrete.

## Reference escaping

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

## Encapsulation e information hiding

__Legge di Parnas (L8)__.
> _Solo ciò che è nascosto può essere cambiato liberamente e senza pericoli._

Lo stato mostrato all'esterno non può essere modificato, mentre quello nascosto sì.

Questo principio serve per __facilitare la comprensione del codice__ e renderne più facile la modifica parziale senza fare danni.

## Immutabilità

Una classe è immutabile quando non c'è modo di modificare lo stato di ogni suo oggetto dopo la creazione.

Per assicurare tale proprietà è necessario:
- __non fornire metodi di modifica__ allo stato;
- avere tutti gli __attributi privati__ per i tipi potenzialmente mutabili (come `List<T>`);
- avere tutti gli __attributi final__ se non già privati;
- assicurare l'__accesso esclusivo__ a tutte le parti non mutabili, ovvero non avere reference escaping.

## Code smell

I _code smell_ sono dei segnali che suggeriscono problemi nella progettazione del codice. 
Di seguito ne sono elencati alcuni:
- __codice duplicato__: si può fare per arrivare velocemente al verde ma è da togliere con il refactoring. 
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
