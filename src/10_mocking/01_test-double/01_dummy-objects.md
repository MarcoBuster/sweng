# Dummy Objects

Nella maggior parte dei test è necessario fare in modo che il SUT si trovi in uno stato opportuno prima di quella che è la fase di exercise; a tale scopo, durante la fase di set up, vengono effettuate chiamate ad alcuni suoi metodi.
Questi possono prendere come argomenti degli oggetti che, a volte, vengono solo memorizzati in variabili d'istanza e non sono di fatto mai utilizzati nel codice testato.
É dunque necessario crearli unicamente per conformarsi alla firma di qualche metodo che si pianifica di chiamare nella fase di set up.
La costruzione di questi oggetti può essere non banale e aggiunge una complessità del tutto superflua al test.

In questi casi, si può passare come argomento un **dummy object**.
Questi oggetti sono una forma degenere di Test Double in quanto esistono solo per poter essere passati da un metodo all'altro e non vengono mai realmente utilizzati.
La loro utilità risiede nell'eliminare la necessità di costruire gli oggetti reali.

Si noti che un dummy object non è la stessa cosa di un _null object_.
Un dummy object non viene utilizzato dal SUT, quindi il suo comportamento è irrilevante.
Al contrario, un null object viene utilizzato dal SUT, ma è progettato per non fare nulla o produrre un risultato sempre "innocuo".

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
public void testDummy() {
    MyClass dummy = ??;

    List<MyClass> SUT = new ArrayList<MyClass>();
    
    SUT.add(dummy);

    assertThat(SUT.size()).isEqualTo(1);
}
```

</div>
</td>
<td>
<div markdown="1">

  ```java
  @Test 
  public void testDummy() {
      MyClass dummy = mock(MyClass.class);
      
      List<MyClass> SUT = new ArrayList<MyClass>();
      
      SUT.add(dummy); 
      
      assertThat(SUT.size()).isEqualTo(1);
  } 
  ```
</div>

</td>
</tr>
</tbody>
</table>
