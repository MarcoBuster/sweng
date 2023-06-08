# Automazione

Generalmente nel testing gli unici due _outcomes_ sono _risultato corretto_ o _non corretto_ e la metrica è una misura della correttezza del programma.
Il discriminante delle tecniche di analisi mutazionale è invece il numero di casi di test che forniscono un risultato ___diverso___ da quello di \\(P\\), indipendentemente dalla correttezza (di entrambi).

Come già detto, trovare errori con queste tecniche (specialmente l'HOM) misura quindi il __livello di approfondimento__ dei casi di test e __non__ la __correttezza__ del programma di partenza. \
Prescindere dalla _correttezza_ dei risultati ha però un aspetto positivo: per eseguire l'analisi mutazionale non è necessario conoscere il comportamento corretto del programma, eliminando la necessità di un _oracolo_ che ce lo fornisca.
Si può quindi misurare la bontà di un insieme casi di test __automatizzando la loro creazione__: come già detto precedentemente, occorre però vigilare sulla __proliferazione del numero di esecuzioni__ da effettuare per completare il test – un caso di test dà infatti origine a \\(n+1\\) esecuzioni, dove \\(n\\) è il numero di mutanti.

Il seguente diagramma di flusso visualizza quindi l'attività __facilmente automatizzabile__ di analisi mutazionale:

![Schema analisi mutazionale](/assets/13_analisi-mutazionale-schema.png)

Benché semplice, questo algoritmo __non garantisce la terminazione__ per una serie di motivi:

- quando si estrae un caso di test casuale, c'è sempre il rischio di __estrarre sempre lo stesso__;
- si potrebbe essere _particolarmente sfortunati_ e __non trovare un caso di test utile__ in tempo breve;
- __esistono infinite varianti__ di programmi __funzionalmente identici__ ma __sintatticamente diversi__, ovvero che svolgono la stessa funzione anche se sono diversi: una modifica sintattica potrebbe non avere alcun effetto sul funzionamento del programma, come per esempio scambiare `<` con `<=` in un algoritmo di ordinamento.
  In tal caso, nessun nuovo caso di test permetterebbe di coprire il mutante, in quanto esso restituirebbe sempre lo stesso output del programma originale.

Spesso viene quindi posto un timeout sull'algoritmo dipendente sia dal tempo totale di esecuzione, sia dal numero di casi di test estratti.

Per verificare la validità del test, è necessario controllare il __numero di mutanti generati__: se questo numero è elevato, il test non era affidabile.
In alternativa, è possibile _"nascondere"_ i mutanti, a patto che non sia richiesta una copertura totale.
In questo modo, è possibile __analizzare programmi__ che sono __funzionalmente uguali ma sintatticamente diversi__, al fine di dimostrarne l'equivalenza o scoprire casi in cui essa non è valida.
