# <big>B</big>UILDER

Può talvolta capitare che l'inizializzazione di un'istanza di una classe richieda un numero molto grande di _parametri_, alcuni dei quali _obbligatori_ e altri _facoltativi_.
Come si realizzano i costruttori della classe in questo tipo di situazioni?

## Telescoping constructor pattern

L'approccio più immediato a questo problema è quello dei __costruttori telescopici__ (_telescoping constructor pattern_): all'interno della classe si realizza _un costruttore completo_ che richiede tutti i parametri e una serie di _costruttori secondari_ che invece prendono i parametri obbligatori e _diverse combinazioni dei parametri opzionali_, rimappando poi spesso la propria esecuzione sul costruttore completo tramite l'assegnamento di valori di default ai parametri non ricevuti.

```java
public class MyClass {
    private final T0 optionalField1;
    private final T1 mandatoryField;
    private final T2 optionalField2;

    public MyClass(T1 mf) {
        this(defaultValue1, mf, defaultValue2);
    }

    public MyClass(T1 mf, T0 of) {
        this(of, mf, defaultValue2);
    }

    public MyClass(T1 mf, T2 of) {
        this(defaultValue1, mf, of);
    }

    public MyClass(T1 mf, T0 of1, T2 of2) {
        this.optionalField1 = of1;
        this.optionalField2 = of2;
        this.mandatoryField = mf;
    }
}
```

Questa tecnica si rivela però presto molto poco funzionale: innanzitutto il numero di costruttori da realizzare cresce esponenzialmente nel numero di parametri opzionali, rendendo la classe estremamente confusionaria. \
Sorgono inoltre dei problemi nel caso di _parametri opzionali dello stesso tipo_, in quanto è impossibile disambiguare tra di essi al momento della definizione dei costruttori: con due parametri opzionali dello stesso tipo, per esempio, non sarebbe possibile distinguere il costruttore che assegni il primo ma non il secondo e viceversa (si noti come non si può nemmeno distinguere tramite il nome del costruttore in quanto questo deve necessariamente essere lo stesso della classe).
Se linguaggi come Python risolvono questo problema imponendo che il chiamante di un costruttore espliciti il nome del parametro opzionale che sta assegnando, questo tipo di meccanismo non esiste in Java: ciò ci costringerebbe quindi a far sì che nei costruttori vengano passati o tutti i parametri dello stesso tipo o nessuno di essi.

## JavaBeans pattern

Per risolvere i problemi appena visti la prossima soluzione che viene in mente è dunque quella di fornire un _unico costruttore_ che prenda in input _solamente i parametri obbligatori_ e creare poi una serie di _setter per i parametri opzionali_: si tratta del cosiddetto __pattern JavaBeans__.

```java
public class MyClass {
    private T0 optionalField1;
    private T1 mandatoryField;
    private T2 optionalField2;

    public MyClass(T1 mf) {
        this.mandatoryField = mf;
    }

    public void setOptionalField1(T0 of) {
        this.optionalField1 = of;
    }

    public void setOptionalField2(T2 of) {
        this.optionalField2 = of;
    }
}
```

Anche questo approccio presenta tuttavia delle notevoli difficoltà.
In primo luogo, un oggetto costruito con il pattern JavaBeans _non può essere immutabile_ in quanto richiede la presenza di setter per i propri attributi opzionali (che dunque non possono essere `final`): possiamo dunque creare solo oggetti mutabili. \
Un problema forse più grave è inoltre che questo pattern ammette la presenza di _momenti nella vita di un oggetto in cui esso non è stato ancora costruito completamente_: tra la creazione e l'assegnamento tramite setter dei parametri opzionali, infatti, l'istanza si trova in uno stato non finito e dunque non consistente che potrebbe creare numerosi problemi in sistemi di tipo concorrente o multi-thread.

## Builder pattern

Gli autori del libro Effective Java propongono dunque un nuovo pattern che prende gli aspetti migliori della prima e della seconda soluzione finora proposta risolvendo al tempo stesso i problemi di entrambe: essa permetterà infatti di creare oggetti immutabili (rendendo gli attributi `final`) e di assegnare solo alcuni dei parametri opzionali senza generare problemi di inconsistenza o di sovrapposizione dei tipi degli attributi.
Questo pattern creazionale prende il nome di __Builder__.

