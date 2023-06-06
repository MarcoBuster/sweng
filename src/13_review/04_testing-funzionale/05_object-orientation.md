# Object orientation e testing funzionale

Trattandosi di un approccio __black box__ che ragiona sulle __funzionalità__ e non sui dettagli implementativi, l'introduzione del paradigma a oggetti __non dovrebbe cambiare nulla__ per quanto riguarda il testing funzionale.
Se questa affermazione è vera per quanto riguarda la verifica di singole unità funzionali, lo stesso non si può dire nel caso di __test di integrazione__.

Nei linguaggi procedurali i test di integrazione sono infatti scritti secondo logiche alternativamente __bottom-up__ o __top-down__: esiste cioè un punto di partenza dal quale partire ad aggregare le componenti, seguendo cioè una qualche forma di __albero di decomposizione__ del programma. \
Per quanto riguarda la programmazione a oggetti, invece, la situazione è __molto più caotica__: le relazioni tra le classi sono spesso cicliche e non gerarchiche (tranne per l'ereditarietà &mdash; la relazione meno interessante), in una serie di _inter-dipendenze_ che rendono difficoltoso individuare un punto da cui partire a integrare.

Relazioni interessanti in questa fase sono infatti _associazioni_,_aggregazioni_ o _dipendenze_, ma rendono complicato identificare il __sottoinsieme di classi da testare__.
Per fare ciò si possono comunque utilizzare alcuni strumenti già visti:

- si può partire dai diagrammi degli __use cases e scenari__ per testare i componenti citati;
- si possono osservare i __sequence diagram__ per testare le classi protagoniste delle interazioni a scambio di messaggi descritte;
- si possono infine usare gli __state diagram__ nella modalità che abbiamo già descritto.
