# Mocking di Iterable
Nel caso in cui si volesse mockare un oggetto che implementa l'interfaccia Iterable durante il testing di un altro componente, come si potrebbe procedere?

Inizialmente si potrebbe pensare di sfruttare il `thenReturn` fornendo un iteratore creato ad hoc da noi, ma il problema è che utilizzando `thenReturn` viene creato l'oggetto solo una volta, di conseguenza il test passerebbe solo alla prima iterazione dell'iteratore mockato, dalla seconda in poi si verificherebbe un errore.

Per risolvere questo problema possiamo utilizzare il seguente codice:

```java
public class MockUtils {
    @SafeVarargs
    public static <T> void whenIterated(Iterable<T> p, T... d) {
        when(p.iterator()).thenAnswer((Answer<Iterator<T>>) invocation -> List.of(d).iterator());
    }
}
```

In questo caso viene sfruttato il metodo `thenAnswer` che ogni volta permette di creare un nuovo iteratore con l'elemento successivo.

Questa tecnica viene utilizzata quando il SUT che sta venendo testato necessita di iterare su qualcosa per svolgere le sue funzioni.
Ecco un [esempio](https://youtu.be/qYX2cpT30PA?t=2729) di come può essere sfruttata questa strategia:

```java
@Test
void scegliSuccess() {
    Giocatore player1 = mock(Giocatore.class);
    Giocatore player2 = mock(Giocatore.class);
    Giocatore me = mock(Giocatore.class);

    when(player1.getMazzettoTop()).thenReturn(Rank.FIVE);
    when(player2.getMazzettoTop()).thenReturn(Rank.TEN);

    Partita partita = mock(Partita.class);
    MockUtils.whenIterated(partita, me, player2, player1);

    List<Card> mano = List.of(Card.get(Rank.ACE, Suit.CLUBS), Card.get(Rank.KING, Suit.DIAMONDS), Card.get(Rank.TEN, Suit.HEAR
    SelettoreCarta FAILED = mock(SelettoreCarta.class);
    
    SelettoreCarta strategy = new SelettoreRubaMazzetto(FAILED, me);
    
    assertThat(strategy.scegli(mano, partita)).isEqualTo(Card.get(Rank.TEN, Suit.HEARTS));
}
```