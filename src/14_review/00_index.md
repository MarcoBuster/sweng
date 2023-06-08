# Tecniche di review

Finora abbiamo esplorato tecniche più o meno _automatiche_ per la ricerca di errori, che stimolavano il programma con specifici input o ne analizzavano il codice per individuare potenziali anomalie. \
Tuttavia, alcuni tipi di errori non possono essere rilevati con questi metodi: si tratta soprattutto errori legati a _incomprensione delle specifiche_.
Del resto, attività come il testing richiedono che il programmatore fornisca l'output "corretto" che si aspetta dal programma che viene confrontato con quello effettivo per scovare eventuali differenze: se chi scrive il codice non comprende in primo luogo _cosa_ dovrebbe fare il suo software non c'è modo di individuare l'errore.

Per questo motivo molto spesso il codice viene sottoposto ad un'attività di __review__, in cui un operatore umano ne analizza la struttura e il funzionamento: egli sarà chiaramente in grado di cogliere una serie di __errori semantici__ che sfuggono alla comprensione dei tool automatici di test.
Spesso questa mansione viene svolta da un __team di testing__ separato dal team di sviluppo: non solo questo promuove l'effettiva ricerca di errori (_mentre gli sviluppatori avrebbero tutto l'interesse di non trovarne nessuno_), ma sottopone il software a uno sguardo esterno più critico e imparziale.

Anche per la review esistono una serie di tecniche: vediamone quindi le principali.

- [**Bebugging**](./01_bebugging.md)
- [**Analisi mutazionale**](./02_analisi-mutazionale/00_index.md)
- [**Object oriented testing**](./03_object-oriented.md)
- [**Testing funzionale**](./04_testing-funzionale/00_index.md)
- [**Software inspection**](./05_software-inspection/00_index.md)
- [**Modelli statistici**](./06_modelli-statistici.md)
- [**Debugging**](./07_debugging.md)
