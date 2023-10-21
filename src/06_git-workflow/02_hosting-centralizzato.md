# Hosting centralizzato

Un hosting centralizzato Git è un servizio che fornisce una repository centrale per i progetti Git dove i contributi vengono integrati e gestiti, garantendo una maggiore trasparenza e controllo del processo di sviluppo e mantenendo molti vantaggi della decentralizzazione, come la possibilità di lavorare in modo asincrono e autonomo.

Gli hosting centralizzati come GitHub e GitLab, nella loro costante evoluzione, spesso inventano nuovi meccanismi e provano a imporre nuovi workflow, come il GitHub Flow o il GitLab Flow, per semplificare e ottimizzare il processo di sviluppo. Tuttavia, è importante valutare attentamente questi nuovi approcci e verificare se si adattano alle esigenze specifiche del progetto e della squadra di sviluppo.
Inoltre, molti servizi di hosting centralizzati offrono funzionalità aggiuntive, come la possibilità di eseguire il "fork" di un repository, inviare _pull request_ per le modifiche e di utilizzare strumenti di continuous integration (CI) per testare automaticamente le modifiche apportate al codice.
Inoltre introducono anche l'autenticazione (garantita dall'autenticazione necessaria per loggare nei sistemi di hosting centralizzato) e il concetto di permessi, in modo da regolare le azioni che ogni utente può compiere all'interno del repositroy. 

## Fork

Il "fork" di un repository Git è una __copia del repository originale__ che viene creata su un account di hosting diverso dal proprietario originale. Inizialmente il concetto di fork aveva un'accezione "negativa" poichè lascia intendere una diatriba nella direzione dello sviluppo di un software e quindi la nascita di __due diversi cammini__ e lo split del team che ci lavorava.

Oggi invece è visto come aspetto positvo perchè permette a un altro sviluppatore di creare una copia del repository, operando su di essa senza influire sul lavoro del proprietario originale e __senza la sua autorizzazione__. È però possibile inviare delle proposte di modifiche tramite le pull request come vedremo in seguito.

La maggioranza delle piattaforme di hosting centralizzato __ottimizza la condivisione dello spazio degli oggetti__, utilizzando un'unica _repository fisica_ per tutti i fork.
Tuttavia, questo può comportare alcune problematiche di sicurezza, come ad esempio la difficoltà per la piattaforma di stabilire in quale fork si trova un determinato oggetto in caso di conflitto o la possibilità che un utente malintenzionato possa modificare o eliminare accidentalmente oggetti di altri fork. 
Per questo motivo, è importante che le piattaforme implementino __misure di sicurezza adeguate__ per proteggere i dati dei fork e garantire la tracciabilità delle modifiche ([esempio sul kernel Linux](https://github.com/torvalds/linux/commit/b4061a10fc29010a610ff2b5b20160d7335e69bf)).

I vari fork poi non sono tutti legati tra di loro ma lo sono solo al loro "_padre_" iniziale, quindi va tenuto conto di questo aspetto durante la condivisione delle varie modifiche effettuate e le possibili evoluzioni diverse dei progetti.

## Review / Pull request

Tra la creazione di una pull request e il suo _merge_, specialmente nei progetti open source (dove chiunque può proporre qualsiasi patch) è fondamentale prevedere un processo di __review__.

![Pull request](/assets/06_pull-request.png)

La funzionalità di _review/pull request_ permette di facilitare le interazioni tra gli sviluppatori utilizzando il sito di hosting come luogo comune per la discussione informale e la revisione delle modifiche.
Il processo di code review e code update può essere iterato più volte fino a che le modifiche non vengono adeguatamente adattate e integrate al progetto.
Esistono però delle problematiche legate alle pull requests, ovvero è possibile che durante questa fase il progetto prosegua e vengano apportati dei cambiamenti allo stesso codice modificato nella pull request, oppure possono presentarsi delle nuove proposte di modifiche in cui viene messa mano allo stesso codice su cui già sta avvenendo una review. In questi casi si verificano dei conflitti che devono essere risolti manualmente da una persona.

## Continous integration (CI)

Come accennato in precedenza, molti servizi di hosting centralizzati offrono strumenti di __continuous integration__ (CI) che possono essere utilizzati per testare automaticamente le modifiche proposte nella pull request. 
Questi strumenti consentono di verificare che le modifiche non introducano errori o vulnerabilità, è però importante che prima di approvare i cambiamenti ci sia una revisione da parte di una persona fisica, in modo da verificare anche la correttezza logica delle modifiche, questo perchè ci potrebbero essere dei casi particolari non coperti dai test. 
Possono essere utilizzati anche per eseguire automaticamente la _suite di test_ o automatizzare il deployment.

![CI/CD](/assets/06_ci-cd.png)
