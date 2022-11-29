---
layout: post
title: "[03] eXtreme Programming"
date:   2022-10-10 14:40:00 +0200
toc: true
---

# eXtreme Programming
Il concetto principale dell'eXtreme Programming è

> Increment then simplify

## Test Driven Development

Il _test driven development_ (TDD) è una __tecnica di progettazione__ che guida verso il design più semplice. 
Non è né un'attività di verifica ne di scrittura del codice.

> __TDD__ = _test-first_ + _baby steps_

Il significato di questa espressione è: prima fai il test e poi passi molto piccoli. 
Viene quindi introdotto il concetto di _feedback instantaneo_: faccio piccoli passi e testo ogni volta. 
Non scrivo tanto codice senza fare alcun test.

Il "mantra" del TDD è __red__, __green__, __refactor__, infatti:

1. ogni volta che devo aggiungere qualcosa faccio prima il test che fallisce (<span style="color: red">rosso</span>);
2. lo faccio poi diventare <span style="color: green">verde</span> il prima possibile, ovvero scrivo il codice nel modo corretto il prima possibile (quasi come se fosse una bozza). 
In questo modo ho sempre un feedback di quello che faccio;
3. nell'ultima fase, in cui bisogna sempre rimanere in uno stato di verde, si può procedere con il <span style="color: lightblue">refactoring</span> (fattorizzare) ovvero riorganizzare e riscrivere il codice in modo da renderlo migliore.
Questa cosa va fatta con una cadenza frequente, ogni 2-10 minutii: compiti semplici.

Quindi prima faccio qualche piccolo progresso (__increment__) e poi lo semplifico (__semplify__).

È necessario passare per lo step _verde_ (punto 2 dell'elenco precedente) prima di fare refactoring perchè in questo modo è semplice verificare che nella fase di refactoring ciò che è stato fatto continuerà a funzionare, senza retrocedere allo step precedente.
Se scrivessimo direttamente il codice in "bella" impiegheremmo molto più tempo senza la garanzia di avere codice funzionante alla fine, siccome implementare del codice gestendo ogni particolare fin da subito al meglio è complesso e prono agli errori.

Perchè il TDD è una tecnica di progettazione?
- spesso capita di scrivere codice difficilmente testabile; scrivere il test prima e il codice dopo aiuta a progettare prodotti _test-first_;
- scrivere prima i test aiuta a definire le interfacce del programma (e come comunicano), perché durante il testing ci si pone dal punto di vista del cliente, se non dovessimo farlo potremmo avere delle dipendenze complicate da rimuovere.

## La tecnica
Ora possiamo iniziare a parlare di eXtreme Programming, tecnica che nasce tra la fine degl anni 90 e inizio del 2000. La figura di riferimento è Kent Beck.

### Le variabili in gioco
Secondo Beck in un software le variabili sono:
- la __portata__, ovvero la quantità di funzionalità da implementare. Potendo il numero di funzionalità da implementare cambiare nel tempo, questa variabile può mutare;
- il __tempo__ dedicabile al progetto;
- la __qualità__ del progretto che si deve ottenere (principalmente correttezza e affidabilità);
- il __costo__, ovvero le risorse finanziare che si possono impegnare.

Queste 4 variabili __non sono indipendenti__, una influenza l'altra; si possono quindi bilanciare, soprattuto costo e tempo (ma non la qualità: che non è negozioniabile e deve essere massima).
Con l'XP si stravolge la prospettiva: __il costo è orario__, il tempo verrà deciso successivamente e la portata viene ricalcolata durante il progetto, quindi l'unica variabile che cambia è la portata.
Essendo inoltre una tecnica fortenete incrementale, il cliente non riceve il lavoro tutto in un colpo solo, ma una parte alla volta. 
Questa caratteristica ha diversi benifici:
- il cliente vede che sto lavorando, siccome vede il prodotto crescere - può anche fornire feedback estremamente utile per gli sviluppatori;
- da la possibilità al cliente di avere comunque qualcosa in mano anche se ad un certo punto vuole interrompere la collaborazione.

Il rapporto tra cliente e sviluppatore non viene più visto quindi come conflittuale ma come collaborativo.

### Principi dell'extreme programming
- __Feedback rapido__ da test, cliente e colleghi. In alcune aziende viene fatto uno _standup meeting_: poche parole in piedi per dire cosa è stato fatto e le successive intenzioni.
- __Presumere la semplicità__: non pianificare per il futuro ma per ciò che serve nel breve termine, sia per quanto riguarda la pianificazione del prodotto da creare sia per la progettazione del team, che deve essere semplice (per esempio non gerarchica). In generale questa regola vale per tutti gli ambiti del progetto.
- __Accettare il cambiamento__: non ci si deve aspettare che il software sia immutabile, deve essere dato per scontato il concetto di flessibilità, ovvero che il cliente vorrà fare cambiamenti sia dopo che durante lo sviluppo.
- __Modifica incrementale__: qui rientra il concetto di baby steps visto prima, ma non solo, per esempio vale anche per il team, ovvero non bisognerebbe mai aggiungere più di una persona per volta al gruppo di valoro (se ne aggiungo di più potrei passare più tempo ad istruirle che a sviluppare).
- __Lavoro di qualità__: far star bene lo sviluppatore; la fidelizzazione dello sviluppatore è importante perchè più lo sviluppatore si trova bene e meglio lavora.

Nell'ingegneria classica invece abbiamo (alcuni sono condivisi con l'extreme programming):
- __Separazione degli interessi__ (_aspects_ o _concerns_): separare tempi, responsabilità, moduli, ovvero tutte le varie viste o le varie dimensioni su cui devo affrontare il mio problema; anche l'XP dà per scontato questo principio.
- __Astrazione e modularità__: ciò che ci permette di dominare i problemi complessi (possono essere i diversi linguaggi di programmazione, linguaggi di descrizione o i vari costrutti che abbiamo usato).
- __Anticipazione del cambiamento__ (_design for change_): in fase di progettazione il programmatore pensa a come potrebbe cambiare il prodotto per aggiungere requisiti che il cliente magari non aveva neanche pensato. Spesso però questo concetto complica arbitrariamente la progettazione e lo sviluppo, considerando anche che sono solo fantasie; può essere un'idea migliore farlo semplice ed incrementarlo man mano.
- __Generalità__.
- __Incrementalità__.
- __Rigore e formalità__.

