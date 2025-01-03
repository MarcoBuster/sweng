# Qualità
Sono _proprietà desiderabili_ del prodotto che costituiscono un "valore per le persone", si dividono innanzitutto in due tipi:
- __qualità esterne__: qualità che vengono colte dai clienti;
- __qualità interne__: qualità che vengono esclusivamente colte dallo sviluppatore.

Le qualità interne non sono solo di interesse degli sviluppatori, ma  influenzano spesso anche le qualità esterne (per esempio se ho un codice facilmente _verificabile_, è più facile che il mio software  risulti anche _corretto_). 

Prima di vedere quali siano alcune proprietà auspicabili in un software, però, facciamo un'importante distinzione a livello terminologico tra __requisiti e specifiche__:
- I __requisiti__ esprimono quello che il cliente vuole che il software faccia. Hanno la caratteristica di essere mutevoli, volatili. Sono cioè spesso cambiati in corso d'opera: il cliente cambia idea, priorità mano a mano che vede il progetto crescere. Alcuni modelli di vita del software moderni sono nati proprio per fronteggiare questa mutabilità. 
- Le __specifiche__ sono ciò che è stato capito dal programmatore a partire dai requisiti: si tratta di una definizione spesso più rigorosa di che cosa dovrà fare il software e in ogni caso scritta in un qualche linguaggio. Possono essere usati come base contrattuale tra cliente e sviluppatore. Chiaramente che se si parte da requisiti incompleti o non corretti anche le specifiche risulteranno inesatte (vd. <a href="#g1">G1</a>).

Fatta questa doverosa distinzione, vediamo quali sono alcune delle qualità che un software dovrebbe idealmente possedere.

## Qualità del software

Un software di qualità deve <b><i>funzionare</i></b>, <b><i>essere bello</i></b> e <b><i>"farmi diventare ricco"</i></b>.

<table style="margin-bottom: 20px">
<thead>
    <tr>
        <th>Un software deve...</th>
        <th>Qualità</th>
        <th>Descrizione</th>
    </tr>
