# <big>F</big>LY<big>W</big>EIGHT

Talvolta ci troviamo in una situazione simile a quella che aveva ispirato il pattern Singleton: abbiamo una __serie di oggetti immutabili fortemente condivisi__ all'interno del programma e per motivi di performance e risparmio di memoria vorremmo che _non esistano istanze diverse a parità di stato_.
Se due client devono usare un'istanza con lo stesso stato, cioè vorremmo non usino ciascuno un'istanza duplicata ma proprio la _stessa istanza_, essendo le istanze immutabili, tale condivisione non dovrebbe infatti creare alcun tipo di problema.

Il pattern FlyWeight serve a gestire una collezione di oggetti immutabili assicurandone l'unicità: esso consiste nel rendere privato il costruttore e __costruire tutte le istanze a priori con un costruttore statico__, salvandole in una lista privata.
I client possono dunque richiedere una certa istanza con un metodo `get` specificando lo stato dell'istanza desiderata: in questo modo, a parità di richiesta verranno restituite le stesse identiche istanze.

Abbiamo visto un'applicazione di questo pattern durante i laboratori parlando di `Card`:

```java
public class Card {
    private static final Card[][] CARDS = new Card[Suit.values().length][Rank.values().length];

    static {
        for (Suit suit : Suit.values()) {
            for (Rank rank : Rank.values()) {
                CARDS[suit.ordinal()][rank.ordinal()] = new Card(rank, suit);
            }
        }
    }

    public static Card get(Rank pRank, Suit pSuit) {
        return CARDS[pSuit.ordinal()][pRank.ordinal()];
    }
}
```

A differenza del pattern Singleton è difficile definire a priori quante istanze ci sono: abbiamo un'istanza per ogni possibile combinazione dei valori degli attributi che compongono lo stato.
Proprio per questo motivo il pattern può risultare un po' inefficiente per oggetti con rappresentazioni grandi: alla prima computazione vengono infatti inizializzati _tutti_ gli oggetti, perdendo un po' di tempo e sprecando potenzialmente spazio se non tutte le istanze saranno accedute.