# Criterio di copertura dei mutanti

_Un test \\(\ T\\) soddisfa il __criterio di copertura dei mutanti__ se e solo se per ogni mutante \\(\pi \in \Pi\\) esiste almeno un caso di test \\(t \in T\\) la cui esecuzione produca per \\(\pi\\) un risultato diverso da quello prodotto da \\(P\\)_.

La metrica di valutazione di questo criterio è la __frazione di mutanti \\(\pi\\) riconosciuta come diversa__ da \\(P\\) sul totale di mutanti generati.
Se non tutti i mutanti vengono scovati sarà necessario aggiungere dei casi di test che li riconoscano.

I tre passi da seguire per costruire un test tramite l'analisi mutazionale sono quindi:

1. __analisi__ delle classi e generazione dei mutanti;
2. __selezionare__ dei casi di test da aggiungere a \\(T\\), in base alla metrica di cui sopra;
3. __esecuzione__ dei casi di test sui mutanti, pensando anche alle performance;

Analizziamo ciascuno di tali step in maggior dettaglio.
