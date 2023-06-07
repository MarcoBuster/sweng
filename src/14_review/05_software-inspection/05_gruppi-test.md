# Gruppi di test autonomi

È convinzione comune che colui che ha sviluppato un pezzo di codice sia la persona meno adatta a testarlo, come afferma la __Legge di Weinberg (L23)__:

> _Uno sviluppatore non è adatto a testare il suo codice._

Di conseguenza, si preferisce spesso che il testing sia affidato ad un __gruppo di tester autonomi__.
Questo implica infatti una serie di vantaggi, sia __tecnici__ che e __psicologici__:

- __Aspetti tecnici__:
  - __maggiore specializzazione__: si evita così di richiedere che i propri sviluppatori siano anche esperti di testing;
  - __maggiore conoscenze delle tecniche di verifica e convalida__ e dei relativi tool: chi fa il _tester_ di lavoro acquisisce competenze specifiche sui tool e sugli strumenti di testing (spesso complessi), oltre che sui concetti di copertura e mutazioni.
- __Aspetti psicologici__:
  - __distacco dal codice__: a causa dell'assenza di modelli mentali precedenti su come il software dovrebbe operare, un tester esterno pone maggiore attenzione agli aspetti spesso trascurati o dimenticati;
  - __indipendenza nella valutazione__: una persona che testa il proprio codice è incentivata a _non_ trovare molti errori in quanto potrebbe suggerire un lavoro di dubbia qualità in fase di sviluppo.
  Un gruppo specializzato nel testing è invece incentivato a trovarne il più possibile per giustificare il loro impiego.

Ci sono tuttavia anche una serie di __svantaggi__ legati all'avere un gruppo di tester autonomo.
Innanzitutto, i problemi più ovvi sono legati all'__aspetto tecnico__: il fatto che i tester diventino specializzati nel testing significa che __perderanno__ con il tempo la __capacità di progettare__ e __codificare__, oltre a possedere una __minore conoscenza dei requisiti__ del progetto.

Nell'analisi di Elisabeth Hendrickson denominata "[__Better testing &mdash; worse quality?__](https://web.archive.org/web/20220526084408/http:/testobsessed.com/wp-content/uploads/2011/04/btwq.pdf)" viene analizzata poi la tecnica sotto un __punto di vista psicologico__: come è possibile che un maggior investimento nel team di testing porti a un calo delle prestazioni in termini di numero di errori nel codice?

La risposta pare dipendere dal concetto di ___responsabilità___: seppur vero che l'attività di testing è compito del tester, è anche vero che è lo sviluppatore stesso che ha il compito di fare __test di unità__ del proprio codice &mdash; il team di testing dovrebbe occuparsi solo di quello funzionale o di integrazione.
Spesso però, a fronte di un aumento del personale nel team di testing e specialmente quando una deadline è vicina, il team di sviluppo tende a __spostare la responsabilità__ di trovare gli errori ai tester, __abbassando la qualità del codice__. \
Il team di testing troverà sì gli errori, riconsegnando il codice agli sviluppatori per correggerli, ma questo passaggio ulteriore implica una notevole __perdita di tempo__ e risorse.

Inoltre, la presenza di un team di testing dedicato può generare __pressioni negative__ sul team di sviluppo: ogni sviluppatore potrebbe sentirsi sotto costante valutazione da parte del team di testing.

## Possibili alternative

Una possibile soluzione alle criticità appena evidenziate consisterebbe nella __rotazione del personale__: una stessa persona potrebbe ricoprire il ruolo di sviluppatore per un progetto e di tester per un altro.
Questo approccio mostra diversi vantaggi, tra cui:

- __evitare pressioni negative__: ricoprendo diversi ruoli in diversi progetti, il personale non si dovrebbe sentire _giudicato_ o _giudicante_;
- __evitare il progressivo depauperamento tecnico__ dovuto ad all'eccessiva specializzazione;
- __evitare lo svuotamento dei ruoli__.

C'è però da considerare un certo __aumento dei costi di formazione__ per via del raddoppio delle responsabilità individuali e un parallelo __aumento della difficoltà di pianificazione__: potrebbe succedere che la stessa persona debba lavorare a più progetti contemporaneamente, dovendo quindi dividere il proprio tempo e le proprie competenze.

Un'altra possibile alternativa consiste nella __condivisione del personale__, che prevede che siano gli stessi sviluppatori a occuparsi del testing: ciò permette di __sopperire__ al problema di __scarsa conoscenza del software__ in esame e del relativo dominio applicativo ma, oltre a far riemergere le __criticità__ individuate precedentemente, aumenta le __difficoltà nella gestione dei ruoli__.
