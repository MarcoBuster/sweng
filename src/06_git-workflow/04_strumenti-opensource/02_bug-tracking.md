# Bug tracking

Il bug tracking è stato reso necessario nel mondo open source per via della numerosità dei contributi e della alta probabilità di avere segnalazioni duplicate.

Inoltre, per gestire le segnalazioni di bug nell'ambito dello sviluppo open source, esistono diversi strumenti come git-bug, BugZilla, Scarab, GNATS, BugManager e Mantis.

Questi tool guideranno, anche gli utenti non esperti, nel dichiararli,creano un __database__ dei bug che ci permetterà di evitare segnalazioni multiple per lo stesso baco e semplifica la vista, l'organizzazione e la comunicazione del lavoro a riguardo.

## Bug workflow e ciclo di vitaa

![Bug workflow](/assets/06_bug-workflow.png)

L'obiettivo del bug tracking è avere più informazioni possibili su ogni bug per saperli riprodurre e quindi arrivare a una soluzione.

Ogni bug quindi avrà un suo ciclo di vita, descritto nell'immagine, che potrà intraprendere diversi percorsi.

È importante verificare i bug una volta che l'_issue_ è stato aperto, in modo da poter confermare la sua esistenza e la completezza delle informazioni fornite.

Un _issue_ è un problema o una richiesta di funzionalità segnalata all'interno di un progetto di software. 
Gli issue vengono solitamente utilizzati per tenere traccia dei problemi noti o delle richieste di nuove funzionalità all'interno di un progetto, e possono essere gestiti attraverso un sistema di bug tracking o gestione delle richieste. 
Gli issue possono essere aperti da qualsiasi membro del team o dalla comunità, e possono essere risolti o chiusi da un membro del team responsabile.

Ci sono diversi modi per cui può essere chiuso un bug:
- __duplicate__: quando è stato già segnalato in precedenza e quindi non rappresenta un problema nuovo. In questo caso, viene solitamente fatto riferimento al numero del bug originale che ha già ricevuto una risoluzione;
- __wontfix__: il bug viene chiuso come "non risolvibile" perché o rappresenta una funzionalità voluta dal progetto o è troppo complesso da risolvere per essere considerato conveniente farlo dal punto di vista dei progettisti;
- __can't reproduce__: non è stato possibile riprodurre il bug, ovvero che non è stato possibile ottenere lo stesso risultato o il comportamento segnalato dal bug. Ciò può essere dovuto a una mancanza di dettagli o a un errore nella segnalazione del bug stesso;
- __fixed__: il bug è stato fixato;
vs __fix verified__: il fix è stato integrato in una release passando tutti gli step di verifica.

I tool di bug tracking sono sempre più integrati negli strumenti di versioning, quindi il baco viene legato a un commit in particolare e da questo possiamo ricavare la sua storia e la sua evoluzione durante la sua risoluzione in base alle sue transizioni di stato e ai commenti dei commit. Ovviamente questo processo si complica se saranno presentid diversi rami nel nostro processo.