# Analisi di raggiungibilità temporale

Rassegnatici dunque alla necessità di creare nuove tecniche di analisi specifiche per le reti temporizzate iniziamo a parlare di __analisi dinamica__ a partire dall'__analisi di raggiungibilità__, ovvero la tecnica con cui nelle reti di Petri classiche eravamo in grado di __enumerare gli stati finiti raggiungibili__.

Provando ad adottare lo stesso approccio nei confronti delle reti TB ci si rende però subito conto di un enorme __problema__: le reti temporizzate hanno sempre __infiniti stati__, in quanto lo scatto di una singola transizione può produrre un'infinità di stati di arrivo che si differenziano unicamente per il timestamp dei gettoni generati.
Sebbene la marcatura sia identica, le informazioni temporali legate ai gettoni sono differenti, distinguendo così ciascuno di tali stati della rete. \
Bisogna inoltre considerare che per sua stessa natura il tempo avanza, rendendo così le reti temporizzate in grado di __evolvere all'infinito__: anche raggiungendo una marcatura che non abilita alcuna transizione, la rete continua ad evolvere in quanto il _tempo corrente_ continua ad avanzare.

Dovendo costruire un __albero di raggiungibilità__ questo sarebbe quindi sicuramente __infinito__, anche se in un modo diverso rispetto a quanto già visto per le reti non limitate: in quel caso infatti i gettoni non erano distinguibili, cosa che ci aveva permesso di raggrupparne un numero qualsiasi sotto il simbolo \\(\omega\\), mentre in questo caso le differenze nei timestamp impediscono un simile approccio.

Al contrario, per ottenere per le reti TB un'analisi simile all'analisi di raggiungibilità delle reti classiche è necessario __ridefinire__ completamente il concetto di __stato raggiungibile__.

## Stati simbolici

Per riformulare il concetto stesso di raggiungibilità partiamo da innanzitutto da quello di __marcatura__: nelle reti temporizzate queste associavano infatti a ciascun posto un _multiset_ in cui ad ogni timestamp era associato il numero di gettoni con tale timestamp presente nel posto.

Per evitare la difficoltà di distinguere tra gettoni con timestamp diversi viene introdotto nelle reti TB il concetto di __stato simbolico__, un oggetto matematico che sostituendo ai timestamp specifici degli identificatori simbolici dei gettoni permette di _rappresentare un __insieme di possibili stati__ con in comune lo stesso numero di gettoni in ciascun posto_ (esattamente come la marcatura delle reti classiche).

Più formalmente, uno stato simbolico è una __tupla__ \\([\mu, C]\\), dove:

- \\(\mu\\) è la __marcatura simbolica__, che associa a ciascun posto un _multiset_ di __identificatori simbolici__ che rappresentano i timestamp dei gettoni in tale posto.
  Timestamp uguali saranno rappresentati dallo stesso simbolo, anche se si trovano in posti diversi: questo permette di mantenere l'__identità__ tra timestamp;

- \\(C\\) è un sistema di __vincoli__ (_constraint_), ovvero equazioni e disequazioni che rappresentano le relazioni tra gli identificatori simbolici dei gettoni.
  In questo modo è possibile mantenere le __relazioni__ tra i timestamp dei gettoni pur non rappresentando esplicitamente il loro valore.

Un'esempio aiuterà a chiarire ogni dubbio.
Immaginiamo di avere una rete TB con 3 posti \\((P1, P2, P3)\\), ciascuno con un solo gettone al loro interno, e la seguente marcatura iniziale: \\(\langle \{0\}, \{1\}, \{0\} \rangle\\).
Volendoci disfare dei timestamp espliciti dei gettoni, che tutto sommato ci interessano relativamente, dobbiamo __mantenere due informazioni__:

- che i gettoni in \\(P1\\) e \\(P3\\) hanno lo _stesso timestamp_;
- che il gettone in \\(P2\\) ha _timestamp maggiore_ di 1 del timestamp dei gettoni negli altri due posti.

