# Analisi statica

Come abbiamo detto nella lezione precedente, il testing dell'esecuzione del programma non è però l'unica cosa che possiamo fare per aumentare la fiducia nostra e del cliente nella correttezza del programma.
Un'altra importante iniziativa in tal senso è l'ispezione tramite varie tecniche del _codice_ del programma, attività che prende il nome di __analisi statica__.

L'analisi statica si basa cioè sull'esame di un __insieme finito di elementi__ (_le istruzioni del programma_), contrariamente all'analisi dinamica che invece considera un insieme infinito (_gli stati delle esecuzioni_).
È un'attività perciò __meno costosa del testing__, poiché non soffre del problema dell'_"esplosione dello spazio degli stati"_.

Considerando solamente il codice "statico" del programma, questa tecnica non ha la capacità di rilevare anomalie dipendenti da particolari valori assunti dalle variabili a runtime.
Si tratta nondimeno di un'attività estremamente utile, che può aiutare a individuare numerosi errori e inaccortezze.

- [**Compilatori**](./01_compilatori.md)
- [**Analisi Data Flow**](./02_data-flow/00_index.md)
- [**Testing**](./03_testing.md)
- [**Criteri di copertura**](./04_criteri/00_index.md)
- [**Oltre le variabili**](./05_oltre-variabili.md)
