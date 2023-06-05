# <big>N</big>ULL<big>O</big>BJECT

Spesso nei nostri programmi avremo bisogno di utilizzare valori "nulli": pensiamo per esempio al termine di una Chain of Responsibilities, dove per fermare la catena di chiamate dobbiamo dare un valore nullo al `next` dell'ultimo gestore.
In generale, a una variabile che indica un riferimento ad un oggetto possiamo assegnare il valore speciale `null` per indicare che essa _non punta a nulla_.

Il problema sorge però quando a runtime si prova a dereferenziare tale valore e viene sollevata un'eccezione (`NullPointerException` in Java): questa possibilità ci costringe nel codice ad essere sempre molto titubanti sui valori che ci vengono passati, in quanto non possiamo mai assumere che essi puntino ad un valore reale e dunque dobbiamo sempre controllare che non siano nulli.

C'è però da dire che anche con tali accortezze l'utilizzo di `null` è poco carino, in quanto un valore nullo può indicare cose anche molto diverse:

- un errore a runtime;
- uno stato temporaneamente inconsistente;
- un valore assente o non valido.

Ogni volta che si utilizza `null` il codice diventa un po' meno chiaro, e sarebbe necessario disambiguare con commenti o documentazione per spiegare con che accezione tale valore viene usato.
Anche le strategie di gestione del `null` variano drasticamente a seconda del significato assegnato a tale valore: quando non ci sono valori "assenti" e dunque il `null` indica solo un errore è sufficiente controllare che i dati passati non siano nulli con condizioni, asserzioni o l'annotazione `@NotNull`.

![null object valori non assenti](/assets/09_nullObject-valori-non-assenti.png)

Quando invece ci sono __valori "assenti"__, ovvero che indicano situazioni particolari (es. il Joker in un mazzo di carte, che non ha né Rank né Suit), la gestione è più complicata.
Se non vogliamo trattarli come `null` per l'ambiguità che tale valore introduce, un'altra opzione è creare un metodo booleano nella classe che restituisce se l'istanza ha il valore nullo (es. `isJoker()`): tuttavia, questo apre le porte a errori da parte dell'utente, che potrebbe dimenticarsi di fare tale controllo e usare l'oggetto come fosse qualunque altro.

Per creare un oggetto che corrisponda al __concetto di nessun valore__ o __valore neutro__ nasce allora il pattern NullObject: si crea all'interno della classe o dell'interfaccia un _oggetto statico_ chiamato `NULL` che fornisce _particolari implementazioni dei metodi_ della stessa per realizzare l'idea di valore nullo a livello di dominio.
In questo modo tale oggetto mantiene l'identità della classe rimanendo però sufficientemente separato dagli altri valori; inoltre, la presenza di implementazioni specifiche dei metodi evita il lancio di eccezioni ambigue.

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

Quindi possiamo notare che il concetto del NullObject pattern è quello di creare un oggetto in cui viene definito un comportamento specifico per ogni metodo che rispecchia ciò che accadrebbe nel caso in cui il metodo venisse chiamato su null nel normale flusso di istruzioni.