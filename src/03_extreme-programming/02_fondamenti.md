# Fondamenti

Ora possiamo iniziare a parlare di Extreme Programming (XP), una tecnica di sviluppo agile nata tra la fine degli anni '90 e l'inizio degli anni 2000 dalla mente di Kent Beck, che la ideò nell'ambito di un progetto Chrysler.

## Variabili

Secondo Beck, durante lo sviluppo di software le principali variabili sono:

- __portata__: la quantità di funzionalità da implementare, una variabile delicata dal valore _mutevole_ poiché il numero di funzionalità richieste può cambiare nel corso dello sviluppo;
- __tempo__: il tempo che si può dedicare al progetto;
- __qualità__: la qualità del progetto che si vuole ottenere, principalmente relativa a correttezza e affidabilità. Di fatto è una costante perchè quando si realizza un progetto si cerca di avere la qualità migliore possibile, quindi tendente al 100%;
- __costo__: le risorse (finanziare o in termini di personale) che si possono impegnare per il progetto.

Queste 4 variabili __non sono indipendenti__ tra di loro, in quanto cambiare una influenza automaticamente le altre, in positivo o in negativo. Ponendo quindi che la qualità non sia negoziabile (il software deve funzionare) bisognerà lavorare sulle altre, specialmente bilanciando costo e tempo.

Nel panorama classico di sviluppo la portata era definita in modo rigido dal cliente, che richiedeva certe funzionalità non negoziabili e pagava lo sviluppatore a progetto completo.
Con l'XP si stravolge invece la prospettiva: __il costo è orario__, il tempo disponibile non è fisso ma pari al tempo richiesto per lo sviluppo e la portata viene ricalcolata durante il progetto, essendo così l'unica variabile a variare effettivamente. Si tratta di un approccio _incrementale_ che mira ad avere sempre un prodotto consegnabile se il cliente decide di essere soddisfatto dello sviluppo; non si fa aspettare il cliente per dargli tutto il lavoro in un colpo solo, ma questo viene consegnato una parte alla volta. Oltre ad alleggerire la pressione sullo sviluppatore, questo approccio è utile per due motivi:

- Il cliente è certo che lo sviluppatore si sia dedicando al progetto siccome vede il prodotto crescere a poco a poco, inoltre anche il cliente fa parte del team, di conseguenza può accertarsi in prima persona che il team di sviluppo si dedichi al massimo delle possibilità al progetto.
- Dà la possibilità al cliente di avere comunque qualcosa in mano se ad un certo punto vuole interrompere la collaborazione.
- Permette al cliente di cambiare idea sulla portata e sulle funzionalità richieste in corso d'opera, bandendo la rigidità dei documenti di specifica.

Tutti questi aspetti permettono di creare un rapporto molto meno conflittuale tra cliente e sviluppatore, cosa che crea le basi per una maggiore collaborazione tra le due parti.
La presenza del cliente all'interno del team permette di avere un feedback rapido in ogni momento.
## Principi

Parliamo ora un po' dei fondamenti della filosofia XP, confrontandoli con quanto veniva prescritto nell'ambiente di sviluppo classico. I principi dell'ingegneria del software classica erano infatti i seguenti:

- __Separazione degli interessi__ (_aspects_ o _concerns_): separare tempi, responsabilità e moduli, ovvero tutte le varie viste o le varie dimensioni su cui si deve affrontare il problema.
- __Astrazione e modularità__: bisogna usare le giuste astrazioni che ci permettono di dominare i problemi complessi (possono essere i diversi linguaggi di programmazione, linguaggi di descrizione o vari altri costrutti). Questo aspetto è importante perchè più un problema è complesso più è necessario un certo livello di astrazione per rappresentarlo (ad esempio non è fattibile rappresentare un software complesso tramite il lingiaggio macchina).
- __Anticipazione del cambiamento__ (_design for change_): in fase di progettazione il programmatore deve pensare a come potrebbe cambiare il prodotto, accomodando la possibile  aggiunta di requisiti a cui il cliente magari non aveva neanche pensato; bisogna stare attenti però, perché spesso questo concetto complica arbitrariamente la progettazione e lo sviluppo, rischiando di far perdere molto tempo su cose che al cliente potrebbero non servire: può essere un'idea migliore partire da qualcosa di semplice ed incrementare man mano.
- __Generalità__: per rendere più semplice la modifica e l'espansione futura è necessario scrivere interfacce molto generali ai sistemi che costruiamo.
- __Incrementalità__: lo sviluppo avviene incrementalmente, un pezzetto alla volta.
- __Rigore e formalità__: è importante essere rigidi e specifici sia nella comunicazione che nella descrizione dei requisiti.