I due punti più in contrasto sono _presumere la semplicità_ (XP) e l'_anticipazione del cambiamento_ (ingegneria classica).

### Presumere la semplicità vs anticipazione del cambiamento
XP dà priorità alla semplicità rispetto che all'anticipazione del cambiamento, ma non inserire funzionalità che non serviranno per il futuro non esclude necessariamente _progettare per il futuro_.
L'XP prescrive comunque la semplicità e la chiarezza rispetto a quest'ultimo. 
Secondo Bohem (1976) invece, si ipotizza una curva di tipo esponenziale per il costo delle modifiche all'aumento dell'avanzamento del progetto. 
Dal'altro canto, per l'XP questa curva ha un asintoto orizzontale a un certo punto.

{% responsive_image path: 'assets/03_bohem-cost-to-fix.png' %}

> _"Nei primi tempi poteva essere vero, ma ora è meglio rimandare l'aggiunta di modifiche fino a quando non servono."_, appunto perchè da un certo punto in poi il costo delle modifiche non subisce cambiamenti sensibili, siccome seguendo i principi dell'XP il codice rimane semplice e facile da modificare.

Bohem parlava in realtà del _cost to fix_, non della modifica in sé: la generalizzazione è un po estesa; inoltre la sua statistica era poco affidabile perchè si basava su pochi elementi. 
La curva è stata poi ritrattata per accomodare il fatto che se un errore avviene in una fase affligge solo le successive, e non le precedenti.

## Figure in gioco e responsabilità
Nell'XP sono generalmente previste tre figure:
- il __cliente__: colui che fa le richieste e che conosce il _dominio applicativo_;
- lo __sviluppatore__: colui che sviluppa e scrive il codice;
- il __manager__: a volte si fonde con il cliente siccome possiamo dire che hanno gli stessi diritti e responsabilità, infatti successivamente li consideriamo come una cosa sola.

### Manager/cliente
- ha responsabilità di decidere:
    - la __portata__ del progetto, ovvero _cosa_ deve fare il progetto. 
    Il manager può limitare questa proprietà;
    - le __priorità__ (_business value_ - valore di mercato) tra le funzionalità: si ragiona cosa vale la pena aggiungere al progetto per far si che il prodotto finale valga di più;
    - le __date dei rilasci__: decidere _quando_ (o _ogni quanto_ in caso di sviluppo incrementale) il prodotto viene rilasciato;
