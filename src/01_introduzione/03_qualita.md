# Qualità
Per fare fronte ai problemi sopracitati si sviluppano allora una serie di processi per lo sviluppo software: essi non assicurano la bontà del programma finito, ma possono assicurare la presenza di _proprietà desiderabili_ del prodotto, dette __qualità__. Le qualità del prodotto, che costituiscono a conti fatti un "valore per le persone", si dividono innanzitutto in due tipi:
- __qualità esterne__: qualità che vengono colte dal cliente;
- __qualità interne__: qualità che vengono esclusivamente colte dallo sviluppatore.

Le qualità interne influenzano molto le qualità esterne (per esempio se ho un codice ottimizzato ed efficiente, il mio software produrrà i risultati più velocemente). Prima di vedere quali siano le proprietà auspicabili in un software, però, facciamo un'importante distinzione a livello terminologico tra __requisiti e specifiche__:
- I __requisiti__ sono quello che il cliente vuole che il software faccia. Spesso sono cambiati in corso d'opera oppure sono espressi in modo sbagliato, per cui è necessaria un'interazione continua. 
- Le __specifiche__ sono ciò che è stato formalizzato dal programmatore a partire dai requisiti: si tratta di una definizione più rigorosa di che cosa dovrà fare il software. Si noti però che se i requisiti sono stati espressi in modo non corretto anche le specifiche risulteranno inesatte (vd. <a href="#g1">G1</a>).

Fatta questa doverosa distinzione, vediamo quali sono le qualità che un software dovrebbe idealmente possedere.

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
            Un software è corretto se soddisfa la specifica dei suoi <i>requisiti funzionali</i>. Si tratta di una proprietà <i>"matematica"</i> e relativamente dimostrabile in modo formale.
        </td>
    </tr>
    <tr>
        <th>Affidabilità</th>
        <td>
            Un software è affidabile quando ci si può fidare del suo funzionamento, ovvero ci si può aspettare che faccia ciò che gli è stato chiesto.
            Se è molto difficile perseverare la correttezza, in quanto si tratta una proprietà assoluta, l'affidabilità è invece relativa: un software può essere affidabile (o <i>dependable</i>) nonostante contenga qualche errore.
        </td>
    </tr>
    <tr>
        <th>Robustezza</th>
        <td>
            Un software è robusto se si comporta in modo accettabile anche in circostanze non previste nella specifica dei requisiti, senza generare effetti troppo negativi.
        </td>
    </tr>
    <tr>
        <th rowspan="3"><i>Essere bello</i></th>
        <th>Usabilità</th>
        <td>
            Un software è usabile (o <i>user-friendly</i>) se i suoi utenti lo ritengono facile da utilizzare.
            Si possono fare degli esperimenti (le grandi aziende lo fanno) per testare e quantificare l’usabilità del software ponendolo di fronte a dei soggetti umani (vd. <a href="#nn23">NN23</a>).
        </td>
    </tr>
    <tr>
        <th>Prestazioni</th>
        <td>
            Ad ogni software è richiesto un certo livello di prestazioni. L'efficienza è una qualità interna e misura come il software utilizza le risorse del computer; la performance, d'altro canto, è invece una qualità esterna ed è basata sui requisiti dell'utente. Essa ha effetto sull'usabilità, e spesso viene considerata alla fine dello sviluppo software visto che vari avanzamenti tecnologici possono efficientare algoritmi e processi prima troppo costosi.
        </td>
    </tr>
    <tr>
        <th>Verificabilità</th>
        <td>
            Un software è verificabile se le sue proprietà sono verificabili facilmente: è importante essere in grado di poter dimostrare la correttezza e la performance di un programma, e in tal senso la <b>leggibilità</b> del codice è fondamentale. 
            La verifica può essere fatta con metodi formali o informali, come il testing.
            È considerata una qualità interna, ma alcune volte può diventare una qualità esterna: per esempio, in ambiti in cui la sicurezza è critica il cliente può chiedere la verificabilità di certe proprietà.
        </td>
    </tr>
    <tr>
        <th rowspan="2"><i>Farmi diventare ricco</i></th>
        <th>Riusabilità</th>
        <td>
            Le componenti del software che costruiamo dovrebbero essere il più riutilizzabili possibile così da risparmiare tempo in futuro: ciò può essere fatto non legandole troppo allo specifico contesto applicativo del software che stiamo sviluppando.
            Con la proprietà di riusabilità, utilizziamo un prodotto per costruire - anche con modifiche minori - un altro prodotto (vd. <a href="#mi15">MI15</a>).
        </td>
    </tr>
    <tr>
        <th>Manutenibilità</th>
        <td>
            Per <i>manutenzione software</i> si intendono tutte le modifiche apportate al software dopo il rilascio iniziale.
            Questa proprietà può essere vista come due proprietà separate:
            <ul style="margin-bottom: 0;">
                <li><b>Riparabilità</b>: un software è riparabile se i suoi difetti possono essere corretti con una quantità di lavoro ragionevole.</li>
                <li><b>Evolvibilità</b>: indica la capacità del software di poter evolvere aggiugendo funzionalità. È importante considerare questo aspetto fin dall'inizio: studi rilevano come l'evolvibilità decresce con il passare delle release (vd. <a href="#l27-28">L27-28</a>).</li>
            </ul>
        </td>
    </tr>
</tbody>
</table>

### Leggi rilevanti

<a id="g1"></a>
__Prima legge di R.Glass (G1)__. 
> _La mancanza di requisiti è la prima causa del fallimento di un progetto._

<a id="nn23"></a>
__Legge di Nielsen-Norman (NN23)__.
> _L'usabilità è misurabile._

<a id="mi15"></a>
__Legge di McIlroy (MI15)__. 
> _Riutilizzare il software permette di incrementare la produttività e la qualità._

<a id="l27-28"></a>
__Leggi di M. Lehman (L27-28)__. 
> _Un sistema che viene utilizzato cambierà._

> _Un sistema che evolve incrementa la sua complessita a meno che non si lavori appositamente per ridurla._

## Qualità del processo
> _Un progetto è di qualità se segue un buon processo._

Sappiamo che il prodotto è influenzato dal processo che viene utilizzato per svilupparlo, di conseguenza possiamo parlare anche di  __qualità del processo__.

Anche un processo deve funzionare, essere essere bello e farmi diventare ricco, ma dobbiamo interpretare queste parole in maniera differente.

Quali caretteristiche ha un processo di qualità?

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
            La produttività di un team è molto meno della somma della produttività individuale dei suoi componenti. È una metrica difficile da misurare: conteggi come il numero di linee codice scritte o la quantità di <i>tempo-uomo</i> richiesta per un lavoro si rivelano spesso un po' fallaci (per esempio, la gravidanza umana non è un'attività parallelizzabile, ma si potrebbe dire che servono 9 mesi-donna per creare un bambino).
        </td>
    </tr>
    <tr>
        <th rowspan="1"><i>Farmi diventare ricco</i></th>
        <th>Tempismo</th>
        <td markdown="span">
            Un processo deve consegnare il prodotto nei tempi stabiliti, in modo da rispettare i tempi del mercato. È spesso conveniente la tecnica dello <b>sviluppo incrementale</b>, ovvero la consegna frequente di parti sempre più grandi del prodotto (es. compilatore ADA): essa permette infatti di conquistare il cliente ancor prima di avere il prodotto finito. 
        </td>
    </tr>
</tbody>
</table>
