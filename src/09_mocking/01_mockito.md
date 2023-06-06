# Mockito

**Mockito** è un framework di testing open source per Java rilasciato sotto la licenza MIT. 
Il framework facilita di gran lunga la creazione di mock objects e in generale di tutti i tipi di Test Double, permettendo quindi di concentrarsi sulla scrittura della logica di testing.   
Inoltre, l'impiego di mockito aumenta notevolmente la leggibilità dei test.  

## Creare Test Double

Mockito mette a disposizione principalmente due metodi per creare Test Double: il metodo `mock()` e il metodo `spy()`.

Il metodo `mock()` è usato per creare **Test Double** (dummy, stub o mock objects) a partire da una determinata classe o interfaccia: l'oggetto creato si presenterà con la stessa interfaccia (_metodi e firme di questi ultimi_) del tipo specificato in fase di costruzione.
Di default, per ogni metodo dell'oggetto reale, il Test Double creato fornisce **un'implementazione minimale**.
Questo si limiterà a restituirà dei valori di default per il tipo di ritorno del metodo oppure a non fare nulla se il metodo ritorna `void`.  
Ad esempio, se si crea un oggetto con `mock()` a partire da una classe che ha un metodo `getValue()` che restituisce un `int`, il metodo `getValue()` del Test Double restituirà 0, che è il valore predefinito per un `int` in Java.  
Il Test Double può essere configurato, mediante opportuna operazione di _stubbing_ anche per restituire valori specifici o lanciare eccezioni qualora vengano chiamati determinati metodi.

Il metodo `spy()` viene utilizzato per creare spy objects a partire da oggetti reali.
Quello che si ottiene è un oggetto che ha le stesse funzionalità dell'oggetto originale, ma che può essere utilizzato per fare il "tracciamento" delle chiamate ai suoi metodi e per verificare che esse vengano portate a termine come previsto.
A differenza degli oggetti creati con il metodo `mock()`, uno spy continuerà a chiamare il metodo reale, a meno che non si specifichi il contrario.

## Stubbing

```java
when(mockedObj.methodname(args)).thenXXX(values);
```
- args: values, matchers, argumentCaptor
- matchers: anyInt(), argThat(is(closeTo(1.0, 0.001)))
- thenXXX: thenReturn, thenThrows, thenAnswer, thenCallRealMethod

Il metodo `when()` insieme ai vari `thenXXX()` (es `thenReturn()`, `thenThrow()`) è usato per specificare il comportamento di un Test Double (stub mock o spy obj) quando viene chiamato un suo determinato metodo.
Si supponga, ad esempio, di avere una classe _Foo_ con un metodo `getValue()` che restituisce un `int`.
Per fare in modo che restituisca un valore diverso dallo 0 (default per int), è possibile scrivere:
```java
Foo foo = mock(Foo.class);
when(foo.getValue()).thenReturn(42);
```
Da questo momento in poi, il metodo `getValue()` del Test Double restituirà l'intero 42 ogni volta che verrà chiamato.  
Ovviamente il metodo `when()` può essere usato per specificare il comportamento di qualsiasi metodo del Test Double.
Se quindi viene scritto:
```java
Foo foo = mock(Foo.class);
when(foo.someMethod()).thenThrow(new SomeException());
```
il Test Double lancerà un'eccezione di tipo `SomeException` quando viene chiamato il suo metodo `someMethod()`. 
Questo permette, per esempio, di testare il comportamento del nostro codice quando viene lanciata un'eccezione senza dover implementare l'oggetto reale.

Anche i metodi del tipo `doXXX()` (es. `doReturn()`, `doThrow()`, `doAnswer()`, `doNothing()`) sono usati per specificare il comportamento del Test Double quando viene chiamato un suo metodo.
Tuttavia, a differenza del metodo `when()`, questi possono essere usati anche per specificare il comportamento di un metodo che ha come tipo di ritorno `void`; è consigliabile usarli solo in questo caso, oppure in tutti i casi in cui utilizzare il metodo `when()` risulterebbe difficile (_e.g._ metodi con tipi di ritorno non banali come `Optional`).
Questi metodi si utilizzano come segue:
  ```java
doXXX(values).when(mockedObj).methodname(args)
```

## Verifying