```plantuml
@startuml
style 500 width

class MyClass {
    - OptionalField : T0
    - MandatoryField : T1

    - MyClass(Builder)
}
class MyClass.Builder {
    + Builder(T1)
    + withOptionalField(T0) : Builder
    + build() : MyClass
}
MyClass +--> MyClass.Builder
hide empty fields
@enduml
```

Data una classe da costruire `MyClass` avente parametri obbligatori e opzionali il primo passo è quello di rendere __privato__ il suo costruttore, il quale prenderà in input non più una lista di parametri ma un'istanza di una __nuova classe `Builder`__.
Tale classe viene definita come una _classe statica, pubblica e interna_ a `MyClass`, con la quale condivide il tipo e il numero di attributi obbligatori e opzionali (questi ultimi subito inizializzati al loro valore di default). \
Seguendo il pattern JavaBeans, la classe Builder esporrà un costruttore pubblico contenente solo i parametri obbligatori e una serie di setter per i parametri opzionali.
Ma a che pro costruire un oggetto della classe Builder quando quella che volevamo ottenere era un'istanza di `MyClass`?
La risposta sta nella definizione __metodo `build()`__: tramite esso, il Builder restituirà un'istanza di MyClass inizializzata con propri i parametri obbligatori e opzionali; essendo una classe interna, infatti, il Builder sarà l'unico in grado di accedere al costruttore privato di `MyClass`.

```java
public class MyClass {
    private final T0 optionalField1;
    private final T1 mandatoryField;
    private final T2 optionalField2;

    private MyClass(Builder builder) {
        mandatoryField = builder.mandatoryField;
        optionalField1 = builder.optionalField1;
        optionalField2 = builder.optionalField2;
    }

    public static class Builder {
        private T1 mandatoryField;
        private T0 optionalField1 = defaultValue1;
        private T2 optionalField2 = defaultValue2;

        public Builder(T1 mf) {
            mandatoryField = mf;
        }

        public Builder withOptionalField1(T0 of) {
            optionalField1 = of;
            return this;
        }

        public Builder withOptionalField2(T2 of) {
            optionalField2 = of;
            return this;
        }

        public MyClass build() {
            return new MyClass(this);
        }
    }
}
```

Questo pattern è particolarmente intelligente per una serie di motivi: innanzitutto, rendendo privato il costruttore di `MyClass` ci si assicura che le sue istanze siano costruite unicamente tramite il Builder.
A tal proposito, il fatto che `Builder` sia una classe __statica__ è di non poca importanza: questo permette infatti di creare una sua istanza senza prima istanziare la classe che la contiene, cosa che come abbiamo visto sarebbe impossibile essendo il costruttore di MyClass privato.
Per creare un'istanza di Builder è dunque sufficiente la seguente sintassi:

```java
MyClass.Builder = new MyClass.Builder(...);
```

Si potrebbe notare che essendo statica la classe Builder potrà accedere solamente agli elementi statici di `MyClass`, ma questo non costituisce un problema: come abbiamo visto, essa dovrà solamente richiamarne il costruttore, che per sua stessa natura è sempre statico. \
È importante notare che non vale però il contrario: `MyClass`, una volta ricevuta un'istanza di Builder come parametro del costruttore, può benissimo accedere ai suoi campi privati e sfrutta questa possibilità per copiare i valori dei parametri obbligatori e opzionali che il Builder ha ricevuto all'interno dei propri attributi.
Assegnando tali valori al momento della creazione, gli attributi di `MyClass` potranno quindi anche essere `final`, permettendo così la creazione di oggetti immutabili.

Un altro particolare da sottolineare è che i setter degli attributi opzionali del Builder sono setter un po' "spuri", in quanto invece di non ritornare nulla _ritornano il Builder stesso_: questo permette infatti di concatenare più setter l'uno con l'altro ottenendo così una notazione più fluente.
È possibile infatti creare inline un'istanza di Builder, settare direttamente i suoi parametri opzionali e infine richiamare il metodo `build()` per ottenere facilmente un'istanza di `MyClass`:

```java
MyClass inst = (new MyClass.Builder(mandatoryField).withOptionalField1(optionalField1)).build();
```

L'utilizzo di un Builder risolve inoltre eventuali problemi dovuti alla concorrenza: quando viene chiamato il metodo `build()` l'istanza di `MyClass` viene restituita già completa, ovvero con tutti i parametri obbligatori e opzionali al valore desiderato (o di default se nessun setter è stato chiamato).
Abbiamo così eliminato la possibilità di inconsistenze e creazioni parziali delle istanze di `MyClass`.
