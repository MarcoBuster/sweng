# Criticità

## Quando non utilizzare XP
Back non esclude mai la possibilità di utilizzare l'XP: secondo lui diceva può provare ad utilizzare questo approccio sempre (anche se in realtà non è sempre possibile "provare"), a patto che vengano rispettati i 12 punti elencati sopra.

Da questo possiamo concludere che Agile non si può usare quando:
- l'__ambiente__ non permette l'applicazione dei 12 punti, come per esempio succede con i team dislocati in luoghi diversi;
- ci sono __barriere managieriali__, come team troppo numerosi;
- ci sono __barriere tecnologiche__, come quando per esempio non è possibile utilizzare una macchina specifica condivisa da tutte le coppie per i test, ostacolando l'integrazione continua.
- ci sono __troppi stakeholders__ diversi e in contrasto tra loro;
- situazioni in cui __la consegna incrementale non ha senso__, come per una _centrale nucleare_ (vero [Dyatlov](https://en.wikipedia.org/wiki/Anatoly_Dyatlov)?).

## Critiche da Meyer
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
È diffuso tra i manager pensare che la stima in tempo in mesi uomo sia graficata come un ramo di un iperbole, ovvero che il tempo diminuisca simil-esponenzialmente all'aumentare dei mesi uomo; tale stima non considera i tempi di _overhead_, ovvero il tempo impiegato per la comunicazione e tutto ciò che non è l'implementazione.
I mesi uomo __non quindi sono una metrica valida__, ma sono utili solo a posteriori per valutare se un approccio ad un problema si è dimostrato valido.

Nella realtà, __all'aumentare delle persone aumenta il bisogno di comunicare__.

Quando il lavoro è strettamente sequenziale e non parallelizzabile (come la _gravidanza_) anche all'aumentare delle persone il tempo non cambia.

Nel mondo dello sviluppatore software spesso c'è un __numero ideale di persone__ per un progetto; dopodiché, persone in più causano solo confusione e rallentano i tempi a causa della comunicazione.
Il numero può anche essere grande, dipende dall'entità del progetto (esempio: space shuttle).

In generale, le metodologie agili iniziano a __non funzionare più__ se il team è __più grande di 8-10 persone__.
Quando il progetto non funziona più con un tale numero di persone, è necessario esplorare altre pratiche.
