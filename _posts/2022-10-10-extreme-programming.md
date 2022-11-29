---
layout: post
title: "[03] eXtreme Programming"
date:   2022-10-10 14:40:00 +0200
toc: true
---

# Test Driven Development

Il _test driven development_ (TDD) è una __tecnica di progettazione__ del software che mira a far emergere "dal basso" il design più semplice in grado di risolvere un dato problema. Non si tratta ne un'attività di verifica ne di scrittura del codice, quanto piuttosto un approccio alla scrittura di questi ultimi.

Il TDD si fonda su due concetti fondamentali, esplicitati nella seguente citazione:

> TDD = __test-first__ + __baby steps__

Il significato di questa espressione è che per scrivere del codice che esalti la semplicità della soluzione è necessario __scrivere prima il test rispetto al codice__ (_test-first_) e procedere a __piccoli passi__ (_baby steps_), realizzando cioè piccole porzioni di codice, testandole e solo allora andando avanti. Questa tecnica mira infatti a stabilire un ciclo di _feedback istantaneo_: facendo piccoli passi e testando ogni volta ciò che si appena scritto è meno probabile buttare molto tempo su una soluzione che non funziona, e anche in caso di errore è più facile individuare cosa lo genera e come risolverlo.

Per applicare questo approccio _test-driven_ allo sviluppo effettivo di software, il TDD ha sviluppato il seguente "mantra": __rosso__, __verde__, __refactoring__. Quando si scrive codice bisogna infatti seguire le seguenti tre fasi:

- Ogni volta che si deve aggiungere una feature __si scrive prima il test__ che la provi; non essendo ancora stata sviluppata, tale test dovrà fallire (<span style="Color: red">rosso</span>).

- Si cerca poi di __soddisfare il test il più velocemente possibile__, facendolo diventare <span style="Color: green">verde</span>. Si ottiene così del codice corretto ma probabilmente molto brutto, quasi come fosse una bozza: tale codice serve però come feedback del fatto che l'algoritmo scelto funziona.

- Si compie infine un'azione di __refactoring__ (_fattorizzazione_), ovvero si riorganizza e si riscrive il codice in modo da renderlo migliore assicurandosi però che il test continui ad essere soddisfatto (in questa fase dobbiamo rimanere in uno stato di <span style="Color: green">verde</span>).

Questa ciclo in tre fasi va ripetuto con una cadenza frequente, ogni 2-10 minuti: ciò obbliga a concentrarsi su compiti semplici evitando così di perdersi in costruzioni software complicate che magari non funzionano neanche. Si preferisce invece prima fare qualche piccolo progresso (_increment_) e poi semplificare per migliorare il codice (_simplify_).

È importante inoltre capire perché quel passaggio intermedio, la "bozza" menzionata al secondo punto dell'elenco precedente, è tanto importante: concentrarsi in primo luogo sulla creazione di una base funzionante permette subito di capire se si è scelta la strategia giusta per risolvere il problema corrente. Scrivere direttamente il codice "in bella" impiegherebbe molto più tempo e potrebbe non produrrebbe neanche un codice funzionante, siccome maggiore è la complessità del codice che si scrive più è probabile commettere errori.

In virtù di quanto appena detto, l'uso del TDD come tecnica di progettazione garantisce inoltre due importanti vantaggi:

- Spesso capita di scrivere codice difficilmente testabile: scrivere il test prima e il codice dopo aiuta invece a progettare prodotti la cui correttezza può essere provata.

- Scrivere prima i test aiuta a definire chiaramente le interfacce del programma e come queste comunicano tra di loro, mentre se non dovessimo farlo potremmo avere delle dipendenze complicate da rimuovere.

Durante il testing ci si pone dal __punto di vista del cliente__: la tecnica TDD ci permette dunque di osservare il codice da molteplici prospettive (sviluppatore e cliente), cosa che contribuisce ovviamente alla creazione di un prodotto migliore.

## eXtreme Programming (XP)

Ora possiamo iniziare a parlare di Extreme Programming (XP), una tecnica di sviluppo agile nata tra la fine degli anni '90 e l'inizio degli anni 2000 dalla mente di Kent Beck, che la ideò nell'ambito di un progetto Chrysler.

### Le variabili in gioco

Secondo Beck, durante lo sviluppo di software le principali variabili sono:

- __portata__: la quantità di funzionalità da implementare, una variabile delicata dal valore _mutevole_ poiché il numero di funzionalità richieste può cambiare nel corso dello sviluppo;
- __tempo__: il tempo che si può dedicare al progetto;
- __qualità__: la qualità del progetto che si vuole ottenere, principalmente relativa a correttezza e affidabilità;
- __costo__: le risorse finanziare che si possono impegnare per il progetto.

Queste 4 variabili __non sono indipendenti__ tra di loro, in quanto cambiare una influenza automaticamente le altre, in positivo o in negativo. Ponendo quindi che la qualità non sia negoziabile (il software deve funzionare) bisognerà lavorare sulle altre, specialmente bilanciando costo e tempo.

Nel panorama classico di sviluppo la portata era definita in modo rigido dal cliente, che richiedeva certe funzionalità non negoziabili e pagava lo sviluppatore a progetto completo.
Con l'XP si stravolge invece la prospettiva: __il costo è orario__, il tempo disponibile non è fisso ma pari al tempo richiesto per lo sviluppo e la portata viene ricalcolata durante il progetto, essendo così l'unica variabile a variare effettivamente. Si tratta di un approccio _incrementale_ che mira ad avere sempre un prodotto consegnabile se il cliente decide di essere soddisfatto dello sviluppo: non si fa aspettare il cliente per dargli tutto il lavoro in un colpo solo, ma questo viene consegnato una parte alla volta. Oltre ad alleggerire la pressione sullo sviluppatore, questo approccio è utile per due motivi:

- Il cliente è certo che lo sviluppatore si sia dedicando al progetto siccome vede il prodotto crescere a poco a poco.
- Dà la possibilità al cliente di avere comunque qualcosa in mano se ad un certo punto vuole interrompere la collaborazione.
- Permette al cliente di cambiare idea sulla portata e sulle funzionalità richieste in corso d'opera, bandendo la rigidità dei documenti di specifica.

Tutti questi aspetti permettono di creare un rapporto molto meno conflittuale tra cliente e sviluppatore, cosa che crea le basi per una maggiore collaborazione tra le due parti.

### Principi dell'extreme programming

Parliamo ora un po' dei fondamenti della filosofia XP, confrontandoli con quanto veniva prescritto nell'ambiente di sviluppo classico. I principi dell'ingegneria del software classica erano infatti i seguenti:

- __Separazione degli interessi__ (_aspects_ o _concerns_): separare tempi, responsabilità e moduli, ovvero tutte le varie viste o le varie dimensioni su cui si deve affrontare il problema.
- __Astrazione e modularità__: bisogna usare le giuste astrazioni che ci permettono di dominare i problemi complessi (possono essere i diversi linguaggi di programmazione, linguaggi di descrizione o vari altri costrutti).
- __Anticipazione del cambiamento__ (_design for change_): in fase di progettazione il programmatore deve pensare a come potrebbe cambiare il prodotto, accomodando la possibile  aggiunta di requisiti che il cliente magari non aveva neanche pensato; bisogna stare attenti però, perché spesso questo concetto complica arbitrariamente la progettazione e lo sviluppo, rischiando di far perdere molto tempo su cose che al cliente potrebbero non servire: può essere un'idea migliore partire da qualcosa di semplice ed incrementare man mano.
- __Generalità__: per rendere più semplice la modifica e l'espansione futura è necessario scrivere interfacce molto generali ai sistemi che costruiamo.
- __Incrementalità__: lo sviluppo avviene incrementalmente, un pezzetto alla volta.
- __Rigore e formalità__: è importante essere rigidi e specifici sia nella comunicazione che nella descrizione dei requisiti.

Sebbene non butti via tutti questi principi ma ne erediti invece alcuni per adattarli alle proprie esigenze (specialmente la _separazione degli interessi_, che viene data per scontata), l'XP pone l'accento su altri aspetti, ovvero:

- __Feedback rapido__: bisogna mantenere un costante flusso di feedback; questo viene dato dai test, dai colleghi ma anche dal cliente, che dev'essere continuamente consultato sullo stato dei lavori. Tra le iniziative che favoriscono un veloce ciclo di feedback c'è lo _standup meeting_, una riunione mattutina fatta in piedi in cui ciascuno descrive in poche parole cosa ha fatto il giorno precedente e cosa intende fare oggi.
- __Presumere la semplicità__: non bisogna complicare senza motivo né il codice, che dev'essere scritto con in mente ciò che serve a breve termine e non in un futuro remoto, né le relazioni tra colleghi, che non devono essere eccessivamente gerarchiche (tutti dovrebbero avere compiti molto simili); in generale si dovrebbe semplificare il più possibile in tutti gli ambiti del progetto.
- __Accettare il cambiamento__: non ci si deve aspettare che il software sia immutabile; al contrario, deve essere dato per scontato il concetto di _flessibilità_ e _malleabilità_, ovvero che il cliente vorrà fare cambiamenti sia dopo che durante lo sviluppo del prodotto.
- __Modifica incrementale__: ritornando al concetto di baby steps, ogni iterazione di sviluppo dovrebbe essere breve e le funzionalità introdotte piuttosto piccole; questa regola si applica tuttavia a tutti gli ambiti del progetto, tra cui la gestione del team: ovvero non bisognerebbe mai aggiungere più di una persona alla volta al gruppo di lavoro, in quanto aggiungerne di più potrebbe portare a passare più tempo ad istruirle che a sviluppare.
- __Lavoro di qualità__: bisogna ovviamente ottenere un buon prodotto, ma per fare ciò la prospettiva cambia in favore dello sviluppatore, al quale si deve garantire un ambiente di lavoro salutare e un certo benessere; la fidelizzazione dei programmatori è importante perché più si trovano bene e meglio lavorano.

I due punti più in contrasto sono il presumere la semplicità e l'anticipazione del cambiamento: ci sembra infatti più previdente pianificare per il futuro e anticipare eventuali cambiamenti, ma come vedremo nel prossimo paragrafo talvolta questo può essere controproducente.

### Presumere la semplicità vs anticipazione del cambiamento

XP mette davanti la semplicità all'anticipazione del cambiamento: non si scrive in anticipo codice che si pensa servirà in futuro. Questo non significa che non si stia progettando per il futuro, ma solo che questo non è il primo aspetto da guardare: il primo aspetto è la semplicità, ovvero fare le cose nella maniera più chiara possibile.

Non pianificare per il futuro sembra rischioso: secondo uno studio condotto da Bohem nel 1976 viene ipotizzata una curva esponenziale per il corso delle modifiche all'aumento dell'avanzamento del progetto; più il progetto avanza più è costoso modificarlo, motivo per cui sembra necessario accomodare il cambiamento futuro in modo da ridurre tale costo. \
Al contrario, XP presuppone una curva di tipo logaritmico che tenda ad un asintoto: passato un certo punto nello sviluppo il costo per le modifiche non subisce più cambiamenti sensibili, per cui non ha senso fasciarsi la testa in anticipo in quanto un codice semplice è relativamente facile da modificare.

{% responsive_image path: assets/03_cost-curves.png %}

Va inoltre considerato che Bohem parlava in realtà di cost-to-fix, non del costo per la modifica in sé; inoltre la sua statistica era poco affidabile poiché era stata costruita a partire da pochi dati. La curva esponenziale da lui descritta è stata poi successivamente ritrattata per accomodare il fatto che se un errore avviene in una fase affligge solo le successive, e non le precedenti.