- ha diritto di:
    - avere __trasparenza__ del processo di sviluppo: sapere cosa è stato fatto, cosa può essere fatto, con quali e tempi e quali i costi;
    - vedere __progressi__ nel sistema, provati dal superamento dei test da lui definiti. Il cliente deve poter vedeere anche le qualità interne e come sta evolvendo il progetto anche in mezzo ad un'iterazione, per poter incrementare la fiducia tra cliente e sviluppatore;
    - __cambiare idea__, sostituire funzionalità e cambiare prorità a intervallo di tempo (all'inizio di un'iterazione e non durante).

### Sviluppatore
- ha responsabilità di decidere:
    - le __stime dei tempi__ per le singole funzionalità: è quindi lo sviluppatore che decide quanto tempo serve per sviluppare una funzionalità. Il manager non dice più _"fammelo in una settimana!"_ ma _"quanto ci metti a farlo?"_;
    - le __scelte tecnologiche__: avendo conoscenze superiori rispetto al cliente può scegliere quali soluzioni tecnologiche adoperare;
    - __pianificazione dettagliata__ come organizzarsi all'interno di un'iterazione;
- ha diritto di:
    - __sapere cosa è necessario fare__ attraverso dei requisti chiari, sottoforma di casi d'uso (_user stories_) con priorità. 
    Per casi d'uso si intende che il cliente specifichi cosa deve succedere date delle condizioni, evitando una specifica formale;
    - __cambiare idea__ sulle stime dei tempi con l'esperienza: come il cliente cambia idea anche lo sviluppatore può cambiare le stime sul tempo;
    In questi casi non è necessariamente vero che lo sviluppatore ha commesso un errore, ma che il contesto in cui doveva realizzare una certa feature è cambiato, considerando che con l'esperienza il tempo di realizzazione diminuisce;
    - __identificare e indicare le funzionalità _pericolose___, ovvero funzionalità che potrebbero essere difficili da implementare e su cui si poggiano le richieste principali del cliente;
    - __produrre software di qualità__.

## Tecniche XP

L'extreme programming fornisce una serie di pratiche per poter garantire tutto ciò che è stato descritto fino ad ora. 
Lo schema sottostante le descrive mettendole in relazione tra loro in modo che i vari aspetti negativi delle diferse pratiche siano compensati dagli aspetti positivi di quelle in relazione con loro. 
In sostanza, abbiamo un mix perfetto di attività organizzate in modo da garantirne i principi.

{% responsive_image path: assets/03_approccio.png %}

### 1. Planning game
È l'attività che viene fatta all'inizio dell'iterazione e serve per "congelare" il sottoinsieme di requisiti sul quale il team lavorerà per le successive ~2 settimane.

#### User stories
Tutto ha inizio dalle richieste del cliente, ovvero le _user stories_, una versione semplificata degli _use case_ degli UML. Ogni _user story_ è composta da tre parti: 
- il __soggetto__, ovvero il ruolo dell'utente nell'azienda - può anche essere esterno;
- l'__azione__ che vuole eseguire il soggetto; 
- la __motivazione__ che spinge il soggetto a portare avanti l'azione descritta.

Esempi di _user stories_ sono:

- > _Da bibliotecario, voglio poter visualizzare dove si trova un particolare libro in modo da poterlo reperire per i clienti._
- > _Da utente della biblioteca, voglio poter visualizzare lo stato di un libro per poterlo prendere in prestito._

Lo scopo del planning game è determinare quali funzionalità saranno presenti nel prossimo rilasio, combinando priorità commerciali e valutazioni tecniche. 
È quindi richiesta una collaborazione con il cliente, che come vedremo sarà in loco (in scrum si introduce un _"product owner"_ portavoce del cliente).

