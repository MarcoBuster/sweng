---
layout: post
title: "[07] Progettazione"
date:   2022-10-24 14:30:00 +0200
toc: true
---

# Progettazione
Per capire lo scopo della progettazione siamo partiti da un esempio, ovvero abbiamo preso un programma che stampa una canzone, e il codice era fatto appositamente per essere difficilmente leggibile, abbiamo visto una seconda versione in cui il codice era molto più leggibile ma comunque difficilmente modificabile perché modificando quel codice sarebbe stato facile commettere degli errori.
Successivamente abbiamo scomposto il codice per renderlo logicamnete più sensato e facilmente modificabile, sono state estratte le parti comuni e messe in una funzione apposita, mentre le parti che cambiano sono state salvate in alcune strutture dati, in questo modo tramite un ciclo abbiamo ricreato la canzone. In questo modo scrivendo un codice più smeplice siamo stati in grado di creare una soluzione più generale e più aperta ai cambiamenti.

È importante quindi quando si scrive un programma adottare la soluzione più semplice (che non è quella più stupida!), e una misura convenzionale per dire quanto una cosa è semplice (qui all'università dove stiamo imparando, ma vale in linea generale anche sul lavoro) si esprime intermini di quanto tempo ci dedico per fare quella cosa.
Questa modo di misurare la semplicità è molto utile perché ci permette di capire se stiamo sfruttando il TDD nel modo corretto, ovvero se ogni breve lasso di tempo (una decina di minuti) abbiamo un feedback, infatti se per una sola iterazione ci mettiamo molto tempo è facile intuire che non stiamo sfruttando il TDD nel modo corretto perché stiamo affrontando un problema troppo complesso senza scomporlo (quindi dobbiamo ridurre la portata di quello che c'è da fare nei 10 minuti), oppure ho frainteso ciò che dovevo fare, e questo non rispetta le regole del TDD.

### Digressione sul Refactoring
Diamo una spiegazione un po' più specifica del refactoring visto nelle lezioni precedenti, prima però vediamo delle regole da rispettare durante il refactoring:
- Modifiche al codice che non modificano le funzionalità. il cliente da fuori non deve accorgersi di queste modifiche.
- Non devo passare dei test in più rispetto alla fase verde appena raggiunta.
- Se durante il refactoring mi dilungo per troppo tempo allora possiamo fare rollback all'ultima versione verde e provare a ragionare di nuovo sul refactoring (posso scomporre in più step? posso farlo meglio? in questo caso quindi vale la regola del "do it twice", ovvero la seconda volta posso farlo più velocemente e meglio).

Quindi perché faccio il refactoring? vediamo le motivazioni:
- Il design precedente era molto semplice, appositamente per passare ad uno scenario verde, quindi ora tramite il refactoring lo miglioro
- Sul lavoro fatto in precedenza (non quello appena concluso) mi posso accorgere di avere dei problemi, o meglio un debito tecnico, ovvero delle debolezze che se lascio li mi causa difficoltà sempre maggiori man mano che proseguo nel lavoro. Qui possiamo notare un richiamo alla legge di bohem<!-- Non ho capito se fosse la legge di bohem oppure un'altra -->, inizialmente contestata da xp ma poi in parte reintrodotta confermando che se vengono lasciati indietro degli errori pagheremo con gli interessi, ovvero più lavoro si fa trascurando questo problema e più fatica facciamo.
- Una volta che abbiamo raggiunto uno stato di verde nella feature e passiamo all'iterazione successiva possiamo accorgerci che se avessimo fatto il coidce in maniera differente nell'iterazione precedente ora sarebbe molto più semplice proseguire nell'iterazione. Allora se notiamo che questa aggiunta non è banale (ci mettiamo più di un minuto per farla) al posto di integrarla nella nuova feature torno indietro alla fase verde e faccio un'operazione di refactoring per far evolvere il codice verso una nuova direzione, ovvero quella per facilitare l'iterazione successiva (design for change).

## Design knowledge
Il design knowledge è dove la conoscienza del nostro design risiede, possiamo utilizzare:
- Memoria: non è efficace, nel tempo posso dimenticarmi. Se si lavora in coppia a maggior ragione non basta la memoria.
- Documenti di design (linguaggio naturale o diagrammi) : se non viene aggiornato di pari passo con il codice rimane disallineato, di conseguenza può risultare più dannoso che d'aiuto.
- Piattaforme di discussione (version control, issue management) : può aiutare ma avremmo le informazioni sparse in luoghi diversi e di conseguenza difficili da reperire, inoltre rimane il problema di mantenere aggiornate queste informazioni.
- UML: tramite diagrammi UML si è cercato di sfruttare l'approccio generative programming, quindi noi da una specificazioni tramite UML generavamo il codice, e anche se modificavamo il codice l'UML cambiava, con l'esperienza però si è visto che non poteva funzionare questa soluzione.
- Nel codice: tramite la scrittura del codice è possibile capire il design ma è difficile rappresentare le ragioni della scelta.

Possiamo dire quindi che partendo dall'ultima voce dobbiamo minimizzare la documentazione scritta e sfruttare tutte e quattro queste voci; l'unica cosa che è necessario scrivere sono le ragioni delle scelte e non la scelta in sé, che si può dedurre anche dal codice.

Come condividiamo queste scelte di design invece (non il design specifico ma il know how, come fare per)? possiamo sfruttare:
- Metodi: per esempio l'agile, o addirittura l'object orientation che può essere un metodo astratto per condividere scelte di design. <!--in che senso? -->
- Design pattern: Fondamentali per condividere scelte di design, sono utili anche per generare un vocabolario comune (sfruttiamo dei nomi riconosciuti da tutti per descrivere delle componenti) e aiutano la l'implementazione (i pattern hanno delle metodologie note per essere implementati).
- Principi: Abbiamo dei principi da rispettare tramite il design che creaiamo, per esempio i principi SOLID.

## Conoscienze preliminari di concetti e termini
Prima di proseguire vediamo dei concetti e termini fondamentali per proseguire nel corso:
- __Object orientation__: Cosa deve supportare un linguaggio per poter essere definito object oriented? abbiamo 3 cose, ovvero:
    - __Ereditarietà__, ovvero il concetto di classe in modo da spiegare per differenza da un'altra classe.
    - __Polimorfismo__, Può assumere diverse forme, quindi per far si che una classe sfrutti il polimorfismo deve implementare una o più interfacce. per esempio se abbiamo un'interfaccia animali, e creiamo una lista di animali, all'interno della lista possiamo metterci dentro diversi oggetti con caratteristiche diverse, ma tutti devono implementare l'interfaccia animali, ovvero deve avere almeno tutte le competenze di un animale, fa niente se poi ne ha altre. Questo collegamento tra capacità e oggetto è fatto __a tempo di compilazione__, quindi di fatto non ci interessa se la capacità non è ancora definita, basta che la abbia.
    - __Collegamento dinamico__, riprendendo l'esempio di prima tutti gli elementi che andranno nella lista sono elementi di cui sappiamo solo che hanno un collegamento con le capacità (metodi) di un animale, però non per forza uno di questi metodi al livello in cui lo stiamo considerando è definito, quindi qui entra in gioco il collegamento dinamico, ovvero a __tempo di esecuzione__ viene risolto il collegamento tra oggetto e metodo che effettivamente viene eseguito. Possiamo quindi dire che il collegamento dinamico ci permette di chiamare codice non ancora scritto, e grazie a questo meccanismo possiamo non toccare il codice appena scritto ma modificare e aggiungere funzionalità mettendo classi il cui codice verrà chiamato da qello già presente, in questo modo possiamo avere l'open-close principle che vedremo a breve.
- __Principi SOLID__: Abbiamo 5 parti che compongono questo principio:
    - __<a style="color: green">S</a>ingle responsability__, ovvero una classe ha un solo scopo, e questo si fa per mantenere la classe semplice e per avere una buona riusabilità.
    - __<a style="color: green">O</a>pen close principle__, cioè le classi devono essere aperte ai cambiamenti (open) senza toccare ciò che è stato scritto (close, qui si intende ciò che già è stato consegnato ed è in produzione, non ciò che ho scritto e a cui sto ancora lavorando).
    - __<a style="color: green">L</a>iskov substitution principle__, ovvero devo garantire che se nella classe padre garantisco delle caratteristiche anche tutte le classi che derivano da quella devono continuare a garantire quelle caratteristiche. Questo si collega all'aspetto __contract based__ del metodo agile (pre e post condizioni), ovvero se una funzione nella classe base funziona date certe pre-condizioni anche nella classe figlia devo far sì che la mia implementazione rispetti almeno tutte le pre-condizioni, poi volendo le può ampliare; al contrario nelle post condizioni dell'implementazione della classe figlia non posso garantire più di quello che nella classe padre garantivo. Quindi possiamo dire che questo è un altro modo per esprimere lo stesso principio (fare il casting bypassa queste regole).
    - __<a style="color: green">I</a>nterface segregation__, ovvero più separo le capacità di una classe in tante interfacce (che tra loro abbiano senso) più è facile usare la classe in contesti differenti. Queste interfacce possono essere viste come classi, come interfacce differenti ma che comunque possono non essere disgiunte, quindi ogni vista può essere usata indipendentemente dalle altre. In questo modo riusciamo a far sì che un client non dipenda da metodi che non usa, meglio avere tante interfacce specifiche e piccole (composte da pochi metodi), piuttosto che poche, grandi e generali. 
    - __<a style="color: green">D</a>ependency inversion__, cioè per far sì che una classe funzioni deve dipendere da dell'altro codice, e se questo codice è più concreto della mia classe ho dei problemi, perché a questo punto sono vincolato dalla concretezza di quello specifico codice da cui dipendo (esempio: telaio della 500 dipende dal motore x -> ho un problema perché posso usare il telaio solo se ho quello specifico motore, se invece telaio della 500 dipende dal concetto di motore con le diferse caratteristiche che deve avere (interfaccia), ma senza dettagli tecnici -> posso usare il telaio con qualisasi motore che aderisce a quell'interfaccia). In conclusione le cose cooncrete devono dipendere da cose astratte, e mai da cose concrete.
- __Reference escaping__: Violazione dell'incapsulamento, quando restituisco un oggetto interno alla classe che non sarebbe da esporre, questo può avvenire tranite dei getter in cui si ritorna un riferimento ad un oggetto interno (quindi anche se quell'oggetto è privato potrò accederci da fuori), tramite un setter che assegna all'oggetto interno un riferimento che gli viene passato oppure tramite il costruttore che assegna ad un oggetto interno un riferimento passato.
- __Encapsulation e information hiding__: Solo ciò che è nascosto può essere cambiato liberamente senza pericoli, ovvero se mostro all'esterno qualcosa devo impegnarmi a non modificarle come voglio, ma quello che ho nascosto posso modificarlo senza problemi. questo serve per facilitare la comprensione del codice e rendere più faicle modificare una parte senza fare danni.
- __Immutabilità__: l'oggetto dopo la sua inizializzazione non può essere modificato il suo stato in alcun modo, per fare ciò dobbiamo:
    - Non fornire metodi di modifica allo stato.
    - Ha attrubuti tutti privati (in realtà non è obbligatorio, posso mostrare cose attributi che non sono a loro volta mutabili)
    - Ha tutti gli attributi final (anche qui non è obbligatorio dichiararlo)
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
- Codice morto: Non deve essere presente del codice irraggiungibile o commentato nel programma, perché avendo a disposizione il versioning da cui possiamo riprenderlo in caso di necessità, non è necessario averlo nel risultato finale.
- Getter e setter: Vediamo nel principio di __Tell don't ask__.

