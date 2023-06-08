# Object-oriented testing

Finora abbiamo trattato i programmi come funzioni matematiche da un dominio di input a un dominio di output.
Questo è tutto sommato vero per quanto riguarda i __linguaggi procedurali__: un programma in tale paradigma è composto da un insieme di funzioni e procedure che preso un dato in ingresso ne restituiscono uno in uscita.
A meno di eventuali variabili globali condivise (il cui uso è comunque sconsigliato), tali funzioni sono indipendenti l'una dall'altra, e possono quindi essere _testate indipendentemente_ come fossero dei piccoli sotto-programmi.

La situazione cambia per quanto riguarda invece i __linguaggi object oriented__ (__OO__), che introducono i concetti di classe e istanza: in tali linguaggi gli oggetti sono l'__unione di metodi e stato__.
Le tecniche di testing viste finora smettono quindi di funzionare: la maggior parte delle volte testare i metodi isolatamente come funzioni da input ad output perde di senso, in quanto non si considera il contesto (lo _stato_ dell'oggetto associato) in cui essi operano.

Bisogna dunque sviluppare una serie di tecniche di test specifiche per i linguaggi orientati agli oggetti, in cui l'__unità testabile__ si sposti dalle procedure alle __classi__.

## Ereditarietà e collegamento dinamico

Prima di capire _come_ è possibile testare un'intera classe, affrontiamo due punti critici che derivano dal funzionamento intrinseco dei linguaggi a oggetti: l'__ereditarietà__ e il __collegamento dinamico__.

Partiamo dal primo e immaginiamo di avere una classe già completamente testata.
Creando ora una sottoclasse di tale classe originale può sorgere un dubbio: _visto che i metodi ereditati sono già stati testati nella classe genitore ha senso testarli nella classe figlia?_
Un quesito simile sorge nel caso di metodi di default appartenenti a un'interfaccia: _ha senso testare i metodi di default direttamente nell'interfaccia o è meglio testarli nelle classi concrete che implementano tale interfaccia?_ \
Il consenso degli esperti è di __testare nuovamente tutti i metodi ereditati__: nelle sottoclassi e nelle classi che implementano delle interfacce con metodi di default tali metodi opereranno infatti in __nuovi contesti__, per cui non vi è alcuna certezza che funzionino ancora a dovere.
Inoltre, a causa del collegamento dinamico non è nemmeno sicuro che eseguire lo stesso metodo nella classe base significa eseguire le stesse istruzioni nella classe ereditata. \
In generale dunque non si eredita l'attività di testing, ma si possono invece ereditare i casi di test e i relativi valori attesi (_l'oracolo_): è perciò opportuno __rieseguire__ i casi di test anche nelle sottoclassi.

Un altro motivo per cui il testing object-oriented differisce fortemente da quello per linguaggi funzionali è la preponderanza del __collegamento dinamico__, attraverso il quale le chiamate ai metodi vengono collegate a runtime in base al tipo effettivo degli oggetti.
Dal punto di vista teorico, infatti, tale meccanismo rende difficile stabilire staticamente tutti i possibili cammini di esecuzione, complicando la determinazione dei criteri di copertura.

## Testare una classe

Entriamo ora nel vivo della questione.
Per __testare una classe__:

- la __si isola__ utilizzando più _classi stub_ possibili per renderla eseguibile indipendentemente dal contesto;
- si implementano eventuali __metodi astratti__ o non ancora implementati (stub);
- si aggiunge una funzione per permettere di estrarre ed esaminare lo stato dell'oggetto e quindi __bypassare l'incapsulamento__;
- si costruisce una classe driver che permetta di istanziare oggetti e chiamare i metodi secondo il __criterio di copertura__ scelto.

Ebbene sì, sono stati progettati dei criteri di copertura specifici per il testing delle classi.
Vediamo dunque di cosa si tratta.

### Copertura della classe

I __criteri classici__ visti precedentemente (comandi, decisioni, ...) continuano a valere ma __non sono sufficienti__.
Per testare completamente una classe occorre considerare lo __stato dell'oggetto__: in particolare, è comodo utilizzare una __macchina a stati__ che rappresenti gli _stati possibili_ della classe e le relative _transazioni_, ovvero le chiamate di metodi che cambiano lo stato.

Tale rappresentazione potrebbe esistere nella documentazione o essere creato specificatamente per l'attività di testing.
Il seguente diagramma rappresenta per esempio una macchina a stati di una classe avente due metodi, \\(\mathtt{m1}\\) e \\(\mathtt{m2}\\).

![Grafo criteri di copertura](/assets/13_criteri-copertura-grafo.png)

Ottenuta una rappresentazione di questo tipo, alcuni criteri di copertura che si possono ipotizzare sono:

- __coprire tutti i nodi__: per ogni __stato__ dell'oggetto deve esistere almeno un caso di test che lo raggiunge;
- __coprire tutti gli archi__: per ogni stato e per ogni metodo deve esistere almeno un caso di test che esegue tale metodo trovandosi in tale stato;
- __coprire tutte le coppie di archi input/output__: per ogni stato e per ogni coppia di archi entranti e uscenti deve esistere almeno un caso di test che arriva nello stato tramite l'arco entrante e lo lascia tramite l'arco uscente (consideriamo anche _come_ siamo arrivati nello stato);
- __coprire tutti i cammini identificabili nel grafo__: spesso i cammini in questione sono infiniti, cosa che rende l'applicazione di questo criterio infattibile (_"sopra la linea rossa"_).

### Tipo di testing: white o black box?

Abbiamo assunto che il diagramma degli stati facesse parte delle specifiche del progetto.
Se così fosse, allora il testing appena descritto assume una connotazione __black box__:  il diagramma rappresenta sì la classe ma è ancora una sua __astrazione__, che non considera il codice effettivo che rappresenta lo stato o che implementa uno specifico metodo ma solo le relazioni tra i vari stati.

In caso il diagramma degli stati non sia però fornito, il testing delle classi è comunque possibile!
Attraverso tecniche di __reverse engineering__ guidate da certe euristiche (che operano ad un livello di astrazione variabile) è possibile ad __estrarre informazioni sugli stati__ di una _classe già scritta_; spesso tali informazioni non sono comprensibili per un essere umano, motivo per cui esse vengono piuttosto utilizzate da vari tool di testing automatico.
In questo caso, però, il testing assume caratteristiche __white box__, in quanto il codice che implementava la classe era già noto prima di iniziare a testarlo.
