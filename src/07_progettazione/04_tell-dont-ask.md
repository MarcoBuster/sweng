# <a href="https://martinfowler.com/bliki/TellDontAsk.html">Principio Tell-Don't-Ask</a>

![Tell-Don't-Ask](/assets/07_tell-dont-ask.png)

> Non chiedere i dati, ma dì cosa vuoi che si faccia sui dati

Il responsabile di un'informazione è anche responsabile di tutte le operazioni su quell'informazione.

Il principio _Tell-Don't-Ask_ sancisce che piuttosto di __chiedere__ ad un oggetto dei dati e fare delle operazioni con quei dati è meglio __dire__ a questo oggetto cosa fare con i dati che contiene. 

## Esempio

Se desideriamo stampare il contenuto di tutte le carte in un mazzo possiamo partire da questo codice.

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
