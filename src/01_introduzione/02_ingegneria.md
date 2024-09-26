# Ingegneria del software

## Storia 
Con la diffusione dei primi computer in ambito non solo accademico, negli anni '50 e '60 si è subito colta la necessità di superare metodi di produzione "artigianale" del software:  il cliente e il programmatore non coincidono e anche il dominio della applicazione non è più esclusivamente quello matematico. Quindi nascono diversi problemi di comunicazione,  
Negli anni '70, si inizia dunque a pensare a dei metodi, dei processi e a degli strumenti che potessero migliorare e ___"assicurare"___ la __qualità del software__. Per deifinire/validare questi metodi, processi e strumenti viene usato il tipico approccio ingegneristico.

## Approccio ingegneristico
1. __Target__: ci si prefigge un obiettivo da raggiungere.
2. __Metric__: si definisce una metrica correlata al raggiungimento del target (la metrica non va scelta a posteriori).
3. __Method, Process, Tool__: si definisce un metodo, processo o strumento che si ritiene possa avvicinarci all'obiettivo.
4. __Measurements__: Tramite degli esperimenti controllati (ingeneria sperimentale) si confrontano la metrica stabilite nel caso di adozione o meno della tecnica sotto valutazione e si valuta se sono state utili (in maniera significativa) e quanto ci hanno avvicinato (o allontanato) all'obiettivo.
A seconda dei risultati ottenuti vi sono due possibili strade:
    - __risultati soddisfacenti__ (_miglioramento della metrica_) - accettiamo come buoni i metodi e processi proposti.
    - __risultati insoddisfacenti__ (_peggioramento della metrica_) - ci sono dei peggioramenti o dei forti effetti collaterali, di conseguenza bisogna modificare qualcosa: si possono cambiare target o metrica se ci si rende conto di non aver ben definito l'obiettivo, ma più comunemente bisogna rivedere i processi e metodi usati.

Ma __che cosa si intede per target__? Gli obiettivi da raggiungere possono essere di due tipi: la risoluzione dei __problemi nello sviluppo del software__ e l'assicurazione di una qualche __qualità che il software dovrà avere__. È dunque necessario porsi le seguenti domande:
- Quali problemi ci sono?
- Quali qualità deve avere il software?

### Problemi principali
Vediamo allora a questo punto alcuni dei problemi che possono insorgere durante lo sviluppo di software, partendo dal presupposto che una delle più grandi fonti di problemi sono dovuti al dover far lavorare insieme __diverse persone__.  Si può dire che l'obiettivo della disciplina è infatti principalmente quello di risolvere i __problemi di comunicazione__, che possono essere:
- tra uno __sviluppatore__ e il __cliente__: sono esperti di domini diversi ed è difficile comprendersi. Spesso il cliente non è una singola persona ma un gruppo avente necessità e problemi diversi (come ad esempio il dirigente, l'impiegato e la segretaria che usano lo stesso software). È possibile anche che chi richiede il software non sia l'utilizzatore finale, ma verrà utilizzato da altre persone.
- tra uno __sviluppatore__ e altri __sviluppatori__: gli sviluppatori del progetto non hanno sempre lo stesso stile di lavoro, hanno sempre più specializzazioni differenti e non è detto neanche che siano di formazione prettamente informatica (ad esempio gli sviluppatori della parte grafica di un videogame)

Un'altra fonte di problemi sono le __dimensioni__ del software, che possono raggiungere valori molto elevati in termini di milioni di righe di codice e migliaia di _"anni uomo"_ di lavoro (solitamente vengono usati anche i _mesi uomo_). Lo sviluppo software non è più piccolo e domestico, e questo crea chiaramente problemi di manutenzione e gestione della codebase.

Il software è infine __malleabile__, ovvero facilmente modificabile nel tempo: il moltiplicarsi di versioni, evoluzioni e variazioni di target può creare non poche difficoltà.

La misurazione in _"anni uomo"_ è una misura che deve essere fatta a posteriori, e non prima per capire come affrontare un lavoro.
Inoltre questa non è una buona unità di misura, in quanto lascia intendere che maggiore è il numero di uomini impegnati nel lavoro e minore sarà il tempo impiegato, ma ovviamente non è così a causa della presenza di possibili compiti intrinsecamente non parallelizzabili e all'overhead di comunicazione necessario al crescere della dimensione del team di sviluppo.