# Mock Objects

Il comportamento del SUT può includere azioni che non possono essere osservate attraverso la sua API pubblica, ma che sono osservate o sperimentate da altri sistemi o componenti dell'applicazione.
Tali attività ricadono sotto il nome di **output indiretti** del SUT.
Gli output indiretti possono includere chiamate a metodi di un altro componente, record inseriti in un database, record scritti su un file _etc_.

![Mock object](/assets/10_mock-object.png)

Testare il comportamento del SUT può voler dire anche verificare che gli output indiretti siano quelli corretti e a tale scopo servono punti di osservazione appropriati.
Un **punto di osservazione** è un modo con cui il test può ispezionare lo stato post-exercise del SUT. 
I punti di osservazione utili a verificare gli output indiretti sono costituiti da Test Double che prendono il nome di **mock object**.
Questi intercettano gli output indiretti del SUT nella fase di exercise e permettono di confrontarli con gli output attesi in un momento successivo (ad esempio la fase di verifying).

Un mock object è dunque utilizzato per organizzare e controllare le chiamate fatte dal SUT.
In genere, l'oggetto Mock include anche la funzionalità di uno Stub; deve infatti essere in grado di restituire valori al SUT, anche se l'enfasi è posta sulla _verifica_ delle chiamate effettuate e non dal loro risultato.

<table>
<tbody>
<tr>
<td>Senza Mockito</td>
<td>Con Mockito</td>
</tr>
<tr>
<td>
<div markdown="1">

```java
@Test
public void testConMock() {
    MyClass mock = ??;
    
    MyList<int> SUT = new MyList<int>();
    
    res = SUT.somma(mock);
    
    assertThat(res).isEqualTo(14);
    // assert che getValue è stata chiamata 3 volte
    // prima una volta con parametro 0 e poi...
}
```

</div>
</td>
<td>
<div markdown="1">

```java
@Test 
public void testConMock() {
     MyClass mock = mock(MyClass.class);
     
     when(mock.getValue(0)).thenReturn(4); 
     when(mock.getValue(1)).thenReturn(7,3);

     MyList<int> SUT = new MyList<int>();

     res = SUT.somma(mock);
     
     assertThat(res).isEqualTo(14); 
     InOrder io = inOrder(mock); 
     io.verify(mock).getValue(0); 
     io.verify(mock, times(2)).getValue(1);
} 
```

</div>
</td>
</tr>
</tbody>
</table>
