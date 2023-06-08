# Confronto tra tecniche di verifica e convalida

Numerosi studi hanno provato a confrontare l'efficacia di varie tecniche di testing, con particolare riferimento a testing strutturale, testing funzionale e software inspection.
Un [articolo](https://web.archive.org/web/20060920113729/http:/www2.umassd.edu/SWPI/ISERN/ISERN-98-10.pdf) del 2004 riporta in una __tabella di confronto__ i risultati di alcuni di questi studi, considerando come metrica di valutazione delle tecniche di verifica e convalida la _percentuale media di difetti individuati_.

![Confronto tecniche verifica e convalida](/assets/13_tabella-confronto-tecniche-vc.png)

Come si può notare, a seconda dello studio appare più efficace l'una o l'altra tecnica; inoltre, la somma delle percentuali per ogni riga non è 100%, il che significa che alcuni difetti non possono essere rilevati da nessuna delle tre tecniche. \
Nonostante ciò, si possono fare una serie di osservazioni: innanzitutto, l'efficacia di una  o dell'altra tecnica dipende dalla __tipologia del progetto__ su cui viene esercitata.
Inoltre, __non è detto__ che tecniche diverse trovino __gli stessi errori__: l'ispezione potrebbe aver trovato una certa tipologia di errore mentre il testing funzionale un'altra; le diverse tecniche controllano infatti diversamente aspetti differenti del programma, osservandolo da __diversi punti di vista__.

Confrontare le varie tecniche non è dunque necessariamente una perdita di tempo, mentre lo è sicuramente __confrontare solo i numeri__, come la varietà di risultati diversi ottenuti dai parte di studi diversi.
Tra l'altro, dal riassunto della tabella si __perdono__ informazioni sulle __modalità di rilevazione__ dei dati, attribuendole ad espressioni generiche (come _comunemente_, _in media_, _progetti junior_, ...).

In conclusione, non c'è una risposta semplice al confronto e __non esiste una tecnica _sempre_ migliore__ rispetto alle altre.

## Combinare le tecniche

Una domanda che sorge spontanea è chiedersi quindi cosa può succedere se si __combinano insieme__ diverse tecniche di verifica e convalida.

Diversi [studi](https://web.archive.org/web/20070221162909/http://www2.umassd.edu/SWPI/TechnicalReview/r4094.pdf) mostrano che applicando tutte e quattro le tecniche qui descritte &mdash; anche se solo in modo superficiale &mdash; il risultato è sicuramente __più performante__ delle tecniche applicate singolarmente.

![Tabella tecniche verifica convalida insieme](/assets/13_tabella-tecniche-vc-insieme.png)

Anche se una certa percentuale di errori può essere rilevata senza alcuna tecnica formale di verifica e convalida, semplicemente usando il software, si può infatti notare ciascuna tecnica presa singolarmente migliora tale percentuale e che la __combinazione__ di tecniche diverse la incrementa ulteriormente.
Questo perché tendenzialmente __ogni tecnica controlla aspetti differenti__ e le rispettive aree di controllo si sovrappongono poco: è dunque conveniente applicare superficialmente ciascuna tecnica piuttosto che una sola tecnica in modo molto approfondito.

In conclusione, come afferma la __Legge di Hetzel-Meyer (L20)__:
> _Una combinazione di diversi metodi di V/C supera qualsiasi metodo singolo._