Per fare ciò lo stato simbolico generato assegnerà lo stesso identificatore ai gettoni in \\(P1\\) e \\(P3\\) e espliciterà nei vincoli la relazione tra tempi.
Otterremo dunque lo stato simbolico iniziale:

$$ \mu(P1)=\{\tau_0\}, \\: \\: \\: \mu(P2)=\{\tau_1\}, \\: \\: \\: \mu(P3)=\{\tau_0\} $$

$$ C_0: \\: \\: \\: \tau_1=\tau_0+1 $$

Infine, ci si potrebbe accorgere che in realtà non ci interessa che il timestamp del gettone in \\(P2\\) sia esattamente \\(\tau_0+1\\), ma solamente che esso sia maggiore di \\(\tau_0\\).
Ecco dunque che spesso si mutano i vincoli in __disequazioni__:

$$ C_0: \\: \\: \\: \tau_0<\tau_1 $$

## Albero di raggiungibilità temporale

Utilizzando la definizione di stato simbolico appena vista è possibile costruire tramite un algoritmo un __albero di raggiungibilità temporale__, in cui gli stati distinguibili solo dai timestamp vengono condensati in stati simbolici che conservano però le _molteplicità_ dei gettoni nei posti e le _relazioni_ tra i timestamp.

Prima di fare ciò, però, è necessario rinnovare un'assunzione già fatta in precedenza: anche in questa analisi assumeremo che le funzioni temporali \\(tf_{t}\\) associate alle transizioni siano esprimibili come __intervalli con estremi inclusi__ \\(\bf{[tmin_t, tmax_t]}\\), dove questi ultimi possono dipendere ovviamente dai timestamp dei token in ingresso nonché da tempi assoluti.

Fatte queste premesse, possiamo partire a costruire effettivamente l'albero di raggiungibilità temporale di una rete TB secondo il seguente algoritmo:

1. __Inizializzazione__: si trasforma la marcatura iniziale della rete in uno stato simbolico, introducendo una serie di vincoli che descrivano le (pre-)condizioni iniziali della rete.
  Tale stato viene poi trasformato in un nodo, diventando la radice dell'albero, e aggiunto alla lista dei nodi da esaminare;

2. __Scelta del prossimo nodo__: tra i nodi dell'albero non ancora esaminati si seleziona il prossimo nodo da ispezionare;

3. __Identificazione delle abilitazioni__: in base allo stato simbolico rappresentato dal nodo si individuano le transizioni abilitate al suo interno;

4. __Aggiornamento di marcatura e vincoli__: ciascuna transizione abilitata trovata viene fatta scattare generando un nuovo stato simbolico, che viene rappresentato nell'albero come nodo figlio del nodo considerato e aggiunto alla lista dei nodi da esaminare;

5. __Iterazione__: si ritorna al punto 2.

Di questo semplice algoritmo approfondiamo dunque le due fasi più interessanti: l'aggiornamento di marcatura e vincoli e l'identificazione delle abilitazioni.

### Aggiornamento di marcatura e vincoli

Come si fa a __generare un nuovo stato simbolico__ a partire dallo stato simbolico corrente quando scatta una transizione abilitata?
Sostanzialmente il processo si divide in due fasi: la __creazione e distruzione di gettoni__ e l'__espansione dei vincoli__.

Il primo step è abbastanza semplice: è sufficiente distruggere i gettoni e i relativi simboli nel preset della transizione e generare nuovi gettoni nel suo postset, questi ultimi identificati tutti dallo __stesso nuovo identificatore simbolico__.

La generazione di nuovi vincoli è invece più complessa.
Essa deve infatti tenere in considerazione quattro diversi aspetti:

- I __vecchi vincoli__ devono continuare a valere: essi esprimono infatti relazioni tra gli identificatori temporali che non possono essere alterate dallo scatto di una transizione;

- Il __nuovo timestamp__ deve avere il __valore massimo__ nella rete: esso rappresenta infatti il tempo di scatto dell'ultima transizione scattata, e per monotonicità del tempo esso dovrà essere maggiore di tutti gli altri;

- Il __nuovo timestamp__ dev'essere __compreso nell'intervallo__ dei possibili tempi di scatto della transizione scattata;