#### Procedura
<!-- immagine scheda -->
1. All'inizio __il cliente prepara le carte__, che sono piccole in modo da non scrivere tanto. In ogni carta c'è:
- un identificativo;
- una breve descrizione che descrive uno scenario d'uso;
- un caso di test che funge da test d'accettazione (in sostanza un esempio, possono essere anche un paio, un caso posiitvo e uno negativo);
- il valore di business che ha per il cliente.
2. Il team di sviluppatori __stima il tempo necessitario__: ognuno dà la propria stima. 
Sul retro della carte si tiene un resoconto di ciò che si è fatto. 
Un sviluppatore prende il ruolo di _tracker_ e si impegna a tracciare lo stato di avanzamento durante le due settimane (per esempio quante feature fatte, quanti bug segnalati, ecc).
3. Il manager quindi sulla base di queste informazioni __decide quali schede verranno implementate__ alla prossima iterazione. 
Le varie funzionalità rappresentate nelle carte in teoria sono indipendenti, quindi il manager per compiere queste scelte calcola il valore fratto tempo stimato e ordina le carte, in questo modo può scegliere meccanicamente le schede da utilizzare durante l'iterazione (in realtà compie dei ragionamenti, quindi non è un'operazione così meccanica).

#### Stime
Le stime sono fatte da parte del team, composto da persone diverse che quindi faranno singolarmente stime diverse. 
Lo sviluppatore junior può non essere in grado di dare una stima siccome è alle prime armi, o comunque stimerà un tempo maggiore rispetto ad uno sviluppatore esperto, ma in ogni caso è tenuto anche lui a dare un'opinione.

