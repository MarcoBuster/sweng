# Criterio di copertura delle condizioni e delle decisioni modificate

Non volendo testare tutte le combinazioni di condizioni, ci si rende presto conto che certe combinazioni sono __più rilevanti__ di altre: se modificando una sola condizione atomica si riesce a modificare l'esito della decisione, allora è molto significativa – indipendentemente dalla sua dimensione.
Se invece l'esito della decisione non varia, allora la modifica può essere considerata neutra o meno significativa. \
Il criterio così ottenuto prende il nome di __criterio di copertura delle condizioni e delle decisioni modificate__.

Si dà quindi importanza nella selezione delle combinazioni al fatto che la modifica di una singola condizione base porti a __modificare l'esito della decisione__.
Per ogni condizione base devono quindi esistere due casi di test che modificano il valore di una sola condizione base e che portino a un diverso esito della decisione: in questo modo, inoltre, il criterio __implica quello di copertura delle condizioni e delle decisioni__.

Si può dimostrare che se si hanno \\(N\\) condizioni base __sono sufficienti \\(N+1\\) casi di test__ per soddisfare questo criterio, decisamente meno di quelli richiesti dal criterio delle condizioni composte.