Sebbene non butti via tutti questi principi ma ne erediti invece alcuni per adattarli alle proprie esigenze (specialmente la _separazione degli interessi_, che viene data per scontata), l'XP pone l'accento su altri aspetti, ovvero:

- __Feedback rapido__: bisogna mantenere un costante flusso di feedback; questo viene dato dai test, dai colleghi ma anche dal cliente, che dev'essere continuamente consultato sullo stato dei lavori. Tra le iniziative che favoriscono un veloce ciclo di feedback c'è lo _standup meeting_, una riunione mattutina fatta in piedi in cui ciascuno descrive in poche parole cosa ha fatto il giorno precedente e cosa intende fare oggi.
- __Presumere la semplicità__: non bisogna complicare senza motivo né il codice, che dev'essere scritto con in mente ciò che serve a breve termine e non in un futuro remoto, né le relazioni tra colleghi, che non devono essere eccessivamente gerarchiche (tutti dovrebbero avere compiti molto simili); in generale si dovrebbe semplificare il più possibile in tutti gli ambiti del progetto.
- __Accettare il cambiamento__: non ci si deve aspettare che il software sia immutabile; al contrario, deve essere dato per scontato il concetto di _flessibilità_ e _malleabilità_, ovvero che il cliente vorrà fare cambiamenti sia dopo che durante lo sviluppo del prodotto.
- __Modifica incrementale__: ritornando al concetto di baby steps, ogni iterazione di sviluppo dovrebbe essere breve e le funzionalità introdotte piuttosto piccole; questa regola si applica tuttavia a tutti gli ambiti del progetto, tra cui la gestione del team: ovvero non bisognerebbe mai aggiungere più di una persona alla volta al gruppo di lavoro, in quanto aggiungerne di più potrebbe portare a passare più tempo ad istruirle che a sviluppare.
- __Lavoro di qualità__: bisogna ovviamente ottenere un buon prodotto, ma per fare ciò la prospettiva cambia in favore dello sviluppatore, al quale si deve garantire un ambiente di lavoro salutare e un certo benessere; la fidelizzazione dei programmatori è importante perché più si trovano bene e meglio lavorano.

I due punti più in contrasto sono il presumere la semplicità e l'anticipazione del cambiamento: ci sembra infatti più previdente pianificare per il futuro e anticipare eventuali cambiamenti, ma come vedremo nel prossimo paragrafo talvolta questo può essere controproducente.

### Presumere la semplicità vs anticipazione del cambiamento

XP mette davanti la semplicità all'anticipazione del cambiamento: non si scrive in anticipo codice che si pensa servirà in futuro. Questo non significa che non si stia progettando per il futuro, ma solo che questo non è il primo aspetto da guardare: il primo aspetto è la semplicità, ovvero fare le cose nella maniera più chiara possibile.

Non pianificare per il futuro sembra rischioso: secondo uno studio condotto da Bohem nel 1976 (basato anche sulla sua esperienza personale) viene ipotizzata una curva esponenziale per il costo delle modifiche all'aumento dell'avanzamento del progetto; più il progetto avanza più è costoso modificarlo, motivo per cui sembra necessario accomodare il cambiamento futuro in modo da ridurre tale costo. \
Al contrario, XP presuppone una curva di tipo logaritmico che tenda ad un asintoto: passato un certo punto nello sviluppo il costo per le modifiche non subisce più cambiamenti sensibili, per cui non ha senso fasciarsi la testa in anticipo in quanto un codice semplice è relativamente facile da modificare.

![Curve di costo: XP vs tradizionale](/assets/03_cost-curves.png)

Va inoltre considerato che Bohem parlava in realtà di cost-to-fix, non del costo per la modifica in sé; inoltre la sua statistica era poco affidabile poiché era stata costruita a partire da pochi dati. La curva esponenziale da lui descritta è stata poi successivamente ritrattata per accomodare il fatto che se un errore avviene in una fase affligge solo le successive, e non le precedenti.

