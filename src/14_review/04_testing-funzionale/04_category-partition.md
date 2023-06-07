# Category partition

La tecnica di __category partition__ è un metodologia che permette di caratterizzare e identificare le classi di equivalenza del dominio di un problema a partire dalle sue specifiche.
Può essere utilizzata a __vari livelli__ a seconda che si debbano realizzare test di unità, test di integrazione e o test funzionali.

Il metodo è composto da una serie di passi in sequenza:

1. __analisi delle specifiche__: in questa fase vengono identificate le _unità funzionali individuali_ che possono essere verificate singolarmente; non necessariamente sono un'unica classe, è sufficiente che siano componenti facilmente separabili dal resto, sia a livello di testing che concettuale.
Per ogni unità vengono quindi identificate delle caratteristiche (__categorie__) dei parametri e dell'ambiente in cui opera;
2. __scegliere dei valori__: per ogni categoria, occorre scegliere quali sono i _valori sensati_ su cui fare riferimento;
3. __determinare eventuali vincoli tra le scelte__, che non sono sempre indipendenti;
4. __scrivere test e documentazione__.

Per capire meglio ciascuna di tali fasi vediamo un'esempio di utilizzo della tecnica di _category partition_ prendendo come soggetto il comando `find` della shell Linux.

## PASSO 1 – analizzare le specifiche

Per prima cosa analizziamo le specifiche del comando:

> __Syntax__: `find <pattern> <file>`
>
> The find command is used to locate one or more instances of a given pattern in a file.
> All lines in the file that contain the pattern are written to standard output.
> A line containing the pattern is written only once, regardless of the number of times the pattern occur in it.
>
> The pattern is any sequence of characters whose length does not exceed the maximum length of a line in the file.
> To include a blank in the pattern, the entire pattern must be enclosed in quotes (`"`).
> To include a quotation mark in the pattern, two quotes (`""`) in a row must be used.

Vista la relativa semplicità, `find` è un'unità funzionale individuale che può essere verificata separatamente.
Bisogna dunque individuarne i parametri: come è chiaro dalla sintassi essi sono due, il `pattern` da cercare e il `file` in cui farlo.

Ora, ciascuno di tali parametri può possedere determinate caratteristiche, ed è nostro compito in questa fase comprenderle ed estrarle. \
Tali caratteristiche possono essere di due tipi: __esplicite__, ovvero quelle ricavabili direttamente dalla lettura specifiche, e __implicite__, ovvero quelle che provengono dalla nostra conoscenza del dominio di applicazione e che quindi non vengono specificate.

Tornando al nostro caso di studio possiamo per esempio ottenere la seguente tabella:

<style>
  #category-partition-find-table ul {
    margin-bottom: 0;
  }
</style>

<table id="category-partition-find-table">
<tr>
  <th>Oggetto</th>
  <th>Caratteristiche esplicite</th>
  <th>Caratteristiche implicite</th>
</tr>
<tr>
  <th>
  
`pattern`
  </th>
  <td>

- lunghezza del pattern;
- pattern tra doppi apici;
- pattern contenente spazi;
- pattern contenente apici.
</td>
  <td>

- pattern tra apici con/senza spazi;
- più apici successivi inclusi nel pattern.
</td>
</tr>
  <th>
  
`file` \
(nome)
  </th>
  <td style="text-align: center;"><i>(nessuna)</i></td>
  <td>

- caratteri nel nome ammissibili o meno;
- file esistente (con permessi di lettura) o meno.
</td>
<tr>
  <th>
  
`file` \
(contenuto)
  </th>
  <td>

- numero occorrenze del pattern nel file;
- massimo numero di occorrenze del pattern in una linea;
- massima lunghezza linea.
</td>
  <td>

- pattern sovrapposti;
- tipo del file.
</td>
</tr>
</table>

È importante _esplicitare le caratteristiche implicite_ dei parametri dell'unità funzionale perché __le specifiche non sono mai complete__ e solo così possiamo disporre di tutti gli elementi su cui ragionare nelle fasi successive.

Si presti poi attenzione alla distinzione fatta tra il _nome_ del file e il suo _contenuto_: il primo infatti è un __parametro__ che viene passato al comando per iniziarne l'esecuzione, mentre il secondo fa parte dell'__ambiente__ in cui il comando opera ed è dunque soggetto ad una sottile distinzione concettuale.

### <big>ALPHA E BETA TESTING</big>

Spesso, però, analizzare le specifiche non basta per comprendere tutte le variabili che entrano in gioco durante l'esecuzione di un programma.
Bisogna infatti ricordare che ci sono moltissime altre caratteristiche d'ambiente che ancora __non sono state considerate__: la versione del sistema operativo, del browser, il tipo di architettura della macchina su cui gira il programma eccetera.

Spesso, quindi, la fase di testing funzionale si divide in due fasi:

- __alpha testing__: l'unità funzionale viene testata in-house, ovvero su una macchina all'interno dello studio di sviluppo.
In questa fase si considerano soprattutto le caratteristiche legate alle specifiche di cui sopra;
- __beta testing__: per testare varie _configurazioni d'ambiente_ una versione preliminare del programma viene distribuito in un _ambiente variegato_ per osservare come esso si comporta sulle macchine di diversi utenti.

