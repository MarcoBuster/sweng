# Ingegneria del software

## Storia 
Con la diffusione dei primi computer in ambito accademico, negli anni '50 e '60 si è subito colta la necessità di superare metodi di produzione "artigianale" del software: sebbene il cliente e il programmatore coincidessero e i programmi fossero prettamente matematici, si iniziavano già a vedere i primi problemi. Negli anni '70, si inizia dunque a pensare a dei metodi, dei processi e a degli strumenti che potessero migliorare e ___"assicurare"___ la __qualità del software__, sviluppando un approccio di tipo ingegneristico costituito da una serie di fasi.

## Approccio ingegneristico
1. __Target__: ci si prefigge un obiettivo da raggiungere.
2. __Metric__: si definisce una metrica per misurare la qualità del software, ovvero quanto esso si avvicina al target prefissato.
3. __Method, Process, Tool__: si provano una serie di metodi, processi e strumenti per avvicinarsi all'obiettivo.
4. __Measurements__: si misura tramite la metrica stabilita se le strategie implementate sono state utili e quanto ci hanno avvicinato (o allontanato) all'obiettivo. A seconda dei risultati ottenuti vi sono due possibili strade:
    - risultati soddisfacenti (_aumento delle metrica_) - accettiamo come buoni metodi e processi utilizzati.
    - risultati insoddisfacenti (_diminuzione della metrica_)- ci sono dei peggioramenti o dei forti effetti collaterali, di conseguenza bisogna modificare il lavoro qualcosa: si possono cambiare target o metrica se ci si rende conto di non aver ben definito l'obiettivo, ma più comunemente bisogna rivedere i processi e metodi usati.

Ma __che cosa si intede per target__? Gli obiettivi da raggiungere possono essere di due tipi: la risoluzione dei __problemi nella progettazione del software__ e l'assicurazione di una qualche __qualità che il software dovrà avere__. È dunque necessario chiedersi le seguenti domande:
- Quali problemi ci sono?
- Quali qualità deve avere il software?

### Problemi principali
Vediamo allora a questo punto alcuni dei problemi che possono insorgere durante lo sviluppo di software, partendo dal presupposto che una delle più grandi fonti di problemi sono le __persone__.  L'obiettivo della disciplina è infatti principalmente quello di risolvere i __problemi di comunicazione__, che possono essere:
- tra il __programmatore__ e il __cliente__: sono esperti di domini diversi ed è difficile comprendersi;
- tra un __programmatore__ e altri __programmatori__.

Un'altra fonte di problemi sono le __dimensioni__ del software, che possono raggiungere valori molto elevati in termini di milioni di righe di codice e migliaia di _"anni uomo"_ di lavoro. Lo sviluppo software non è più piccolo e domestico, e questo crea chiaramente problemi di manutenzione e gestione della codebase.

Il software è infine __facilmente malleabile__, ovvero modificabile nel tempo: il moltiplicarsi di versioni, evoluzioni e variazioni di target può creare non poche difficoltà.
