# Interface segregation all'opera

```java
public static List<Card> drawCards(Deck deck, int number) {
    List<Card> result = new ArrayList<>();
    for (int i = 0; i < number && !deck.isEmpty(); i++) {
        result.add(deck.draw());
    }
    return result;
}
```

Consideriamo il metodo `drawCards` che prende come parametri un `Deck` e un intero. \
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
