# Bug tracking

Il bug tracking è stato reso necessario nel mondo open source per via della numerosità dei contributi e della alta probabilità di avere segnalazioni duplicate.

Inoltre, per gestire le segnalazioni di bug nell'ambito dello sviluppo open source, esistono diversi strumenti come git-bug, BugZilla, Scarab, GNATS, BugManager e Mantis.

Questi tool guideranno l'utente (anche quelli meno esperti) nella segnalazione di bug, creando un __database__ che permetterà di evitare segnalazioni duplicate semplificandone la visione, l'organizzazione e la comunicazione del lavoro a riguardo.

## Bug workflow e ciclo di vita

![Bug workflow](/assets/06_bug-workflow.png)

L'obiettivo del bug tracking è avere più informazioni possibili su ogni bug in modo da poterli __riprodurre__ (un bug non riproducibile potrebbe non dipendere dal software ma dal contesto in cui si trova) e di conseguenza arrivare a una soluzione.

Ogni bug quindi avrà un suo ciclo di vita, descritto nell'immagine, che potrà intraprendere diversi percorsi.

È importante verificare i bug una volta che l'_issue_ è stato aperto, in modo da poter confermare la sua esistenza e la completezza delle informazioni fornite.

Un _issue_ è una segnalazione relativa ad un malfunzionamento di una feature presente all'interno di un progetto di software, oppure una richiesta di aggiunta di nuove funzionalità. 
Gli issue possono essere aperti da qualsiasi membro del team o dalla comunità, e possono essere risolti o chiusi da un membro del team responsabile.

Ci sono diversi modi per cui può essere chiuso un bug:
- __duplicate__: quando è stato già segnalato in precedenza e quindi non rappresenta un problema nuovo. In questo caso, viene solitamente fatto riferimento al numero del bug originale che ha già ricevuto una risoluzione;
- __wontfix__: il bug viene chiuso come "non risolvibile" perché o rappresenta una funzionalità voluta dal progetto o è troppo complesso da risolvere per essere considerato conveniente farlo dal punto di vista dei progettisti;
- __can't reproduce__: non è stato possibile riprodurre il bug, ovvero che non è stato possibile ottenere lo stesso risultato o il comportamento segnalato dal bug. Ciò può essere dovuto a una mancanza di dettagli o a un errore nella segnalazione del bug stesso;
- __fixed__: il bug è stato fixato;
- __fix verified__: il fix è stato integrato in una release passando tutti gli step di verifica.

I tool di bug tracking sono sempre più integrati negli strumenti di versioning, quindi il baco viene legato a un commit in particolare.
Da ciò è possibile ricavarne l'evoluzione durante la sua risoluzione in base alle transizioni di stato e ai commenti dei commit.
Ovviamente questo processo si complica se saranno presenti diversi rami nel progetto, infatti solitamente una segnalazione viene chiusa quando il commit che risolve il problema entra a far parte del ramo master.
Un'ulteriore problema riguarda la poca compatibilità tra le fasi della vita di un issue e le operazioni di un tool di versioning, questo porta ad una difficile rappresentazione dello stato del problema.