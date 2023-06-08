# <big>M</big>ODEL VIEW CONTROLLER

Spesso nelle applicazioni capita che uno stesso dato sia riportato tramite diverse __viste__ all'interno dell'interfaccia utente: il colore di un testo, per esempio, potrebbe essere rappresentato contemporaneamente da una terna di valori RGB, dal suo valore esadecimale e da uno slider di colori.
Si tratta di modi differenti di rappresentare la medesima __informazione condivisa__, che viene replicata più volte per dare all'utente diversi modi in cui visualizzarla. \
La condivisione di un medesimo valore porta però con sé un problema: se tale dato viene modificato dall'utente interagendo con una delle viste è necessario che tale _modifica venga propagata a tutte le altre viste_ in modo da mantenere l'informazione __coerente__.

Abbiamo dunque bisogno di un framework che ci permetta di mantenere un'informazione condivisa in modo efficiente e pulito e che permetta di rappresentarla facilmente sotto diversi punti di vista: l'invitante soluzione di fare semplicemente sì che le viste comunichino direttamente i cambiamenti del dato l'una con l'altra si rivela infatti velocemente impraticabile.
Il pattern __Model View Controller__ (MVC) propone invece di suddividere la gestione del dato e dell'interazione con l'utente in tre tipologie di classi:

- __Model__: un'unica classe contenente lo __stato condiviso__; si tratta dell'unico depositario dell'informazione con cui tutte le viste dovranno comunicare per aggiornare i dati mostrati.
- __View__: una serie di classi che costituiscono l'__interfaccia con l'utente__; esse mostrano il dato secondo il loro specifico punto di vista e permettono all'utente di interagire con l'applicazione.
- __Controller__: ciascuna vista possiede infine una classe di controllo collegata che si occupa della __logica dell'applicazione__; ogni volta che l'utente interagisce con una vista tale interazione viene passata al relativo Controller, che si occuperà di rispondere all'input eventualmente modificando lo stato condiviso nel Model.

Abbiamo dunque una suddivisione dell'applicazione in tre tipi di componenti differenti che cooperano tra di loro senza però essere _strettamente_ dipendenti l'uno dall'altro.
Un tipico ciclo di interazione tra le tre componenti funziona infatti come mostrato in figura: 

1. Una View riceve un'interazione da parte dell'utente e comunica tale evento al proprio Controller;
2. Il Controller gestisce l'interazione e se essa richiede un cambiamento dello stato comune chiede al Model di modificare il proprio contenuto;
3. Come ulteriore passaggio, il Controller aggiorna il dato mostrato dalla View ad esso associata prima ancora che il modello sia cambiato;
4. Ricevuta la richiesta, il Model aggiorna l'informazione condivisa e notifica _tutte_ le View del cambiamento: in questo modo esso non avrà effetto solo nella vista che ha ricevuto l'input dell'utente ma in tutte;
5. Le View ricevono la comunicazione del fatto che il Model è cambiato e aggiornano la propria informazione mostrata recuperando il dato aggiornato dal modello (politica _pull_).

![MVC](/assets/09_model-view-controller.png)

Questo modello di interazione circolare permette di separare l'interfaccia utente (_view_) dall'interfaccia dello stato comune (_model_) e dalla logica del cambiamento di stato (_controller_): grazie alla mediazione del Controller le View non hanno bisogno di conoscere direttamente la struttura dei dati contenuti nel Model, cosa che ci permette di riutilizzare le stesse View, e dunque le stesse interfacce utente, per dati diversi (es. una casella di testo è una View e non dipende dal dato che ci si inserisce). \
È inoltre interessante notare come un Controller potrebbe voler comunicare dei _cambiamenti virtuali_ alla View da cui è partito un input prima ancora che al Model venga chiesta un eventuale modifica dello stato.
Nel caso ci siano errori nell'input inserito dall'utente, infatti, esso va informato in qualche modo: il Controller non cambierà dunque lo stato condiviso ma solo lo stato dalla relativa View in modo da mostrare un qualche messaggio d'errore.
Similmente, se i dati inseriti sono già presenti nel Model (cosa che il Controller non può sapere a priori) quest'ultimo potrebbe avvisare il Controller di tale evenienza al momento della richiesta di cambiamento: esso dovrà dunque nuovamente notificare l'utente che l'inserimento dei dati non è andato a buon fine aggiornando la propria View.

