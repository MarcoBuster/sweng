---
layout: post
title: "[03] eXtreme programming"
date:   2022-10-10 14:40:00 +0200
toc: true
---

# eXtreme programming
Concetto principale dell'extreme programming
> Increment then simplify

## Test Driven Development

Il _test driven development_ (TDD) è una __tecnica di progettazione__ che guida verso il design più semplie. Non è ne un'attività di verifica ne di scrittura del codice.

> TDD = test-first + baby steps

Il signifcato di questa espressione è di fare prima il test e poi passi molto piccoli. Concetto di feedback instantaneo: faccio piccoli passi e testo ogni volta. Non scrivo tanto codice senza fare alcun test.

Il "mantra" del TDD è __red__, __green__, __refactor__, infatti:

- ogni volta che devo aggiungere qualcosa faccio prima il test che fallisce (<span style="Color: red">rosso</span>)
- poi lo faccio diventare <span style="Color: red">verde</span> il prima possibile, ovvero scrivo il codice nel modo corretto il prima possibile (quasi come se fosse nua bozza) cosi facendo il test diventa verde. in questo modo ho sempre un feedback di quello che faccio
- refactoring -> fattorizzare, riorganizzare e riscrivere il codice in modo da renderlo migliore (in questa fase dobbiamo rimanere in uno stato verde).
questa cosa va fatta con una cadenza frequente, ogni 2-10 minutii: compiti semplici.

Quindi prima faccio qualche piccolo progresso (increment) e poi lo semplifico (semplify)

È necessario passare per quel passaggio intermedio (la bozza menzionata al punto 2 dell'elenco precendete) perchè in questo modo una volta che abbiamo una base funzionante sicuramente nella fase di refactoring ciò che ho fatto continuerà a funzionare (non si torna al rosso). Se scrivessimo direttamente il codice in "bella" impiegheremmo molto più tempo e magari alla fine non abbiamo neanche un codice funzionante (siccome implementare del codice gestendo ogni particolare fin da subito al meglio ècomplesso ed è facile commettere errori).

Perchè il TDD è una tecnica di progettazione?
- spesso capita di scrivere codice difficilmente testabile; scrivere il test prima e il codice dopo aiuta a progettare prodotti _test-first_;
- scrivere prima i test aiuta a definire le interfacce del programma (e come comunicano), perché durante il testing ci si pone dal punto di vista del clinte, se non dovessimo farlo potremmo avere delle dipendenze complicate da rimuovere.

## eXtreme Programming (XP)
Ora possiamo iniziare a parlare di extrene programming, nasce tra la fine degl anni 90 e inizio del 2000, la figura di riferimento è Kent Beck.

### Le variabili in gioco
secondo kent Beck, l'ideatore dell'extreme programming, in un software le variabili sono:
- __portata__: quantità di funzionalità da implementare, la portata èmutevole siccome il numero di funzionalitàda implementare può cambiare nel tempo.
- __tempo__: tempo dedicabile al progetto;
- __qualità__: la qualità del progretto che si deve ottenere (principalmente correttezza e affidabilità);
- __costo__: risorse finanziare che si possono impegnare.

Queste 4 variabili __non sono indipendenti__, una influenza le altre; possiamo dire che la qualità non è negoziabile, deve essee per forza massima, quindi bisogna lavorare sulle altre, sopratutto bilanciando costo e tempo.
Con l'XP si stravolge la prospettiva: __il costo è orario__, il tempo verrà deciso successivamente, e infine la portata viene ricalcolata durante il progetto, quindi l'unica variabile che cambia è la portata. Inoltre siccome è una tecnica fortenete incrementale non dò al cliente tutto il lavoro in un colpo solo, ma una parte alla volta. questo serve per 2 motivi:
- Il cliente vede che sto lavorando, siccome vede il prodotto crescere.
- Da la possibilità al cliente di avere comunque qualcosa in mano anche se ad un certo punto vuole interrompere la collaborazione.
Quindi non abbiamo più un rapporto così conflittuale tra cliente e sviluppatore.

### Principi dell'extreme programming
- __Feedback rapido__ da test, cliente e colleghi. In alcune aziende viene fatto uno _standup meeting_: poche parole in piedi per dire cosa è stato fatto e le successive intenzioni.
- __Presumere la semplicità__: Non pianificare per il futuro ma per ciò che ti serve nel breve termine, questo sia per quanto riguarda la pianificazione del prodotto da creare sia per la progettazione del team, che deve essere semplice (per esempio non gerarchica). in generale questa regola vale per tutti gli ambiti del progetto.
- __Accettare il cambiamento__: non ci si deve aspettare che il software sia immutabile, deve essere dato per scontato il concetto di flessibilità, ovvero che il cliente vorrà fare cambiamenti sia dopo che durante lo sviluppo del prodotto.
- __Modifica incrementale__: Qui rientra il concetto di baby steps visto prima, ma non solo, per esempio vale anche per il team, ovvero non bisognerebbe mai aggiungere più di una persona al gruppo di valoro (se ne aggiungo di più potrei passare più tempo ad istruirle che a sviluppare).
- __Lavoro di qualità__: far star bene lo sviluppatore; la fidelizzazione dello sviluppatore è importante perchè più lo sviluippatore si trova bene e meglio lavora.

Nell'ingegneria classica invece abbiamo (alcuni sono condivisi con l'extreme programming):
- __Separazione degli interessi__ (_aspects_ o _concerns_): separare tempi, responsabilità, moduli, ovvero tutte le varie viste o le varie dimensioni su cui devo affrontare il mio problema. anche l'extreme programming da per scontato questo principio.
- __Astrazione e modularità__: ciò che ci permette di dominare i problemi complessi (possono essere i diversi linguaggi di programmazione, linguaggi di descrizione o i vari costrutti che abbiamo usato).
- __Anticipazione del cambiamento__ (_design for change_): in fase di progettazione il programmatore pensa a come potrebbe cambiare il prodotto per aggiungere requisiti che il cliente magari non aveva neanche pensato. Spesso però questo concetto complica arbitrariamente la progettazione e lo sviluppo, considerando anche che sono solo fantasie; può essere un'idea migliore farlo semplice ed incrementarlo man mano.
- __Generalità__
- __Incrementalità__
- __Rigore e formalità__

