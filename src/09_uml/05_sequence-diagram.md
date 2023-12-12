# Sequence diagram

## Concetto e struttura

Lo scopo del __diagramma di sequenza__ è rappresentare il flusso di interazione tra attori all'interno di un software
nel tempo.
Di seguito ne è indicato un esempio.

![Sequence diagram](/assets/11_sequence-diagram-example.png)

Si compone di alcuni elementi chiave:

- __attori__: rappresentano le entità coinvolte nel processo; spesso sono _oggetti_;
- __invocazioni__: identificano chiamate di metodo su un attore da parte di un altro e sono rappresentate con una
  freccia che va da _sinistra verso destra_. \
  La parte a sinistra è il _chiamante_ e la parte a destra è il _chiamato_;
- __valori di ritorno__: visualizzati tramite una freccia tratteggiata che va da _destra verso sinistra_;
- __cicli__: aree rettangolari etichettate con il termine `loop` che specificano la presenza di un ciclo in una certa
  zona del diagramma;
- __condizioni__: aree rettangolari etichettate con il termine `opt` che specificano la necessità di verificare alcune
  condizioni prima di entrare nella zona corrispondente.
