# Convenzioni di stile e contenuto

Gli appunti devono essere chiari, concisi ma __completi__.
L'obiettivo è creare la _bibbia_ del corso: idealmente studiandola da zero si dovrebbe arrivare al 30L.

In tale prospettiva proponiamo una guida alle fasi di integrazione e di review che chiarifichi che cosa dev'essere presente negli appunti e lo stile di scrittura consigliato.

Naturalmente, queste indicazioni valgono per gli appunti proposti per il branch master: per gli appunti presi a lezione è assolutamente OK essere vaghi o brevi.

## Guida all'integrazione

La fase di integrazione degli appunti dovrebbe servire per riunire gli appunti di tutti i partecipanti in un unico documento.
Per agevolare la fase di review e riscrittura, tuttavia, questo non può limitarsi a un semplice _merge_ dei rispettivi file: l'integratore ha il compito di fornire a colui che dovrà riscrivere gli appunti la miglior base possibile su cui lavorare. \
Ecco dunque alcuni consigli utili in tal senso:

- Assicurarsi che __CI SIA TUTTO__: idealmente la fase di review dovrebbe solo fare "refactoring" degli appunti senza aggiungere nessun concetto, per cui è espressa responsabilità dell'integratore assicurarsi che il risultato finale sia assolutamente completo in quanto nessuno controllerà più i contenuti.

- __Una frase, una riga__: al termine di ciascuna frase (_ndr. una proposizione terminata da punto_) andare a capo in Markdown.
Questo infatti non spezza il paragrafo, come si può vedere dalla preview, ma agevola moltissimo il versioning con Git in quanto ogni frase viene così trattata come una linea di codice indipendente dalle altre.

- Assicurarsi che le stesse cose non siano dette in più punti diversi e, nel caso, integrarle tra di loro;

- Tenere i propri appunti sottomano per accertarsi che ogni concetto citato a lezione sia riportato: è chiaro che all'esame viene chiesto _tutto_, compresi i riferimenti esterni, per cui occorre includere negli appunti ogni nozione rilevante;

- Organizzare gli argomenti in maniera logica, evitando salti logici in avanti e in indietro per agevolare il lavoro di review;

- Sfruttare le potenzialità di Markdown (_es. titoli di vario livello, tabelle, elenchi..._) e rispettarne per quanto possibile le convenzioni (_es. linea vuota dopo i titoli, nessuno spazio alla fine di una riga..._);

- Tenere __sempre__ la preview di mdbook aperta per verificare che immagini e/o schemi vengano mostrati correttamente.

## Guida alla review

Gli appunti definitivi dovrebbero costituire un discorso omogeneo e fluido, come fossero un piccolo libro di testo. \
Per fare ciò, ecco alcune accortezze di stile e consigli utili durante la fase di review e riscrittura: si tratta solo di indicazioni (_"Just rules"_ ^-^), per cui non sentitevi in dovere di seguirle alla lettera.

### <big>Contenuto</big>

- Immaginare sempre di stare parlando con chi non sa nulla della materia: leggendo gli appunti dall'inizio alla fine si dovrebbe essere in grado di comprendere tutto.
È quindi importante:

  - non citare concetti senza che siano stati già spiegati precedentemente: se invece sono già stati spiegati può essere utile richiamarli con una formula del tipo _"Come sappiamo..."_ o _"Come abbiamo già visto..."_ seguita da un breve accenno al concetto;

  - non dare per scontato nessuna conoscenza;

- Se qualcosa è preso pari pari dalle slide può essere un campanello d'allarme.
Conviene dunque farsi le seguenti domande:

  - La frase si sposa bene con lo stile del discorso?
  Come potrei riscriverla in modo da rendere il fluire del discorso più omogeneo?

  - Il concetto espresso non è affrontato da nessun'altra parte?
  Se sì, tale ripetizione è davvero necessaria e funzionale?

- Mantenere convenzione "una frase, una riga" adottata nella fase di integrazione (_vd. sopra_): specialmente nella fase di review è importante che modificare una singola frase non comporti modificare interi paragrafi.