I due punti più in contrasto sono presumere la semplicità e l'anticipazione del cambiamento.

### Presumere la semplicità vs anticipazione del cambiamento
- XP mette davanti la semplicità all'anticipazione del cambiamento: non sto inserendo cose che mi serviranno per il futuro, ma non è detto che non stia progettando per il futuro. Diciamo non è il primo aspetto da guardare, il primo aspetto è la semplicità, ovvero fare le cose nella maniera più chiara possibile.
- Secondo Bohem (1976) invece, si ipotizza una curva di tipo esponenziale per il corso delle modifiche all'aumento dell'avanzamento del progetto.
    - Dal'altro canto, per l'XP questa curva ha un asintoto orizzontale a un certo punto.
    - "Nei primi tempi poteva essere vero, ma ora è meglio rimandare l'aggiunta di modifiche fino a quando non servono.", appunto perchè da un certo punto in poi il costo delle modifiche non subisce cambiamenti sensibili, siccome abbiamo del codice semplice e facile da modificare.

Bohem parlava in realtà di cost to fix, non per modificare: la generalizzazione è un po estesa; inoltre la sua statistica era poco affidabile perchèsi basava su pochi elementi. La curva è stata poi ritrattata per accomodare il fatto che se un errore avviene in una fase affligge solo le successive, e non le precedenti.

## Figure in gioco e responsabilità
Solitamente ci sono tre figure:
- cliente -> colui che fa le richieste e che conosce il dominio applicativo.
- sviluppatore -> Colui che va a sviluppare e a scrivere il codice.
- manager -> a volte si fonde con il cliente siccome possiamo dire che hanno gli stessi diritti e responsabilità, infatti successivamente li consideriamo come una cosa sola

Manager/cliente
- ha responsabilità di decidere
    - la portata del progetto -> cosa deve fare il progetto, questa cosa può essere limitata dal manager
    - priorità (_business value_) tra le funzionalità -> valore di mercato, ovvero si ragiona cosa vale la pena aggiungere al progetto per far si che il prodotto finale valga di più.
    - date dei rilasci -> quando ti do il prodotto oppure ogni quanto se adottiamo una sviluppo incrementale
