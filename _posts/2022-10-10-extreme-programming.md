---
layout: post
title: "[03] eXtreme programming"
<<<<<<< HEAD
date:   2022-10-10 14:40:00 +0200
toc: true
---

# eXtreme programming

## Increment then simplify
TDD (test driven development) è una tecnica di __progettazione__ che guida verso la soluzione più semplice, il design più semplice.

TDD = test first + baby stap (passi piccoli)
ovvero faccio i test e programmo qualcosa di piccolo, verificando tutto

prima faccio qialcosa (increment) e poi lo semplifico (simplify).

perchè questa è una tecnica di progettazione?
quando si scrive pensa sopratutto a ciò che è facile per me che sto scrivendo, e non a chi deve usare il prodotto. questo causa delle dipendenze che sono difficili da togliere.
Scrivendo prima i test mi pongo già dalla parte dell'utente siccome progetto già come sarà alla fine, e poi grazie al test so già cosa fare. (sistema sto pezzo).

nasce inizio anni 90 fine 2000, il guru di questa cosa è kent back

lui ha individuato delle variabili che ...:
- portata ->  la quantità di funzionalità che si vogliono implementare, la portata puo cambiare, quindi è mutevole
- tempo -> il tempo che si può dedicare al progetto
- qualità -> la qualità del progetto che si deve ottenere
- costo -> le risorse finanziarie che si possono impegnare

queste 4 variabili non sono indipendenti
la qualità non è negoziabile, deve essere sempre al top.
nell'extreme programming abbiamo un cambio di punto di vista, ci si fa pagare in base al tempo, e in questo modo avremo come unica cosa variabile la portata.

### Principi dell'extreme programming
- __feedback rapido__ (da test, cliente, colleghi). ci sono una serie di pratiche per la comunicazione per esempio lo stand up meeting, ovvero una mini organizzazione e sullo stato di avanzamento di ciò che ho fatto
- __presumere la semplicità__ -> progetta per quello che ti serve subito, non nel futuro lontano
- __accettare il cambiamento__ -> accettare il fatto che il software verrà modificato su ruchiesta del cliente quasi sicuramente.
- __modifica incrementale__ -> non solo per quanto riguarda il codice ma anche nel team,, ovvero è meglio aggiungere poche persone nel breve tempo, se no tutte quelle persone sono da istruire.
- __lavoro di qualità__ -> far star bene lo sviluppatore, quindi la fidelizzazione dello sviluppatore all'azinda è importante

nell'ingengeria classica invece abbiamo:
- __separazione degli interessi__ (aspect o concerns) -> ovvero devo separare i tempi, le modalità, ecc. quindi devo separare le varie viste che ho.
- __astrazione e modularità__ -> ci permettono di modulare i problemi complessi
- __anticipazione del cambiamento__ -> accetto il cambiamento predisponendomi già a soddisfare il cambiamento. però c'è da dire che molte volte il programmatore potrebbe complicare lo sviluppo mettendo cose che in realtà non vorrà il cliente. Questa cosa è molto pericoloso, come anche iniziare a fare cose mentre sto facendo altre parti (spiega meglio). ciò complica molto lo schema di ciò che sto facendo
- __generalità__
- __incrementalità__
- __Rigore e formalità__ -> cosa che l'extreme programming non fa

### Presumere la semplicità vs anticipare il cambiamento
- XP sembra dire di non pianificare per il futuro e per il riuso, e raffigura la cosa con una curva che man mano si stabilizza
- Boehm basandosi sullo studio di casi reali ipotizza una curva di tipo esponenziale per il costo di modifiche.

quindi XP dice che ora come ora con i vantaggi della tecnologia che avanza non abbiamo tutte le difficolta che c'erano una volta nel fare le modifiche

### figure
da fare
## Approccio
### 1) planning game
viene fatta all'inizio dell'iterazione, serve per congelare quella parte di requisiti che verranno fatti dalle successive 2 settimane (tempo scelto dal manager)
si inizia dalle user stories ovvero una versione infoemale e semplificata dei casi d'uso di UML.
lo scopo del planning game è capire quali di queste storie faranno parte del lavoro da fare nelle prossime settimane -> ci deve essere un certo bilanciamento tra priorità commerciali e valutazione tecniche.
il cliente fa parte del team e farà parte di tuttei le parti del progetto, non solo nel plannning game.
il cliente prepara delle carte con un identificativo, una breve frase che descrive uno scenario d'uso, uno o più casi di test che fungono da test di accettazione ed infine il valore che attribuisce il cliente a questa cosa da fare.

il __team__ di sviluppatori invece stima il tempo necessario per soddisfare la richiesta
coraggio e miglioramento continuo? spiega sta cringiata