- Il __nuovo timestamp__ dev'essere __minore del massimo tempo di scatto__ di tutte le __transizioni forti abilitate__ il cui intervallo di scatto non sia nullo: per la semantica temporale forte, infatti, se così non fosse la transizione non potrebbe scattare prima che tale transizione forte scatti (cambiando anche potenzialmente l'insieme delle transizioni abilitate).

Tutte queste considerazioni devono essere condensate in un'__unica espressione logica__.
Si dimostra quindi che _dato uno stato simbolico precedente avente vincoli \\(C_n\\), detto \\(maxT\\) il timestamp massimo all'interno della rete e \\(\tau_{n+1}\\) l'identificatore simbolico dei gettoni generati dalla transizione \\(t\\) è possibile definire i vincoli dello stato simbolico prodotto con la seguente __formula___:

$$
\boxed{
\begin{align*}
C_{n+1} = \\: & C_n \wedge \tau_{n+1} \geq maxT \\: \wedge tmin_t \leq \tau_{n+1} \leq tmax_t \\\\
& \bigcap\limits_{t_{STS}}(tmax_{t_{STS}} < tmin_{t_{STS}} \vee tmax_{t_{STS}} < maxT \vee tmax_{t_{STS}} \geq \tau_{n+1} )
\end{align*}
}
$$

dove per \\(t_{STS}\\) si intende una qualunque __transizione forte__ diversa da \\(t\\); per __ciascuna__ di esse bisognerà infatti aggiungere la condizione tra parentesi, relativa appunto alla semantica STS.

Tale catena di condizioni può ben presto diventare soverchiante, ma fortunatamente essa può essere semplificata sfruttando le __implicazioni__ e le proprietà degli operatori logici.
In particolare:

- se una condizione \\(A\\) implica un'altra condizione \\(B\\) con cui è in __AND__ (\\(\wedge\\)), allora la condizione __implicata__ \\(B\\) può essere cancellata;
- se una condizione \\(A\\) implica un'altra condizione \\(B\\) con cui è in __OR__ (\\(\vee\\)), allora la condizione __implicante__ \\(A\\) può essere cancellata.

### Identificazione delle abilitazioni

Al contrario di quanto ci si potrebbe aspettare, però, la creazione di questo nuova catena di vincoli non è relegata alla sola creazione di un nuovo stato simbolico, ma è invece necessaria anche per __identificare le transizioni abilitate__.
Avendo infatti introdotto degli identificatori simbolici che mascherano i timestamp dei gettoni, capire se una transizione sia abilitata o meno non è più così facile.

Tuttavia, è possibile dimostrare che _la __soddisfacibilità__ del vincolo generato da un eventuale scatto della transizione __implica__ la sua __abilitazione___: se esiste cioè un assegnamento di timestamp agli identificatori simbolici che __rende vero__ il vincolo allora la transizione è abilitata e può scattare.
Il motivo di ciò appare evidente quando ci si accorge che nella generazione del vincolo abbiamo già tenuto in conto di tutti gli aspetti che avremmo osservato per stabilire se la transizione fosse abilitata o meno.

![](/assets/16_esempio_albero_raggiungibilita_reti_temporizzate-grafico.png)

Proprio riguardo la soddisfacibilità viene poi fatta una distinzione a livello grafico nell'albero: essendo gli stati simbolici _insiemi_ di marcature è possibile che una transizione sia abilitata in alcune di esse mentre è disabilitata in altre. \
Quando questo succede, lo stato generato dalla transizione __potrebbe essere uno stato finale__, in quanto potrebbe aver disabilitato tutte le transizioni: ciò si comunica graficamente con un __nodo circolare__, mentre i nodi (e quindi gli stati) i cui vincoli sono __sempre soddisfacibili__ si indicano con dei __nodo rettangolari__.

![](/assets/16_esempio_albero_raggiungibilita_reti_temporizzate.png)

