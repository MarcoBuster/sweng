# Utilità di un test

Abbandonata la vana speranza di un criterio di selezione universalmente valido che permetta di testare alla perfezione qualunque programma vediamo ora cosa significa _utilizzare_ un criterio di selezione per costruire un test.
Come sappiamo un test altro non è che un insieme di casi di test, specifici input appartenenti al dominio del programma: un criterio di selezione governa dunque quanti e quali casi di test vengono aggiunti al test che si sta costruendo.

Possiamo quindi ora farci una domanda: quali sono le __caratteristiche__ che __rendono utile__ un caso di test, ovvero che rendono "possibile" o "probabile" che il caso di test evidenzi un malfunzionamento causato da un'anomalia?
Ebbene, un caso di test utile deve:

- __eseguire il comando che contiene l'anomalia__ – non è altrimenti possibile che il malfunzionamento si manifesti;
- l'esecuzione del comando che contiene l'anomalia deve portare il sistema in uno
__stato scorretto__, o per meglio dire __inconsistente__;
- lo stato inconsistente deve propagarsi fino all'uscita del codice in esame in modo da __produrre un output diverso da quello atteso__;

Un buon criterio di selezione dovrà quindi selezionare test contenenti casi di test utili: ma quanti dovrebbe contenerne?
Per capire ciò si può utilizzare un metro di misura legato alle caratteristiche del codice: a ogni criterio è infatti possibile associare una __metrica__ che misuri la __copertura__ del test che si sta costruendo e che ci permetta di decidere _quando smettere di aggiungere casi di test_, _quali casi di test è opportuno aggiungere_ e di _confrontare la bontà di test diversi_.
Aggiungeremo infatti solo casi di test che permettano di aumentare la metrica di copertura, e test in grado di garantire una copertura maggiore saranno inerentemente migliori di test con una copertura minore.