Per il momento, però, consideriamo solo la fase di alpha testing e le categorie ad essa relative.

## PASSO 2 – scegliere dei valori

Individuate le caratteristiche dei parametri e delle variabili d'ambiente da cui l'unità funzionale dipende, che prendono il nome di __categorie__, si passa quindi alla seconda fase.

In questa fase si devono identificati __tutti e i soli__ _casi significativi_ per ogni categoria, ovvero quei valori della stessa che si ritiene abbia senso testare; poiché si tratta di un compito molto soggettivo è importante in questa fase avere __esperienza__ (_know-how_) nel dominio d'applicazione.

Per capire meglio di cosa stiamo parlando ritorniamo al nostro esempio e consideriamo il parametro `pattern`.
Per ciascuna delle sue categorie possono essere individuati vari casi significativi:

- __lunghezza del pattern__: vuoto, un solo carattere, più caratteri, più lungo di almeno una linea del file;
- __presenza di apici__: pattern tra apici, pattern non tra apici, pattern tra apici errati;
- __presenza di spazi__: nessuno spazio nel pattern, uno spazio nel pattern, molti spazi nel pattern;
- __presenza di apici interni__: nessun apice nel pattern, un apice nel pattern, molti apici nel pattern.

È interessante notare il _mantra_ già visto del "__nessuno__, __uno__, __molti__", spesso molto utile in questa fase.

## PASSO 3 – determinare i vincoli tra le scelte

Trovati tutti i valori significativi delle categorie dell'unità funzionale come possiamo costruire i casi di test da utilizzare per verificarne la correttezza?

Si potrebbe pensare di testare __tutte le combinazioni__ di valori significativi, facendo cioè il prodotto cartesiano tra le categorie.
Nella pratica, però, ciò risulterebbe in un numero esagerato di casi di test: già solo nel nostro semplice esempio questi sarebbero ben 1944, decisamente __troppi__.

Nel tentativo di evitare quest'esplosione combinatoria ci si accorge però che spesso le anomalie sorgono dall'interazione di __coppie__ di caratteristiche indipendentemente dal valore assunto da tutte le altre: per esempio, un problema potrebbe presentarsi se si usa il browser _Edge_ sul sistema operativo _Linux_, indipendentemente da caratteristiche quali la dimensione dello schermo, l'architettura del processore eccetera. \
Per ridurre il numero di casi di test si sviluppa quindi la tecnica del ___pairwise testing___, che riduce l'insieme delle configurazioni da testare a tutte le combinazioni di coppie di valori.
È quindi presente almeno un caso di test _per ogni coppia ipotizzabile_ di valori: in rete e in Java sono presenti diversi [__strumenti__](https://www.pairwise.org/tools.html) che permettono di creare casi di test combinati con il metodo _pairwise_.

Un'ulteriore tentativo di ridurre il numero di casi di test prevede di definire una serie di ___vincoli___ per la generazione delle coppie, escludendo particolari combinazioni di caratteristiche: così, per esempio si potrebbe escludere la coppia "OS == MacOs" e "browser == Edge" perché sfruttando la conoscenza di dominio sappiamo che tale browser non è disponibile sul suddetto sistema operativo. \
Volendo essere più precisi, la creazione di vincoli prevede un passaggio intermedio: vengono definite una serie di __proprietà__ (es. _NotEmpty_ o _Quoted_ per l'esempio su `find`) e si creano dei vincoli logici a partire da esse.
I vincoli seguono poi una struttura tra le seguenti:

- __se__: si può limitare l'uso di un valore solo ai casi in cui è definita una proprietà. Per esempio, è inutile testare il caso _"il file non esiste"_ se la proprietà _NotEmpty_ si manifesta;
- __single__: alcune caratteristiche prese singolarmente anche se combinate con altre generano lo stesso risultato. Per esempio, se il file non contiene occorrenze del pattern cercato il risultato del programma è indipendente dal tipo di pattern cercato;
- __error__: alcune caratteristiche generano semplicemente errore, come per esempio se si omette un parametro.

## PASSO 4 – scrivere i test

Fissati i vincoli e fatti i calcoli combinatori si procede ad enumerare iterativamente tutti i casi di test generati continuando ad aggiungere vincoli fino ad arrivare ad un __numero ragionevole__.

Ovviamente, i casi di test avranno poi bisogno di __valori specifici__ per le caratteristiche: non basta dire "pattern con apici all'interno", bisogna creare un pattern aderente a questa descrizione!
Fortunatamente questa operazione è solitamente molto facile, anche con tool automatici.

## Conclusioni

Per quanto intuitiva e utile, la tecnica di category partition presenta due criticità:

- individuare i __casi significativi__ delle varie caratteristiche può essere difficile e si può sbagliare, anche utilizzando mantra come "_zero_, _uno_, _molti_";
- una volta generati i casi di test serve comunque un "__oracolo__" che fornisca la risposta giusta, ovvero quella che ci si attende dall'esecuzione sul caso di test.
L'attività non è dunque _completamente_ automatizzabile.

Va però detto che esistono delle tecniche di __property-based testing__ che cercano di eliminare la necessità di un oracolo considerando particolari proprietà che dovrebbero sempre valere durante l'esecuzione (invarianti) piuttosto che analizzare il risultato dell'esecuzione dei casi di test per determinare la correttezza del programma.
