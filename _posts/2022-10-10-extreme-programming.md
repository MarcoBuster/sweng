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
Non bisogna avere paura di apportare modifiche che semplificano il progetto: bisogna avere coraggio.

Il refactoring è un'operazione che modifica il software __ma non modifica le funzionalità__, quindi tocchiamo solo proprietà interne.
L'obiettivo è eliminare l'entropia con le continue modifiche e aggiunte. <!-- da scrivere meglio -->

Deve essere graduale e continua in modo da poter aggiungere funzionalità in maniera più semplice.

Se una parte di codice non viene stimolato dai test non è utile ai fini della soluzione, al massimo posso aggiungere dei test per gestire dei casi specifici, se no posso togliere le parti di codice non richiamate dai test.

### 7. Programmazione a coppie
È una tecnica che può portare dei vantaggi, anche se il manager può non rendersi subito conto, infatti paga due persone e una delle due guarda l'altro lavorare, ma non è cosi.

I punti a favore sono:
- Ci si controlla a vicenda su ogni aspetto (codice, rispetto delle regole, idee)
- Uno attua le cose, l'altro pensa a ciò che bisogna fare subito dopo, quindi la seconda persona pensa a come fare refactoring
- Ad avere un controllo continuo delle regole di XP
- L'inserimento di nuovo personale e la sua formazione, al posto di mettere quelli nuovi a studiare libri interi lasciati a se stessi, vengono affiancati a persone che stanno lavorando e quindi può essere istruito guardando gli altri lavorare e dialogando.
- Ottenere una _proprietà colettiva_ (conoscenza osmotica), quindi quando programmo con un altra persona posso conoscere il codice scritto dall'altro. Un altro punto importante sono i commenti naif, ovvero quelli fatti dai programmatori junior, sono importanti perchè molto spesso i programmatori esperti devono ripensare a delle cose basilari che danno per scontato, e può succedere che trovino parti di codice che potevano essere scritte meglio o addirittura tolte.
- Dimenzzare le persone dimezzano la produttività? no, è stimato che la produttività sia una volta e mezzo in più, che comunque sarebbe una perdita. Ma degli studi pongono una domanda, la produttività calcolata puntualmente è davvero sensata da calcolare? no perchè sul lungo (quindi sull'iertazione) ciò che sembrava meno produttivo in realtà lo è di più. Questo perchè una persona da sola deve fare il lavoro, poi passare molto tempo a verificarlo e ricontrollarlo, mentre nella programmazione a coppie questa cosa si verifica costantemente e quindi la parte sul refactoring sarà più leggera perchè in parte già svolta (questa tecnica si chiama __ispezioe del codice__).

### 8. Proprietà collettiva
L'extreme programming ha cercato di mettere insieme proprietà già esistenti che funzionavano, di fatto non ha inventato niente di nuovo.
Proprietà collettiva significa che il codice non è di una persona sola ma del team, quindi la responsabilità del codice appaertiene a ogni il team, anche se non lo si conosce tutto alla stessa maniera. Di conseguenza tutti sono autorizzati a metterci mano qualcosa non va, anche a parti che magari ha scritto qualche altro membro.
Durante il lavoro succedera spesso di cambiare coppia, magari anche più volte al giorno e per diversi motivi, per esempio nessuno dei due ha una profonda conoscienza della parte di codice che stanno trattando, oppure perchè il task da fare non si addice alle competenze della coppia. In ogni caso il continuo riferirsi al team e non al singolo è importatnissimo nell'XP.

### 9. Integrazione continua
Nell'ottica di avere feedback rapidi è necessario fare l'integrazione spesso, anche più volte al giorno, e questo non significa fare i test di unità e poi alla fine integrare tutti in una bottasola, ma intergrare man mano. Questo perchè è frequente il caso in cui ogni parte è stata testata singolarmente e funziona, ma quando tutti i pezzi vengono messi insieme per formare il prodotto finale qualcosa non funziona, per questo motivo integrando man mano è possibile risolvere meglio questi problemi (questo funziona in ogni campo non solo nello sviluppo software).
Nello sviluippo software queste intergazioni vengono fatte cosi frequentemente che dopo lo sviluppo anche di una piccola feature è compito della coppia andare ad integrarla nella macchina di riferimento per. Questa macchina di riferimento è una macchina a cui si accede in maniera __esclusiva__ che serve per integrare tutti i lavori delle diverse coppie; questa sequenzialità nell'uso della macchina la si deve garantire anche nel caso in cui ci si acceda da remoto, questo si fa grazie ad un token.
Il completamento di una use sotry si ha quidi dopo aver integrato la feature, aver testato il suo funzionamento (test di integrazione) e aver mostrato al cliente il risultato della macchina complessiva dopo l'integrazione.
La macchina è sempre in una situazione monotona creascente per quanto riguarda le funzionalità (io posso andare a rimuovere cose dalla macchina, è per questo che parlo di crescita delle funzionalità e non delle componenti della macchina in se). Inoltre ogni volta che vado ad integrare una parte devo sempre produrre un qualcosa di consegnabile all'utente.
Un altra motivazione importante della continua integrazione è che se devo integrare qualcosa nella macchina e un'altra coppia prima di me ha aggiunto una parte che non integrava da molto tempo, la probabilità che la macchina funzioni dopo la mia aggiunta è molto bassa, al contrario se tutti integrano molto spesso le probabilità saranno sicuramente molto più alte. Se una coppia non riesce ad integrare bloccherà anche tutte le altre che non possono andare avanti con le use story, quindi sarà necessario che quella coppia rinunci, ritorni sulla sua macchina e cerchi di risolvere li (tutte le coppie hanno una loro macchina su cui testano prima di farlo su quella comune).

### 10. Settimana di 40 ore
Il mestiere dello sviluppatore ha sempre avuto dei ritmi dettati un po dalle consegne, questo causa dei problemi come per esempio se lavoro di più renderò sicuramente di meno, inoltre porta a stress e frustrazione. Nell'XP si cerca di evitare queste situazioni in modo da avere una resa migliore, avere maggior soddisfazione nel lavorare nel team o nell'azienda, avere meno problemi fuori dal lavoro (tante volte questo eccessivo lavoro può causare problemi familiari) e inoltre abbassa la probabilità per l'azienda di perdere dipendenti. Purtroppo però il mestiere dello sviluppatore non è meccanico e molto spesso si vuole portare a termine quello che si sta facendo perchè magari si è quasi alla soluzione, inoltre si continua a pensare a come risolvere dei problemi anche fuori dall'orario lavorativo.

### 11. Cliente sul posto
Fino ad ora abbiamo visto le motivazioni a favore del cliente per cui vengono messe delle persone sul posto dove si sviluppa il progetto, ovvero perchè cosi può essere sicuro che stiamo lavorando per lui e per verificare come procede il progetto. Ma perchè a noi fa comodo avere il cliente sul posto?
È fondamentale avere il cliente sul posto in modo date da avere qualcuno a cui chiedere in caso di specifiche poco chiare, infatti noi abbiamo a disposizione solo le use story che non sempre sono chiare, quindi avere il cliente a nostra disposizione (lui può comunque continuare a lavorare per la sua azienda, ma noi abbiamo la priorità) ci permette di fargli domande per chiarire i punti delle specifiche, è come avere una documentazione vivente.
Quindi questo punto è fondamentale, e nel caso in cui il cliente sul posto non sia disponibile dobbiamo trovare degli escamotage per far si di avere comunque un punto di riferimento, però non sarà sicuramente come avere il cliente nel team.
Anche avere il cliente sul posto ha dei limiti in realtà, infatti dobbiamo avere una persona che riesca ad essere rappresentativo di tutti gli stakeholders.
Il cliente durante le iterazioni può creare delle altre storie che nell'iterazione successiva potrà inserire nel planning game, e in più è disponibile anche nel caso in cui vogliamo che faccia dei test funzionali.

### 12. Standard di codifica
È necessario avere delle regole che specificano come va scritto il codice, con delle convenzioni comuni, questo per aumentare la comunicazione anche attraverso il codice.
Vengono utilizzati dei tool per garantire queste convenzioni in modo date da non avere membri del team che non le rispettino, oppure questi strumenti possono anche fare un'autocorrezione del codice per far si che rispetti gli standard.
Inoltre avere uno standard di codifica aiuta:
- il refactoring
- la programmazione a coppie
- le proprietà collettive

### 13. Just rules
Definiamo ora questa tredicesima regola "non canonica" che è stata aggiunta da alcuni.
Nel caso in cui non si voglia seguire una regola deve esser fatto da tutto il team, e non solo dal singolo o dalla coppia, e poi alla fine dell'iterazione si fa un resoconto di come sono andate le cose e se nell'iterazione successiva sia il caso di reintrodurre la regola oppure no. In questo resoconto si può anche decidere di sospendere delle regole se si pensa che per il team non siano necessarie o non vadano bene, e successivamente possono essere reintrodotte. In conclusione si possono effettuare questo tipo di test per trovare il giusto equilibrio, e questa ultima regola mostra anche che l'XP non è una tecnica cosi rigida e rigorosa. Questo punto però non è condiviso da tutti e una motivazione la si può trovare nel fatto che tutti i punti sono interconnessi tra loro, e quindio non è possibile studiarli singolarmente senza considerate anche gli altri perchè non avrebbero senso in quanto hanno una forte dipendenza l'una dall'altra (non a caso nei punti sopra si può notare come si influenzino a vicenda).

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