- ha diritto di:
    - trasparenza del processo di sviluppo: sapere cosa è stato fatto, cosa può essere fatto, con quali e tempi e quali i costi.
    - vedere progressi nel sistema, provati dal superamento dei test da lui definiti. Il cliente deve poter vedeere anche le qualità interne e come sta evolvendo il progetto anche in mezzo ad un'iterazione, questo per poter incrementare la fiducia tra cliente e sviluppatore.
    - cambiare idea, sostituire funzionalità e cambiare prorità a intervallo di tempo (in genere ogni due settimane, ovvero il tempo dell'iterazione).

Sviluppatore
- ha responsabilità di decedere:
    - stime dei tempi per le singole funzionalità -> ovvero decide lo sviluppatore quanto tempo serve per sviluppare una funzionalità (quindi il manager non dice più "fammelo in una settimana" ma "Quanto ci metti a farlo").
    - conseguenze di scelte tecnologiche -> questo perchè ha conoscenze superiori rispetto al cliente per poter scegliere quali soluzioni tecnologiche adoperare.
    - pianificazione dettagliata -> sceglie anche come ci si organizza all'interno di un'iterazione.
- ha diritto di:
    - sapere cosa è necessario fare attraverso dei requisti chiari, sottoforma di casi d'uso (storie di uso) con priorità. per casi d'uso si intende che il cliente specifichi cosa deve succedere date delle condizioni, evitando una specifica formale.
    - cambiare stimi tempi con l'esperiezna, come il cliente cambia idea anche lo sviluppatore può cambiare le stime sul tempo. Questo non è come dire che lo sviluppatore ha commesso un errore, ma che il contesto in cui doveva realizzare una certa feature è cambiato, considerando che con l'esperienza il tempo di realizzazione diminuisce.
    - identificare e indicare le funzionalità _pericolose_, ovvero funzionalità che potrebbero essere difficili da applicare e su cui si poggiano le richieste principali del cliente.
    - produrre software di qualità

## Tecniche XP

L'extreme programming fornisce una serie di pratiche per poter garantire tutto ciò che è stato descritto fino ad ora. Lo schema sottostante le descrive mettendole in relazione tra loro in modo che i vari aspetti negativi delle diferse pratiche siano compensati dagli aspetti positivi di quelle in relazione con loro. In sostanza abbiamo un mix perfetto di attività organizzate in modo da garantire i principi.

{% responsive_image path: assets/03_approccio.png %}

### 1. Planning game
È l'attività che viene fatta all'inizio dell'iterazione e serve per "congelare" il sottoinsieme di requisiti sul quale il team lavorerà per le prossime ~2 settimane.

Si inizia da dalle richieste del cliente, ovvero le _user stories_, una versione semplificata degli _use case_ degli UML; hanno come soggetto sempre un ruolo specifico nell'azienda del cliente.
Lo scopo del planning game è determinare quali funzionalità saranno presenti nel prossimo rilasio, combinando priorità commerciali e valutazioni tecniche, questo richiede una collaborazione con il cliente, che come vedremo sarà in loco (in scrum si introduce un "product owner portavoce del cliente").

#### Procedura
<!-- immagine scheda -->
1. All'inizio il cliente prepara le carte, che sono piccole in modo da non scrivere tanto. In ogni carta c'è:
- un identificativo;
- una breve descrizione che descrive uno scenario d'uso;
- un caso di test che funge da test d'accettazione (in sostanza un esempio, possono essere anche un paio, un caso posiitvo e uno negativo);
- il valore di business che ha per il cliente.
2. Il team di sviluppatori stima il tempo necessitario: ognuno dà la propria stima. Sul retro della carte si tiene un resoconto di ciò che si è fatto. Un sviluppatore prende il ruolo di _tracker_ e si impegna a tracciare lo stato di avanzamento durante le due settimane (per esempio quante feature fatte, quanti bug segnalati, ecc).
3. Il manager quindi sulla base di queste informazioni decide quali schede verranno implementate alla prossima iterazione. Le varie funzionalità rappresentate nelle carte in teoria sono indipendenti, quindi il manager per compiere queste scelte calcola il valore fratto tempo stimato e ordina le carte, in questo modo può scegliere meccanicamente le schede da utilizzare durante l'iterazione (in realtà compie dei ragionamenti, quindi non è un'operazione così meccanica).

