# Spy objects

![Spy object](/assets/10_spy-object.png)

Un altro modo per implementare punti di osservazione che controllino e instrumentino le chiamate effettuate dal SUT su determinati DOC sono gli **spy object**.
A differenza dei mock, questi sono costruiti a partire da oggetti reali.  
Successivamente alla fase d'interazione con il SUT (exercise), durante la fase di verifica dei risultati (verify), il test confronta le chiamate effettuate dal SUT sul Test Spy con il comportamento desiderato (expected).

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
public void testConSpy() {
        MyClass spy = ??;

        MyList<int> SUT = new MyList<int>();

        res = SUT.somma(spy);

        assertThat(set).isEqualTo(14);
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
public void testConSpy() {
     MyClass spy = spy(new MyClass());

     MyList<int> SUT = new MyList<int>();

     res = SUT.somma(spy);
     
     assertThat(res).isEqualTo(14); 
     InOrder io = inOrder(spy); 
     io.verify(spy).getValue(0); 
     io.verify(spy, times(2)).getValue(1);
} 
```

</div>
</td>
</tr>
</tbody>
</table>
