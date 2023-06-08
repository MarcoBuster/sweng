# Compilatori

Prima di trasformare il codice sorgente in eseguibile, i compilatori fanno un'attività di analisi statica per identificare errori sintattici (o presunti tali) all'interno del codice.

Il lavoro dei compilatori si può dividere solitamente in __quattro tipi di analisi__ (gli esempi sono presi dal compilatore di Rust, caratteristico per la quantità e qualità di analisi svolta durante la compilazione):

- __analisi lessicale__: identifica i token appartenenti o meno al linguaggio, permettendo di individuare possibili errori di battitura;

  ```txt
  error: expected one of `!`, `.`, `::`, `;`, `?`, `{`, `}`, or an operator, found `ciao`
  --> src/main.rs:2:9
    |
  2 |     BRO ciao = "mondo";
    |           ^^^^ expected one of 8 possible tokens
  ```

- __analisi sintattica__: controlla che i token identificati siano in relazioni _sensate_ tra di loro in base alla grammatica del linguaggio, scovando così possibili errori di incomprensione del linguaggio;

  ```txt
  error: expected `{`, found keyword `for`
  --> src/main.rs:2:14
    |
  2 |     if !expr for;
    |              ^^^ expected `{`
    |
  ```

- __controllo dei tipi__: nei linguaggi tipizzati, individua violazioni di regole d'uso dei tipi ed eventuali incompatibilità tra tipi di dati;

  ```txt
  error[E0308]: mismatched types
  --> src/main.rs:2:24
    |
  2 |     let name: String = 42;
    |               ------   ^^- help: try using a conversion method: `.to_string()`
    |               |        |
    |               |        expected struct `String`, found integer
    |               expected due to this

  For more information about this error, try `rustc --explain E0308`.
  ```

- __analisi flusso dei dati__: si cercano di rilevare problemi relativi all'_evoluzione dei valori_ associati alle variabili, come per esempio porzioni di codice non raggiungibili.

  ```txt
  error: equal expressions as operands to `!=`
  --> src/main.rs:2:8
    |
  2 |     if 1 != 1 {
    |        ^^^^^^
    |
  ```

Se i primi tre tipi di analisi sono abbastanza facili da comprendere, l'ultimo merita una maggiore attenzione, motivo per cui gli dedichiamo il prossimo paragrafo.