- Tenere i propri appunti sottomano per verificare ulteriormente che non manchi nulla: sebbene la fase di integrazione dovrebbe in teoria creare un documento completo di tutto, può capitare che qualcosa sia sfuggito.

### <big>Stile</big>

- Adottare una __sintassi semplice__: gli appunti dovrebbero essere completi ma facili da seguire;

- Avere una qualche estensione di __controllo ortografico__ attiva (_es. Code Spell per vscode_);

- Usare il più possibile l'__impersonale__: non _"possiamo fare X"_ ma _"si può fare X"_;

- Sforzarsi di presentare gli argomenti nel modo più chiaro possibile, legandoli tra di loro in unico discorso logico.
Per favorire questo approccio, ogni argomento dovrebbe essere affrontato nel modo seguente:

    1. __Presentare il problema__: es. _"Spesso capita di dover gestire X, Y e Z"_;

    2. __Discutere e analizzare il problema__: es. _"Il problema ha queste queste e queste caratteristiche, che non possiamo risolvere con quanto visto finora"_;

    3. __Proporre la/le soluzione/i al problema e discuterle__, confrontandole se più di una: es. _"In un primo momento si potrebbe pensare di risolvere così; tuttavia questo approccio ha questi difetti. Ecco allora che si è pensato di fare quest'altro"_;

    4. __Concludere con un breve riassunto__ su quanto visto, che servirà inoltre a introdurre il prossimo argomento: es. _"Abbiamo quindi visto come risolvere sta cosa; la soluzione pone però un nuovo problema..."_.

- Preferire i discorsi omogenei agli elenchi: usare gli elenchi __SOLO__ quando necessari.
Alcuni esempi dei pochi casi in cui un elenco è accettabile sono:

  - un __elenco puntato__ quando si elencano più cose contrapposte tra di loro (_es. diversi approcci o soluzioni a un problema_)

  - un __elenco numerato__ quando si specificano le varie fasi di un processo (_es. ciclo di vita del software_)

- Utilizzare la __separazione in paragrafi__ in modo coscienzioso: all'interno di un paragrafo dovrebbe idealmente essere trattato _un unico concetto_.
Diversi aspetti dello stesso concetto possono essere separati nello stesso paragrafo andando a capo (_con \ al termine della riga_), mentre quando si passa al concetto successivo è bene aprire un nuovo paragrafo.

- Utilizzare la __corretta punteggiatura__.
Può essere utile in tal senso rileggere mentalmente gli appunti appena scritti per assicurarsi che il discorso fluisca in modo scorrevole, ricordando che:

  - la virgola (",") rappresenta una pausa brevissima utilizzata per riprendere fiato o per evidenziare tramite un inciso (_una frase compresa tra due virgole_) determinati concetti che espandono in modo significativo il discorso principale;

  - i due punti (":") rappresentano una pausa breve e sono usati per introdurre elenchi o proposizioni strettamente correlate con quella principale;

  - il punto e virgola (";") rappresentano una pausa media, e vanno utilizzati quando si vuole dare un legame debole alla proposizione con la precedente e al termine di ogni elemento di un elenco tranne l'ultimo (_dove invece si usa il punto_);

  - le parentesi ("(...)") vengono utilizzate per incapsulare proposizioni che espandono la frase principale in modo non significativo: idealmente esse potrebbero essere saltate nella lettura senza togliere nulla al discorso.

- Utilizzare il __grassetto__ per evidenziare concetti chiave e il _corsivo_ per sottolineare frasi importanti; all'interno delle parentesi si può inoltre utilizzare il corsivo per aumentare la rilevanza del contenuto.

- Usare le congiunzioni correttamente per legare le frasi tra di loro (_es. dunque, perché, perciò, allora, in quanto..._);

- __NON IGNORARE I COMMENTI__: si tratta di richieste di aiuto da parte di chi ha fatto l'integrazione, che chiede un consiglio su una determinata questione.
È dunque importante che per il termine della review tale problema sia stato risolto: se vi trovate in difficoltà potete sempre chiedere sul gruppo!