### Le stime
Le stime sono fatte da parte del team, composto da persone diverse chee quindi faranno stime diverse. Questo è dato anche dall'esperienza del team, lo svilupatore junior può non essere in grado di dare una stima siccome è alle prime armi, o comunque stimerà un tempo maggiore rispetto ad uno sviluppatore esperto, ma in ogni caso è tenuto anche lui a dare un'opinione.

possiamo avere stime:
- __molto differenti__ (ore vs giorni): in questo caso, è possibile che la carta non sia descritta o compresa correttamente; bisogna raggiungere un accordo siccome se uno sviluppatore stima poche ore e un altro qualche giorno abbiamo dei problemi. Se viene deciso che il tempo per una data scheda è di qualche ora e viene assegnato allo sviluppatore che aveva fatto una stima più alta allora si troverà in difficoltà nel portare a termine il compito. in conclusione è necessario trovare un punto di incontro.
- quasi uniformi, ma __molto alte__: potrebbe essere che la storia sia troppo ampia. Se alla fine dell'iterazione no ho portato a termine il lavoro prefissato è come se non l'avessi fatto, e quindi il suo valore è zero (anche se magari era stato completato all'80%), perchè il cliente non lo avrà alla fine dell'iterazione. Questo concetto è molto importante nelle tecniche agili. Per ovviare a questo problema si può fare lo __splitting__ delle carte, ovvero scomponiamo una carta in più carte in modo da scomporre il problema.
- non c'è accordo ma __sono simili__: non bisogna prendere la più bassa, alta o la media. Secondo XP bisogna arrivare ad un accordo in modo tale che chiunque nel team si riconosca nella stima effettuata, la stima non è del singolo.

La fase di stima dei tempi si porta dietro diverse problematiche, tra cui:
- perdita di tempo per accordarsi su ciò che si dovrà fare (troppa comunicazione);
- effetto àncora (anchoring effect): effetto che si verifica quando le persone devono assegnare un valore ad una quantità ignota, se questo viene fatto, tutte le stime successive del valore saranno fatte in riferimento al primo valore deciso. Nel nostro caso quando il team si riunisce per fare delle stime e il primo membro da la sua opinione, tutte le stime successive saranno fatte in confronto alla prima stima fatta. Il cervello unano tende a ragionare in questo modo.

#### [Planning poker](https://en.wikipedia.org/wiki/Planning_poker)

{% responsive_image path: assets/03_planning-poker.jpg %}

Vengono presentate brevemente le carte con attenzione a non fare riferimento alle tempistiche in modo da non creare subito l'effetto àncora, successivamente il team può fare domande, chiedere chiarimenti e discutere per chiararire assunzioni e rischi.
Dopodichè ogni componente sceglie una carta del poker per rappresentare la propria stima. Le carte vengono girate contemporaneamente in modo da evitare l'effetto ancora, quindi la prima stima è _blind_. Ci sono anche delle carte particolari, ovvero:
- il punto di domanda indica che non si è in grado di dare una stima
- la tazza di caffè indica che la riunione è andata troppo per le lunghe e è necessaria una pausa.
Dopo ogni giro di carte, solo chi ha fatto la stima più bassa e la più alta parlano (per ~1 minuto) per motivare la propria scelta in modo da cercare di trovare un punto in comune. Successivamente tutti fatanno una nuova stima e solitamente le votazioni convergono (non sempre, a volte ci vogliono più "giri" di votazione).
Sulle carte usate dal team per fare la stima ci sono dei numeri che rappresentano i tempi stimati per quel task, l'unità di misura di questi numeri può essere scelta prima o dopo aver trovato un acordo. Queste unità di misuta possono variare, può essere ore, giorni, pomodori (un pomodoro è formato da 25 minuti senza alcuna distrazioni,e dopo c'è una pausa).
Ovviamente non si può pretendere si lavorare delle ore senza alcune distrazioni, quindi in queste stime si considera uno __slacl time__, ovvero un tempo cuscinetto per che comprende il "tempo perso" a causa di distrazioni.

