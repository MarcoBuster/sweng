
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

È necessario passare per quel passaggio intermedio (la bozza menzionata al punto 2 dell'elenco precendete) perchè in questo modo una volta che abbiamo una base funzionante sicuramente nella fase di refactoring ciò che ho fatto continuerà a funzionare (non si torna al rosso). Se scrivessimo direttamente il codice in "bella" impiegheremmo molto piùtempo e magari alla fine non abbiamo neanche un codice funzionante (siccome implementare del codice gestendo ogni particolare fin da subito al meglio ècomplesso ed è facile commettere errori).

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
Lo scopo del planning game è determinare quali funzionalità saranno presenti nel prossimo rilasio, combinando priorità commerciali e valutazioni tecniche, questo richiede una collaborazione con il cliente.

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