Con oggetti di tipo mock o spy si desidera spesso verificare l'occorrenza di una chiamata con certi parametri. 
Mockito permette di farlo con il metodo `verify()`: è possibile verificare che un metodo sia stato chiamato, con quali parametri e per quante volte.
```java
verify(mockedclass, howMany).methodname(args)
```
Il parametro _howMany_ del metodo verify specifica il numero di volte che il metodo associato all'oggetto mockato deve essere chiamato durante l'esecuzione del test.

Le possibili opzioni sono:

-   `times(n)`: verifica che `methodname()` sia stato chiamato esattamente `n` volte;
-   `never()`: verifica che `methodname()` non sia mai stato chiamato;
-   `atLeastOnce()`: verifica che `methodname()` sia stato chiamato almeno una volta;
-   `atLeast(n)`: verifica che `methodname()` sia stato chiamato almeno `n` volte;
-   `atMost(n)`: verifica che `methodname()` sia stato chiamato al massimo `n` volte.

Se si desidera verificare l'ordine delle occorrenze delle chiamate ai metodi di un oggetto, si può utilizzare il metodo `inOrder()`:
```java
InOrder inO = inOrder(mock1, mock2, ...)
inO.verify...
```

È possibile anche catturare un parametro per farci delle asserzioni.
```java
ArgumentCaptor<Person> arg = ArgumentCaptor.forClass(Person.class);
verify(mock).doSomething(arg.capture());
assertEquals("John", arg.getValue().getName());
```

## Argument Matchers

Quando si esegue un'operazione di stubbing oppure quando si verifica la chiamata a un metodo, al posto di specificare i valori precisi (values) si può utilizzare quello che è un **argument matcher**. \\
Questo agisce come un segnaposto che corrisponde a qualsiasi valore corretto (_i.e._ che soddisfa la condizione di match), consentendo di specificare il comportamento senza dover conoscere il valore esatto dell'argomento che sarà passato al metodo.
Alcuni possibili matcher sono:

* `any()`, `anyInt()`, `anyString()`, etc.: questi metodi sono usati per creare degli argument matcher, che permettono di specificare che un particolare argomento del metodo può essere qualsiasi valore di un particolare tipo.
Per esempio, si può utilizzare `anyInt()` per specificare che un argomento può essere un qualsiasi valore int.
Questo risulta utile qualora si desideri fare lo stub di un metodo che restituisca un valore indipendentemente dagli argomenti passatigli.

* `eq()`: questo metodo viene utilizzato per creare un argument matcher che corrisponde a un valore specifico.
Per esempio, si può utilizzare `eq(42)` per specificare che un argomento deve avere il valore 42 per poter essere confrontato.
Ciò è utile quando si vuole fare lo stub di un metodo in modo che questo restituisca un valore solo quando viene chiamato con argomenti specifici.

* Il metodo `argThat()` è un modo più generale per specificare argument matchers.
Permette di creare matcher personalizzati implementando l'interfaccia `ArgumentMatcher`.
Questa definisce un metodo `matches()` che può essere utilizzato per determinare se un particolare argomento corrisponde al matcher.
Tale metodologia risulta utile quando si vuole abbinare gli argomenti in maniere più complesse o articolate rispetto ai matcher di argomenti di tipo `any()`.


## Reset a Test Double

Infine, il metodo `reset()` è usato per ripristinare un Test Double al suo stato iniziale, cancellando qualsiasi metodo che era stato precedentemente ridefinito.
È utile quando si vuole riutilizzare un Test Double in più test.


## Esempio di testing con pattern <big>O</big>BSERVER (PULL)

```java
@Test
void modelTest {
    // setup
    Model model = new Model();
    Observer obs = mock(Observer.class);
    Observer obs1 = mock(Observer.class);

    // exercise
    model.addObserver(obs);
    model.addObserver(obs1);
    model.setTemp(42.0, scale);

    // verify
    verify(obs).update(eq(model), eq("42.0"));
    verify(obs1).update(eq(model), eq("42.0"));
}
```

Test di un observer con un modello non generico, ma di cui si ha solo interfaccia di cui viene fornita una versione dummy:

```java
@Test
void observerTest {
    abstract class MockObservableIModel extends Observable implements Model {};
    MockOBservableIModel model = mock(MockObservableIModel.class);
    when(model.getTemp()).thenReturn(42.42);

    observer.update(model, null);

    verify(model).getTemp();
    assertThat(val).isCloseTo(42.42, Offset.offset(.01));
}
```