#### [Team Estimation Game](https://agilelearninglabs.com/2012/05/how-to-play-the-team-estimation-game/)
Metodo un po più complesso, si compone in 3 fasi, e alla base si ha un confronto tra i diversi task da fare.
È facile dire che un task è più facile di un altro, ma il difficile è capire di quanto, quindi il cercare di splittare in fasi questa cosa di dover dare un valore al task considerandone sempre di più difficili può aiutare a fare una buona stima.

##### PRIMA FASE
{% responsive_image path: assets/03_team-estimation-1.jpg %}

Si fa una pila con le storie e si mette la prima carta al centro del tavolo. I developer si mettono in fila:
- il primo della fila prende una carta della pila, la rilegge (ad alta voce) e la posiziona a sinistra (più semplice), a destra (più complicata) o sotto (equivalente).
- il prossimo developer può:
    - prendere una nuova carta della pipa e posizionarla secondo le stesse regole (può anche distanziare due file e metterla in mezzo tra le due);
    - spostare una carta precedentemente posizionata (commentando la motivazione della sua azione), ovviamente può succedere che venga rispostata nella sua posizione originale ma si punta a trovare un accordo sulla difficoltà della carta (il task).

A questo punto abbiamo le carte disposte sul tavolo in colonne di difficoltà comparabile, ordinate dalla meno difficile (sinistra) alla più difficile (destra).
Usando questa tecnica abbiamo evitato anche l'effetto àncora, o per lo abbiamo ma diverso (molto più lieve), siccome le stime sono relative, non abbiamo un valore preciso che può influenzare gli altri. A differenza del planning poker posso tornare sulle mie decisioni e quindi ho un continuo adattamento e ripensamento delle stime, grazie al fatto che sono stime relative (e no valori specifici).

##### SECONDA FASE
Ora si cerca di quantificare le distanze tra le carte.

{% responsive_image path: assets/03_team-estimation-2.jpg %}

Ci si mette di nuovo in coda davanti al tavolo con il mazzo di carte del planning poker (uno solo, non uno per persona), e si cerca di etichettare le colonne in base alle difficoltà.

Si posiziona la prima carta (solitamente si parte da 2 perchè magari nella prossima iterazione può esserci qualcosa di ancora più facile) sopra la prima colonna.
Il primo sviluppatore prende il valore successivo e lo posiziona sulla prima colonna che pensa abbia quel valore (rispetto al 2), oppure lo posiziona tra due colonne se pensa che sia un valore di difficoltà intermedio tra le due.
Gli sviluppatori successivi invece possono fare due cose:
- prende una carta dal mazzo e la posiziona secondo le regole di prima (la prima colonna che pensa abbia quel valore di difficoltà)
- Spostare una carta con un valore precedentemente posizionata, commentando la motivazione dello spostamento
- nel caso in cui non ci siano più carte nella pila e non vuole spostare altre carte, lo svuluppatore può passare.

È possibile avere delle carte in cui sopra non c'è nessun numero, queste saranno assimilate alla colonna alla loro sinistra, e avremo una situaione di questo tipo

<!-- {% responsive_image path: assets/fine-seconfa-fase-estimation-game.jpg %} -->


##### TERZA FASE
Si stima il tempo in ore/uomo di una delle carte più semplici e successivamente si calcolano tutte le colonne in proporzione alla prima.
Ma questa fase è davvero cosi utile? nella pratica si è visto che non è una utile valutare tutto il lavoro fatto in ore/uomo, anche perchè con il passare del tempo la taratura può variare.
Possiamo allora prendere tutte le carte portate a termine e assegnamogli un valore, questa cosa si chiama __velocity__.

