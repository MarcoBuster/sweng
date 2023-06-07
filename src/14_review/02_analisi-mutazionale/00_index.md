# Analisi mutazionale

Una evoluzione del bebugging è l'__analisi mutazionale__.
Dato un programma \\(P\\) e un test \\(T\\) (_insieme di casi di test_), viene generato un insieme di programmi \\(\Pi\\) _simili_ al programma \\(P\\) in esame: tali programmi prendono il nome di __mutanti__. \
Si esegue poi il test \\(T\\) su ciascun mutante: se \\(P\\) era corretto i programmi in \\(\Pi\\) __devono essere sbagliati__, ovvero devono produrre un __risultato diverso__ per almeno un caso di test \\(t \in T\\).
Se così non fosse, infatti, vorrebbe dire che il programma \\(P\\) non viene opportunamente testato nell'aspetto in cui si discosta dal mutante che non ha sollevato errori, per cui non si può essere sicuri della sua correttezza.
Non viene cioè testata la correttezza del programma, ma piuttosto __quanto il test è approfondito__.

Si può quindi valutare la capacità di un test di rilevare le differenze introdotte nei mutanti tramite un nuovo criterio di copertura, che prende il nome di __criterio di copertura dei mutanti__.

- [**Criterio di copertura dei mutanti**](./01_copertura-mutanti.md)
- [**Generazione dei mutanti**](./02_generazione.md)
- [**Automazione**](./03_automazione.md)