Le stime possono tra loro essere:
- __molto differenti__ (ore vs giorni): in questo caso, è possibile che la carta non sia descritta o compresa correttamente; bisogna raggiungere un accordo siccome se uno sviluppatore stima poche ore e un altro qualche giorno abbiamo dei problemi. 
Se viene deciso che il tempo per una data scheda è di qualche ora e viene assegnato allo sviluppatore che aveva fatto una stima più alta allora si troverà in difficoltà nel portare a termine il compito: è necessario trovare un punto di incontro;
- quasi uniformi, ma __molto alte__: potrebbe essere che la storia sia troppo ampia. Se alla fine dell'iterazione il lavoro prefissato non è stato portato a termine è come se non l'avessi fatto, quindi il suo valore è zero (anche se magari era stato completato all'80%), perchè il cliente non lo avrà alla fine dell'iterazione. 
Questo concetto è molto importante nelle tecniche agili. Per ovviare a questo problema si può fare lo __splitting__ delle carte, ovvero scomporre una carta in più carte in modo da scomporre il problema.
- non c'è accordo ma __sono simili__: non bisogna prendere la più bassa, alta o la media. Secondo XP bisogna arrivare ad un accordo in modo tale che chiunque nel team si riconosca nella stima effettuata: è il team che fa la stima, non il singolo.

La fase di stima dei tempi si porta dietro diverse problematiche, tra cui:
- __perdita di tempo__ per accordarsi su ciò che si dovrà fare (troppa comunicazione);
- __effetto àncora__ (anchoring effect): quando una persona assegna a un valore a una quantità ignota, tutte le stime successive avranno come punto di riferimento il primo valore deciso; il cervello unano tende a ragionare in questo modo.

Per risolvere questi problemi gli agilisti propongono alcuni gioci, come il _planning poker_ e il _team estimation game_.

#### [Planning poker](https://en.wikipedia.org/wiki/Planning_poker)

{% responsive_image path: assets/03_planning-poker.jpg %}

Vengono presentate brevemente le carte con attenzione a non fare riferimento alle tempistiche in modo da non creare subito l'effetto àncora, successivamente il team può fare domande, chiedere chiarimenti e discutere per chiararire assunzioni e rischi.
Dopodichè __ogni componente sceglie una carta__ del poker per rappresentare la propria stima. 
Le carte vengono girate contemporaneamente in modo da evitare l'effetto ancora, quindi la prima stima è _blind_. 
Ci sono anche delle carte particolari, ovvero:
- il __punto di domanda__ indica che non si è in grado di dare una stima
- la __tazza di caffè__ indica che la riunione è andata troppo per le lunghe ed [è necessaria una pausa](https://www.youtube.com/watch?v=-gAlDOcXgyM).

Dopo ogni giro di carte, solo chi ha fatto la stima più bassa e la più alta parlano (per ~1 minuto) per motivare la propria scelta in modo da cercare di trovare un punto in comune. 
Successivamente tutti propongono una nuova stima e dopo qualche iterazione le votazioni convergono .
Sulle carte usate dal team per fare la stima ci sono dei numeri che rappresentano i tempi stimati per quel task, l'unità di misura di questi numeri può essere scelta prima o dopo aver trovato un accordo. 
Queste unità di misuta possono variare, può essere ore, giorni, pomodori (un pomodoro è formato da 25 minuti senza alcuna distrazioni, e dopo c'è una pausa).
Ovviamente non si può pretendere si lavorare delle ore senza alcune distrazioni, quindi in queste stime si considera uno __slack time__, ovvero un tempo cuscinetto per che comprende il "tempo perso" a causa di distrazioni.

#### [Team Estimation Game](https://agilelearninglabs.com/2012/05/how-to-play-the-team-estimation-game/)
Metodo un po più complesso, si compone in 3 fasi, e alla base si ha un confronto tra i diversi task da fare.
È facile dire che un task è più facile di un altro, ma il difficile è capire di _quanto_: suddividere le fasi di questa decisione considerando task sempre più difficili aiuta a fare una buona stima.

##### PRIMA FASE
{% responsive_image path: assets/03_team-estimation-1.jpg %}

Si fa una pila con le storie e si mette la prima carta al centro del tavolo. I developer si mettono in fila:
- il __primo della fila estrae una carta della pila__, la rilegge (ad alta voce) e la __posiziona__ a sinistra (più semplice), a destra (più complicata) o sotto (equivalente).
- il __prossimo developer__ può:
    - __estrarre una nuova carta della pila__ e __posizionarla__ secondo le stesse regole (può anche distanziare due file e metterla in mezzo tra le due);
    - __spostare una carta precedentemente posizionata__, commentando la motivazione della sua azione. 
    Ovviamente può succedere che la carta venga rispostata nella sua posizione originale ma si punta a trovare un accordo sulla difficoltà della carta (il task).

A questo punto abbiamo le carte disposte sul tavolo in colonne di difficoltà comparabile, ordinate dalla meno difficile (sinistra) alla più difficile (destra).
Usando questa tecnica __abbiamo evitato__ anche l'__effetto àncora__, o comunque è allievato dal fatto che le stime sono relative e non c'èun valore preciso che può influenzare gli altri. 
A differenza del planning poker posso tornare sulle mie decisioni e quindi ho un continuo adattamento e ripensamento delle stime, grazie al fatto che sono stime relative (e non ci sono valori specifici).

##### SECONDA FASE
L'obiettivo di questa fase è cercare di quantificare le distanze tra le carte.

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

##### TERZA FASE
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
Non è un raggruppanmento oggettivo in quanto i diversi punti hanno tante sfaccetature, però un possibile raggruppamento potrebbe essere:

- __Requirements__:
    - I clienti fanni parte del team di sviluppo -> sono requirements viventi
    - Consegne incrementali e pianificazioni continue -> c'è un'evoluzione del progetto
- __Design__
    - Una metafora come visione unificante di un progetto
    - Refactoring -> il refactoring è design puro, attività molto utile per rendere possibile l'evolvibilità del software
    - Presumere la semplicità
- __Code__
    - Programmazione a coppie
    - proprietà collettiva
    - Integrazione continua
    - Standard di codifica
- __Test__
    - Test di unità continuo (da scriversi prima del codice)
    - test funzionale scritto dagli utenti

Spike -> Sono dei prototipi, questa tecnica è utilizzata anche nell'XP per capire se ho compreso le specifiche, la tencnologia da utilizzare, e per capire come approcciarmi ai componenti esterni con cui devo dialogare. Questi prototipi vengono fatti, mostrati al cliente e poi vengono buttati.

## Documentazione
La documentazione cartacea non è necessaria, il cliente e il compagno di peer programming lo sono, ma sopratutto è nel codice senza commenti (perchè usanto questo approccio dell'extreme programming i commenti nel codice non sono utilizzati), questo perchè abbiamo due cose fondamentali nel codice che sostituiscono la documentazione:
- I test di unità che sono delle specifiche eseguibili, infatti li scrivo prima di fare il codice (prima dico cosa voglio tramite il test).
- Il continuo refactoring consente di avere un codice estremamente leggibile, questo permette di non avere bisogno dei commenti (quindi i commenti non si mettono perchè non si deve sentierne il bisogno in quanto il refactoring ci semplifica la comprensione del codice). Però scrivere cose semplici tramite il refactoring in modo che si capiscano senza bisogno di commenti è molto complesso.

### CRC cards (sistema)
CRC card (class responsability and collaboration card) -> sono un altro modo per dire i metodi che rendo disponibile a chi è esterno (collaborazione) e i miei segreti cioè gli attributi e lo stato che inglobo dentro di me (responsabilità).
Sono nate in ambiente didattico per spiegare l'object orientation, ma ora sono utilizzate da alciuni team agile per discutere di design, e il modo di utilizzarle è simile a quello del planning game.
Aiutano a chiarire l'idea su una qualche parte del sistema, ma non persistono, dopo che sono state usate vengono butate.

## Quando non utilizzare agile
Back non esclude mai la possibilità di utilizzare agile, lui diceva che si può provare ad utilizzare questo approccio sempre (anche se in realtà non è sempre possibile "provare"), basta che vengano rispettati i 12 punti elencati sopra.
Quindi agile non si può usare quando:
- Siamo in ambienti che non permettono di applicare i 12 punti -> per esempio quando si lavora con il team dislocato in luoghi differenti
- Quando abbiamo barriere di tipo manageriale, ovvero team troppo numerosi
- barriere tecnologiche, ovvero se abbiamo l'obbligo di utilizzare una macchina specifica condivisa da tutte le coppie per i test, e questo ostacola lìintegrazione continua.
- Ci sono troppi stakeholders diversi in contrasto tra di loro.
- Sistemi in cui la consegna incrementale non ha senso -> per esempio una centrale nuclere non posso consegnarla pezzo per pezzo.

## Critiche
Alcune critiche all'extreme programming fatte da meyer
- Sottovalutazione dell'up-front, ovvero la sottovalutazione dell'approccio in cui penso al design prima di iniziare. Questa cosa nell'extreme programming non si verifica, infatti si inizia chiedendo al cliente di scrivere delle use story per l'iterazione che si sta per fare.
- Sopravalutazione delle use stories, ovvero le use stories devono essere ben chiare e definite fin da subito
- Mancata evidenziazione della dipendenza tra uses stories. Noi abbiamo detto che le use stories devono essere indipendenze, però nel design classico si ha una vista che chiarisce tutte le dipendenze tra i diversi punti del sistema da realizzare.
- TDD può portare ad una visione troppo ristretta
- Cross functional team, ovvero se i team sono troppo disomogenei (ovvero quando ci tante singole figure specializzate in un campo e queste devono collaborare in coppia) ci possono essere dei problemi.

Tutti questi punti cercano di evidenziare la mancanza di approfondimento e chiarezza dell'extreme programming su alcuni aspetti dell'approccio ad un lavoro fornito da un cliente.
Qui i punti sono solo enunciati, se si vuole approfondire c'è il libro di meyer.

## Mesi uomo
I manager pensano che la stima del tempo in mesi uomo sia graficata come un ramo di iperbole, ovvero che possibile aumentare il nuermo di uomini per diminuire il tempo stimato senza considerare i tempi di overhead, ovvero tutto il tempo impiegato per la comunicazione e tutto ciò che non è l'implementazione. Questo ovviamente non è vero, i mesi uomo non sono una metrica valida, sono utili solo a posteriori per capire se un certo approccio ad un problema si è dimostrato valido.
Nella realtà all'aumentare delle persone aumenta il bisogno di comunicare.
C'è anche il caso in cui all'aumentare delle persone il tempo di consegna non cambia, questo si verifica quando il lavoro è strettamente sequenziale e non paralelizzabile (esempio gravidanza).
Infine nel software abbiamo un caso ancora differente, ovvero abbiamo un numero ideale di persone, dopodichè le persone in più causano solo confusione e rallentano i tempi a causa della comunicazione. Il nuemro può essere grande però, dipende dall'entità del progetto (esempio space shuttle).
In generale nelle metodologie agili se il team è più grande di 8-10 persone inizia a non funzionare più, e questo può essere visto come un caso in cui l'extreme programming non va utilizzato, ovvero (sistema questa parte, da 01:05:00 a 01:07:00 della videolezione 4 parte, successivamente sempre nella videolezione ci sono i riferimenti ai vari libri).