## Figure in gioco e responsabilità

Al fine di organizzare il lavoro, XP individua diverse figure che partecipano allo sviluppo:

- Cliente: colui che richiede funzionalità e conosce il dominio applicativo.
- Sviluppatore: colui che sviluppa concretamente scrivendo codice.
- Manager: colui che amministra lo sviluppo con uno sguardo generale.

È interessante l'inclusione del cliente nel contesto dello sviluppo: esso non è più soltanto il committente ma ha un ruolo attivo nel lavoro, potendo cioè contribuire alla riuscita del progetto anche e soprattutto in virtù della già citata conoscenza del dominio applicativo.

Ciascuna di tali figure ha responsabilità e diritti riassunti nella seguente tabella (_manager e cliente sono accorpati perché hanno grossomodo gli stessi compiti_):

<table style="margin: 20px">
    <tr style="text-align: center; background-color: #DEDEDE">
        <th>Soggetto</th>
        <th>Ha responsabilità di decidere...</th>
        <th>Ha diritto di...</th>
    </tr>
    <tr>
        <td style="padding-left: 15px; padding-right: 15px; text-align: center;">
            <b>Manager/Cliente</b>
        </td>
        <td style="padding-left: 5px; padding-right: 15px; padding-top: 10px">
            <ul>
                <li>Portata del progetto, ovvero le funzionalità da realizzare</li>
                <li>Priorità tra funzionalità e loro <i>business value</i></li>
                <li>Date dei rilasci, anche nel caso di release incrementali</li>
            </ul>
        </td>
        <td style="padding-left: 5px; padding-right: 15px; padding-top: 10px">
            <ul>
                <li>Sapere cosa può essere fatto, con quali tempi e quali costi</li>
                <li>Vedere progressi nel sistema, provati dai test da lui definiti (<i>trasparenza</i>)</li>
                <li>Cambiare idea, sostituendo funzionalità o cambiandone le priorità a intervalli di tempo fissi (<i>fine del ciclo di sviluppo incrementale</i>)</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 5px; padding-right: 15px; text-align: center;">
            <b>Sviluppatore</b>
        </td>
        <td style="padding-left: 5px; padding-right: 15px; padding-top: 10px">
            <ul>
                <li>Stime dei tempi per le singole funzionalità (<i>no deadline imposte dall'alto</i>)</li>
                <li>Scelte tecnologiche e loro conseguenze, ovvero <i>come</i> si realizzano le funzionalità richieste</li>
                <li>Pianificazione dettagliata delle iterazioni</li>
            </ul>
        </td>
        <td style="padding-left: 5px; padding-right: 15px; padding-top: 10px">
            <ul>
                <li>Ricevere dei requisiti chiari (<i>casi d'uso</i>) con priorità per le varie funzionalità</li>
                <li>Cambiare le stime dei tempi man mano che il progetto procede e il contesto di sviluppo cambia</li>
                <li>Identificare funzionalità pericolose o troppo difficili da realizzare</li>
                <li>Produrre software di qualità, per il quale deve godere di un certo benessere</li>
            </ul>
        </td>
    </tr>
</table>

Come si vede, per migliorare la fiducia tra sviluppatore e cliente sono necessari due requisiti: un certo grado di _trasparenza_ da parte di chi sviluppa, ottenuta dall'uso delle contiene release incrementali per mostrare come sta evolvendo il sistema, e una certa dose di _pazienza_ da parte del cliente, che deve accettare di lasciare allo sviluppatore la facoltà di decidere come si realizzano le funzionalità e di cambiare le prospettive temporali di sviluppo qualora fosse necessario.

## Tecniche XP

L'extreme programming fornisce una serie di metodologie pratiche per poter garantire tutto ciò che è stato descritto fino ad ora. Lo schema sottostante le descrive mettendole in relazione tra loro in modo che i vari aspetti negativi delle diverse pratiche siano compensati dagli aspetti positivi di quelle in relazione con loro; in sostanza abbiamo un mix perfetto di attività organizzate in modo da garantire i buoni principi di cui sopra.

{% responsive_image path: assets/03_approccio.png %}

### 1. Planning game

È l'attività di pianificazione che viene fatta all'inizio di ogni iterazione e serve per "congelare" il sottoinsieme di requisiti sul quale il team lavorerà per le prossime ~2 settimane.

Si parte dalle richieste del cliente espresse tramite _user stories_, una versione semplificata degli _use case_ degli UML; esse hanno come soggetto sempre un ruolo specifico nell'azienda del cliente e descrivono una funzionalità. Ogni _user story_ è dunque composta da tre parti:

- il __soggetto__, ovvero il ruolo dell'utente nell'azienda (può anche essere esterno);
- l'__azione__ che vuole eseguire il soggetto;
- la __motivazione__ che spinge il soggetto a portare avanti l'azione descritta.

Esempi di _user stories_ potrebbero essere:

- > _Da bibliotecario, voglio poter visualizzare dove si trova un particolare libro in modo da poterlo reperire per i clienti._
- > _Da utente della biblioteca, voglio poter visualizzare lo stato di un libro per poterlo prendere in prestito._

Lo scopo del planning game è dunque quello di determinare quali funzionalità saranno presenti nel prossimo rilascio combinando priorità commerciali e valutazioni tecniche: questo richiede una collaborazione da parte del cliente, che come vedremo sarà presente in loco al momento della decisione.

#### Procedura

Quest'attività di pianificazione si divide fondamentalmente in tre fasi:

1. All'inizio il cliente compila le __carte__, nient'altro che pezzetti di carta volutamente piccoli per impedire di scriverci troppo. Su ogni carta è presente:
    - un identificativo numerico;
    - una breve frase che descrive uno scenario d'uso;
    - un caso di test che funge da test d'accettazione della funzionalità: si tratta in sostanza di un paio di esempi, di solito uno positivo e uno negativo, che devono essere soddisfatti per ritenere completa la feature;
    - il valore di business che la funzionalità ha per il cliente.

2. Per ogni carta il team di sviluppatori fa dunque una __stima__ del tempo necessario a realizzarla: raggiunta una stima comune questa viene scritta sulla carta e servirà per confrontare tale previsione con il tempo effettivamente impiegato, di cui si tiene conto sul suo retro. Per ciascuna carta uno sviluppatore assume infatti il ruolo di _tracker_, impegnandosi cioè a tracciare lo stato di avanzamento della relativa funzionalità durante le due settimane (_es. quante feature fatte, quanti bug segnalati, etc._).

3. Il manager decide quindi sulla base di queste informazioni __quali carte verranno implementate__ durante prossima iterazione: per questa operazione prende in considerazione il valore delle feature, le dipendenze tra l'una e l'altra e una serie di altri fattori. Se, come dovrebbe essere, le varie funzionalità rappresentate nelle carte sono indipendenti, il manager può compiere questa scelta calcolando il rapporto tra il valore e il tempo stimato e usarlo per ordinare le carte: tuttavia l'operazione richiede una certa dose di ragionamento e non è mai così meccanica.

{% responsive_image path: assets/03_user-story-card.png %}

#### Le stime

Abbiamo detto che le stime dei tempi vengono fatte dall'intero team in accordo; tuttavia il team è composto da persone diverse che quindi faranno stime diverse in funzione dell'esperienza e delle proprie capacità. È tuttavia importante raggiungere una stima accettata da tutti in quanto il team si impegna a rispettarla: se viene deciso che il tempo per una data scheda è di qualche ora e questa viene assegnata a uno sviluppatore che aveva fatto una stima di qualche giorno allora quest'ultimo si troverà in difficoltà nel portare a termine il compito; per questo motivo è importante il contributo anche degli sviluppatori junior o inesperti.

Al di là del problema del raggiungimento di una stima comune, per il quale vedremo delle tecniche specifiche, ci possono essere una serie di problemi di stima legati alla funzionalità in sé. Potremmo infatti avere stime:

- __molto differenti__ (ore vs giorni): in questo caso, è possibile che la carta non sia descritta o compresa correttamente; se uno sviluppatore stima poche ore e un altro qualche giorno c'è qualche problema.  in conclusione è necessario trovare un punto di incontro.

- quasi uniformi, ma __molto alte__: se la stima supera il tempo di iterazione potrebbe essere che la storia sia troppo ampia. Non si può neanche iniziarla in questo ciclo e continuarla nel prossimo: se alla fine dell'iterazione non ho portato a termine il lavoro prefissato è come se non l'avessi fatto (anche se magari era stato completato all'80%), perché il cliente non lo vede nella release e tale lavoro non è dunque dimostrabile. Per ovviare a questo problema si può fare lo __splitting__ delle carte, ovvero scomporre una carta in più carte in modo da dividere il problema in sotto-problemi.

- non uguali ma __simili__: non bisogna prendere la più bassa, alta o la media. Come abbiamo già detto, secondo XP bisogna arrivare ad un accordo in modo tale che chiunque nel team si riconosca nella stima effettuata.

Oltre a ciò, la fase di stima dei tempi si porta dietro diverse problematiche intrinseche, tra cui:

- __perdita di tempo__: per accordarsi su una stima comune si spende molto tempo (troppa comunicazione);

- __effetto àncora__ (anchoring effect): si tratta di un effetto che si verifica quando bisogna assegnare un valore ad una quantità ignota. Poiché il cervello umano è più bravo a ragionare per relazioni piuttosto che per assoluti, una volta che viene fatta la prima stima numerica questa definisce l'ordine di grandezza delle stime successive, facendo cioè da punto di riferimento da cui è molto difficile distanziarsi: nel nostro caso quando il team si riunisce per fare delle stime e il primo membro dà la sua opinione, tutte le stime successive orbiteranno intorno ad essa. Tale effetto impedisce di fare una stima che prenda obiettivamente in considerazione le sensazioni di tutti i membri del team, e va dunque assolutamente evitato.

Per evitare questi problemi e semplificare il processo di stima si sono sviluppati diversi processi, che data la loro natura giocosa aumentano anche l'engagement degli sviluppatori in questa fase di pianificazione.

#### [Planning poker](https://en.wikipedia.org/wiki/Planning_poker)

{% responsive_image path: assets/03_planning-poker.jpg %}

Una per una vengono presentate brevemente le carte con le user stories facendo attenzione a non fare alcun riferimento alle tempistiche in modo da non creare subito un effetto àncora: in questa fase il team può fare domande, chiedere chiarimenti e discutere per chiarire assunzioni e rischi sulla user story, ma deve stare molto attento a non fare alcuna stima.

Dopodiché ogni componente del team sceglie una carta dal proprio mazzo personale per rappresentare la propria stima e la pone coperta sul tavolo: su queste carte si trovano una serie di numeri senza unità di misura che vanno da 0 a 100 seguendo un andamento non uniforme; il loro scopo è quello di definire un'ordine di grandezza piuttosto che una stima precisa. Ci sono anche delle carte particolari, ovvero:

- il punto di domanda indica che non si è in grado di dare una stima
- la tazza di caffè indica che la riunione è andata troppo per le lunghe ed [è necessaria una pausa](https://www.youtube.com/watch?v=-gAlDOcXgyM).

Fatta questa prima stima _blind_ le carte vengono girate contemporaneamente: idealmente vi dovrebbe essere l'unanimità sulla stima. Se così non è chi ha espresso le stime più basse e più alte ha ~1 minuto per motivare la propria scelta in modo da cercare di convincere gli altri; si noti che agli altri componenti del team non è concesso parlare per evitare di perdere troppo tempo! \
Finito questo momento di consultazione tutti i membri del team fanno una nuova stima e si continua così finché non si raggiunge l'unanimità; solitamente le votazioni convergono dopo un paio di round.

Ma qual'è l'unità di misura su cui si fanno le stime? Dipende: essa può essere scelta prima o dopo aver trovato un accordo; possono essere ore, giorni o pomodori (un pomodoro è formato da 25 minuti senza alcuna distrazioni,e dopo c'è una pausa). Ovviamente non si può pretendere di lavorare delle ore senza alcuna distrazione, per cui in queste stime si considera anche un certo __slack time__, ovvero un tempo cuscinetto per che comprende il "tempo perso" a causa di distrazioni.

#### [Team Estimation Game](https://agilelearninglabs.com/2012/05/how-to-play-the-team-estimation-game/)

Si tratta di un metodo un po più complesso articolato in 3 fasi e basato sul confronto tra i diversi task piuttosto che sulla stima numerica: esso si basa infatti sull'idea che sia semplice stabilire se un task sia più facile o più difficile di un altro, mentre è molto più complicato capire di quanto sia più facile/difficile. L'idea è dunque quella di splittare in fasi questa cosa di dover dare un valore al task considerandone sempre di più difficili per arrivare a fare una buona stima.

##### __<big>PRIMA FASE</big>__

{% responsive_image path: assets/03_team-estimation-1.jpg %}

Si fa una pila con le storie e si mette la prima carta al centro del tavolo. I developer si mettono in fila e uno alla volta eseguono queste azioni:

- il __primo della fila estrae una carta della pila__, la legge ad alta voce e la __posiziona__ a sinistra (più semplice), a destra (più complicata) o sotto (equivalente) la carta già presente sul tavolo.
- il __prossimo developer__ può:
  - __estrarre una nuova carta dalla pila__ e __posizionarla__ secondo le stesse regole, eventualmente inserendola in mezzo a due colonne già presenti;
  - __spostare una carta precedentemente posizionata__ commentando la motivazione della sua scelta; può ovviamente succedere che tale carta venga rispostata nella sua posizione originale, ma dopo un po' si troverà un accordo sulla difficoltà del relativo task.

Terminata la pila avremo le carte disposte sul tavolo in colonne di difficoltà comparabile, ordinate dalla meno difficile (sinistra) alla più difficile (destra).
Oltre ad aver ridotto la comunicazione (molte carte non saranno contestate), usando questa tecnica abbiamo evitato anche l'effetto àncora rendendolo relativo: l'assenza di valori precisi evita il rischio di influenzare eccessivamente gli altri. Inoltre a differenza del planning poker si può tornare sulle proprie decisioni, cosa che favorisce un continuo adattamento e ripensamento delle stime.

##### __<big>SECONDA FASE</big>__

Si cerca dunque di quantificare le _distanze_ tra le carte.

{% responsive_image path: assets/03_team-estimation-2.jpg %}

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

{% responsive_image path: assets/03_fine-seconda-fase-estimation-game.jpg %}

##### __<big>TERZA FASE</big>__

Si stima il tempo in ore/uomo di una delle carte più semplici e successivamente si calcolano tutte le colonne in proporzione alla prima.
Ma questa fase è davvero cosi utile? Nella pratica si è visto che __è inutile valutare il lavoro fatto in ore/uomo__, anche perchè con il passare del tempo la taratura può variare.

Nella prossima sezione parliamo di come la nozione di __velocity__ risolve questo problema. 

#### Velocity
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

### 2. Brevi cicli di rilascio
Per ridurre i rischi, la vita e lo sviluppo dell'applicazione sono scanditi dai rilasci di diversioni del prodotto funzionanti, di solito uno ogni due settimane (come abbiamo visto in scrum con il _freez_, ma con un tempo di rilascio minore). 
È necessario avere abbastanza tempo per sviluppare qualcosa di concreto, e il cliente per poter pensare alle richieste che ha fatto e stabilire se ha bisogno di modifiche.

Betrand Meyer, nel suo libro _"Agile! The Good, the Hype and the Ugly"_, definisce questa idea _"brillante"_, _"forse l'idea agile con l'influenza e impatto maggiore nell'industria"_. 

### 3. Uso di una metafora
Definire un __nuovo vocabolario__ con cui parlare con l'utente (tecnica _non informatica_) ma anche ai nuovi sviluppatori.
Serve per permettere una nominazione di classi e metodi omogenei e fornire una vista d'insieme.
Siccome non c'è una vera documentazione in XP, possiamo usare queste metafore come una vista d'insieme, quindi sostituire in parte l'architettura del sistema, e far capire gli elementi fondamentali, il loro scopo e le relazioni fra loro. 

### 4. Semplicità di progetto
Ovvero l'___arte di massimizzare il lavoro non fatto___, o da non fare.
Non è necessario riscrivere cose già esistenti e consolidate. 

Uno slogan tipico è __KISS__: __Keep It Simple, Stupid__.

Questo punto si contrappone al _design for change_ che viene invece visto come un appesantimento inutile, perchè una feature che aggiungiamo può essere scartata dal cliente.

### 5. Testing
È consolidato su due fronti:
- i clienti scrivono i __test di accettazione__ (o funzionali) sulle schede per aumentare la loro fiducia nel programmi;
- i programmatori scrivono i __test di unità__ perché la fiducia nel codice diventi parte del programma stesso.

Nell'XP ogni aspetto viene massimizzato, ma in particolare il testing viene esasperato di più in quanto, oltre ad essere molto importante, molti altri aspetti si basano su di esso (vedi la figura all'inizio della sezione). 
Ha il ruolo di __rete di protezione__ in tutte le fasi: ogni cambiamento è verificabile tramite i test.

Il testing aiuta molto anche quando non si parte da zero con il programma, ma quando si deve modificare un programma proprietario precedentemente sviluppato anche in modalità non agile.
Prima di apportare modifiche al codice scrivo i test e solo successivamente procedo, in modo da non causare problemi.

Un altro concetto importante è che i test dovrebbero __coprire tutte le righe di codice__.

### 6. Refactoring
Anche da novizi, non bisogna avere paura di apportare modifiche che semplificano il progetto: bisogna avere coraggio.

Il refactoring è l'operazione che __modifica solo le proprietà interne__ del software, __non le funzionalità__.
L'obiettivo è eliminare l'entropia generata dalle continue modifiche e aggiunte.

Il refactoring deve essere __graduale e continuo__ in modo da poter aggiungere funzionalità in maniera semplice. 
Chiaramente, in caso di ristrutturazioni architetturali di grosse dimensioni di sistemi legacy non è sempre possibile procedere in questa maniera.

Parti di codice non stimolate da test non sono utili ai fini della soluzione: o si aggiungono test per gestire i casi specifici, altrimenti si possono rimuovere _in toto_.

Il refactoring è una delle tecniche più __importanti__ e __fondamentali__ dell'XP.

### 7. Programmazione a coppie

La programmazione a coppie (__pair programming__) è una tecnica controintuitiva: dal punto di vista del manager si pagano due persone per fare il lavoro di una, ma non è così.

Ci sono diversi __vantaggi__:
- in coppia, __ci si controlla a vicenda__ su ogni aspetto (codice, rispetto delle regole XP, idee); 
- mentre il _pilota_ attua le idee, il _navigatore_ pensa cosa fare subito dopo: forma di __refactoring__;
- favorisce l'__inserimento di nuovo personale__: piuttosto che lasciare i novizi da soli a studiare libroni, vengono affiancati e incitati a osservare e interagire con persone esperte che stanno lavorando;
- fa ottenere una __proprietà collettiva__ (conoscenza osmotica), come descritta da Crystal. 
Un altro punto importante sono i commenti _naive_ (ovvero fatti da programmatori junior) per permettere di chiarire concetti basilari date spesso per scontato. 

Raddoppiare il numero di persone raddoppia la produttività?
__No__, è stimato invece che la produttività aumenti circa del 50% - quindi non abbastanza per giustificare il costo.

Diversi studi si chiedono se la produttività calcolata puntualmente sia una metrica sensata. 
Secondo molti no, perché al termine di un'iterazione ciò che sembra poco produttivo in realtà lo è di più: il tempo non successivamente speso in verifica, convalida e refactoring è largamente assorbito dall'__ispezione continua del codice__ svoltasi durante le sessioni di pair programming.

#### Critiche
Betrand Meyer, nel suo libro _"Agile! The Good, the Hype and the Ugly"_, scrive:

> __Applied judiciously, pair programming can unquestionably be useful__. Many developers enjoy the opportunity to program jointly with a peer, particularly to deal with a thorny part of an assignment. 
> The basic techniques, in particular the idea of speaking your thoughts aloud for immediate feedback, are well understood and widely applied. (As a manager I regularly hear, from a developer, “On this problem I would like to engage in a round of pair programming with X ”, and invariably find it a good idea.)
> 
> What is puzzling is the insistence of XP advocates that this technique is the only way to develop software and has to be applied at all times. __Such insistence makes no sense__, for two reasons.
> 
> The first is the __inconclusiveness of empirical evidence__, noted above. Granted, lack of data is often used as a pretext to block the introduction of new techniques. 
> When an idea is obviously productive, we should not wait for massive, incontrovertible proof. 
> But here there is actually a fair amount of empirical evidence, and it does not show a significant
advantage for pair programming. 
> Pair programming may be good in some circumstances, but if it were always the solution the studies would show it. 
> In the absence of scientific evidence, a universal move is based on ideology, not reason.
> 
> The second reason, which may also explain why studies’ results vary, is that __people are different__. 
> Many excellent programmers love interacting with someone else when
they write programs; and many excellent programmers do not. 
> Those of the second kind want to think in depth, undisturbed. 
> The general agile view is that communication should be encouraged and that the days of the solitary, silent genius are gone. 
> Fine; but if your team has an outstanding programmer who during the critical steps needs peace, quiet and solitude, do you kick him out of the team, or force him to work in a way that for him may be torture?

> It is one thing to require that people explain their work to others; it is another, quite dangerous, to __force a single work pattern__, especially in a highly creative and challenging intellectual endeavor. 
> When Linus Torvalds was writing Linux, he was pretty much by
himself; that did not prevent him from showing his code, and, later on, engaging thousands of people to collaborate on it.

### 8. Proprietà collettiva
Il codice non appartiene a una singola persona ma al _team_: non devono quindi esistere policy di _"code owners"_ a la Microsoft.
Tutti i componenti del team sono quindi autorizzati a modificare e sistemare ogni parte del codice, anche se scritta da un altro. 

Durante il giorno, più volte al giorno, è comune __cambiare coppia__ e saranno quindi possibili situazioni in cui nessuno dei due ha una profonda conoscenza della parte di codice che si sta trattando o che il task non si addica alle competenze della coppia.

In tutti i casi, in XP ci si riferisce al team e non al singolo.

### 9. Integrazione continua
Nell'ottica di ricevere feedback rapidi dal cliente è necessario __integrare spesso__, anche __più volte al giorno__. 
Questo non significa far passare i test d'unità per integrare tutto in un'unica operazione, ma essere graduali: è frequente scoprire che parti testate e funzionanti singolarmente una volta integrate nel prodotto finale non funzionano. 

L'integrazione continua e graduale è una tecnica largamente utilizzata in tutti i campi, non solo nello sviluppo software.

Al termine dello sviluppo di una _feature_, è compito della coppia integrarla nella __macchina di riferimento__.
L'accesso a tale macchina deve essere regolato in maniera __esclusiva__: in situazioni di lavoro da remoto si può utilizzare un token.
La macchina di riferimento si trova, per quanto riguarda le funzionalità, in una situazione __monotona crescente__.
Ad ogni integrazione è necessario produrre sempre qualcosa di consegnabile al cliente. 

Una _user story_ si definisce __completata__ solo dopo aver terminato l'integrazione, superato dei test di integrazione e aver mostrato al cliente il risultato della macchina complessiva dopo l'integrazione.

Un'altro punto a favore della continua integrazione è che evita la situazione in cui una coppia modifichi la macchina __dopo molto tempo__ dalla propria ultima integrazione, aumentando di molto la probabilità di errori per le altre coppie. 

Se una coppia __non riesce ad integrare__ blocca anche tutte le altre che non possono andare avanti con le use story, quindi sarà necessario che quella coppia rinunci, ritorni sulla sua macchina e cerchi di risolvere lì - tutte le coppie hanno una propria macchina su cui testano prima di farlo su quella comune.

### 10. Settimana di 40 ore
Il mestiere di sviluppatore ha sempre avuto dei __ritmi dettati dalle consegne__: lavorare troppo a lungo porta a un abbassamento della produttività, oltre che a stress e frustrazione. 

Nell'XP si cerca di evitare queste situazioni in modo da avere una resa migliore, avere maggior soddisfazione nel lavorare nel team e nell'azienda, avere meno problemi fuori dal lavoro (tante volte questo eccessivo lavoro può causare problemi familiari) e inoltre abbassare la probabilità per l'azienda di perdere dipendenti. 

Purtroppo però il mestiere dello sviluppatore non è meccanico e molto spesso si vuole portare a termine quello che si sta facendo perchè magari si è quasi alla soluzione, inoltre si continua a pensare a come risolvere dei problemi anche fuori dall'orario lavorativo.

### 11. Cliente sul posto

Dal punto di vista del cliente, il suo inserimento nel luogo fisico di sviluppo è un vantaggio in quanto può essere sicuro che gli sviluppatori stiano lavorando per lui e __può verificare come procede il progetto__.

Dal punto di vista degli sviluppatori, invece, è fondamentale avere il cliente sul posto per potergli __chiedere chiarimenti__ in caso di specifiche non chiare. 
La possibilità di poter far domande è come avere una _documentazione vivente_; il cliente potrà continuare a lavorare per la sua azienda, ma dovrà dare priorità alle richieste degli sviluppatori. 

Avere il cliente sul posto ha comunque dei __limiti__: quest'ultimo, infatti, deve essere scelto accuratamente per avere una persona rappresentativa di tutti gli stakeholder; il compito è forse impossibile.
Se il cliente del posto non è disponibile, il team deve trovare dei modi per poter comunque avere un _punto di riferimento_: la tecnica Scrum introduce il concetto di __product owner__, un componente interno al team che si comporta come se fosse il cliente.

Il cliente durante le iterazioni può __creare altre storie__ che a partire dall'iterazione successiva potrà inserire nel planning game; è inoltre disponibile per __test funzionali__.

### 12. Standard di codifica
È necessario prevedere delle regole (__convenzioni comuni__) che specificano come scrivere il codice, per aumentare la leggibilità e quindi la comunicazione attraverso il codice.

Spesso, si utilizzano degli __strumenti__ per garantire il rispetto delle convenzioni o autocorreggere il codice auutomaticamente.

Avere uno standard di codifica aiuta inoltre:
- il refactoring;
- la programmazione a coppie;
- la proprietà collettiva.

### 13. _They're just rules_
L'ultima regola _"non è canonica"_, in quanto è stata aggiunta successivamente da alcuni agilisti.

Al termine di un'iterazione si fa un __resoconto__ e quindi decidere come comportarsi per l'iterazione successiva.
Nel suddetto resoconto si può anche decidere di __sospendere regole__ se si pensa che non siano adatte per la situazione o per il team e successivamente possono essere reintrodotte. 
La decisione di non seguire una regola deve essere sempre fatta a livello di __team__, non dal singolo o dalla coppia.

In conclusione, l'XP non è una tecnica così rigida e rigorosa: ad ogni iterazione, si possono effettuare test per trovare il giusto equilibrio.

Questo punto non però è condiviso da tutti e una motivazione la si può trovare nel fatto che tutti i punti sono interconnessi tra loro, e quindio non è possibile studiarli singolarmente senza considerate anche gli altri perchè non avrebbero senso in quanto hanno una forte dipendenza l'una dall'altra; non a caso nei punti sopra si può notare come si influenzino a vicenda.

## XP e modello a cascata
È possibile tentare di  raggruppare le diverse tecniche dell'eXtreme Programming nelle macrofasi descritte dal modello a cascata.

- __Requirements__:
    - i _clienti fanno parte del team di sviluppo_: requirements viventi;
    - _consegne incrementali_ e pianificazioni continue: evoluzione del progetto.
- __Design__:
    - _metafora_ come visione unificante del progetto;
    - _refactoring_: è design puro, molto utile per rendere possibile l'evolvibilità del software;
    - presumere la _semplicità_.
- __Code__:
    - _programmazione a coppie_;
    - _proprietà collettiva_;
    - _integrazione continua_;
    - _standard di codifica_.
- __Test__
    - _test di unità_ continuo (da scriversi prima del codice);
    - _test funzionale_ scritto dagli utenti nelle user stories.

In XP è inoltre presente la nozione di _prototipo_ sotto il nome di ___spike___, ovvero programmi molto semplici creati per esplorare soluzioni potenziali.
Sono utili per capire se ho compreso le specifiche, la tecnologia da utilizzare e l'approccio da avere con i componenti esterni con cui bisogna dialogare. 
Questi prototipi vengono creati, mostrati al cliente e quindi scartati.

## Documentazione
La __documentazione__ cartacea __non è necessaria__: 
il cliente, il compagno di peer programming e il codice _sono la documentazione_.

La documentazione è sostituita dal codice in quanto:
- i __test di unità__ che sono delle _specifiche eseguibili_, infatti li scrivo prima di fare il codice (prima dico cosa voglio tramite il test);
- il __continuo refactoring__ consente di avere un codice estremamente leggibile e quindi elimina il bisogno dei commenti.
Scrivere codice semplice tramite refactoring in modo che sia facilmente comprensibile è in realtà molto complesso.

### CRC cards
Le __Class Responsibility and Collaboration cards__ permettono di rappresentare classi e le relazioni tra di esse.
Nate in ambiente didattico per spiegare l'OOP, sono ora utilizzati da alcuni team agile per discutere di design e il modo di utilizzo è simile a quello del planning game.

> Le carte CRC sono realizzate su piccole schede di carta o cartoncino. Ciascuna carta descrive una classe (o un oggetto) in modo sommario, indicando:
> 
> - Il nome della classe
> - Le sue superclassi e sottoclassi (dove applicabile)
> - Le sue responsabilità
> - Il nome di altre classi con cui questa classe collabora per svolgere i compiti di cui è responsabile
> - L'autore
> 
> L'uso di schede di piccole dimensioni ha lo scopo di limitare la complessità della descrizione, evitando che vengano riportate troppe informazioni di dettaglio. Serve anche a impedire che a una classe vengano assegnate troppe responsabilità. Il supporto cartaceo consente una serie di attività gestuali utili in fase di brainstorming, come piazzare le carte su un tavolo e spostarle, riorganizzarle, o anche eliminarle e sostituirle facilmente con altre nel corso della discussione. Il posizionamento delle carte su un tavolo può essere usato intuitivamente per rappresentare informazioni aggiuntive; per esempio, due carte possono essere parzialmente sovrapposte per indicare una relazione di stretta collaborazione, o una carta può essere posta sopra un'altra per indicare una relazione di controllo/supervisione.
> 
> _Da [Wikipedia](https://it.wikipedia.org/wiki/Carte_di_Class_Responsibility_Collaboration), l'enciclopedia libera (licenza CC BY-SA 3.0)_.

## Quando non utilizzare XP
Back non esclude mai la possibilità di utilizzare l'XP: secondo lui diceva può provare ad utilizzare questo approccio sempre (anche se in realtà non è sempre possibile "provare"), a patto che vengano rispettati i 12 punti elencati sopra.

Da questo possiamo concludere che Agile non si può usare quando:
- l'__ambiente__ non permette l'applicazione dei 12 punti, come per esempio succede con i team dislocati in luoghi diversi;
- ci sono __barriere managieriali__, come team troppo numerosi;
- ci sono __barriere tecnologiche__, come quando per esempio non è possibile utilizzare una macchina specifica condivisa da tutte le coppie per i test, ostacolando l'integrazione continua.
- ci sono __troppi stakeholders__ diversi e in contrasto tra loro;
- situazioni in cui __la consegna incrementale non ha senso__, come per una _centrale nucleare_ (vero [Dyatlov](https://en.wikipedia.org/wiki/Anatoly_Dyatlov)?).

## Critiche
Di seguito sono elencate alcune critiche all'eXtreme Programming fatte da Meyer (già pluricitato in questo documento).

- __Sottovalutazione dell'up-front__, ovvero la progettazione iniziale prima di partire. Per Meyer, a parte in casi eccezionali (sviluppatori o manager particolarmente bravi) la progettazione non può essere fatta in modo totalmente incrementale. Nell'esperienza dei tesisti e colleghi di dottorando del prof. Bellettini questo problema non è così presente, ma potrebbe trattarsi di _survivorship bias_.
- __Sopravalutazione delle user stories__: secondo Meyer sono troppo specifiche per sostituire i requisiti.
- __Mancata evidenziazione delle dipendenze tra user stories__. 
Le _user stories_ dovrebbero essere indipendenti tra loro, ma questo non è quasi mai possibile; nel design classico si utilizzano i diagrammi di Gantt per chiarire tutte le dipendenze tra i diversi punti del sistema da realizzare.
- Il __TTD può portare ad una visione troppo ristretta__.
- __Cross functional team__: se i team sono troppo disomogenei, ovvero ci sono tante singole figure specializzate in un campo e queste devono collaborare in coppia, ci possono essere dei problemi.

I punti di cui sopra cercano di evidenziare la mancanza di approfondimento e chiarezza dell'XP su alcuni aspetti dell'approccio ad un lavoro fornito da un cliente.

È consigliata la lettura del libro di Meyer.

## Mesi uomo
I manager pensano che la stima del tempo in mesi uomo sia graficata come un ramo di iperbole, ovvero che possibile aumentare il nuermo di uomini per diminuire il tempo stimato senza considerare i tempi di overhead, ovvero tutto il tempo impiegato per la comunicazione e tutto ciò che non è l'implementazione. Questo ovviamente non è vero, i mesi uomo non sono una metrica valida, sono utili solo a posteriori per capire se un certo approccio ad un problema si è dimostrato valido.
Nella realtà all'aumentare delle persone aumenta il bisogno di comunicare.
C'è anche il caso in cui all'aumentare delle persone il tempo di consegna non cambia, questo si verifica quando il lavoro è strettamente sequenziale e non paralelizzabile (esempio gravidanza).
Infine nel software abbiamo un caso ancora differente, ovvero abbiamo un numero ideale di persone, dopodichè le persone in più causano solo confusione e rallentano i tempi a causa della comunicazione. Il nuemro può essere grande però, dipende dall'entità del progetto (esempio space shuttle).
In generale nelle metodologie agili se il team è più grande di 8-10 persone inizia a non funzionare più, e questo può essere visto come un caso in cui l'extreme programming non va utilizzato, ovvero (sistema questa parte, da 01:05:00 a 01:07:00 della videolezione 4 parte, successivamente sempre nella videolezione ci sono i riferimenti ai vari libri).
