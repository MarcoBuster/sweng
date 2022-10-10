---
layout: post
title: "[03] eXtreme programming"
date:   2022-10-10 14:40:00 +0200
toc: true
---

# eXtreme programming

## Increment then simplify
TDD (test driven development) è una tecnica di __progettazione__ che guida verso la soluzione più semplice, il design più semplice.

TDD = test first + baby stap (passi piccoli)
ovvero faccio i test e programmo qualcosa di piccolo, verificando tutto

- ogni volta che devo aggiungere qualcosa faccio prima il test che fallisce (red)
- poi lo faccio diventare verde il prima possibile, ovvero scrivo il codice nel modo corretto il prima possibile (quasi come se fosse nua bozza) cosi facendo il test diventa verde. in questo modo ho sempre un feedback di quello che faccio
- refactoring -> ovvero riscrivo il codice in modo migliore, il refactoring non deve far fallire il test 
questa cosa va fatta con una cadenza frequente, ogni 2-10 minuti.

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


