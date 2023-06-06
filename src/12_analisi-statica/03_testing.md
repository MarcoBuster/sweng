# Testing

Oltre ad essere un processo utile di per sé per il rilevamento di potenziali errori, l'__analisi statica__ può anche contribuire a guidare l'attività di __testing__. \
Per capire come, osserviamo che a partire dall'analisi statica è possibile fare le seguenti osservazioni:

- perché si presenti un malfunzionamento dovuto a una anomalia in una _definizione_, deve esserci un _uso_ che si serva del valore assegnato;
- un ciclo dovrebbe essere ripetuto (di nuovo) se verrà _usato_ un valore _definito_ alla iterazione precedente.

L'analisi statica può quindi aiutare a __selezionare i casi di test__ basandosi sulle _sequenze definizione-uso_ delle variabili, costruendo cioè dei nuovi criteri di copertura.

## Terminologia

Per rendere più scorrevole la spiegazione dei prossimi argomenti introduciamo innanzitutto un po' di terminologia.

Dato un nodo \\(i\\) del diagramma di flusso (_un comando/riga del programma_), chiamiamo \\(\operatorname{def}(i)\\) l'__insieme delle variabili definite in__ \\(\bf{i}\\).

Data invece una variabile \\(x\\) e un nodo \\(i\\), chiamiamo \\(\operatorname{du}(x, \\, i)\\) l'insieme dei nodi \\(j\\) tali che:

- \\(x \in \operatorname{def}(i)\\), ovvero la variabile \\(x\\) è __definita__ in \\(i\\);
- \\(x\\) è __usata__ nel nodo \\(j\\);
- __esiste un cammino__ da \\(i\\) a \\(j\\) __libero da definizioni__ di \\(x\\), ovvero che se seguito non sovrascrive il valore di \\(x\\).

Si tratta cioè dell'__insieme di nodi \\(\bf{j}\\) che _potrebbero_ usare il valore di \\(\bf{x}\\) definito in \\(\bf{i}\\)__.
