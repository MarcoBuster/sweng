# Testing delle interfacce

Questa tecnica mira a testare come i vari sotto-sistemi del programma dialoghino e __collaborino__ tra loro: per "interfacce" non si intendono infatti le `interface` Java o le _signature_, ma l'insieme di funzionalità che permettono l'interoperabilità dei componenti. \
Esistono in particolare diversi tipi di interfacce:

- a __invocazione di parametri__;
- a __condivisione di memoria__;
- a __metodi sincroni__;
- a __passaggio di messaggi__.

Le interfacce aderenti a ciascuna categoria possono essere analizzate in modi diversi alla ricerca di anomalie.
Gli sbagli più comuni sono per esempio __errori nell'uso dell'interfaccia__, come il passaggio di parametri in ordine o tipo errato oppure assunzioni sbagliate circa ciò che le funzionalità richiedono (_precondizioni_), ed __errori di tempistica o di sincronizzazione__ tra componenti.
