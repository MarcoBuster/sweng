# Test Driven Development

Il _test driven development_ (TDD) è una __tecnica di progettazione__ del software che mira a far emergere "dal basso" il design più semplice in grado di risolvere un dato problema. Non si tratta ne un'attività di verifica ne di scrittura del codice, quanto piuttosto un approccio alla scrittura di questi ultimi.

Il TDD si fonda su due concetti fondamentali, esplicitati nella seguente citazione:

> TDD = __test-first__ + __baby steps__

Il significato di questa espressione è che per scrivere del codice che esalti la semplicità della soluzione è necessario __scrivere prima il test rispetto al codice__ (_test-first_) e procedere a __piccoli passi__ (_baby steps_), realizzando cioè piccole porzioni di codice, testandole e solo allora andando avanti. Questa tecnica mira infatti a stabilire un ciclo di _feedback istantaneo_: facendo piccoli passi e testando ogni volta ciò che si appena scritto è meno probabile buttare molto tempo su una soluzione che non funziona, e anche in caso di errore è più facile individuare cosa lo genera e come risolverlo.

Per applicare questo approccio _test-driven_ allo sviluppo effettivo di software, il TDD ha sviluppato il seguente "mantra": __rosso__, __verde__, __refactoring__. Quando si scrive codice bisogna infatti seguire le seguenti tre fasi:

- Ogni volta che si deve aggiungere una feature __si scrive prima il test__ che la provi; non essendo ancora stata sviluppata, tale test dovrà fallire (<span style="Color: red">rosso</span>).

- Si cerca poi di __soddisfare il test il più velocemente possibile__, facendolo diventare <span style="color: green">verde</span>. Si ottiene così del codice corretto ma probabilmente molto brutto, quasi come fosse una bozza: tale codice serve però come feedback del fatto che l'algoritmo scelto funziona.

- Si compie infine un'azione di __refactoring__ (_fattorizzazione_), ovvero si riorganizza e si riscrive il codice in modo da renderlo migliore assicurandosi però che il test continui ad essere soddisfatto (in questa fase dobbiamo rimanere in uno stato di <span style="color: green">verde</span>).

Questa ciclo in tre fasi va ripetuto con una cadenza frequente, ogni 2-10 minuti: ciò obbliga a concentrarsi su compiti semplici evitando così di perdersi in costruzioni software complicate che magari non funzionano neanche. Si preferisce invece prima fare qualche piccolo progresso (_increment_) e poi semplificare per migliorare il codice (_simplify_).

È importante inoltre capire perché quel passaggio intermedio, la "bozza" menzionata al secondo punto dell'elenco precedente, è tanto importante: concentrarsi in primo luogo sulla creazione di una base funzionante permette subito di capire se si è scelta la strategia giusta per risolvere il problema corrente. Scrivere direttamente il codice "in bella" impiegherebbe molto più tempo e potrebbe non produrrebbe neanche un codice funzionante, siccome maggiore è la complessità del codice che si scrive più è probabile commettere errori.

In virtù di quanto appena detto, l'uso del TDD come tecnica di progettazione garantisce inoltre due importanti vantaggi:

- Spesso capita di scrivere codice difficilmente testabile: scrivere il test prima e il codice dopo aiuta invece a progettare prodotti la cui correttezza può essere provata.

- Scrivere prima i test aiuta a definire chiaramente le interfacce del programma e come queste comunicano tra di loro, mentre se non dovessimo farlo potremmo avere delle dipendenze complicate da rimuovere.

Durante il testing ci si pone dal __punto di vista del cliente__: la tecnica TDD ci permette dunque di osservare il codice da molteplici prospettive (sviluppatore e cliente), cosa che contribuisce ovviamente alla creazione di un prodotto migliore.
