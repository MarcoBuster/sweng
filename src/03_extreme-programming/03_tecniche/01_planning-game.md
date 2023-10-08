# Planning game

È l'attività di pianificazione che viene fatta all'inizio di ogni iterazione e serve per "congelare" il sottoinsieme di requisiti sul quale il team lavorerà per le prossime ~2 settimane.
Questa procedura è posta ai membri del team come un gioco, in modo da alleggerire, almeno apparentemente, la riunione da fare ad inizio iterazione.

Si parte dalle richieste del cliente espresse tramite _user stories_, una versione semplificata degli _use case_ degli UML; esse hanno come soggetto sempre un ruolo specifico nell'azienda del cliente e descrivono una funzionalità. Ogni _user story_ è dunque composta da tre parti:

- il __soggetto__, ovvero il ruolo dell'utente nell'azienda (può anche essere esterno);
- l'__azione__ che vuole eseguire il soggetto;
- la __motivazione__ che spinge il soggetto a portare avanti l'azione descritta.

Esempi di _user stories_ potrebbero essere:

- > _Da bibliotecario, voglio poter visualizzare dove si trova un particolare libro in modo da poterlo reperire per i clienti._
- > _Da utente della biblioteca, voglio poter visualizzare lo stato di un libro per poterlo prendere in prestito._

Lo scopo del planning game è dunque quello di determinare quali funzionalità saranno presenti nel prossimo rilascio combinando priorità commerciali e valutazioni tecniche: questo richiede una collaborazione da parte del cliente, che come vedremo sarà presente in loco al momento della decisione.

## Procedura

Quest'attività di pianificazione si divide fondamentalmente in tre fasi:

1. All'inizio il cliente compila le __carte__ (prima dell'inizio del planning game), nient'altro che pezzetti di carta volutamente piccoli per impedire di scriverci troppo. Su ogni carta è presente:
    - un identificativo numerico;
    - una breve frase che descrive uno scenario d'uso;
    - un caso di test che funge da test d'accettazione della funzionalità: si tratta in sostanza di un paio di esempi, di solito uno positivo e uno negativo, che devono essere soddisfatti per ritenere completa la feature;
    - il valore di business che la funzionalità ha per il cliente.

2. Per ogni carta il team di sviluppatori fa dunque una __stima__ del tempo necessario a realizzarla: raggiunta una stima comune questa viene scritta sulla carta e servirà per confrontare tale previsione con il tempo effettivamente impiegato, di cui si tiene conto sul suo retro. Per ciascuna carta uno sviluppatore assume infatti il ruolo di _tracker_, impegnandosi cioè a tracciare lo stato di avanzamento della relativa funzionalità durante le due settimane (_es. quante feature fatte, quanti bug segnalati, etc._). <!-- il tracker non era quella figura descritta al capitolo 3.2 nella sezione "figure e responsabilità? chiedi a lezione"  -->

3. Il manager decide quindi sulla base di queste informazioni __quali carte verranno implementate__ durante prossima iterazione: per questa operazione prende in considerazione il valore delle feature, le dipendenze tra l'una e l'altra e una serie di altri fattori. Se, come dovrebbe essere, le varie funzionalità rappresentate nelle carte sono indipendenti, il manager può compiere questa scelta calcolando il rapporto tra il valore e il tempo stimato e usarlo per ordinare le carte: tuttavia l'operazione richiede una certa dose di ragionamento e non è mai così meccanica.

![Card user story](/assets/03_user-story-card.png)

## Le stime

Abbiamo detto che le stime dei tempi vengono fatte dall'intero team in accordo; tuttavia il team è composto da persone diverse che quindi faranno stime diverse in funzione dell'esperienza e delle proprie capacità. È tuttavia importante raggiungere una stima accettata da tutti in quanto il team si impegna a rispettarla: se viene deciso che il tempo per una data scheda è di qualche ora e questa viene assegnata a uno sviluppatore che aveva fatto una stima di qualche giorno allora quest'ultimo si troverà in difficoltà nel portare a termine il compito; per questo motivo è importante il contributo anche degli sviluppatori junior o inesperti.

Al di là del problema del raggiungimento di una stima comune, per il quale vedremo delle tecniche specifiche, ci possono essere una serie di problemi di stima legati alla funzionalità in sé. Potremmo infatti avere stime:

- __molto differenti__ (ore vs giorni): in questo caso, è possibile che la carta non sia descritta o compresa correttamente; se uno sviluppatore stima poche ore e un altro qualche giorno c'è qualche problema.  in conclusione è necessario trovare un punto di incontro.

