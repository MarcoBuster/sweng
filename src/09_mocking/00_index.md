# Mocking

Un aspetto importante da considerare durante la scrittura dei test è la chiarezza del loro _scopo_.

Chiunque li legga deve essere in grado di determinare rapidamente quale comportamento si sta testando.
Tuttavia, questo può risultare molto difficile se i test non sono strutturati in modo ottimale. 
L'obiettivo di un test può essere molto confusionario se, ad esempio, vengono invocati senza alcun criterio diversi comportamenti del **system under test** (SUT, ciò che _sta venendo testato_), _e.g._ alcuni per impostare lo stato pre-test (fixture) del SUT, altri per utilizzare il SUT e altri ancora per verificare lo stato post-test del SUT.

Un modo per rendere evidente ciò che si sta testando è strutturare ogni test in modo che abbia quattro fasi distinte, eseguite in sequenza:  
1. **SET UP**: si inizializza tutto il necessario affinché il SUT _esibisca il comportamento atteso_ e il test, successivamente, sia in grado di _osservare il risultato effettivo_ (ad esempio, creare i vari Test Double).
2. **EXERCISE**: si interagisce con il SUT, facendo dunque eseguire il codice che si vuole effettivamente testare.
3. **VERIFY**: si fa tutto il necessario per determinare se il risultato atteso è stato ottenuto o meno (_e.g._ tramite asserzioni di vario tipo).
4. **TEARDOWN**: fase di pulizia atta a riportare l'ambiente nello stato in cui è stato trovato.

Per aumentare ulteriormente la leggibilità dei nostri test è desiderabile anche fare in modo che ogni metodo di test verifichi una e una sola funzionalità.
Ciò non significa che un metodo di test che verifica più funzionalità sia scorretto, ma fornirà sicuramente una minore localizzazione delle anomalie rispetto a un gruppo di test che testano singole  funzionalità; in altre parole, sarà meno leggibile e contraddistinto da una logica più complessa.