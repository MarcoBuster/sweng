# Stub Objects

Altre volte risulta difficile testare il SUT perché il suo comportamento dipende dai cosiddetti _input indiretti_: valori restituiti da altri componenti software (DOC) con i quali interagisce.
Gli **input indiretti** possono essere valori di ritorno dei metodi del DOC, parametri aggiornati, errori o eccezioni sollevate dal DOC.

![Stub object](/assets/10_stub-object.png)

In presenza di input indiretti la verifica del comportamento del SUT richiede di sostituire i DOC reali con Test Double che immettano gli input desiderati nel SUT.
Test Double con questo scopo prendono il nome di **stub object**: sostituiscono un componente reale, da cui dipende il SUT, e forniscono risposte (input) "preconfezionate" alle sole chiamate fatte durante il testing.
L'utilizzo di stub consente al test di forzare la realizzazione di determinati scenari particolari o di interesse specifico.

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
public void testConStub() {
    MyClass stub = ??;
    MyList<int> SUT = new MyList<int>();

    SUT.add(stub.getValue(0));  // deve ritornare 4
    SUT.add(stub.getValue(1));  // deve ritornare 7
    SUT.add(stub.getValue(1));  // deve ritornare 3
        
    res = SUT.somma();
    
    assertThat(res).isEqualTo(14);
}
```

</div>
</td>
<td>
<div markdown="1">

```java
@Test
public void testConStub() {
    MyClass stub = mock(MyClass.class);
    when(stub.getValue(0)).thenReturn(4);
    when(stub.getValue(1)).thenReturn(7, 3);
    
    MyList<int> SUT = new MyList<int>();
    SUT.add(stub.getValue(0));  // deve ritornare 4
    SUT.add(stub.getValue(1));  // deve ritornare 7
    SUT.add(stub.getValue(1));  // deve ritornare 3
        
    res = SUT.somma();
    
    assertThat(res).isEqualTo(14);
}
```

</div>
</td>
</tr>
</tbody>
</table>

È importante ricordardare che, in linea generale, i test non dovrebbero mai essere più complicati della funzione che stanno testando. Quindi se ci si trova di fronte alla necessità di creare un test estremamente dispendioso per una funziona banale potrebbe essere il caso di fermarsi e non creare un test specifico per questa funzione, ma "appoggiarsi" ad altri test più generali che comprendono pure quella sezione particolare.