## <a src="https://martinfowler.com/bliki/TellDontAsk.html">Principio Tell-Don't-Ask</a>
Il principio tell don't ask dice che piuttosto di __chiedere__ ad un oggetto dei dati e fare delle operazioni con quei dati è meglio __dire__ a questo oggetto cosa fare con i dati che contiene, quindi per esempio piuttosto che farsi dare i dati da una classe e cercare di stampare una stringa creata con quei dati in un certo formato è meglio dire all'oggetto di utilizzare il metodo toString che ci restituisce una stringa con la rappresentazione dello stato dell'oggetto, e noi semplicemente la stampiamo.

## Chiarimento estrazionde delle interfacce (interface segregation)
Queste interfacce possono nascere in due modi, tramite un approccio up front oppure down front, ovvero partendo direttamente a scrivere l'interfaccia oppure scrivendo il codice e cercare di capire successivamente se possiamo estrarre una classe (quest'ultimo modo si adatta di più al TDD).
Facciamo quindi un esempio (dal basso) per capire quando possiamo estrarre un'interfaccia.
{% responsive_image path: assets/07_drawCards.png %}
prendiamo per esempio un metodo drawCards che prende come parametri un deck e un intero, le uniche cose che conosciamo di deck sono che è in frado di dirci se è vuoto (isEmpty) e che sa pescare una carta dal mazzo (draw), questo ci suggerisce che Deck può implementare un'interfaccia mette a disposizione queste capacità.
Quindi è possibile modificare il codice in questo modo passando a drawCards non un deck ma un qualunque oggetto che è in grado di fare quelle due operazioni, quindi un elemento che implementa CardSource (quindi viene sfruttato il polimorfismo qui).