- quasi uniformi, ma __molto alte__: se la stima supera il tempo di iterazione potrebbe essere che la storia sia troppo ampia. Non si può neanche iniziarla in questo ciclo e continuarla nel prossimo: se alla fine dell'iterazione non ho portato a termine il lavoro prefissato è come se non l'avessi fatto (anche se magari era stato completato all'80%), perché il cliente non lo vede nella release e tale lavoro non è dunque dimostrabile. Per ovviare a questo problema si può fare lo __splitting__ delle carte, ovvero scomporre una carta in più carte in modo da dividere il problema in sotto-problemi.

- non uguali ma __simili__: non bisogna prendere la più bassa, alta o la media. Come abbiamo già detto, secondo XP bisogna arrivare ad un accordo in modo tale che chiunque nel team si riconosca nella stima effettuata.

Oltre a ciò, la fase di stima dei tempi si porta dietro diverse problematiche intrinseche, tra cui:

- __perdita di tempo__: per accordarsi su una stima comune si spende molto tempo (troppa comunicazione);

- __effetto àncora__ (anchoring effect): si tratta di un effetto che si verifica quando bisogna assegnare un valore ad una quantità ignota. Poiché il cervello umano è più bravo a ragionare per relazioni piuttosto che per assoluti, una volta che viene fatta la prima stima numerica questa definisce l'ordine di grandezza delle stime successive, facendo cioè da punto di riferimento da cui è molto difficile distanziarsi: nel nostro caso quando il team si riunisce per fare delle stime e il primo membro dà la sua opinione, tutte le stime successive orbiteranno intorno ad essa. Tale effetto impedisce di fare una stima che prenda obiettivamente in considerazione le sensazioni di tutti i membri del team, e va dunque assolutamente evitato.

Per evitare questi problemi e semplificare il processo di stima si sono sviluppati diversi processi, che data la loro natura giocosa aumentano anche l'engagement degli sviluppatori in questa fase di pianificazione.

## [Planning poker](https://en.wikipedia.org/wiki/Planning_poker)

![Planning poker](/assets/03_planning-poker.jpg)

Una per una vengono presentate brevemente le carte con le user stories facendo attenzione a non fare alcun riferimento alle tempistiche in modo da non creare subito un effetto àncora: in questa fase il team può fare domande, chiedere chiarimenti e discutere per chiarire assunzioni e rischi sulla user story, ma deve stare molto attento a non fare alcuna stima.

Dopodiché ogni componente del team sceglie una carta dal proprio mazzo personale per rappresentare la propria stima e la pone coperta sul tavolo: su queste carte si trovano una serie di numeri senza unità di misura che vanno da 0 a 100 seguendo un andamento non uniforme; il loro scopo è quello di definire un'ordine di grandezza piuttosto che una stima precisa. Ci sono anche delle carte particolari, ovvero:

- il punto di domanda indica che non si è in grado di dare una stima
- la tazza di caffè indica che la riunione è andata troppo per le lunghe ed [è necessaria una pausa](https://www.youtube.com/watch?v=-gAlDOcXgyM).

Fatta questa prima stima _blind_ le carte vengono girate contemporaneamente: idealmente vi dovrebbe essere l'unanimità sulla stima. Se così non è chi ha espresso le stime più basse e più alte ha ~1 minuto per motivare la propria scelta in modo da cercare di convincere gli altri; si noti che agli altri componenti del team non è concesso parlare per evitare di perdere troppo tempo! \
Finito questo momento di consultazione tutti i membri del team fanno una nuova stima e si continua così finché non si raggiunge l'unanimità; solitamente le votazioni convergono dopo un paio di round.

Ma qual'è l'unità di misura su cui si fanno le stime? Dipende: essa può essere scelta prima o dopo aver trovato un accordo; possono essere ore, giorni o pomodori (un pomodoro è formato da 25 minuti senza alcuna distrazioni,e dopo c'è una pausa). Ovviamente non si può pretendere di lavorare delle ore senza alcuna distrazione, per cui in queste stime si considera anche un certo __slack time__, ovvero un tempo cuscinetto per che comprende il "tempo perso" a causa di distrazioni.

## [Team Estimation Game](https://agilelearninglabs.com/2012/05/how-to-play-the-team-estimation-game/)

Si tratta di un metodo un po più complesso articolato in 3 fasi e basato sul confronto tra i diversi task piuttosto che sulla stima numerica: esso si basa infatti sull'idea che sia semplice stabilire se un task sia più facile o più difficile di un altro, mentre è molto più complicato capire di quanto sia più facile/difficile. L'idea è dunque quella di splittare in fasi questa cosa di dover dare un valore al task considerandone sempre di più difficili per arrivare a fare una buona stima.

### __<big>PRIMA FASE</big>__

![Prima fase del team estimation game](/assets/03_team-estimation-1.jpg)

Si fa una pila con le storie e si mette la prima carta al centro del tavolo. I developer si mettono in fila e uno alla volta eseguono queste azioni:

- il __primo della fila estrae una carta della pila__, la legge ad alta voce e la __posiziona__ a sinistra (più semplice), a destra (più complicata) o sotto (equivalente) la carta già presente sul tavolo.
- il __prossimo developer__ può:
  - __estrarre una nuova carta dalla pila__ e __posizionarla__ secondo le stesse regole, eventualmente inserendola in mezzo a due colonne già presenti;
  - __spostare una carta precedentemente posizionata__ commentando la motivazione della sua scelta; può ovviamente succedere che tale carta venga rispostata nella sua posizione originale, ma dopo un po' si troverà un accordo sulla difficoltà del relativo task.

Terminata la pila avremo le carte disposte sul tavolo in colonne di difficoltà comparabile, ordinate dalla meno difficile (sinistra) alla più difficile (destra).
Oltre ad aver ridotto la comunicazione (molte carte non saranno contestate), usando questa tecnica abbiamo evitato anche l'effetto àncora rendendolo relativo: l'assenza di valori precisi evita il rischio di influenzare eccessivamente gli altri. Inoltre a differenza del planning poker si può tornare sulle proprie decisioni, cosa che favorisce un continuo adattamento e ripensamento delle stime.

### __<big>SECONDA FASE</big>__

Si cerca dunque di quantificare le _distanze_ tra le carte.

![Seconda fase del team estimation game](/assets/03_team-estimation-2.jpg)

Ci si mette di nuovo in coda davanti al tavolo con il mazzo di carte del planning poker (uno solo, non uno per persona) e __si cerca di etichettare le colonne in base alle difficoltà__.

Si posiziona la prima carta (solitamente si parte da 2 perchè magari nella prossima iterazione può esserci qualcosa di ancora più facile) sopra la prima colonna.

Quindi:
- il __primo sviluppatore__ prende il valore successivo e lo posiziona sulla prima colonna che pensa abbia quel valore (rispetto al 2), oppure lo posiziona tra due colonne se pensa che sia un valore di difficoltà intermedio tra le due.
- lo __sviluppatore successivo__ può invece:
    - __estrarre una carta__ dal mazzo e __posizionarla__ secondo le regole di prima (la prima colonna che pensa abbia un particolare valore di difficoltà);
    - __spostare una carta__ con un valore precedentemente posizionato, commentando la motivazione dello spostamento;
    - __passare__ il turno, nel caso in cui non ci siano più carte nella pila e non si vogliono spostare altre carte.

È possibile avere delle carte in cui sopra non c'è nessun numero, queste saranno assimilate alla colonna alla loro sinistra. 

Al termine di questa fase, la situazione sarà simile alla seguente:

![Fine seconda fase del team estimation game](/assets/03_fine-seconda-fase-estimation-game.jpg)

### __<big>TERZA FASE</big>__

Si stima il tempo in ore/uomo di una delle carte più semplici e successivamente si calcolano tutte le colonne in proporzione alla prima.
Ma questa fase è davvero cosi utile? Nella pratica si è visto che __è inutile valutare il lavoro fatto in ore/uomo__, anche perchè con il passare del tempo la taratura può variare.

Nella prossima sezione parliamo di come la nozione di __velocity__ risolve questo problema. 

## Velocity
È importante riuscire a stimare la _velocità_ con la quale stiamo avanzando. 
In fisica la velocità è data dal rapporto tra la distanza percorsa e il tempo per percorrerla. 
Questa proprietà può essere usata anche nella gestione dello sviluppo agile: il numeratore è il punteggio delle storie mentre il denominatore è la lunghezza dell'iterazione (assimilabile in un'unità di tempo).

La ___velocity___ nel mondo agile è quindi il __numero di story point__ guadagnati nell'arco dell'iterazione corrente.

Essa riesce quindi a dare un'idea di quanto si è riusciti a fare in termini di complessità astratta.
Se per esempio il team è riuscito a fare 50 punti nella iterazione appena finita, è ragionevole prefissarsi di fare almento 50 punti nell'iterazione successiva.

La velocity __non può essere usata__ per dare __premi__, per __confrontare__ team diversi o __punire__ in caso di diminuzione, però si adatta al modo diverso degli sviluppatori di gestire le stime e dal fatto che si tende a sottostimare o sovrastimare carte diverse.

All'atto di aggiungere una persona questa metrica deve inizialmente rimanere invariata, per prevedere la sua formazione; se la rimuovo ci sarà una perdita di produttività.

La velocity __non deve considerare le storie lasciate incompiute__, quindi anche se l'ho completata al 90% devo considerarla come se non l'avessi fatta.
Inoltre, __non deve essere__ imposta: la velocity di un team è fissa e non può essere aumentata.

Esiste un movimento chiamato ___no estimates___, che evita al team tutta la parte delle stime. 
Dall'esperienza del prof. Bellettini, però, questa metodologia funziona in team molto maturi che sono in grado di guidare il ciente a formulare storie simili in termini di difficoltà, avendo tutti una misura standard per le storie.