Alcuni operano poi una distinzione sulle frecce che collegano i nodi dell'albero: una freccia con punta nera indica che la transizione è sempre possibile, mentre una freccia con alla base un pallino bianco indica che per rendere possibile la transizione è stato violato qualche parte del vincolo, per cui non è detto che la transizione sia possibile in nessuna delle marcature rappresentate dallo stato simbolico.

### Proprietà _bounded_

Eseguendo l'algoritmo a mano per un paio di iterazioni ci si rende ben presto conto di una cosa: il processo __non termina__!

Questo è dovuto al fatto che __non avendo una forma normale__ per i vincoli che permetta di confrontare tra di loro gli stati simbolici non è possibile stabilire se si sia già visitato o meno uno stato: i vincoli si allungano così sempre di più, creando sempre stati simbolici nuovi (almeno sulla carta).

Si ottiene cioè un __albero infinito__.
Nonostante ciò, tale albero è comunque particolarmente utile perché permette di __verificare proprietà entro un certo limite di tempo__: si parla per esempio di __bounded liveness__ e __bounded invariance__, delle caratteristiche molto preziose sopratutto per lo studio dei sistemi Hard Real-Time.

## Dall'albero al grafo aciclico

Esattamente come per le reti di Petri classiche, costruito l'albero di raggiungibilità ci piacerebbe ristrutturarlo per trasformarlo in un __grafo__ che illustri più concisamente l'evoluzione del sistema rappresentato dalla rete.
Di certo non possiamo sperare di ottenere un _grafo ciclico_ in quanto per sua stessa natura _il tempo non può tornare indietro_, ma c'è qualche chance di ottenere un __grafo aciclico__?

