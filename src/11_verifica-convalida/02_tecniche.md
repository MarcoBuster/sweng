# Tecniche

## Classificazione delle tecniche

Nell'ambito della _verifica e convalida_ è possibile classificare le tecniche di analisi in due categorie:
- __tecniche statiche__, basate sull'analisi degli elementi sintattici del codice. \
Ad esempio: metodi formali, analisi del dataflow e modelli statistici;
- __tecniche dinamiche__, basate sull'esecuzione del programma. \
Ad esempio: testing e debugging.

In generale, __è più facile determinare tecniche dinamiche__ rispetto alle tecniche statiche.
Per contro, una volta ideate e a patto di avere dimensioni del codice ragionevoli e costrutti sintattici non troppo complessi le __tecniche statiche sono più veloci__ nell'analizzare il codice e, soprattutto, più complete dato che le tecniche dinamiche lavorano sui possibili stati del programma - che possono essere infiniti.

Ovviamente diverse metodologie di verifica e convalida avranno i rispettivi pro e contro.
Come si possono dunque confrontare queste tecniche?

![Classificazione tecniche verifica e convalida](/assets/12_classificazione-tecniche-di-verifica-e-convalida.jpg)

Nell'immagine sopra è possibile osservare una _piramide immaginaria a 3 dimensioni_ che riassume dove si posizionano le tecniche di verifica e convalida relativamente le une con le altre.
La cima della piramide rappresenta il __punto ideale__ a cui tendere, nel quale è possibile affermare di esser riusciti a verificare perfettamente una proprietà arbitraria attraverso una prova logica (dal lato statico) o una ricerca esaustiva su tutti gli stati del problema (dal lato dinamico).

Tale punto ideale è __praticamente impossibile__ da raggiungere per la stragrande maggioranza dei problemi che siamo interessati a risolvere. 
Bisogna scegliere da quale versante iniziare la scalata della piramide: __lato verde__ (approccio statico) o __lato blu__ (approccio dinamico)?

Più ci si posiziona verso il basso, più si degenera in:
<ul>
<li>

__estrema semplificazione delle proprietà__ (in basso a sinistra): si stanno in qualche modo _rilassando_ eccessivamente gli obiettivi che si vogliono raggiungere.

Ad esempio, se si vuole dimostrare che si sta usando un puntatore in maniera corretta e nel farlo si sta semplicemente controllando che non valga `null`, è _cambiata_ la proprietà che si vuole come obiettivo (controllare che un puntatore non valga `null` __non significa che__ lo si stia usando nel modo corretto);
</li>
<li>

__<span id="innaccuratezza_pessimistica">estrema inaccuratezza pessimistica</span>__ (in basso al centro): è dovuta all'approccio pessimistico che ha come mantra:
> _"Se non riesco a dimostrare l'assenza di un problema assumo che il problema sia presente"_

Ad esempio, si manifesta nei compilatori quando non riescono a dimostrare che una determinata funzione che deve ritornare un valore ritorni effettivamente un valore per tutti i possibili cammini `if` / `else if` / eccetera. La mancanza di capacità nel dimostrare l'assenza di un problema non ne implica la presenza di uno.
</li>
<li>

__estrema <span id="innaccurettezza_ottimistica">inaccuratezza ottimistica</span>__ (in basso a destra): è dovuta all'approccio ottimistico che ha come mantra:
> _"Se non riesco a dimostrare la presenza di un problema assumo che questo non sia presente"_

È una possibile deriva degli approcci legati al testing: con esso si cercano malfunzionamenti, se a seguito dei test non ne vengono trovati allora si assume che il programma funzioni correttamente.
</li>
</ul>

A metà strada tra questi estremi inferiori e l'estremo superiore ideale si posizionano quindi le varie tecniche di verifica e convalida, ciascuna più o meno legata ai tra approcci sopra descritti.
Tra queste evidenziamo le dimostrazioni con metodi formali, il testing e il debugging.

## Metodi formali

L'approccio dei metodi formali tenta di dimostrare l'_assenza_ di anomalie nel prodotto finale. \
Si possono utilizzare diverse tecniche (spiegate nelle lezioni successive), come:
- analisi di dataflow;
- dimostrazione di correttezza delle specifiche logiche.

Questo approccio segue la linea dell'_<a href="#innaccuratezza_pessimistica">inaccuratezza pessimistica</a>_.

## Testing

Il testing è l'insieme delle tecniche che si prefiggono di rilevare __malfunzionamenti__. \
Attraverso il testing non si può dimostrare la correttezza ma solo aumentare la _fiducia_ dei clienti rispetto all'affidabilità del prodotto.

Le tecniche di testing possono essere molto varie e si raggruppano in:
- __white box__: si ha accesso al codice da testare e si possono cercare anomalie guardandolo da un punto di vista interno;
- __black box__: non si ha accesso al codice ma è possibile testare e cercare malfunzionamenti tramite le interfacce esterne;
- __gray box__: non si ha accesso al codice ma si ha solo un'idea dell'implementazione ad alto livello. \
Per esempio, se sappiamo che il sistema segue il pattern <big>M</big>ODEL <big>V</big>IEW <big>C</big>ONTROLLER ci si può aspettare che certe stimolazioni portino a chiamate al database mentre altre no.

Come è chiaro, questo approccio segue una logica di _<a href="#innaccuretezza_ottimistica">inaccuratezza ottimistica</a>_.

È inoltre interessante notare che il Test Driven Development (TDD) adotta una filosofia di testing completamente black box: imponendo che venga scritto prima il test del codice questo non può assumere niente sul funzionamento interno dell'oggetto di testing.

## Debugging

Dato un _programma_ e un _malfunzionamento noto e riproducibile_, il debugging permette di localizzare le __anomalie__ che causano i malfunzionamenti.
A differenza del testing, infatti, è richiesta la conoscenza a priori di un malfunzionamento prima di procedere con il debugging.

Molto spesso viene usato il debugging al posto del __testing__, almeno a livello di terminologia: questo è un problema perché il debugging non è fatto per la "grande esecuzione" ma al contrario per esaminare in maniera granulare (a volte anche passo passo per istruzioni macchina) una determinata sezione di codice in esecuzione con lo scopo di trovare l'anomalia che provoca un malfunzionamento.
Se si usassero le tecniche di debugging per effettuare il testing il tempo speso sarebbe enorme: il debugging osserva infatti _stati interni_ dell'esecuzione e per rilevare un malfunzionamento in questo modo sarebbe necessario osservare tutti i possibili - e potenzialmente infiniti - stati del programma.

Due possibili approcci al debugging sono:
- partendo da una malfunzionamento _noto_ e _riproducibile_ si avvia una procedura di analisi basata sulla __produzione degli stati intermedi__ dell'esecuzione del programma: _passo passo_ (a livello a piacere, da istruzione macchina a chiamata di funzione) si controllano tutti gli stati di memoria alla ricerca di uno inconsistente;
- ___divide-et-impera___: il codice viene smontato sezione per sezione e componente per componente in modo da poter trovare il punto in cui c'è l'anomalia. 
Si possono mettere breakpoint o _"print tattiche"_.
