---
layout: post
title: "[03] eXtreme programming"
date: 2022-10-10 14:40:40 +0200
toc: true
---

## Test Driven Development
> Increment then simplify

Il _test driven development_ (TTD) è una __tecnica di progettazione__ che guida verso il design più semplice.

> TTD = test-first + baby steps

Il signifcato di questa espressione è di fare prima il test e poi passi molto piccoli. Concetto di feedback instantaneo: faccio piccoli passi e testo ogni volta.

Per aggiungere una nuova funzionionalità:
1. <span style="color:red;">scrivo un test che fallisce</span>;
2. <span style="color:green">lo faccio passare</span>: versione semplice che lo fa passare;
3. <span style="color:green">refactor</span>: riscriviamo meglio l'implementazione.

Quindi prima faccio un incremento (2.) e poi semplifico (3.).
Gli step sopra sarebbero da reiterare ogni 2-10 minuti: compiti semplici.

Il TTD è una tecnica di progettazione: 
- spesso capita di scrivere codice difficilmente testabile; scrivere il test prima e il codice dopo aiuta a progettare prodotti _test-first_;
- scrivere prima i test aiuta a definire le interfacce del programma, perché durante il testing ci si pone dal punto di vista del cliente.

# eXtreme Programming (XP)

## Le variabili in gioco
Secondo l'ideatore della eXtreme programming, in un software le variabili sono:
- __portata__: quantità di funzionalità da implementare;
- __tempo__: tempo dedicabile al progetto;
- __qualità__: la qualità del progretto che si deve ottenere (principalmente correttezza e affidabilità);
- __costo__: risorse finanziare che si possono impegnare.

La qualità non è negozionabile: normalmente si cerca di variare il costo e il tempo.

Nell'extreme programming il costo e la qualità sono fissate, il tempo e la portata vengono da sé.

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
