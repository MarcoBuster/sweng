---
layout: post
title: "[07] Progettazione"
date:   2022-10-24 14:30:00 +0200
toc: true
---

# Progettazione
Per capire lo scopo della progettazione siamo partiti da un esempio, ovvero abbiamo preso un programma che stampa una canzone, e il codice era fatto appositamente per essere difficilmente leggibile, abbiamo visto una seconda versione in cui il codice era molto più leggibile ma comunque difficilmente modificabile perchè modificando quel codice sarebbe stato facile commettere degli errori.
Successivamente abbiamo scomposto il codice per renderlo logicamnete più sensato e facilmente modificabile, sono state estratte le parti comuni e messe in una funzione apposita, mentre le parti che cambiano sono state salvate in alcune strutture dati, in questo modo tramite un ciclo abbiamo ricreato la canzone. In questo modo scrivendo un codice più smeplice siamo stati in grado di creare una soluzione più generale e più aperta ai cambiamenti.

È importante quindi quando si scrive un programma adottare la soluzioe più semplice (che non è quella più stupida!), e una misura convenzionale per dire quanto una cosa è semplice (qui all'università dove stiamo imparando, ma vale in linea generale anche sul lavoro) si esprime intermini di quanto tempo ci dedico per fare quella cosa.
Questa modo di misurare la semplictà è molto utile perchè ci permette di capire se stiamo sfruttando il TDD nel modo corretto, ovvero se ogni breve lasso di tempo (una decina di minuti) abbiamo un feedback, infatti se per una sola iterazione ci mettiamo molto tempo è facile intuire che non stiamo sfruttando il TDD nel modo corretto perchè stiamo affrontando un problema troppo complesso senza scomporlo (quindi dobbiamo ridurre la portata di quello che c'è da fare nei 10 minuti), oppure ho frainteso ciò che dovevo fare, e questo non rispetta le regole del TDD.

<!-- Valutare se è meglio togliere questa parte e metterla dove abbiamo partalto del refactoring nella lezione 3 -->:
### Digressione sul Refactoring
Diamo una spiegazione un po più specifica del refactoring visto nelle lezioni precedenti, prima però vediamo delle regole da rispettare durante il refactoring:
- Modifiche al codice che non modificano le funzionalità. il cliente da fuori non deve accorgersi di queste modifiche.
- Non devo passare dei test in più rispetto alla fase verde appena raggiunta.
- Se durante il refactoring mi dilungo per troppo tempo allora possiamo fare rollback all'ultima versione verde e provare a ragionare di nuovo sul refactoring (posso scomporre in più step? posso farlo meglio? in questo caso quindi vale la regola del "do it twice", ovvero la seconda volta posso farlo più velocemente e meglio).

Quindi perchè faccio il refactoring? vediamo le motivazioni:
- Il design precedente era molto semplice, appositamente per passare ad uno scenario verde, quindi ora tramite il refactoring lo miglioro
- Sul lavoro fatto in precedenza (non quello appena concluso) mi posso accorgere di avere dei problemi, o meglio un debito tecnico, ovvero delle debolezze che se lascio li mi causa difficoltà sempre maggiori man mano che proseguo nel lavoro. Qui possiamo notare un richiamo alla legge di bohem<!-- Non ho capito se fosse la legge di bohem oppure un'altra -->, inizialmente contestata da xp ma poi in parte reintrodotta confermando che se vengono lasciati indietro delgi errori pagheremo con gli interessi, ovvero più lavoro si fa trascurando questo problema e più fatica facciamo.
- Una volta che abbiamo raggiunto uno stato di verde nella feature e passiamo all'iterazione successiva possiamo accorgerci che se avessimo fatto il coidce in maniera differente nell'iterazione precedente ora sarebbe molto più semplice proseguire nell'iterazione. Allora se notiamo che questa aggiunta non è banale (ci mettiamo più di un minuto per farla) al posto di integrarla nella nuova feature torno indietro alla fase verde e faccio un'operazione di refactoring per far evolvere il codice verso una nuova direzione, ovvero quella per facilitare l'iterazione successiva (design for change).

## Design knowledge
Il design knowledge è dove la conoscienza del nostro design risiede, possiamo utilizzare:
- Memoria: non è efficacie, nel tempo posso dimenticarmi. Se si lavora in coppia a maggio ragione non basta la memoria.
- Documenti di design (linguaggio naturale o diagrammi) : se non viene aggiornato di pari passo con il codice rimane disallineato, di conseguenza può risultare più dannoso che d'aiuto.
- Piattaforme di discussione (version control, issue management) : può aiutare ma avremmo le informazioni sparse in luoghi diversi e di conseguenza difficili da reperire, inoltre rimane il problema di mantenere aggiornate queste informazioni.
- UML: tramite diagrammi UML si è cercato di sfruttare l'approccio generative programming, quindi noi da una specificazioni tramite UML generavamo il codice, e anche se modificavamo il codice l'UML cambiava, con l'esperienza però si è visto che non poteva funzionare questa soluzione.
- Nel codice: tramite la scrittura del codice è possibile capire il design ma è difficile rappresentare le ragioni della scelta.

Possiamo dire quindi che partendo dall'ultima voce dobbiamo minimizzare la documentazione scritta e sfruttare tutte e quattro queste voci; l'unica cosa che è necessario scrivere sono le ragioni delle scelte e non la scelta in se, che si può dedurre anche dal codice.

Come condividiamo queste scelte di design invece (non il design specifico ma il know how, come fare per)? possiamo sfruttare:
- Metodi: per esempio l'agile, o addirittura l'object orientation che può essere un metodo astratto per condividere scelte di design <!--in che senso? -->
- Design pattern: Fondamentali per condividere scelte di design, sono utili anche per generare un vocabolario comune (sfruttiamo dei nomi riconosciuti da tutti per descrivere delle componenti) e aiutano la l'implementazione (i pattern hanno delle metodologie note per essere implementati).
- Principi: Abbiamo dei principi da rispettare tramite il design che creaiamo, per esempio i principi SOLID.

## Conoscienze preliminari di concetti e termini
Prima di proseguire vediamo dei concetti e termini fondamentali per proseguire nel corso:
- __Object orientation__: Cosa deve supportare un linguaggio per poter essere definito object oriented? abbiamo 3 cose, ovvero:
    - __Ereditarietà__, ovvero il concetto di classe in modo da spiegare per differenza da un'altra classe.
    - __Polimorfismo__, Può assumere diverse forme, quindi per far si che una classe sfrutti il polimorfismo deve implementare una o più interfacce. per esempio se abbiamo un'interfaccia animali, e creiamo una lista di animali, all'interno della lista possiamo metterci dentro diversi oggetti con caratteristiche diverse, ma tutti devono implementare l'interfaccia animali, ovvero deve avere almeno tutte le competenze di un'animale, fa niente se poi ne ha altre. Questo collegamento tra capacità e oggetto è fatto __a tempo di compilazione__, quindi di fatto non ci interessa se la capacità non è ancora definita, basta che la abbia
    - __Collegamento dinamico__, riprendendo l'esempio di prima tutti gli elementi che andranno nella lista sono elementi in cui sappiamo solo che hanno un collegamento con le capacità di un'animale, però non per forza questo metodo al livello in cui lo stiamo considerando è definito, quindi qui entra in gioco il collegamento dinamico, ovvero a __tempo di esecuzione__ viene risolto il collegamento tra oggetto e metodo che effettivamente viene eseguito<!--Probabilemente può essere scritto meglio-->.
- __Principi SOLID__: Abbiamo 5 parti che compongono questo principio:
    - <a style="color: green">S</a>ingle responsability, ovvero una classe ha un solo scopo, e questo si fa per mantenere la classe semplice e per avere una buona riusabilità.
    - <a style="color: green">O</a>pen close principle, cioè le classi devono essere aperte ai cambiamenti (open) senza toccare ciò che è stato scritto (close, qui si intende ciò che già è stato consegnato ed è in produzione, non ciò che ho scritto e a cui sto ancora lavorando).
    - <a style="color: green">L</a>iskov substitution principle, ovvero devo garantire che se nella classe padre garantisco delle caratteristiche anche tutte le classi che derivano da quella devono continuare a garantire quelle caratteristiche. Questo si collega all'aspetto __contract based__ del metodo agile (pre e post condizioi), ovvero se una funzione nella classe base funziona date certe pre-condizioni anche nella classe figlia devo far si che la mia implementazione rispetti almeno tutte le pre-condizioni, poi volendo le può ampliare; al contrario nelle post condizioni dell'implementazione della classe figla non posso garantire più di quello che nella classe padre garantivo. Quindi possiamo dire che questo è un altro modo per esprimere lo stesso principio (fare il casting bypassa queste regole).
    - <a style="color: green">I</a>nterface segregation, ovvero più separo le capacità di una classe in tante interfacce (che tra loro abbiano senso) più è facile usare la classe in contesti differenti. Queste interfaccie possono essere viste come classe, come interfacce differenti ma che comunque possono non essere disgiunte, però ogni vista può essere usata indipendentemente dalle altre<!--chiarisci-->.
    - <a style="color: green">D</a>ependency inversion, cioè per far si che una classe funzioni deve dipendere da dell'altro codice, e se questo codice è più concreto della mia classe ho dei problmei, perchè a questo punto sono vincolato dalla concretezza di quello specifico codice da cui dipendo (esempio: telaio della 500 dipende dal motore x -> ho un problema perchè posso usare il telaio solo se ho quello specifico motore, se invece telaio della 500 dipende dal concetto di motore con le diferse caratteristiche che deve avere (interfaccia), ma senza dettagli tecnici -> posso usare il telaio con qualisasi motore che aderisce a quell'interfaccia).
- __Reference escaping__: Violazione dell'incapsulamento, quando restituisco un oggetto interno alla classe che non sarebbe da esporre, questo può avvenire tranite dei getter in cui si ritorna un riferimento ad un oggetto interno (quindi anche se quell'oggetto è privato potrò accederci da fuori), tramite un setter che assegna all'oggetto interno un riferimento che gli viene passato oppure tramite il costruttire che assegna ad un oggetto interno un riferimento passato.
- __Encapsulation e information hiding__: Solo ciò che è nascosto può essere cambiato liberamente senza pericoli, ovvero se mostro all'esterno qualcosa devo impegnarmi a non modificarle come voglio, ma quello che ho nascosto posso modificarlo senza problemi. questo serve per facilitare la comprensione del codice e rendere più faicle modificare una parte senza fare danni.
- __Immutabilità__: l'oggetto dopo la sua inizializzazione non può essere modificato il suo stato in alcun modo, per fare ciò dobbiamo:
    - Non fornire metodi di modifica allo stato.
    - Ha attrubuti tutti privati (in realtà non è obbligatorio, posso mostrare cose attributi che non sono a loro volta mutabili)
    - Ha ttutti gli attributi final (anche qui non è obbligatorio dichiararlo)
    - Assicura accesso esclusivo a tutte le parti non mutabili, ovvero non ci sono reference escaping.