Portiamo ora attenzione su un altro aspetto: nell'insieme dei meccanismi che realizzano il pattern Model View Controller si possono riscontrare una serie di altri pattern che abbiamo già trattato.
Per agevolare la comprensione del funzionamento di questo nuovo "mega-pattern", vediamo quindi quali sono i pattern utilizzati al suo interno:

- __Observer__, poiché _le View sono Observer del Model_: ogni vista si registra come Observer del modello in modo che il Model, in pieno stile Observable, le notifichi dei suoi cambiamenti di stato.
Spesso la strategia di aggiornamento delle viste è qui quella __pull__, ovvero quella secondo cui agli Observer viene passato un riferimento all'oggetto Observable in modo che siano loro stessi a recuperare i dati di cui hanno bisogno tramite opportuni metodi getter: questo permette infatti di memorizzare nello stesso Model i dati di diverse View. \
Va inoltre fatto notare che se l'interfaccia esposta dalle View è un'_interfaccia a eventi_, come per esempio un'interfaccia grafica (es. un click sullo schermo genera un evento), _anche la comunicazione tra View e Controller può avvenire tramite il pattern Observer_: ciascun Controller si registra infatti come Observer degli eventi che avvengono sulla View.
- __Strategy__, poiché _i Controller sono Strategy per le View_: poiché ad ogni vista è collegato uno e un solo Controller che regola come la vista reagisca agli input dell'utente, i Controller possono essere visti come strategie di gestione degli eventi generati dalle viste.
Poiché le viste sono componenti sostanzialmente "stupidi" che risolvono le interazioni dell'utente delegando al proprio Controller la loro gestione, questo approccio permette per esempio di gestire viste identiche in modi diversi semplicemente cambiando il Controller ad esse associato: così, per esempio, è possibile rendere una casella di testo read-only oppure modificabile senza modificare in alcun modo la classe della relativa vista e rispettando così l'Open-Close Principle.
- __Composite__, poiché _le View sono spesso composte da più Component_: quando le View rappresentano interfacce grafiche (GUI) esse sono spesso realizzate componendo diversi elementi tra di loro (es. aree di testo, bottoni, etc...).
Per questo motivo è spesso prevalente il pattern Composite nella loro implementazione, utile specialmente per quanto riguarda la creazione su schermo dell'interfaccia, che viene disegnata pezzo per pezzo.

In conclusione, il Model è in grado di interagire con tutte le viste che l'osservano tramite un unico comando (_update_), mentre le View comunicano con il Model passando attraverso il Controller, che fa da una sorta di "Adapter" tra i due.
Questo permette allo stesso dato di avere interfacce disomogenee senza alcun tipo di problema riguardante la coerenza dello stesso.

Tuttavia, il problema principale del pattern Model View Controller è la _dipendenza circolare_ tra le tre componenti: le view comunicano ai rispettivi controller gli eventi, questi li elaborano e aggiornano il modello il quale a sua volta avvisa le view dei cambiamenti di stato.
Questa struttura fortemente interconnessa rende difficoltoso lo sviluppo e il testing in quanto non esiste un chiaro punto da cui partire a costruire: si potrebbe pensare di fare mocking delle view e iniziare a sviluppare il resto, ma questo approccio porta comunque a una serie di inutili complicazioni; bisogna inoltre considerare che il testing delle view è spesso particolarmente complesso coinvolgendo varie funzioni di libreria o funzioni grafiche. \
Come vedremo nel prossimo paragrafo, per ovviare a questo problema si decide spesso di spezzare il circolo vizioso di Model, View e Controller modificando lievemente le rispettive dipendenze.