## Figure e responsabilità

Al fine di organizzare il lavoro, XP individua diverse figure che partecipano allo sviluppo:

- Cliente: colui che richiede funzionalità e conosce il dominio applicativo.
- Sviluppatore: colui che sviluppa concretamente scrivendo codice.
- Manager: colui che amministra lo sviluppo con uno sguardo generale.

È interessante l'inclusione del cliente nel contesto dello sviluppo: esso non è più soltanto il committente ma ha un ruolo attivo nel lavoro, potendo cioè contribuire alla riuscita del progetto anche e soprattutto in virtù della già citata conoscenza del dominio applicativo.

Ciascuna di tali figure ha responsabilità e diritti riassunti nella seguente tabella (_manager e cliente sono accorpati perché hanno grossomodo gli stessi compiti_):

<table style="margin: 20px">
    <tr style="text-align: center; background-color: #DEDEDE">
        <th>Soggetto</th>
        <th>Ha responsabilità di decidere...</th>
        <th>Ha diritto di...</th>
    </tr>
    <tr>
        <td style="padding-left: 15px; padding-right: 15px; text-align: center;">
            <b>Manager/Cliente</b>
        </td>
        <td style="padding-left: 5px; padding-right: 15px; padding-top: 10px">
            <ul>
                <li>Portata del progetto, ovvero le funzionalità da realizzare</li>
                <li>Priorità tra funzionalità e loro <i>business value</i></li>
                <li>Date dei rilasci, anche nel caso di release incrementali</li>
            </ul>
        </td>
        <td style="padding-left: 5px; padding-right: 15px; padding-top: 10px">
            <ul>
                <li>Sapere cosa può essere fatto, con quali tempi e quali costi</li>
                <li>Vedere progressi nel sistema, provati dai test da lui definiti (<i>trasparenza</i>)</li>
                <li>Cambiare idea, sostituendo funzionalità o cambiandone le priorità a intervalli di tempo fissi (<i>fine del ciclo di sviluppo incrementale</i>)</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 5px; padding-right: 15px; text-align: center;">
            <b>Sviluppatore</b>
        </td>
        <td style="padding-left: 5px; padding-right: 15px; padding-top: 10px">
            <ul>
                <li>Stime dei tempi per le singole funzionalità (<i>no deadline imposte dall'alto</i>)</li>
                <li>Scelte tecnologiche e loro conseguenze, ovvero <i>come</i> si realizzano le funzionalità richieste</li>
                <li>Pianificazione dettagliata delle iterazioni</li>
            </ul>
        </td>
        <td style="padding-left: 5px; padding-right: 15px; padding-top: 10px">
            <ul>
                <li>Ricevere dei requisiti chiari (<i>casi d'uso</i>) con priorità per le varie funzionalità</li>
                <li>Cambiare le stime dei tempi man mano che il progetto procede e il contesto di sviluppo cambia</li>
                <li>Identificare funzionalità pericolose o troppo difficili da realizzare</li>
                <li>Produrre software di qualità, per il quale deve godere di un certo benessere</li>
            </ul>
        </td>
    </tr>
</table>

__business value__: valore che assume una feature, dipendente dal costo (in termini di difficoltà) e dalla sua importanza all'interno del sistema.
Questo valore viene sfruttato per decidere in che ordine dedicarsi le diverse feature da implementare.  

Come si vede, per migliorare la fiducia tra sviluppatore e cliente sono necessari due requisiti: un certo grado di _trasparenza_ da parte di chi sviluppa, ottenuta dall'uso delle contiene release incrementali per mostrare come sta evolvendo il sistema, e una certa dose di _pazienza_ da parte del cliente, che deve accettare di lasciare allo sviluppatore la facoltà di decidere come si realizzano le funzionalità e di cambiare le prospettive temporali di sviluppo qualora fosse necessario.

Inoltre all'interno del team vi è anche la figura del __tracker__, ovvero una persona del team (non è fissa, può cambiare ad ogni iterazione) incaricata di tenere traccia delle problematiche incontrate durante l'iterazione.
Grazie a questa figura tutto il team viene a conoscenza dei problemi principali che sono stati riscontrati durante il progetto, e ad ogni iterazione si cerca di capire in che modo risolverli in modo da migliorare il processo di sviluppo.
