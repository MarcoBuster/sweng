# <big>S</big>TRATEGY / <big>D</big>ELEGATION

Talvolta nelle nostre classi vogliamo definire __comportamenti diversi per diverse istanze__: la soluzione classica dei linguaggi Object-Oriented è la creazione di una gerarchia di classi in cui le classi figlie sovrascrivano i metodi della classe genitore.
Tuttavia, questo espone a delle problematiche: cosa fare se per esempio la classe genitore cambia aggiungendo un metodo che una delle classi figlie non dovrebbe poter implementare? (es. `Duck` che ha come figlia `RubberDuck`, che aggiunge il metodo `fly()` che ovviamente non potrà essere utilizzato dalla figlia)

Non volendo violare il principio Open-Close, non siamo intenzionati a rimuovere il metodo incriminato, per cui dobbiamo cercare altre soluzioni. Una prima idea sarebbe quella di sopperire al fatto che la classe genitore non sappia chi sono i suoi figli con costrutti propri del linguaggio:

- una classe `Final` non permette di ereditare, ma questo non ci permetterebbe di differenziare il comportamento per le diverse possibili istanze;
- una classe `Sealed` (aggiunta di Java 17) che permette di scegliere esplicitamente chi possano essere i suoi figli, specificandone il nome: in questo modo si ha controllo su chi saranno i figli e nell'implementare i nuovi metodi saprò sempre da chi verranno utilizzati successivamente, ma si tratta comunque di una soluzione parziale, che limita l'espandibilità del mio progetto, infatti non permetterò ad altri utenti, che non conosco, di creare classi figlie della mia classe.

Non si può neanche pensare di fare semplicemente l'override nella classe figlia del metodo aggiunto facendo in modo che lanci un'eccezione: si avrebbe infatti una inaccettabile violazione del principio di sostituzione di Liskov, che afferma sostanzialmente che un'istanza di una sottoclasse deve poter essere usata senza problemi al posto dell'istanza di una classe genitore.

Allora si potrebbe creare un interefaccia e non dare l'implementazione dei metodi, così facendo delego alle classi figlie la possibile implementazione dei metodi rischiosi (`fly` per la `RubberDuck` lancerebbe errore ad esempio), ma al costo di limitare la fattorizzazione. Dovrò implementare il metodo in ogni classe figlia non potendolo più fare nel padre, quindi avrò del codice ripetuto. L'introduzione di una o più classi astratte per evitarlo andrebbe a complicare molto la gerarchia.

Una soluzione migliore si basa invece sul concetto di __delega__, che sostituisce all'ereditarietà la _composizione_.
Fondamentalmente si tratta di individuare ciò che cambia nell'applicazione e separarlo da ciò che rimane fisso: si creano delle _interfacce per i comportamenti da diversificare_ e una _classe concreta che implementa ogni diverso comportamento_ possibile.
All'interno della classe originale si introducono dunque degli __attributi di comportamento__, impostati al momento della costruzione o con dei setter a seconda della dinamicità che vogliamo permettere: quando viene richiesto il comportamento a tale classe essa si limiterà a chiamare il proprio "oggetto di comportamento".
Nell'esempio delle `Duck`, per esempio, la struttura è la seguente:

```plantuml
@startuml
scale 1024 width

interface FlyBehavior << interface >> {
    + {abstract} fly()
}
abstract Duck {
    + performQuack()
    + performFly()
    + swim()
    + {abstract} display()
}
FlyBehavior <-o Duck
interface QuackBehavior << interface >> {
    + {abstract} quack()
}
Duck o-> QuackBehavior
class FlyWithWings implements FlyBehavior {
    + fly()
}
class FlyNoWay implements FlyBehavior {
    + fly()
} 
class Quack implements QuackBehavior {
    + quack()
}
class Mute implements QuackBehavior {
    + quack()
}
class Squeak implements QuackBehavior {
    + quack()
}
hide empty fields
@enduml
``` 

Come si vede, qui non c'è scritto da nessuna parte che una `Duck` deve volare, ma solo che deve definire la sua "politica di volo" incorporando un `FlyBehaviour`.

Ovviamente la modifica della classe padre resta sempre rischiosa e va fatta studiando le circostanze e gli effetti del cambiamento.
In un team __XP__ idealmente dovrebbe essere meno problematica una modifica in quanto l'intero team condivide la conoscenza del progetto, quindi si conoscono anche gli effetti causati da tale modifica (anche se la conoscenza non è mai assoluta).
Nel caso di un progetto __open-source__ invece bisogna trovare un modo per rendere pubblico a tutti coloro che hanno ereditato dalla classe modificata la possibilità che si possano verificare dei problemi.

La differenziazione dei comportamenti si fa dunque _a livello d'istanza_ e non di classe: il pattern definisce una famiglia algoritmi e li rende tra di loro intercambiabili tramite _encapsulation_.
Per questo motivo tale pattern è usato in situazioni anche molto diverse da quella mostrata nell'esempio. 
Un'altra situazione in cui viene sfruttato questo pattern è l'interfaccia `Comparator`.

Diagramma UML generale del pattern strategy:

```plantuml
@startuml
class Client {}
interface AbstractStrategy << interface >> {
    + {abstract} void doSomething()
}
Client .> AbstractStrategy
class ConcreteStrategy1 implements AbstractStrategy {
    + void doSomething()
}
class ConcreteStrategy2 implements AbstractStrategy {
    + void doSomething()
}
hide empty fields
@enduml
```


È possibile notare nel diagramma che il client inizialmente conosce il concetto di abstract strategy, e in qualche modo (tramite costruttore, setter o altre metodologie) gli viene fornita un'implementazione di tale strategia.
Questo pattern è applicabile in quelle situazioni in cui il client non deve conoscere in che modo una certa operazione viene fatta, ma basta soltanto che venga svolta.
Nell'esempio del Comparator si può dire che basta che si possano comparare due oggetti, non importa il criterio di confronto.