## Code smell
I seguenti sono dei segnali che ci permettono di capire che qualocsa non va:
- Codice duplicato: Posso farlo per arrivare velocemente al verde ma poi lo devo togliere con il refactoring, siccome se ho codice duplicato vuol dire che quei pezzi di codice hanno qualcosa in comune ed è possibile fattorizzare.
- Metodi troppo lunghi: sono poco leggibili e poco riusabili.
- Troppi livelli di indentazione: anche qui abbiamo una scarsa leggibilità e riusabilità, quando ho tanti livelli di indentazione a causa di cicli per esempio è facile fattorizzare il codice.
- Troppi attributi: suggerisce che la classe non rispetta la single responsability, ovvero fa troppe cose.
- Lunghezza sequenze di _if-else_ o _switch_
- Classe troppo grande
- Lista parametri troppo lunga
- numeri _magici_: Quando si hanno delle costanti numeriche all'interno del codice non si capisce cosa rappresentano, essendo adimensionali e non danno informazioni. Allora bisogna dargli un nome per fare in modo che si capisca a cosa serve.
- Commenti: Se sono presenti vuol dire che il codice non era abbastanza chiaro.
- Nomi oscuri o inconsistenti: bisogna dare dei nomi sensati a metodi/classi/variabili.
- Codice morto: Non deve essere presente del codice irraggiungibile o commentato nel programma, perchè avendo a disposizione il versioning da cui possiamo riprenderlo in caso di necessità, non è necessario averlo nel risultato finale.
- Getter e setter: Vediamo nel principio di __Tell don't ask__.

## <a src="https://martinfowler.com/bliki/TellDontAsk.html">Principio Tell-Don't-Ask</a>
Il principio tell don't ask dice che piuttosto di __chiedere__ ad un oggetto dei dati e fare delle operazioni con quei dati è meglio __dire__ a questo oggetto cosa fare con i dati che contiene, quindi per esempio piuttosto che farsi dare i dati da una classe e cercare di stampare una stringa creata con quei dati in un certo formato è meglio dire all'oggetto di utilizzare il metodo toString che ci restituisce una stringa con la rappresentazione dello stato dell'oggetto, e noi semplicemente la stampiamo.