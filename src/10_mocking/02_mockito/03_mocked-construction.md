# Mocked Construction

Durante il testing di determinate funzioni potremmo trovarci di fronte alla necessità di modificare la classe per poterlo fare. Ad esempio gli attributi __final__ appartenenti a una classe, che non ci permettono di essere riassegnati, rendono impossibile l'inizione di oggetti __mockati__ al loro interno. Una soluzione possibile è quella di togliere l'attributo __final__ solamente ai fini del nostro testing. Ovviamente non si tratta di un metodo "pulito", soprattuto se si vuole procedere con un "__design by testing__".

Una implementazione funzionale, anche se più complessa, del test è l'utilizzo del __MockedConstruction__ di _mockito_.

Nel caso in esempio un Mazziere quando viene istanziato, nel suo costruttore crea pure un Multimazzo, che è un attributo __private final__. Per poter modificare il suo funzionamento quindi dovremo procedere così:

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

Dentro al __try__ quindi ogni chiamata che costruirà un multimazzo in realtà creerà un oggetto _mockato_ che si comporterà come gli specificheremo noi attraverso _mock_ e _context_.