Abbiamo già detto che a causa di come sono costruiti i nuovi stati simbolici è impossibile riottenere più volte lo stesso esatto stato.
Ammettendo tuttavia di __dimenticare la storia__ di come si è giunti in un certo nodo (ovvero l'insieme di transizioni che hanno portato ad esso) si potrebbe sperare di __ritrovare alcuni stati__ che pur caratterizzati da storie diverse possiedono la _stessa marcatura simbolica_ e lo _stesso insieme di vincoli sugli identificatori simbolici_ presenti al suo interno.

Vediamo dunque una serie di tecniche che permettono, al costo di __perdere una serie di informazioni__, di individuare le _somiglianze_ tra diversi stati simbolici in modo da raggrupparli in una serie di "super-stati" che fungano da nodi per il grafo che intendiamo costruire.

### Semplificare i vincoli: l'algoritmo di Floyd

Per dimenticare la storia di come si è giunti in un certo stato simbolico è innanzitutto necessario __semplificare i vincoli__: come abbiamo visto nella formula precedente, ogni nuovo stato simbolico ereditava infatti i vincoli del precedente, cosa che permette di distinguere marcature identiche a cui si è giunti in modo diverso.

È dunque necessario __esprimere i vincoli solo in termini della marcatura corrente__: possiamo infatti considerare i vincoli sugli identificatori simbolici non più presenti nella rete come sostanzialmente inutili.
Tuttavia, non basta cancellarli per risolvere la questione: sebbene il simbolo a cui fanno riferimento sia scomparso, essi potrebbero ancora esprimere __vincoli indiretti__ sugli identificatori ancora presenti nella marcatura, che vanno ovviamente mantenuti. \\
Si immagini per esempio di avere i vincoli \\(B - A \leq 5\\) e \\(C - B \leq 6\\) e che l'identificatore \\(B\\) sia ormai scomparso dalla rete.
Sebbene si riferiscano a un simbolo ormai non più presente, tali vincoli contengono ancora delle informazioni: sommando le due disequazioni membro a membro si ottiene infatti che \\(C - A \leq 11\\), un vincolo su variabili presenti che era espresso _indirettamente_.

![](/assets/16_Floyd-grafo-cut.png)

Per rimappare in modo semplice gli effetti dei vincoli sulle variabili non più presenti nella marcatura su quelle presenti si utilizza spesso l'__algoritmo di Floyd__, che funziona come segue:

1. Si riconducono tutti i vincoli alla __forma__ \\(\bf{A - B \leq k}\\), dove \\(A\\) e \\(B\\) sono identificatori simbolici e \\(k\\) è una costante numerica; per esempio:

    $$ A+2 \leq B \leq A+5 \\: \\: \\: \longrightarrow \\: \\: \\: A - B \leq -2 \\: \text{ e } \\: B - A \leq 5 $$

    $$ B \leq C \leq B+6 \\: \\: \\: \longrightarrow \\: \\: \\: B - C \leq 0 \\: \text{ e } \\: C- B \leq 6 $$

2. Si costruisce una __matrice__ in cui ad ogni riga e colonna corrisponde un identificatore simbolico e l'intersezione tra la riga \\(A\\) e la colonna \\(B\\) corrisponde al __valore \\(\bf{k}\\) tale per cui__ \\(\bf{A - B \leq k}\\) in base ai vincoli ricavati al punto precedente, mentre per i valori non noti si scrive semplicemente un __punto di domanda__;

3. Si __riempiono tutti i posti contrassegnati da punti di domanda__ utilizzando la seguente formula:  

    $$ \boxed{m[i,j] = m[i,k] + m[k,j]} $$

    che mima la somma membro a membro delle disequazioni che rappresentano i vincoli.
    In questo modo è possibile scoprire i __vincoli indiretti__ tra variabili;

4. Si __esplicitano i vincoli indiretti__ relativi agli identificatori simbolici presenti nella marcatura corrente e __si eliminano__ i vincoli che contengono gli identificatori non inclusi.

![](/assets/16_Floyd-matrici.png)

Applicato l'algoritmo di Floyd, ottenuti i vincoli impliciti ed eliminati i vincoli contenenti identificatori simbolici è possibile semplificare di molto l'insieme dei vincoli di nodi del grafo, identificando anche le prime _somiglianze_ tra nodi.

### Inclusione tra stati

Il raggruppamento offerto dalla semplificazione dei vincoli tramite l'algoritmo di Floyd non è però sufficiente a ottenere grafi aciclici soddisfacenti.
Si consideri per esempio la rete in figura:

![](/assets/16_esempio-inclusione.png)

Come si vede, essa genera una serie di nodi nel grafo di raggiungibilità tutti diversi nonostante essi abbiano la __stessa marcatura__ e l'unica differenza sia data dalla costante nel vincolo.
Per semplificare situazioni come queste viene introdotto il concetto di __inclusione__ (o _contenimento_) __tra stati__: sapendo infatti che gli stati simbolici rappresentano _insiemi_ di marcature è opportuno chiedersi se alcuni di essi possano essere _sottoinsiemi_ di altri.

Ecco dunque che si dice che _uno stato \\(A\\) è __contenuto__ in un altro stato \\(B\\) se e solo se __tutte__ le marcature rappresentate da \\(A\\) sono rappresentate anche da \\(B\\)_.
Ciò avviene quando:

- \\(A\\) e \\(B\\) hanno lo __stesso assegnamento di timestamp__;
- __i vincoli di \\(A\\) implicano i vincoli di \\(B\\)__, ovvero \\(C_A \rightarrow C_B\\).

Decidiamo quindi di rappresentare nel grafo __solo gli stati contenuti__, introducendo però una distinzione grafica: la punta bianca della freccia indica che spostandosi lungo di essa si arriva ad un __sottoinsieme__ del "super-stato" di arrivo, ovvero uno stato avente _vincoli più stringenti_ di quelli mostrati.

![](/assets/16_esempio-inclusione-2.png)

### Tempi relativi

Osservando l'evoluzione di una rete Time Basic ci si può poi accorgere di un ulteriore fatto: se le funzioni temporali delle transizioni __non fanno riferimento a tempi assoluti__, ovvero a specifici istanti di esecuzione della rete, per comprendere come la rete può evolvere a partire da una certa marcatura è __sufficiente osservare i vincoli relativi tra i timestamp__.

Si prenda per esempio in considerazione la rete in figura:

![](/assets/16_esempio-tempi-relativi-crop.png)

ci si accorge che mantenere il riferimento ai tempi assoluti \\(0\\) e \\(10\\) introdotti dai vincoli iniziali farebbe sì che vengano generati __infiniti stati__ anche considerando la possibilità di inclusione.
Poiché _l'unica transizione presente nella rete non fa alcun riferimento a tempi assoluti_, si può quindi __eliminare i vincoli legati a tempi assoluti__ ottenendo il secondo grafo in figura: esso rappresenta alla perfezione l'evoluzione della rete (che può far scattare la transizione \\(T1\\) un numero infinito di volte) pur ignorando i vincoli sul valore iniziale del timestamp dell'unico gettone presente.

### Tempi anonimi

Si può infine introdurre un'ulteriore astrazione: ci si rende infatti conto che _se il timestamp associato ad un gettone in una marcatura M non verrà __mai più utilizzato__ per stabilire come evolverà la rete a partire da quella marcatura_, allora è possibile __anonimizzare__ il tempo di tale gettone.
L'identificatore simbolico del gettone viene cioè sostituito da un __identificatore anonimo__ \\(\tau_A\\) e i vincoli che lo coinvolgono cancellati: questo permette di riconoscere la somiglianza tra stati simbolici che, pur diversi a livello di timestamp dei gettoni, __evolvono nello stesso modo__.

Si consideri per esempio la rete in figura:

![](/assets/16_esempio-time-anonymous-crop.png)

All'interno di questa rete, il timestamp del gettone in \\(P2\\) non ha alcuna influenza sull'evoluzione della rete: esso funge infatti unicamente da _zero relativo_ per determinare il timestamp del gettone in \\(P1\\), che sarà maggiore di esso di tante unità quanto il numero di volte che è scattata la transizione \\(T1\\).
Il gettone può dunque essere reso anonimo, eliminando l'unico vincolo che, a conti fatti, non aggiunge nulla alla nostra conoscenza della rete.

Non esiste una vera e propria regola formale per capire quali gettoni siano anonimizzabili, ma esistono una serie di __euristiche__ che possono suggerire tale eventualità: così, per esempio, è molto probabile che i __gettoni morti__ (gettoni in posti che non appartengono al preset di alcuna transizione) possano essere resi anonimi.

### Conclusioni

L'utilizzo delle tecniche di __raggruppamento degli stati simbolici__ appena viste permette di costruire dei grafi di raggiungibilità più coincisi per le reti Time Basic, ma non senza __sacrificare__ una serie di __informazioni__.
Infatti:

- la tecnica di __inclusione__ introduce la possibilità che nel grafo esistano dei __cammini non percorribili__ dovuti al fatto che muovendosi tra _sottoinsiemi_ degli stati rappresentati è possibile che lo stato simbolico reale in cui ci si trova non permetta una certa transizione che è invece possibile a parte degli stati rappresentati dal nodo;
- con l'abolizione dei __vincoli assoluti__ si perdono informazioni sulle __relazioni precise__ tra gli stati (anche se è possibile arricchire le informazioni sugli archi per non perderne troppe);
- __anonimizzando__ alcuni gettoni potrebbe non essere sempre possibile verificare la __raggiungibilità__ di una marcatura definita da vincoli sui timestamp.

Si tratta di un equo prezzo da pagare per una rappresentazione semplice ed efficace dell'evoluzione della rete.

## Albero di copertura temporale?

Avevamo detto che sulle reti TB non era possibile utilizzare la tecnica di analisi di copertura vista per le normali reti di Petri a causa della __distinguibilità__ tra gettoni dovuta ai rispettivi timestamp.

Tuttavia, l'introduzione della possibilità di __anonimizzare i gettoni__ è in grado di far riconsiderare tale conclusione: i gettoni anonimi sono infatti tutti __equivalenti__ e indistinguibili, motivo per cui potrebbero essere rappresentati globalmente solo dal loro __numero__ \\(\omega_{\tau A}\\).

Non approfondiamo la questione, ma esiste un'ipotesi non dimostrata che suppone che _le reti TB non limitate siano non limitate __solo__ sul numero di gettoni anonimi_ in quanto in caso contrario bisognerebbe avere una rete che si interessi del passato all'infinito.