il manager sulla base di queste info decide quali schede verranno implementate alla prossima iterazione

come si fa la stima da parte del team?
- le stime sono molto differenti (ore vs giorni) -> ci si deve mettere d'accordo per trovare una tempistica comune che vada bene per tutti
- le stime sono quasi uniformi ma molto alte -> se già so che non farò in tempo allora il valore è nullo, allora come faccio? si può fare uno __split__ della storia, ovvero si suddivide la carta in modo da rendere più facile il lavoro
- se non c'è accordo nelle stime ma sono simili? cosa si fa? -> si deve arrivare ad un accordo, la stima non è del singolo.

problemi nelle stime condivise:
- si perde molto tempo
- Effetto ancora -> sistema

##### Stime agili: planning poker
vengono presentate brevemente le carte senza fare nessun riferimeto allo sforzo (per evitare l'effetto ancora), e il team può fare domande richieste e chiarimenti.
ogni componente del team sceglie una carta del poker rappresentante la prima stima.
si evita l'effetto ancora in quanto devo fare la prima stima senza basarmi su quella di altri.
nel caso in cui non si arriva ad una conclusione chi ha messo il voto piu alto e piu basso possono parlare per un minuto. questa parte deve essere molto veloce.
ma che unità di misura do hai valori scelti? -> si scegie ???

#### Team estimation game
i developer si mettono in fila e si fa una pila con le storie e si mette la prima carta che viene messa sul tavolo. il primo dev di turno pesca una carta e decide se è piu facile, più difficile o uguale a quella sul tavono
il successivo decide se pescare e fare come il primo oppure spiego il  motivo e sposto una carta esistente in un altra posizione

finisci

seonda fase: ci si mette ancora in coda davanti al tavolo e si etichetta la difficoltà delle carte

terza fase ...

### 2. Brevi cicli di rilascio
Per ridurre i rischi la vita e lo sviluppo dell'applicazione sono scanditi dai rilasci di versioni del prodotto funzionanti
devono essere comunque rilasci significativi

### 3. uso di una metafora
utilizzare delle metafore per parlare di cose tecniche facilita la comprensione anche da parte del cliente

### 4. semplicità di progetto











=======
date: 2022-10-10 14:40:40 +0200
toc: true
---

# eXtreme programming
Concetto principale dell'extreme programming
> Increment then simplify

## Test Driven Development

Il _test driven development_ (TDD) è una __tecnica di progettazione__ che guida verso il design più semplie.

> TDD = test-first + baby steps

Il signifcato di questa espressione è di fare prima il test e poipassi molto piccoli. Concetto di feedback instantaneo: faccio piccoli passi e testo ogni volta.

- ogni volta che devo aggiungere qualcosa faccio prima il test che fallisce (<span style="Color: red">rosso</span>)
- poi lo faccio diventare <span style="Color: red">verde</span> il prima possibile, ovvero scrivo il codice nel modo corretto il prima possibile (quasi come se fosse nua bozza) cosi facendo il test diventa verde. in questo modo ho sempre un feedback di quello che faccio
- refactoring -> ovvero riscrivo il codice in modo migliore, il refactoring non deve far fallire il test. 
questa cosa va fatta con una cadenza frequente, ogni 2-10 minutii: compiti semplici.

Quindi prima faccio qualche piccolo progresso (increment) e poi lo semplifico (semplify)

È necessario passare per quel passaggio intermedio (la bozza menzionata al punto 2 dell'elenco precendete) perchèin questo modo una volta che abbiamo una base funzionante sicuramente nella fase di refactoring ciò che ho fatto continuerà a funzionare (non si torna al rosso). Se scrivessimo direttamente il codice in "bella" impiegheremmo molto piùtempo e magari alla fine non abbiamo neanche un codice funzionante (siccome implementare del codice gestendo ogni particolare fin da subito al meglio ècomplesso ed èfacile commettere errori).

Il TDD è una tecnica di progettazion:
- spesso capita di scrivere codice difficilmente testabile; scrivere il test prima e il codice dopo aiuta a progettare prodotti _test-first_;
- scrivere prima i test aiuta a definire le interfacce del programma, perché durante il testing ci si pone dal punto di vista del clinte, se non dovessimo farlo potremmo avere delle dipendenze complicate da rimuovere.


## eXtreme Programming (XP)
Ora possiamo iniziare a parlare di extrene programming, nasce tra la fine degl anni 90 e inizio del 2000, la figura di riferimento � �Kent Beck.

## Le variabili in gioco
secondo kent Beck, l'ideatore dell'extreme programming, in un software le variabili sono:
- __portata__: quantità di funzionalità da implementare, la portata èmutevole siccome il numero di funzionalitàda implementare può cambiare nel tempo.
- __tempo__: tempo dedicabile al progetto;
- __qualità__: la qualità del progretto che si deve ottenere (principalmente correttezza e affidabilità);
- __costo__: risorse finanziare che si possono impegnare.

Queste 4 variabili __non sono indipendenti__, una influenza le altre; possiamo dire che la qualità non è negoziabile, deve essee per forza massima, quindi bisogna lavorare sulle altre, sopratutto bilanciando costo e tempo.
Con l'XP si stravolge la prospettiva: il costo è orario, il temp verrà deciso successivamente, e infine la portata viene ricalcolata durante il progetto, quindi l'unica variabile che cambia è la portata.




## Principi
- __Feedback rapido__ da test, cliente e colleghi. In alcune aziende viene fatto uno _standup meeting_: poche parole in piedi per dire cosa è stato fatto e le successive intenzioni.
- __Presumere la semplicità__: ??? 
- __Accettare il cambiamento__: non ci si deve aspettare che il software sia immutabile, deve essere dato per scontato il concetto di flessibilità.
- __Modifica incrementale__: per esempio, mai aggiungere più di una persona nel team.
- __Lavoro di qualità__: far star bene lo sviluppatore; la fidelizzazione dello sviluppatore è importante.

Nell'ingegneria classica invece abbiamo:
- __Separazione degli interessi__ (_aspects_ o _concerns_): separare tempi, responsabilità, moduli.  
- __Astrazione e modularità__
- __Anticipazione del cambiamento__ (_design for change_): in fase di progettazione si pensa come potrebbe cambiare il prodotto e decido in tal modo. Spesso però questo concetto complica arbitrariamente la progettazione e lo sviluppo, considerando anche che sono solo fantasie; può essere un'idea migliore farlo semplice ed incrementarlo man mano. 
- __Generalità__
- __Incrementalità__
- __Rigore e formalità__

### Presumere la semplicità vs anticipazione del cambiamento
- XP mette davanti la semplicità all'anticipazione del cambiamento: non sto inserendo cose che mi serviranno per il futuro, ma non è detto che non stia progettando per il futuro.
- Secondo Bohem (1976) invece, si ipotizza una curva di tipo esponenziale per il corso delle modifiche all'aumento dell'avanzamento del progetto.
    - Dal'altro canto, per l'XP questa curva ha un asintoto orizzontale a un certo punto. 
    > "Nei primi tempi poteva essere vero, ma ora è meglio rimandare l'aggiunta di modifiche fino a quando non servono."

## Figure in gioco e responsabilità
Solitamente ci sono tre figure: cliente, sviluppatore e manager.

Manager/cliente
- ha responsabilità di decidere
    - la portata del progetto
    - priorità (_business value_) tra le funzionalità
    - date dei rilasci
- ha diritto di:
    - trasparenza del processo di sviluppo: sapere cosa è stato fatto, cosa può essere fatto, quali e tempi e quali i costi
    - vedere progressi nel sistema, provati dal superamento dei test da lui definiti
    - cambiare idea, sostituire funzionalità e cambiare prorità a intervallo di tempi

Sviluppatore
- ha responsabilità di decedere:
    - stime dei tempi per le singole funzionalità
    - conseguenze di scelte tecnologiche
    - pianificazione dettagliata
- ha diritto di:
    - sapere cosa è necessario fare attraverso dei requisti chiari (storie di uso) con priorità
    - cambiare stimi tempi con l'esperiezna
    - identificare e indicare le funzionalità _pericolose_, ovvero funzionalità che potrebbero essere difficili da applicare
    - produrre software di qualità

# Tecniche XP
## 1. Planning game
È l'attività che viene fatta all'inizio dell'iterazione e serve per "congelare" il sottoinsieme di requisiti sul quale il team lavorerà per le prossime ~2 settimane.

Si inizia dalle _user stories_, una versione semplificata degli _use case_ degli UML; hanno come soggetto sempre un ruolo specifico nell'azienda del cliente.
Lo scopo del planning game è determinare quali funzionalità saranno presenti nel prossimo rilasio, combinando priorità commerciali e valutazioni tecniche.

#### Procedura
<!-- immagine scheda -->
1. All'inizio il cliente prepara le carte. In ogni carta c'è:
- un identificativo;
- una breve descrizione che descrive uno scenario d'uso;
- un caso di test che funge da test d'accettazione;
- il valore di business che ha per lui.
2. Il team di sviluppatori stima il tempo necessitario: ognuno dà la propria stima. Un sviluppatore prende il ruolo di _tracker_ e si impegna a tracciare.
3. Il manager quindi sulla base di queste informazioni decide quali schede verranno implementate alla prossima iterazione. 

### Le stime
Le stime sono fatte da parte del team, composto da persone diverse possono essere...
- __molto differenti__ (ore vs giorni): in questo caso, è possibile che la carta non sia descritta o compresa correttamente; bisogna dialogare;
- quasi uniformi, ma __molto alte__: potrebbe essere che la storia sia troppo ampia;
- non c'è accordo ma __sono simili__: non bisogna prendere la più bassa, alta o la media. Secondo XP bisogna arrivare ad un accordo in modo tale che chiunque nel team si riconosca nella stima effettuata.

I problemi sono:
- perdita di tempo per troppa comunicazione;
- effetto àncora (anchoring effect): settare delle aspettative porta ad ancorarsi intorno ad esse.

#### [Planning poker](https://en.wikipedia.org/wiki/Planning_poker)
<!-- immagine planning poker -->
{% responsive_image path: assets/03_planning-poker.jpg %}

Vengono presentate brevemente le carte, il team può fare domande chiedere chiarimenti e discutere per chiararire assunzioni e rischi. 

Ogni componente sceglie una carta del poker per rappresentare la propria stima. Le carte vengono girate contemporaneamente, la prima stima è _blind_: si evita l'effetto ancora.

Dopo ogni giro di carte, solo chi ha messo la stima più bassa e la più alta parlano (per ~1 minuto) e si ripetono le votazioni. Dopo poche votazioni si converge.

#### [Team Estimation Game](https://agilelearninglabs.com/2012/05/how-to-play-the-team-estimation-game/)

##### PRIMA FASE
{% responsive_image path: assets/03_team-estimation-1.jpg %}

Si fa una pila con le storie e si mette la prima carta al centro del tavolo. I developer si mettono in fila:
- il primo della fila prende una carta della pila, la rilegge (ad alta voce) e la posiziona a sinistra (più semplice), a destra (più complicata) o sotto (equivalente).
- il prossimo developer può:
    - prendere una nuova carta della pipla e posizionarla secondo le stesse regole (può anche distanziare due file e metterla in mezzo tra le due);
    - spostare una carta precedentemente posizionata (commentando la motivazione della sua azione).

##### SECONDA FASE
{% responsive_image path: assets/03_team-estimation-2.jpg %}

Ci si mette di nuovo in coda davanti al tavolo; il nuovo mazzo è il planning poker ordinato e si reiterano le operazioni precedenti.

##### TERZA FASE

#### Velocity
La capacità (osservata) di completare lavori da parte del team.
Non può essere usata per dare premi, per confrontare team diversi o punire in caso di diminuzione.

Se aggiungo una persona lascio questa metrica inizialmente invariata, per la formazione; se la rimuovo ci sarà una perdita di produttività.

Sostituisce la necessità di rimappare unità ideali in tempi assoluti.
...

Lo slack time è il tempo aggiunto ... riguarda domanda aceti.

## 2. Brevi cicli di rilascio
Per ridurre i rischi, la vita e lo sviluppo dell'applicazione sono scanditi dai rilasci di dversioni del prodotto funzionanti. Di solito uno ogni due settimane.

## 3. Uso di una metafora
Definire un nuovo vocabolario con cui parlare con l'utente (tecnica _non informatica_) ma anche ai nuovi venuti.
Serve per permettere una nominazione di classi e metodi omogenei e fornire una vista d'insieme.

## 4. Semplicità di progetto
Massimizzare il lavoro da non fare. KISS: Keep It Simple, Stupid.

## 5. Testing
- I clienti scrivono i test funzionali per aumentare la loro fiducia nel programmi. 
- I programmatori scrivono i test di unità perché la fiducia nel codice diventi parte del programma stesso. 

Il testing è molto importante nell'XP: ha il ruolo di _"rete di protezione"_ in tutte le varie fasi. 

Nei sistemi legacy si procede passo passo.

## 6. Refactoring
Non bisogna avere paura di apportare modifiche che semplificano il progetto: bisogna avere coraggio.

Il refactoring è un'operazione che modifica il software ma non modifica le funzionalità. Serve ad eliminare l'entropia che si creerebbe con le continue modifiche aggiunte.
L'obiettivo è eliminare l'entropia con le continue modifiche e aggiunte.

## 7. Programmazione a coppie
Aiuta:
- Ad avere un controllo continuo delle regole di XP
- L'inserimento di nuovo personale e la sua formazione
- Ottenere una _proprietà colettiva_ (conoscenza osmotica)
- Il refactoring

Una domanda che si potrebbe porre il management è: ma dimezzare le persone che scrivono il codice non dimezza la produttività del team?  
<!-- riassumere pippone -->
>>>>>>> marco/03-appunti