{% responsive_image path: assets/07_CardSource.png %}

Notiamo come alla linea 14 dobbiamo specificare __staticamente__ che Deck implementi CardSource, ovvero devo forzare la dichiarazione del fatto che Deck è un sottotipo di CardSource (java è strong typed) e quindi posso mettere un oggetto Deck ovunque sia richiesto un oggetto CardSource. In altri linguaggi tipo GO abbiamo una maggiore dinamicità perché non abbiamo bisogno di specificare nel codice che un oggetto è sottotipo di qualcos'altro, ci basta solo che implementi il metodo con lo stesso nome, però così facendo il check che l'oggetto passato ad una funzione che richede un oggetto avente quelle capacità avviene a runtime e non prima.

Un problema della troppa dinamicità (duck typing) è che se i metodi che deve implementare un oggetto non hanno dei nomi abbastanza specifici possiamo avere dei problemi, per esempio in un programma per il gioco del tennis se una funzione richiede un oggetto che implementa il metodo play, e riceve in input un oggetto che non centra nulla con il tennis (per esempio un oggetto giocatoreDiScacchi) che ha il metodo play, avremo degli errori, perché è un play che fa cose diverse da quelle che ci si aspetta.

Torniamo ora all'interface segregation, ora che abbiamo visto che la classe Deck implementa l'interfaccia CardSource, nulla ci vieta di fare in modo che implementi altre interfaccie, come si vede nell'immagine sotto. Al metodo precedente interessa solo che Deck abbia le capacità viste prima e specificate in CardSource, se poi implementa anche altre interfaccie al metodo non interessa.

