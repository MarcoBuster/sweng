# Injection

Mockito, tra le sue varie feature, ci permette di utilizzare una particolare notazione per iniettare degli oggetti mockati in una classe, ai fini della creazione di test appropriati.

In particolare possiamo estendere una classe con la sua notazione propria e poi utilizzarla sugli attributi:



```java
    @ExtendWith(MOckitoExtension.Class)
    class Test{

        @Mock Object mocked;
        
        void test() {
            when(mocked.method()).thenReturn(...);
        }

    }
```

Potremo poi, sempre con la notazione specifica, far inserire gli oggetti _mockati_ in un oggetto reale, cosa che tipicamente avremmo fatto passando l'oggeto finto come fosse un parametro al costruttore della classe che stiamo testando.

```java
    @ExtendWith(MockitoExtension.Class)
    class Test{

        @Mock Object mocked;
        @InjectMocks Object SUT;
        
        void test() {
            when(mocked.method()).thenReturn(...);

            assertThat(SUT.method()).isEqualTo(...)
        }

    }