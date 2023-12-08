# Mocked Construction
Nella versione 4 di Mockito è stato aggiunto un modo per fare delle operazioni al momento della creazione degli oggetti, questa tecnica è il __mocking del costruttore__ (in contemporanea è stato aggiunto anche il mocking dei metodi statici).
Questa funzionalità risulta molto utile nel caso in cui si voglia controllare la creazione di un oggetto, infatti il mocking del costruttore permette di mockare gli oggetti specificati al momento dela creazione (e quindi quando viene fatta una `new`) dell'oggetto sotto test.

Un problema riscontrato precedentemente con l'injection classico erano dato dagli attributi __final__ appartenenti a una classe, infatti quest'ultimi non potevano essere riassegnati, rendono impossibile l'iniezione di oggetti __mockati__ al loro interno.
Per aggirare questo problema era stato necessario rimuovere la parola chiave __final__ dagli attributi, ma ovviamente non si tratta di un metodo "pulito", soprattutto se si vuole procedere con un "__design by testing__".

Nel seguente esempio si ha un ``Mazziere`` che al momento della creazione (quindi nel costruttore), viene creato anche un ``Multimazzo``, che è un attributo __private final__.
Per poter mockare il ``Multimazzo`` prima che esso venga generato e assegnato all'interno del costruttore di ``Mazziere`` si deve procedere con il seguente codice:

```java
    @Test
    void constructorTest() {
        try (MockedConstruction<MultiMazzo> mockedConstruction = mockConstruction(MultiMazzo.class, (mock, context) -> {
            when(mock.draw()).thenReturn(Card.get("2C"));
        })) {

            Mazziere m = new Mazziere();

            assertThat(m.draw()).isEqualTo("2C");
        }
```

All'interno del __try__ (che è un try with resources, quindi con l'auto chiusura delle risorse) va specificato quale è il costruttore da mockare, e oltre alla classe, va passata come parametro una lambda expression che permette di citare l'oggetto appena mockato e il suo contesto, in questo modo è possibile eseguire delle operazioni su di essi, che vengono fatte contestualmente alla creazione dell'oggetto mockato, e non successivamente.
Facendo ciò, alla creazione di ogni oggetto ``Multimazzo`` (quindi a ogni ``new Multimazzo()``) viene definito lo stub, ovvero cosa deve fare. 

È inoltre possibile specificare comportamenti diversi per ogni istanza creata, si può fare specificando l'occorrenza della ``new``, specificando il costruttore utilizzato (se ce ne sono diversi) e anche in altri modi.


Questa tecnica permette di gestire anche casi in cui sia necessario testare degli oggetti che al loro interno contengono un attributo (oggetto) di cui si deve fare una deep copy, ma l'attributo in questione è un oggetto mockato.
Sfruttando la tecnica __mocked construction__, quando viene chiamato il costruttore copia (e quindi viene fatta una ``new``) viene creato un nuovo oggetto mockato avente lo stesso comportamento dell'originale, quindi il problema non si presenta più.

Ecco un esempio <span style="Color:Red">sbagliato</span> per mostrare quali sono le differenze:
```java
    @Test
    void constructorTest() {
        try (MockedConstruction<MultiMazzo> mockedConstruction = mockConstruction(MultiMazzo.class) {
            Mazziere m = new Mazziere();
            when(mock.draw()).thenReturn(Card.get("2C"));
            assertThat(m.draw()).isEqualTo("2C");
        }
```

In questo caso, si potrebbe definire soltanto il comportamento del primo ``Multimazzo`` creato, e non quello di ogni nuova istanza, inoltre una differenza importante è che nella versione corretta le operazioni specificate vengono effettuate subito dopo la creazione del mock, invece in quest'ultimo caso le esegue dopo molte altre operazioni interne.

Una piccola scomodità di questa tecnica è che le ``verify`` devono essere fatte specificando l'istanza da verificare, come nel seguente esempio

```java
    @Test
    void constructorTest() {
        try (MockedConstruction<MultiMazzo> mockedConstruction = mockConstruction(MultiMazzo.class, (mock, context) -> {
            when(mock.draw()).thenReturn(Card.get("2C"));
        })) {

            Mazziere m = new Mazziere();
            
            m.carteIniziali();
            m.gioca();
            
            verify(mocked.constructed().get(0), times(8)).draw();
            assertThat(m.draw()).isEqualTo("2C");
        }
```

In questo caso si verifica che vengano fatte 8 draw successive a quelle eseguite dal metodo ``carteIniziali`` (il ``verify`` non va inserito nella lambda)

È importante sottolineare che questa tecnica è abbastanza complessa, di conseguenza è facile incappare in situazioni in cui il test diventa molto più complesso del codice da testare.
Ecco un riferimento dove trovare degli [esempi](https://www.baeldung.com/java-mockito-constructors-unit-testing) e anche la [documentazione](https://javadoc.io/doc/org.mockito/mockito-core/latest/org/mockito/Mockito.html)