{% responsive_image path: assets/07_UML-Deck.png %}

Notiamo ora nell'immagine dell'interfaccia CardSource che ci sono dei commenti javadoc, che specificano valore di ritorno e precondizioni, questo è il principio del __contract based design__, ovvero noi abbiamo un "contratto" in cui diciamo che è possibile richiamare il metodo draw solo se sono sicuro che no sia vuoto, altrimenti non garantisco il funzionamento del mio metodo, se poi chi lo usa non aderisce a questo contratto è un problema del chiamante (per specificare il contratto posso usare delle asserzioni o il @pre, la differenza è che il primo in fase di sviluppo mi avvisa se non sto rispettando il contratto, poi nella fase di deployment questi assert vengono rimossi, mentre nel secondo caso ho solo un commento, quindi non fa nessun controllo). Si potrebbe pensare che basti fare questo controllo all'interno del metodo draw ma questo sarebbe un approccio differente chiamato __programmazione difensiva__, ovvero non faccio assunzioni su ciò che mi viene dato e controllo io che l'input rispetti le condizioni di cui ho bisogno.

Abbiamo detto che una classe che implementa un'interfaccia deve implementare tutti i metodi dell'interfaccia, però abbiamo un'altra possibilità, ovvero quella di mettere la classe che implementa come classe astratta, ovvero una classe da cui non si possono istanziare oggetti.
Usando questo modo è come dire che la classe non è ancora completa, e quindi non ancora utilizzabile, però possiamo usare questo modo dell'abstract anche per classi complete ma che non ha senso che vengano istanziate. Un esempio è la classe Subject e l'interfaccia Oberserver di java, la classe Subject non è stata messa abstract ma non aveva alcun senso istanziarla, era necessario creare un sottotipo di Subject. Questo caso è un buon esempio di situazione in cui sarebbe stato necessario mettere la parola chiave abstract a Subject anche se era una classe completa ma non aveva senso istanziarla.