</thead>
<tbody>
    <tr>
        <th rowspan="3"><i>Funzionare</i></th>
        <th>Correttezza</th>
        <td>
            Un software è corretto se fa ciò che è scritto nelle specifiche. Più queste specifiche sono scritte formalmente e più (almeno dal punto di vista teorico) dovrebbe essere facile  dimostrarne il rispetto da parte del software.
        </td>
    </tr>
    <tr>
        <th>Affidabilità</th>
        <td>
            Un software è affidabile quando ci si può fidare del suo funzionamento, ovvero ci si può aspettare che faccia ciò che si vuole.
            Qui il termine di confronto non sono le specifiche ma i requisiti stessi.
            Il controllo dell'affidabilità è compito del cliente (unico depositario dei requisiti) che a differenza del caso della correttezza potrà anche valutarne il soddisfacimento in maniera relativa/parziale/statistica: un software può essere affidabile (o <i>dependable</i>) anche se non corretto. Ad es. un programma che dà un valore che si scosta dal valore corretto entro un range di tolleranza (fissato non contrattualmente [cosa che lo farebbe diventare parte delle specifiche] ma stabilito unilateralmente dal cliente); oppure al limite anche un programma che crasha con una frequenza giudicata (sempre dal cliente) accettabile.
        </td>
    </tr>
    <tr>
        <th>Robustezza e/o Safety</th>
        <td>
            Un software è robusto se si comporta in modo accettabile (nel caso della safety, senza generare effetti negativi) anche in circostanze non previste dalle specifiche.
        </td>
    </tr>
    <tr>
        <th rowspan="3"><i>Essere bello</i></th>
        <th>Usabilità</th>
        <td>
            Un software è usabile (o <i>user-friendly</i>) se i suoi utenti lo ritengono facile e intuitivo da utilizzare.
            Si possono fare degli esperimenti (le grandi aziende lo fanno) per testare e quantificare l’usabilità del software ponendolo di fronte a dei soggetti umani (vd. <a href="#nn23">NN23</a>).
            Questa qualità è costosa a causa del grande numero di risorse da impiegare per garantirla, infatti sono necessarie sia delle analisi sia qualitative che quantitative.
            Le analisi qualitative vengono svolte facendo testare il software ad un gruppo di persone e analizzandone i feedback (verbale, o implicito tipo eye-tracking), mentre le analisi quantitative riguardano tutte quelle situazioni analizzabili tramite dei numeri (ad esempio numero di click necessari per fare una certa operazione, e se questa quantità è eccessiva oppure no).
        </td>
    </tr>
    <tr>
        <th>Prestazioni e Efficienza</th>
        <td>
            Ad ogni software è richiesto un certo livello di prestazioni. L'efficienza è una qualità interna e misura come il software utilizza le risorse del computer; la performance, d'altro canto, è invece una qualità esterna ed è basata sui requisiti dell'utente. Essa ha effetto sull'usabilità, e spesso viene considerata alla fine dello sviluppo software visto che vari avanzamenti tecnologici possono rendere efficienti algoritmi e processi prima troppo costosi.
            Questo però in maniera relativa perché un avanzamento tecnologico non permette la diminuzione della complessità di un algoritmo (se un algoritmo lavora in tempo esponenziale,  un miglioramento hardware non causerà un'alterazione in positivo della complessità).
        </td>
    </tr>
    <tr>
        <th>Verificabilità</th>
        <td>
            Un software è verificabile se le sue proprietà sono verificabili facilmente: è importante essere in grado di poter dimostrare la correttezza e la performance di un programma. Spesso è in tal senso correlata alla <b>leggibilità</b> del codice ma può essere ottenuta anche tramite metodi formali e strumenti di analisi appositi. 
            È considerata una qualità interna, ma alcune volte può diventare una qualità esterna: per esempio, in ambiti in cui la sicurezza è critica il cliente può chiedere la certificazione di certe proprietà.
        </td>
    </tr>
    <tr>
        <th rowspan="3"><i>Farmi diventare ricco</i></th>
        <th>Riusabilità</th>
        <td>
            Le componenti del software che costruiamo dovrebbero essere il più riutilizzabili possibile così da risparmiare tempo in futuro: per farlo bisogna aumentare l'adattabilità, ciò può essere fatto evitando di legare troppo il software allo specifico contesto applicativo.
            È possibile avere anche un aumento dell'affidabilità e della verificabilità, perché il codice riutilizzato è stato già testato e verificato al momento della sua creazione e soprattutto durante il suo periodo di uso.
            Con la proprietà di riusabilità, utilizziamo un prodotto (o più spesso un componente) per costruirne - anche con modifiche minori - un altro, anche se non sempre è un'operazione sicura a causa dei contesti diversi in cui il software può essere utilizzato (es: architettura hardware sottostante) (vd. <a href="#mi15">MI15</a>).
            Attenzione che come sempre deve essere adottato in maniera corretta. Ad esempio si cita spesso il fallimento del viaggio inaugurale (esplosione) del razzo Ariane 5, causato dal riuso di un componente software ereditato dall'Ariane 4 ma senza averne controllato correttamente le condizioni di uso assunte nel vecchio progetto. 
        </td>
    </tr>
    <tr>
        <th>Manutenibilità</th>
        <td>
            Per <i>manutenzione software</i> si intendono tutte le operazioni sul progetto svolte dopo il rilascio.
            Questa proprietà può essere vista come due proprietà separate:
            <ul style="margin-bottom: 0;">
                <li><b>Riparabilità</b>: un software è riparabile se i suoi difetti possono essere corretti con una quantità di lavoro ragionevole.</li>
                <li><b>Evolvibilità</b>: indica la capacità del software di poter evolvere aggiungendo funzionalità. È importante considerare questo aspetto fin dall'inizio: studi rilevano come l'evolvibilità decresce con il passare delle release a meno che non vengano svolte attività mirate proprio a questo aspetto (vd. <a href="#l27-28">L27-28</a>).</li>
            </ul>
        </td>
    </tr>
    <tr>
        <th> Perfettibilità </th>
        <td>
            Migliorare le qualità del software in modo da aumentare la qualità sia degli aspetti esterni che di quelli interni, senza però alterare le funzionalità richieste dalle specifiche.
            Questo aspetto quindi non va ad aggiungere o rimuovere features.
        </td>
    </tr>
</tbody>
</table>

### Leggi rilevanti

<a id="g1"></a>
__Prima legge di R.Glass (G1)__. 
> _Le imprecisioni/fraintendimenti/errori dei requisiti sono la prima causa del fallimento dei progetti._

<a id="nn23"></a>
__Legge di Nielsen-Norman (NN23)__.
> _L'usabilità è misurabile._

<a id="mi15"></a>
__Legge di McIlroy (MI15)__. 
> _Riutilizzare il software permette di incrementare la produttività e la qualità._

<a id="l27-28"></a>
__Leggi di M. Lehman (L27-28)__. 
> _Un sistema che viene utilizzato cambierà._

> _Un sistema che evolve incrementa la sua complessità a meno che non si lavori appositamente per ridurla._

## Debito tecnico

Durante lo sviluppo di un software è facile che pur avendo notato dei problemi nel codice si scelga di rimandarne la soluzione a un momento futuro.
Questo modo di operare viene spesso chiamato "accendere un debito tecnico", cioè ci si indebita sulla valuta "tempo di sviluppo"... Come per i debiti finanziari si deve essere coscienti che alla fine non si pagherà però solo con il tempo di sviluppo per sanare il problema, ma si saranno aggiunti gli interessi che in questo caso corrispondono a tutte le maggiorazioni di tempo che ci sono state durante lo sviluppo delle altre funzionalità causate dalla maggiore difficoltà di lavorare su del "brutto" codice.

## Qualità del processo

È generalmente condiviso che le qualità del prodotto sono influenzate dalla bontà del processo che viene utilizzato per svilupparlo, di conseguenza diventa importante ragionare e parlare anche di  __qualità del processo__.

Anche un processo deve _funzionare_, _essere bello_ e _farmi diventare ricco_, ma dobbiamo interpretare queste parole in maniera differente.

Quali caratteristiche ha un processo di qualità?

<table style="margin-bottom: 20px">
<thead>
    <tr>
        <th>Un processo deve...</th>
        <th>Qualità</th>
        <th>Descrizione</th>
    </tr>
</thead>
<tbody>
    <tr>
        <th rowspan="1"><i>Funzionare</i></th>
        <th>Robustezza</th>
        <td markdown="span">
            Un processo deve poter resistere agli imprevisti, come la mancanza improvvisa di personale o il cambiamento delle specifiche.
            Esistono certificazioni (<i>CMM: Capability Maturity Model</i>) che valutano la robustezza di alcuni processi aziendali e che vengono per esempio considerate nei bandi pubblici.
        </td>
    </tr>
    <tr>
        <th rowspan="1"><i>Essere bello</i></th>
        <th>Produttività</th>
        <td markdown="span">
            La produttività di un team è molto meno della somma della produttività individuale dei suoi componenti. È una metrica difficile da misurare: conteggi come il numero di linee codice scritte o la quantità di <i>tempo-uomo</i> richiesta per un lavoro si rivelano spesso un po' fallaci. 
        </td>
    </tr>
    <tr>
        <th rowspan="1"><i>Farmi diventare ricco</i></th>
        <th>Tempismo</th>
        <td markdown="span">
            <ul style="margin-bottom: 0;">
                <li><b>Scadenze: </b> Un processo deve consegnare il prodotto nei tempi stabiliti, in modo da rispettare i tempi del mercato. È spesso conveniente la tecnica dello <b>sviluppo incrementale</b>, ovvero la consegna frequente di parti sempre più grandi del prodotto (es. compilatore ADA): essa permette infatti di conquistare il cliente ancor prima di avere il prodotto finito.</li>
                <li><b>Volatilità dei requisiti</b>: i requisiti possono cambiare nel tempo, quindi è fondamentale mantenere un equilibrio tra il loro sviluppo e il loro aggiornamento.
                Lavorare cercando di soddisfare dei requisiti non più necessari o non aggiornati diminuisce la produttività.</li>
                <li><b>Cogliere l'attimo</b>: il progetto deve essere realizzato in relazione al contesto in cui ci si trova, sviluppare un software già esistente da molto tempo (ad esempio lo sviluppo di una calcolatrice o di un document viewer) o che non regge il confronto con la concorrenza risulta essere decisamente poco produttivo.</li>
            </ul>
        </td>
    </tr>
</tbody>
</table>
