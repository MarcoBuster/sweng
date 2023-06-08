<style>
  .algorithm p {
    margin-top: 0;
    margin-bottom: 0;
  }
</style>
<div style="display: none">
$$
\require{color}
\def\node#1{\fcolorbox{black}{white}{#1}}
\def\nodenew#1{\fcolorbox{lime}{white}{#1}}
$$
</div>

# Albero di raggiungibilità

Per generare l'_albero di raggiungibilità_ di una rete di Petri si può applicare il seguente **algoritmo**.

<ol class="algorithm">
  <li>

  **crea la radice** dell'albero corrispondente alla marcatura iniziale \\(M_0\\) ed etichettala come _nuova_;
  </li>
  <li>

  **_<u>finché</u>_ esistono nodi etichettati come _"nuovi"_** esegui:
  <ol>
  <li>

  **seleziona** una marcatura \\(M\\) etichettata come _"nuova"_; \
    prendila in considerazione e **rimuovi l'etichetta** _"nuova"_.
  </li>
  <li>

  ***<u>se</u>*** la **marcatura** \\(M\\) è **identica** ad una marcatura di un altro nodo allora:
  - **etichetta** \\(M\\) come **"duplicata"**;
  - ***<u>continua</u>*** passando alla prossima iterazione.
  </li>
  <li>

  ***<u>se</u>*** nella **marcatura** \\(M\\) non è abilitata **nessuna transizione** allora:
  <ul>
  <li>

  **etichetta** \\(M\\) come **"finale"**;
  </li>
  <li>

  _situazione di deadlock_.
  </li>
  </ul>

  ***<u>altrimenti</u>*** esegui:
  <ul>
  <li>

  ***<u>finché</u>* esistono transizioni abilitate** in \\(M\\) esegui:
  <ul>
  <li>

  ***<u>per ogni</u> transizione* \\(t\\) abilitata** in \\(M\\) esegui:
  <ol>
  <li>

  **crea** la **marcatura** \\(M'\\) prodotta dallo **scatto** di \\(t\\);
  </li>
  <li>

  **crea** un nuovo **nodo** corrispondente alla marcatura \\(M'\\);
  </li>
  <li>

  **aggiungi** un **arco** nell'albero al nodo corrispondente di \\(M\\) al nodo di \\(M'\\);
  </li>
  <li>

  **etichetta** la **marcatura** \\(M'\\) come **"nuova"**.
  </li>
  </ol>
  </li>
  </ul>
  </li>
  </ul>
  </li>
  </ol>
  </li>
</ol>

## Esempio

Di seguito è mostrata una consegna di un esercizio riguardo gli alberi di raggiungibilità.

> Modellare tramite una rete di Petri l'accesso ad una risorsa condivisa tra quattro lettori e due scrittori, ricordandosi che i lettori possono accedere contemporaneamente, mentre gli scrittori necessitano di un accesso esclusivo.

Come primo approccio, si possono creare due reti, una per i lettori e una per gli scrittori.
È possibile successivamente procedere modellando la _Risorsa_ condivisa collegando le diverse parti create.

![Esempio albero di raggiungibilità](/assets/15_esempio-1-albero-raggiungibilita.png)

Essendo presente un solo gettone nel posto _Risorsa_, i **lettori** non sono
in grado di accedervi contemporaneamente.
Per risolvere questo problema, si può aumentare il numero di gettoni all'interno di _Risorsa_ a 4.
Per evitare che gli scrittori possano accedere alla _Risorsa_ mentre viene letta, è possibile aggiungere un peso pari a 4 sugli archi da "_Risorsa"_ a _"S\_inizia"_ e da _"S\_finisce"_ a _"Risorsa"_.

Così facendo, per accedere alla _Risorsa_ uno **scrittore** dovrà attendere che tutti i token saranno depositati in essa, garantendo che nessun'altro sta utilizzando la risorsa.

Il **risultato finale** è il seguente.

![Esempio albero di raggiungibilità completo](/assets/15_esempio-1-albero-raggiungibilita-rete-completa.png)

### Costruzione dell'albero di raggiungibilità

Una volta creata la rete finale, è possibile **generare** l'albero di raggiungibilità seguendo l'**algoritmo precedente**.

Il primo passo è creare il **nodo radice** corrispondente alla marcatura iniziale e marcarlo come <span style="color: green"><i>nuovo</i></span>: \\(\nodenew{40420}\\).

Successivamente, occorre procedere _per ogni nodo marcato come nuovo_.
In questo caso l'unico nodo marcato come _nuovo_ è \\(\nodenew{40420}\\).
Dopo aver rimosso l'etichetta _nuovo_ si verifica che, partendo dalla radice dell'albero, non siano già presenti altri nodi uguali.
Essendo \\(\node{40420}\\) esso stesso la radice (e unico nodo dell'albero), si procede.

A questo punto, per ogni transizione abilitata nella marcatura presa in considerazione (\\(\node{40420}\\)) la si fa **scattare** generando le altre marcature marcate come _nuovo_ (\\(\nodenew{40011}\\) e \\(\nodenew{31320}\\)) che quindi si **collegano** con un arco alla marcatura originale (\\(\node{40420}\\)).

La situazione attuale è la seguente.

![Esempio albero primo giro algoritmo](/assets/15_esempio-1-albero-prima-giro-algoritmo.png)

Si procede quindi con l'algoritmo ripetendo i passi fino ad arrivare in una situazione in cui **non esistono più nodi nuovi**, marcando nel mentre come duplicati tutti i nodi che si re-incontrano nonostante siano già presenti almeno una volta nell'albero.

La **situazione finale** sarà la seguente.

![Esempio albero finale](/assets/15_esempio-1-albero-finale.png)

L'albero di raggiungibilità sopra in figura è a ora **completo** e rappresenta tutti gli _stati_ raggiungibili.

Grazie a questo albero, se si volesse verificare che gli scrittori sono in **mutua esclusione** con i lettori, basterà controllare se esiste una marcatura in cui il secondo e il quinto numero (rispettivamente _"LettoriAttivi"_ e _"ScrittoriAttivi"_) sono entrambi contemporaneamente maggiori di zero.
Si può verificare in modo esaustivo (model checking) guardando tutti i nodi dell'albero.
Inoltre si può verificare se gli **scrittori** si **escludono a vicenda**, controllando se in ogni marcatura l'ultimo numero (_"ScrittoriAttivi"_) è maggiore di uno.
Si infine verificare l'assenza di **deadlock**, data dalla presenza o meno di nodi terminali.

_Collassando_ i nodi aventi la stessa marcatura, si può verificare dall'albero di raggiungibilità se la rete è **viva**.

![Esempio di grafo di raggiungibilità](/assets/15_grafo-di-raggiungibilita.png)

La rete è anche **reversibile** in quanto ogni stato è uno _stato base_ ed è quindi possibile raggiungere da ogni stato tutti gli altri stati. \
Avendo questo grafo è quindi facile capire che la rete è **viva**, in quanto sono rappresentate tutte le transizioni all'interno del grafo, e siccome il sistema è reversibile è sempre possibile riportarsi ad una situazione in cui si può far scattare una transizione.

### Limiti

- Per poter creare un albero di raggiungibilità è necessario enumerare tutte le possibili marcature raggiungibili, di conseguenza **la rete deve essere obbligatoriamente limitata**: non sarebbe altrimenti possibile elencare tutti i nodi.
- la **crescita** (esponenziale) del numero degli stati globali può risultare velocemente **ingestibile** per una rete limitata.

Inoltre:

- Questa tecnica di analisi non è in grado di rilevare se una rete è limitata o meno;
- Nel caso in cui si sappia già che la rete è limitata:
  - l'albero di raggiungibilità non perde informazioni ed è la esplicitazione degli stati della rete (quindi ne è di fatto la FSM corrispondente).