Le interfacce diminuiscono leggermente le performance, però migliorano estremamente la generalità (che aiutano l'espandibilità ed evolvibilità del programma), quindi vale la pensa di perdere leggermente in efficienza.

### Esempio nella libreria standard Java
Un esempio di ciò che abbiamo visto fino ad ora è quello usato nella libreria standard di java, infatti se noi abbiamo una classe Deck che ha come attributo una lista di carte, e vogliamo mettere a disposizione un metodo che mescola il deck, ci basterà sfruttarare Collections.shuffle che accetta come parametro una lista di qualcosa (List<?> list). Infatti non è necessario conoscere le carte per poterle mescolare, quindi possiamo dire che non abbiamo bisogno di sapere cosa contiene la lista per poter cambiare la loro posizione all'interno di essa.
La stessa cosa si può dire se vogliamo ordinare il mazzo di carte? no perché dobbiamo aver bisogno di un criterio per comparare gli elementi, quindi il metodo sort di collection dovrà prendere come parametro una lista di T con il vincolo che questo T estenda l'interfaccia comparable di qualocosa antenato di T (quindi T deve avere un metodo compareTo usabile, presente in T o in un suo antenato), in altre parole sort ha bisogno che gli elementi della lista da ordinare siano confrontabili tra di loro.
```java
public static <T extends Comparable<? sper T>> void sort(List<T> list)
```
Comparable è un altro esempio di interface segregation, è un'interfaccia tirata fuori per specificare che un oggetto ha bisogno della caratteristica di essere comparabile.

Digressione: la classe Collections era l'unico modo per definire dei metodi sulle interfaccie (es: dare la possibilità di avere dei metodi sulle collezioni, ovvero liste, mappe, ecc), questo andrà a sparire siccome ora esistono i metodi di default.

## polimorfismo e loose coupling
Passando ora al polimorfismo vediamo come viene affiancato dal concetto di __loose coupling__, ovvero la capacità di una variabile o parametro di accettare l'assegnazione di oggetti aventi tipo diverso da quello della variabile/parametro, a patto però che sia un sottotipo.

```java
Deck deck = new Deck();

CardSource source = deck;

List<Card> cards;
cards = drawCards(deck, 5);
```
## Diagrammi UML
Abbiamo diversi tipi di diagrammi UMP, il primo che vediamo è il diagramma delle classi, ovvero una vista statica (ovvero come se fosse una fotografia) di una situazoine.

{% responsive_image path: assets/07_UML.png %}

In un diagramma UML delle classi abbiamo:
- classi
- interfacce
- collegamenti tra queste

ecco le caratteristiche principali:
- Se una scritta è in _italico_ vuol dire che all'elemento manca qualche definizione, quindi è astratto.
- Se una scritta è <u>sottolineata</u> vuol dire che l'attributo o metodo è statico, ovvero hanno una visibilità a livello di classe e non a livello di istanza (quindi possiamo riferirci a loro anche senza avere un'istanza della classe).

vediamo i tipi di relazioni indicati dalle freccie:
- __frecce tratteggiate__: sono le più generiche, indica una relazione tra classi, quello che c'è scritto nella classe da cui parte la freccia dipende dal codice che c'è nella classe a cui arriva la freccia (Deck dipende da collections). Questa relazione è chiamata __associazione__.
- __freccia con rombo bianco__: questo tipo di relazione è chiamata __aggregazione__ ed indica che all'interno della classe (Deck) ho una collezione (in questo caso una lista) di n oggetti (Card). Questa relazione non è più tra classi ma tra istanze delle classi (Un'istanza di Deck aggrega da 0 a 52 carte). Posso specificare anche la cardinalità nel senso apposto, ovvero da Card a Deck, che in questo caso essendo oggetti virtuali (immutabili) non sono vincolato ad avere una carta specifica in un solo mazzo, ma può stare in tanti mazzi.
- __freccia con rombo nero__:  questa è chiamata __composizione__ ed è utilizzata quando ho degli elementi che sono fisicamente collegati e non solo virtualmente (come le carte), senza l'uno l'altro non può vivere, e viceversa. L'esempio può essere un aereo che senza il motore cade, e il motore non passa ad un altro aereo (a differenza delle carte che possono passare a più mani).

Abbiamo anchela freccia con la punta a triangolo che specifica un'implementazione.

La direzione delle frecce sono importanti perché indicano il senso della relazione, per esempio il mazzo conosce le carte che contiene, ma le carte non conoscono i mazzi in cui sono, è per questo che la direzione della freccia va da Deck a Card e non viceversa.
Queste sono sempre delle relazioni tra oggetti ma sono utilizzate in contesti differenti.

In questo esempio la visibilità dei metodi è espressa da un pallino verde (public), ma potremmo avere anche l'arancio o il rosso, che indicano protected e private, poi possono essere rappresentati in altri modi ma comunque molto intuitivi.