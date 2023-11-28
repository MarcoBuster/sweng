# <big>N</big>ULL<big>O</big>BJECT

Spesso nei nostri programmi avremo bisogno di utilizzare valori "nulli": pensiamo per esempio al termine di una Chain of Responsibilities, dove per fermare la catena di chiamate dobbiamo dare un valore nullo al `next` dell'ultimo gestore.
In generale, a una variabile che indica un riferimento ad un oggetto possiamo assegnare il valore speciale `null` per indicare che essa _non punta a nulla_.

In Java `null` è il valore di default che ogni oggetto avrà quando non gli è ancora stato assegnato niente, questo perchè è l'unico valore comune ad ogni classe.

Il problema sorge però quando a runtime si prova a dereferenziare tale valore e viene sollevata un'eccezione (`NullPointerException` in Java): questa possibilità ci costringe nel codice ad essere sempre molto titubanti sui valori che ci vengono passati, in quanto non possiamo mai assumere che essi puntino ad un valore reale e dunque dobbiamo sempre controllare che non siano nulli (è necessario scegliere se adottare programmazione difensiva o programmazione a contratti).

C'è però da dire che anche con tali accortezze l'utilizzo di `null` è poco carino, in quanto un valore nullo può indicare cose anche molto diverse:

- un errore a runtime;
- uno stato temporaneamente inconsistente;
- un valore assente o non valido.

Di conseguenza è possibile affermare che un codice chiaro non dovrebbe fare uso di `null`, o per lo meno dovremme limitarlo il più possibile.
Le strategie di gestione del `null` variano drasticamente a seconda del significato assegnato a tale valore: quando non ci sono valori "assenti" e dunque il `null` __indica solo un errore__ è sufficiente controllare che i dati passati non siano nulli con:
-  __condizioni__: se scritte correttamente sono una buona soluzione ma non la migliore.
- __asserzioni__: avranno lo stesso effetto delle condizioni-if ma permettono di essere considerate nella compilazione in base alla circostanza (utile includerle nel testing ma non nella relase dato che ormai saremo certi di non finire mai in questo caso).
 - __annotazione__: `@NotNull` è un annotazione che viene messa a disposizione da Intellij (ma non solo questo ide la mette a disposizione, ci sono altre librerie che la forniscono ma possono avere implementazioni differenti), anche questa è un'ottima soluzione poichè l'IDE indicherà se sono presenti dei punti in cui un oggetto assume valore nullo, questo ancora prima della compilazione, e di conseguenza sarà possibile individuare il problema durante la fase di scrittura del codice.

![null object valori non assenti](/assets/09_nullObject-valori-non-assenti.png)

Quando invece ci sono __valori "assenti"__, ovvero che indicano situazioni particolari (es. il Joker in un mazzo di carte, che non ha né Rank né Suit), la gestione è più complicata.
Se non vogliamo trattarli come `null` per l'ambiguità che tale valore introduce, una prima soluzione potrebbe essere quella di creare un metodo booleano nella classe che verifica se l'istanza ha il valore nullo (es. `isJoker()`), e di conseguenza restituisce un valore booleano.
Tuttavia, questo approccio apre le porte a errori da parte dell'utente, che potrebbe non fare il controllo prima di utilizzare l'oggetto.

Una soluzione migliore sfrutta l'utilizzo dell'[__Optional type__](https://docs.oracle.com/en/java/javase/21/docs//api/java.base/java/util/Optional.html) (introdotto in Java 8); consiste in un oggetto che potrebbe o meno contenere un valore non nullo.
Un oggetto di tipo optional è utilizzato principalmente come valore di ritorno per metodi che potrebbero restituire "nessun valore" (se usati come parametri potrebbero esservi [diverse casistiche da considerare](https://rules.sonarsource.com/java/RSPEC-3553/).), inoltre gli oggetti optional non dovrebbero mai essere nulli, ma dovrebbero puntare sempre a un'istanza di un oggetto optional.

Al posto del __costruttore__ definisce tre metodi statici:
- `static <T> Optional<T> empty()` che restituisce un'istanza vuota di un oggetto optional;
- `static <T> Optional<T> of(T value)` restituisce un oggetto optional che descrive un valore non nullo del tipo passato come parametro;
- `static <T> Optional<T> ofNullable(T value)` restituisce un oggetto optional che descrive un valore del tipo passato come parametro, ma solo se questo non è nullo, altrimenti restituisce un oggetto optional.

Inoltre la classe optional fornisce diversi metodi, i più degni di nota sono i seguenti:
- `T get()` Restituisce il valore se presente, altrimenti solleva l'eccezione NoSuchElementException;
- `boolean isEmpty()` Restituisce true se il valore non è presente, false altrimenti;
- `boolean isPresent()` Restituisce true se il valore è presente, false altrimenti;
- `T orElse(T other)` Restituisce il valore se presente, altrimenti restituisce il valore di tipo T passato. 

La soluzione più elegante (ma non sempre applicabile facilmente) per creare un oggetto che corrisponda al __concetto di nessun valore__ o __valore neutro__ sfrutta il pattern __NullObject__: consiste nella creazione all'interno della classe o dell'interfaccia di un _oggetto statico_ (solitamente chiamato `NULL`) che rappresenta il concetto di _valore nullo_, e quindi va di fatto a sostituire `null`.
Questo oggetto fornisce _particolari implementazioni dei metodi_ dell'interfaccia per realizzare l'idea di valore nullo a livello di dominio.
In questo modo tale oggetto mantiene l'identità della classe rimanendo però sufficientemente separato dagli altri valori, inoltre, la presenza di implementazioni specifiche dei metodi evita il lancio di eccezioni ambigue.

```java
public interface CardSource {
    Card draw();
    boolean isEmpty();

    public static CardSource NULL = new CardSource() {
        public boolean isEmpty() { 
            return true; 
        }
        public Card draw() {
            assert !isEmpty();
            return null;
        }
    }
}
```

Quindi possiamo notare che il concetto del NullObject pattern è quello di creare un oggetto in cui viene definito un comportamento specifico per ogni metodo che rispecchia ciò che accadrebbe nel caso in cui il metodo venisse chiamato su _null_ nel normale flusso di istruzioni.

Una particolarità dell'esempio riportato qui sopra è che il pattern NullObject è realizzato tramite un _attributo dell'interfaccia_, che deve essere obbligatoriamente statico e pubblico. 