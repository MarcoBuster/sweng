# Injection

Mockito, tra le sue varie feature, permette di utilizzare una particolare notazione per iniettare oggetti mockati all'interno di una classe, al fine di testare alcune particolari situazioni.
In particolare possiamo estendere la classe di test con la notazione `@ExtendWith` che permette di customizzare i meccanismi base di Junit, infatti è necessario passare a questa notazione `MockitoExtension.Class`, che è un _runner_ specificato da Mockito che permette di automatizzare alcune procedure.

Esempio di Injection:

```java
@ExtendWith(MockitoExtension.class)
public class TestPartita {
    
    @Mock Tavolo mockedTable;
    @InjectMocks Partita SUT;
    
    @Test
    void primoTest () {
        assertThat(SUT.controllaSeCartaPresenteSuTavolo(Card.get(Rank.ACE, Suit.CLUBS))).isFalse();
    }
    
    @Test
    void secondoTest () {
        /* Stubbing necessario perchè ogni chiamata di un qualsiasi metodo di un oggetto 
         * mockato ritorna sempre un valore di default (se oggetto restituisce
         * null, se booleano restituisce false, ecc).
        */
        when(mockedTable.inMostra(Card.get(Rank.ACE, Suit.CLUBS))).thenReturn(true);
        
        assertThat(SUT.controllaSeCartaPresenteSuTavolo(Card.get(Rank.ACE, Suit.CLUBS))).isTrue();
    }
}
```

La notazione `@Mock` permette di specificare l'oggetto mockato che verrà iniettato nell'oggetto reale marcato dalla notazione `@InjectMocks`.

In questo esempio `Partita` contiene nel suo stato un riferimento ad un oggetto di tipo `Tavolo`, quindi mockito per prima cosa cerca dei costruttori che accettino un parametro di tipo `Tavolo`, se non ne trova proverà a sfruttare dei setter, ma se anche in questo caso non trova niente cercherà se nella classe `Partita` è presente un campo privato in cui iniettare il valore mockato.

In questo caso però è necessario che l'attributo non sia `final`, questo perchè se lo fosse e nel costruttore venisse assegnato un valore all'attributo, quest'ultimo non potrebbe più essere modificato, e di conseguenza mockito non riuscirebbe ad iniettare il valore.
Per mantene anche il `final` sarà necessario sfruttare un'altra funzionalità di mockito che vedremo in seguito.