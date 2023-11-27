# <big>S</big>INGLETON

Talvolta vorremmo che di un certo oggetto esistesse __una sola istanza__, questo perché logicamente l'esistenza di diverse copie di quest'ultimo all'interno dell'applicazione non ha senso (es. diverse istanze della classe Gioco in un sistema che gestisce un solo gioco alla volta).
Tuttavia i linguaggi Object-Oriented forniscono solo classi che poi possono essere istanziate senza limiti, per cui la realizzazione di questa unicità può rivelarsi più complessa del previsto.

La soluzione proposta dal pattern Singleton (appartiene alls tipologia di metapattern chiamata unificaiton) consiste nel rendere la classe stessa responsabile del fatto che non può esistere più di una sua istanza: per fare ciò il primo passo è ovviamente quello di _rendere privato il costruttore_, o se non privato comunque non pubblico (conviene metterlo protected in modo da poter creare sottotipi). \
Bisogna però garantire comunque un modo per recuperare l'unica istanza disponibile della classe: si crea dunque il _metodo statico_ `getInstance` che restituisce a chi lo chiama l'unica istanza della classe, creandola tramite il costruttore privato se questa non è già presente.
Tale istanza è infatti memorizzata in un _attributo statico_ della classe stessa, in modo da poterla restituire a chiunque ne abbia bisogno.

La creazione dell'istanza avviene solo alla prima chiamata del metodo statico, che la restituisce per evitare di _appesantire_ inutilmente il carico di lavoro della macchina virtuale.
Se l'instanza ci servirà solo per un breve lasso di tempo in un momento futuro all'interno del processo, non ha senso appesantire il _boot_ della macchina virtuale istanziando un oggetto attualmente non necessario.

```plantuml
@startuml
scale 300 width

class Singleton {
    + {static} instance : Singleton
    # Singleton()
    + {static} Singleton getInstance()
    + sampleOp()
}
@enduml
```

Con queste accortezze è possibile creare una classe Singleton simile a questa:

```java
public class Singleton {
    /* costruttore privato o comunque non pubblico */
    protected Singleton() { ... }

    /* salvo l'istanza per usarla dopo */
    private static Singleton instance = null;

    /* metodo statico */
    public static Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton();
        }
        return instance;
    }

    public void metodoIstanza() { ... }
}
```

Tuttavia, per come abbiamo scritto questa classe, non vi è la certezza di non creare più di un'istanza di sé stessa, perchè non viene considerata la __concorrenza__.
Se due processi accedono in modo concorrente al metodo `getInstance`, per problemi di scheduling, entrambi potrebbero eseguire il controllo sul valore nullo dell'istanza nello stesso momento (prima che l'altro processo lo abbia effettivamente istanziato) e quindi rischiare di creare più di un oggetto, o addirittura causare la restituzione di un valore nullo, poichè non ancora istanziata effettivente!

Una prima soluzione a questo problema potrebe essere quella di mettere un lock sull'esecuzione del metodo anteponendovi la direttiva `@Synchronized`: tuttavia, tale approccio comporterebbe un notevole calo di prestazioni in quanto verrà usata ogni volta che chiamerò il metodo e non solo alla prima chiamata. \
Una soluzione molto più efficiente è invece quella che prevede di avere un _blocco sincronizzato_ di istruzioni posto all'interno del ramo in cui si verifica effettivamente che l'istanza sia nulla, e solo allora si esegue il costruttore in maniera synchronized. 

La presenza del doppio controllo assicura che non vi siano squilibri dovuti alla concorrenza, mentre sincronizzare solamente un blocco e non l'intero metodo fa sì che il calo di prestazioni sia presente solamente durante le prime chiamate concorrenti, infatti una volta creata l'istanza non verrà più eseguito il blocco di codice in questione, indipendentemente dallo scheduling del processo. \
Questa soluzione non era applicabile prima di Java 5 poichè al tempo l'allocazione della memoria di un oggetto e l'effettiva creazione dell'istanza erano gestite separatamente e quindi c'era il rischio di avere solo allocato la memoria ma senza averci scritto nulla, quindi sarebbe stato possibile restituire una referenza ad una porzione di memoria vuota.
Con la quinta versione di Java l'allocazione e la creazione dell'oggetto sono state "_accorpate_" in una singola operazione a livello di esecuzione nella macchina virtuale e quindi il problema non si pone più.

```java
public class Singleton {
    private static Singleton instance = null;
    
    protected Singleton() {}
    
    public static Singleton getInstance() {
        if (instance == null) {
            synchronized(Singleton.class) {
                if (instance == null)
                    instance = new Singleton();
            }
        }
        return instance;
    }
    public void sampleOp() {...}
}
```

## Idioma Java

La presentazione appena vista è corretta concettualmente, ma come è stato detto ogni linguaggio grazie alle sue caratteristiche può sviluppare degli __idiomi__ un po' diversi per implementare lo stesso concetto.
Nel caso di Java, il Singleton, invece che essere implementato tramite una classe, per definire l'oggetto è preferibile utilizzare un __enumerativo__ con un unico valore, l'_istanza_.
Ciascun valore di tali oggetti è infatti trattato nativamente da Java proprio come un Singleton: viene creato al momento del suo primo uso, non ne esiste più di una copia, e chiunque vi acceda accede sempre alla medesima istanza.
La possibilità di creare attributi e metodi all'interno degli `enum` completa il quadro.

```java
public enum MySingleton {
    INSTANCE;

    public void metodoIstanza() { ... }
}

MySingleton.INSTANCE.sampleOp();
```

Si tratta inoltre di un approccio "thread safe", quindi la concorrenza viene gestita internamente da java; l'unico svantaggio è che, se non si conosce l'idioma, a prima vista questa soluzione risulta molto meno chiara rispetto all'approccio precedente.

Il Singleton, per quanto sia un pattern interessante, non deve essere usato impropriamente visto che va contro alcuni dei principi SOLID e può essere sostituito da altri elementi in base alla circostanza, come ad esempio le variabili globali. 

Più informazioni a riguardo [qui](https://www.davidtanzer.net/david%27s%20blog/2016/03/14/6-reasons-why-you-should-avoid-singletons.html).