#### Velocity
La capacità osservata (quindi alla fine dell'osservazione) di qunato sono riuscito a fare in termini di complessità astratta.
Se per esempio sono riuscito a fare 50 punti nella iterazione appena finita, posso prefissarmi di fare almento 50 punti nell'iterazione successiva.
La Velocity non può essere usata per dare premi, per confrontare team diversi o punire in caso di diminuzione, però si adatta al modo diverso degli sviluppatori di gestire le stime e anche al fatto che ho una tendenza a sottostimare le diverse carte.
Se aggiungo una persona lascio questa metrica inizialmente invariata, per la formazione; se la rimuovo ci sarà una perdita di produttività.
 La Velocity non deve considerare le storie lasciate incompiute, quindi anche se l'ho completata al 90% devo considerarla come se non l'avessi fatta.
Inoltre non deve essere imposta, nel senso che se la velocity di un team è x non deve essere aumentata per produrre come un altro team.
Acnhe qui abbiamo lo slack time visto nel planning poker.

Esiste un movimento chiamato no estimates, che evita tutta questa parte delle stime, ma dall'esperienza di bellettini si vede che funziona in generale per team molto maturi che sono in grado di guidare il ciente a formulare storie simili intermini di difficoltà, questo perchè tutti hanno una misura standard per le storie.

## 2. Brevi cicli di rilascio
Per ridurre i rischi, la vita e lo sviluppo dell'applicazione sono scanditi dai rilasci di dversioni del prodotto funzionanti. Di solito uno ogni due settimane (come abbiamo visto in scram con il freez, ma con un tempo di rilascio minore). Dobbiamo avere il tempo per sviluppare qualcosa di concreto, e il cliente per poter pensare alle richieste che ha fatto e pensare se ha bisogno di modifiche.

## 3. Uso di una metafora
Definire un nuovo vocabolario con cui parlare con l'utente (tecnica _non informatica_) ma anche ai nuovi sviluppatori.
Serve per permettere una nominazione di classi e metodi omogenei e fornire una vista d'insieme.
Siccome non c'è una vera documentazione in XP, possiamo usare queste metafore come una vista d'insieme, quindi sostituisce in parte l'architettura del sistema, e fa capire gli elementi fondametali, il loro scopo e le relazioni fra loro. ... non chiaro, sistema

## 4. Semplicità di progetto
chiamata anche l'arte di massimizzare il lavoro non fatto, o da non fare, infatti non è necessario riscrivere cose già esistenti e consolidate. uno slogan tipico è KISS: Keep It Simple, Stupid.
Questo punto si contrappone al Design for change che viene visto come un appesantimento inutile, perchè una feature che aggiungiamo può essere scartata dal cliente, e quindi abbiamo perso tempo inutilmente.

## 5. Testing
- I clienti scrivono i test di accettazione (o funzionali) sulle schede per aumentare la loro fiducia nel programmi.
- I programmatori scrivono i test di unità perché la fiducia nel codice diventi parte del programma stesso.

Nell'XP ogni aspetto viene massimizzato, ma in particolare il testing viene esasperato di più perchè molto importante siccome molti altri aspetti si basano su di esso. Possiamo dire quindi che ha il ruolo di _"rete di protezione"_ in tutte le varie fasi, ogni volta che faccio qualcosa posso verificarla tramite i test.

Il testing aiuta molto anche quando non si parte da 0 con il programma, per esempio quando il lavoro è proprio modificare un programma proprietario precedentemente sviluppato.
Può essere che non sia stato sviluppato in modalità agile e quindi non sono presenti test, a questo punto se devo fare alcune modifice prima scrivo i test e successivamente modifico il codice in modo da non causare problemi.

Un'altra cosa importante è che i test devono coprire tutte le righe di codice.

## 6. Refactoring
Non bisogna avere paura di apportare modifiche che semplificano il progetto: bisogna avere coraggio.

Il refactoring è un'operazione che modifica il software __ma non modifica le funzionalità__, quindi tocchiamo solo proprietà interne.
L'obiettivo è eliminare l'entropia con le continue modifiche e aggiunte. ??

Deve essere graduale e continua in modo da poter aggiungere funzionalità in maniera più semplice.

Se una parte di codice non viene stimolato dai test non è utile ai fini della soluzione, al massimo posso aggiungere dei test per gestire dei casi specifici, se no posso togliere le parti di codice non richiamate dai test.

## 7. Programmazione a coppie
Aiuta:
- Ad avere un controllo continuo delle regole di XP
- L'inserimento di nuovo personale e la sua formazione
- Ottenere una _proprietà colettiva_ (conoscenza osmotica)
- Il refactoring

Una domanda che si potrebbe porre il management è: ma dimezzare le persone che scrivono il codice non dimezza la produttività del team?
<!-- riassumere pippone -->
>>>>>>> marco/03-appunti
