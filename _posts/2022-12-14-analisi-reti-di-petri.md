---
layout: post
title: "[15] Analisi di reti di Petri"
date: 2022-12-14 14:40:00 +0200
toc: true
---
# Analisi delle reti di Petri
Le reti di Petri sono state introdotte per poter **analizzare un sistema** ancora prima di avere il codice.
Alcune domande da porsi sono:
- può essere raggiunta una determinata marcatura?
- è possibile una certa sequenza di scatti?
- esiste uno stato di deadlock all'interno della rete?
- la rete (o una certa transizione) è viva? e di che grado?

Per rispondere a queste domande esistono diverse tecniche, suddivise in:
- **tecniche dinamiche**:
    - albero (grafo) delle marcature raggiungibili (chiamato anche **grafo di raggiungibilità**);
    - albero (grafo) di copertura delle marcatura raggiungibili (chiamato anche **grafo di copertura**);
- **tecniche statiche**:
    - identificazione delle **P-invarianti** (caratteristiche invarianti riguardanti i posti);
    - identificazione delle **T-invarianti** (caratteristiche invarianti riguardanti alle transizioni).

Le tecniche dinamiche ragionano sugli **stati raggiungibili** durante l'esecuzione della rete di Petri (o di un programma), mentre le statiche sulla **topologia della rete**.

## Albero di raggiungibilità
Per generare l'_albero di raggiungibilità_ di una rete di Petri si può applicare il seguente **algoritmo**.

<style>
  .algorithm p {
    margin-bottom: 0;
  }
</style>

<ol class="algorithm">
  <li markdown="1">
  **crea la radice** dell'albero corrispondente alla marcatura iniziale $$M_0$$ ed etichettala come _nuova_;
  </li>
  <li markdown="1">
  **_<u>finché</u>_ esistono nodi etichettati come _"nuovi"_** esegui:
  <ol>
  <li markdown="1">
  **seleziona** una marcatura $$M$$ etichettata come _"nuova"_; \\
    prendila in considerazione e **rimuovi l'etichetta** _"nuova"_.
  </li>
  <li markdown="1">
  ***<u>se</u>*** la **marcatura** $$M$$ è **identica** ad una marcatura di un altro nodo allora:
  - **etichetta** $$M$$ come **"duplicata"**;
  - ***<u>continua</u>*** passando alla prossima iterazione.
  </li>
  <li markdown="1">
  ***<u>se</u>*** nella **marcatura** $$M$$ non è abilitata **nessuna transazione** allora:
  <ul>
  <li markdown="1">
  **etichetta** $$M$$ come **"finale"**;
  </li>
  <li markdown="1">
  _situazione di deadlock_.
  </li>
  </ul>
  ***<u>altrimenti</u>*** esegui:
  <ul markdown="1">
  <li markdown="1">
  ***<u>finché</u>* esistono transazioni abilitate** in $$M$$ esegui:
  <ul>
  <li markdown="1">
  ***<u>per ogni</u> transazione* $$t$$ abilitata** in $$M$$ esegui:
  <ol>
  <li markdown="1">
  **crea** la **marcatura** $$M'$$ prodotta dallo **scatto** di $$t$$;
  </li>
  <li markdown="1">
  **crea** un nuovo **nodo** corrispondente alla marcatura $$M'$$;
  </li>
  <li markdown="1">
  **aggiungi** un **arco** nell'albero al nodo corrispondente di $$M$$ al nodo di $$M'$$;
  </li>
  <li markdown="1">
  **etichetta** la **marcatura** $$M'$$ come **"nuova"**.
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

### Esempio
Di seguito è mostrata una consegna di un esercizio riguardo gli alberi di raggiungibilità.

> Modellare tramite una rete di Petri l'accesso ad una risorsa condivisa tra quattro lettori e due scrittori, ricordandosi che i lettori possono accedere contemporaneamente, mentre gli scrittori necessitano di un accesso esclusivo.

Come primo approccio, si possono creare due reti, una per i lettori e una per gli scrittori.
È possibile successivamente procedere modellando la _Risorsa_ condivisa collegando le diverse parti create.

{% responsive_image path: assets/15_esempio-1-albero-raggiungibilita.png %}

Essendo presente un solo gettone nel posto _Risorsa_, i **lettori** non sono 
in grado di accedervi contemporaneamente.
Per risolvere questo problema, si può aumentare il numero di gettoni all'interno di _Risorsa_ a 4.
Per evitare che gli scrittori possano accedere alla _Risorsa_ mentre viene letta, è possibile aggiungere un peso pari a 4 sugli archi da "_Risorsa"_ a _"S\_inizia"_ e da _"S\_finisce"_ a _"Risorsa"_.

Così facendo, per accedere alla _Risorsa_ uno **scrittore** dovrà attendere che tutti i token saranno depositati in essa, garantendo che nessun'altro sta utilizzando la risorsa.

Il **risultato finale** è il seguente.

{% responsive_image path: assets/15_esempio-1-albero-raggiungibilita-rete-completa.png %}

#### Costruzione dell'albero di raggiungibilità

<div style="display: none">
$$
\require{color}
\def\node#1{\fcolorbox{black}{white}{#1}}
\def\nodenew#1{\fcolorbox{lime}{white}{#1}}
$$
</div>

Una volta creata la rete finale, è possibile **generare** l'albero di raggiungibilità seguendo l'**algoritmo precedente**.

Il primo passo è creare il **nodo radice** corrispondente alla marcatura iniziale e marcarlo come <span style="color: green"><i>nuovo</i></span>: $$\nodenew{40420}$$. 

<!-- <???> -->
Successivamente, occorre procedere _per ogni nodo marcato come nuovo_. 
In questo caso l'unico nodo marcato come _nuovo_ è $$\nodenew{40420}$$.
Dopo aver rimosso l'etichetta _nuovo_ si verifica che, partendo dalla radice dell'albero, non siano già presenti altri nodi uguali.
Essendo $$\node{40420}$$ esso stesso la radice (e unico nodo dell'albero), si procede.

A questo punto, per ogni transazione abilitata nella marcatura presa in considerazione ($$\node{40420}$$) la si fa **scattare** generando le altre marcature marcate come _nuovo_ ($$\nodenew{40011}$$ e $$\nodenew{31320}$$) che quindi si **collegano** con un arco alla marcatura originale ($$\node{40420}$$).

La situazione attuale è la seguente.

{% responsive_image path: assets/15_esempio-1-albero-prima-giro-algoritmo.png %}

Si procede quindi con l'algoritmo ripetendo i passi fino ad arrivare in una situazione in cui **non esistono più nodi nuovi**, marcando nel mentre come duplicati tutti i nodi che si re-incontrano nonostante siano già presenti almeno una volta nell'albero.

La **situazione finale** sarà la seguente.

{% responsive_image path: assets/15_esempio-1-albero-finale.png %}

L'albero di raggiungibilità sopra in figura è a ora **completo** e rappresenta tutti gli _stati_ raggiungibili.

Grazie a questo albero, se si volesse verificare che gli scrittori sono in **mutua esclusione** con i lettori, basterà controllare se esiste una marcatura in cui il secondo e il quinto numero (rispettivamente _"LettoriAttivi"_ e _"ScrittoriAttivi"_) sono entrambi contemporaneamente maggiori di zero.
Si può verificare in modo esaustivo (model checking) guardando tutti i nodi dell'albero.
Inoltre si può verificare se gli **scrittori** si **escludono a vicenda**, controllando se in ogni marcatura l'ultimo numero (_"ScrittoriAttivi"_) è maggiore di uno. 
Si infine verificare l'assenza di **deadlock**, data dalla presenza o meno di nodi terminali.

_Collassando_ i nodi aventi la stessa marcatura, si può verificare dall'albero di raggiungibilità se la rete è **viva**.

{% responsive_image path: assets/15_grafo-di-raggiungibilita.png %}

<!-- Anche questa fa un po schifo ma non ho il tool per migliorarla -->

La rete è anche **reversibile** in quanto ogni stato è uno _stato base_ ed è quindi possibile raggiungere da ogni stato tutti gli altri stati.

<!-- sistemare -->
Ora avendo questo grafo è facile capire che la rete è viva, in quanto sono rappresentate tutte le transizioni all'interno del grafo, e siccome il sistema è reversibile, è possibile affermare che la rete è viva.

### Limiti 

- Per poter creare un albero di raggiungibilità è necessario enumerare tutte le possibili marcature raggiungibili, di conseguenza **la rete deve essere obbligatoriamente limitata**: non sarebbe altrimenti possibile elencare tutti i nodi.
- la **crescita** (esponenziale) del numero degli stati globali può risultare velocemente **ingestibile** per una rete limitata.

Inoltre:
- Questa tecnica di analisi non è in grado di rilevare se una rete è limitata o meno;
- Nel caso in cui si sappia già che la rete è limitata:
    - l'albero di raggiungibilità non perde informazioni ed è la esplicitazione degli stati della rete (Quindi ne è di fatto la FSM corrispondente).

## Albero di copertura
A questo punto risulterà normale chiedersi se sia possibile creare una struttura dati (albero e grafo) anche per le **reti illimitate**, cui nodi rappresenteranno _gruppi di stati_ potenzialmente infiniti. \\
È bene introdurre il concetto di __copertura__ prima di procedere. 

_Una marcatura $$M$$ __copre__ una marcatura $$M'$$ se e solo se:_

$$
\forall p \in P (p) \quad  M(p) \geq M'(p).
$$

Ovvero _se per ogni posto in $$P$$, la marcatura $$M(p)$$ è maggiore o uguale a $$M'(p)$$_.

Al contrario, $$M$$ si dice __copribile__ da $$M'$$ se:

$$
\exists M\smash{''} \! \in R(M') \quad M'' \! \textit{ copre } M.
$$

Grazie al concetto di _copertura_ è possibile ridefinire quello di **transazione morte**: \\
una transazione $$t$$ si dice __morta__ se e solo se data la sua _marcatura minima_ $$M$$ (ovvero il minor numero di gettoni necessario in ogni posto nel suo preset per abilitarla) questa **non è copribile** a partire dalla marcatura corrente.
In caso contrario la transizione $$t$$ è almeno 1-viva.

Si conclude quindi che se una marcatura ne copre un'altra, tutte le azioni possibili nella prima **sono possibili** anche nella seconda.
È quindi possibile modificare l'_albero di raggiungibilità_ in modo tale che, quando viene creato un nodo è necessario verificare se tra i suoi predecessori ne esiste uno che lo copre, allora a questo punto nei posti dove c'è copertura propria (ovvero $$M(p) \geq M'(p)$$) si mette $$\omega$$. \\
Il **simbolo** $$\omega$$ rappresenta un numero __grande a piacere__ (e non _qualsiasi_), che può aumentare all'infinito: questo aspetto è da tenere in considerazione quando bisogna cercare quali transizioni sono abilitate da esso.
Questo tipo di notazione ($$\omega$$) viene introdotta per limitare l'aumento spropositato di nodi nel diagramma, comprimendo marcature uguali se non per $$\omega$$.

Se una marcatura copre la precedente, infatti, significa che è possibile ripetere gli scatti delle transizioni

<!-- bo --->
Infatti se una marcatura ne copre una precedente significa che è possibile ripetere gli scatti delle transizioni fatti per arrivare fino a quella marcatura, e di conseguenza se alla fine sono presenti più gettoni di prima in un posto significa ceh è possibile crearne un numero grande a piacere.
<!-- fine bo -->

È importante noatare come le transizione che erano **abilitate** in una certa marcatura $$M'$$ lo saranno anche in una marcatura diversa che copre $$M'$$, a meno che non ci siano archi inibitori.

Ora è possibile definire l'algoritmo per la creazione di un albero di copertura, che però è molto sibile al precedente, a meno di qualche punto:

<ol class="algorithm">
  <li markdown="1">
  **crea la radice** dell'albero corrispondente alla marcatura iniziale $$M_0$$ ed etichettala come _nuova_;
  </li>
  <li markdown="1">
  **_<u>finché</u>_ esistono nodi etichettati come _"nuovi"_** esegui:
  <ol>
  <li markdown="1">
  **seleziona** una marcatura $$M$$ etichettata come _"nuova"_; \\
    prendila in considerazione e **rimuovi l'etichetta** _"nuova"_.
  </li>
  <li markdown="1">
  ***<u>se</u>*** la **marcatura** $$M$$ è **identica** ad una marcatura di un altro nodo allora:
  - **etichetta** $$M$$ come **"duplicata"**;
  - ***<u>continua</u>*** passando alla prossima iterazione.
  </li>
  <li markdown="1">
  ***<u>se</u>*** nella **marcatura** $$M$$ non è abilitata **nessuna transazione** allora:
  <ul>
  <li markdown="1">
  **etichetta** $$M$$ come **"finale"**;
  </li>
  </ul>
  ***<u>altrimenti</u>*** esegui:
  <ul markdown="1">
  <li markdown="1">
  ***<u>finché</u>* esistono transazioni abilitate** in $$M$$ esegui:
  <ul>
  <li markdown="1">
  ***<u>per ogni</u> transazione* $$t$$ abilitata** in $$M$$ esegui:
  <ol>
  <li markdown="1">
  **crea** la **marcatura** $$M'$$ prodotta dallo **scatto** di $$t$$;
  </li>
  <li markdown="1">
  ***<u>se</u>*** sul cammino dalla **radice** ($$M_0$$) alla **marcatura** $$M$$ \\
  **esiste** una **marcatura** $$M''$$ **coperta** da $$M'$$ allora
  <ul>
  <li markdown="1">
  **aggiungi** $$\omega$$ in tutte le posizioni corrispondenti a coperture proprie;
  </li>
  </ul>
  </li>
  <li markdown="1">
  **crea** un nuovo **nodo** corrispondente alla marcatura $$M'$$;
  </li>
  <li markdown="1">
  **aggiungi** un **arco** nell'albero al nodo corrispondente di $$M$$ al nodo di $$M'$$;
  </li>
  <li markdown="1">
  **etichetta** la **marcatura** $$M'$$ come **"nuova"**.
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

Dall'albero generato da questo algoritmo è possibile arrivare al **grafo di copertura**.

Inoltre, ripetendo l'algoritmo precedente su una rete limitata viene generato un grafo di copertura senza $$\omega$$ e quindi equivalente a un albero di raggiungibilità.

L'algoritmo **termina** in ogni caso: è sufficiente **osservare** l'albero risultante per stabilire se la rete considerata è limitata oppure no.

### Esempio
Partendo dalla rete di Petri sottostante ed applicando l'**algoritmo** appena descritto è possibile arrivare ad un **albero di copertura**.

{% responsive_image path: assets/15_esempio-albero-copertura-rete.png %}

Come visto nell'esempio della creazione di un albero di raggiungibilità, il primo passo da fare è crere il nodo radice corrispondente alla marcatura iniziale ($$\nodenew{100}$$) e marcarlo come nuovo. \\
Successivamente, è necessario considerare l'unico nodo esistente ($$\node{100}$$) e iterare tra le sue transazioni.
In questo caso, è abilitata la transazione $$t_1$$ che porta a una marcatura $$M' = \nodenew{101}$$.

A questo punto si può notare come la radice sia una **marcatura coperta da $$M'$$**, in quanto:
- $$M \: \vert \: 1 \geq 1 \: \vert \: M'$$;
- $$M \: \vert \: 0\geq 0 \: \vert \: M'$$;
- $$M \: \vert \: 1 > 0 \: \vert \: M'$$.

Nel nodo corrispondente alla marcatura $$M'$$ è quindi possibile sostituire l'unica **copertura propria** (quella con il $$>$$ e non il $$\geq$$) con il simbolo $$\omega$$ e marcare il nodo.
Questa è l'unica parte dell'algoritmo differente da quello che genera l'albero di raggiungibilità: il resto dell'esempio è quindi completato dall'immagine sottostante.

{% responsive_image path: assets/15_esempio-albero-copertura-albero.png %}

Tramite lo stesso procedimento attuato per gli alberi di raggiungibilità, è possibile trasformare il precedente albero in un **grafo di copertura**.

{% responsive_image path: assets/15_esempio-albero-copertura-grafo.png %}

### Considerazioni
- se $$\omega$$ non compare mai nell'albero di copertura la rete è __limitata__;
- una rete di Petri è __binaria__ se nell'albero di copertura compaiono solo 0 e 1;
- una transizione è **morta** (0-viva) se non compare mai come etichetta di un arco dell'albero di copertura;
- condizione necessaria affinchè una marcatura $$M$$ sia __raggiungibile__ è l'esistenza di un nodo etichettato con una marcatura che copre $$M$$ (non sufficiente: _le marcature coperte non sono necessariamente raggiungibili_);
- non è possibile stabilire se una rete è **viva**.

### Esempio particolare

<!-- non ho capito, da sistemare ancora -->

È doveroso un ulteriore esempio particolare nel caso di reti **non vive**. \\
Data una _rete non viva_ (come nella figura sotto) dall'albero di copertura **non è possibile** evincere se la rete è effettivamente viva o no: infatti se il nodo $$\node{01$\omega$}$$ è duplicato, quindi non verrà più espanso.
A questo punto non è possibile aggiungere all'interno dell'albero il nodo 010, in cui la rete raggiunge un deadlock.
Questo però significa che questo albero di copertura è uguale a quello della stessa rete senza arco che collega $$p_3$$ a $$t_4$$, che in quel caso è una rete viva.
Detto ciò si può affermare che tramite l'albero di copertura non è possibile dire se una rete è viva oppure no.

{% responsive_image path: assets/15_esempio-particolare.png %}

#### Da albero di copertura a rete
Passare dall'albero di copertura alla rete di Petri è un'operazione che rispetto all'inverso crea più **incertezza**. 
L'albero di copertura permette infatti di rappresentare reti potenzialmente illimitate, è quindi normale avere come risultato reti di cui non si conosce la struttura: molte reti potrebbero essere associate **allo stesso albero**.

Nel seguente esempio si può notare come la rete ricavata presenta degli _archi tratteggiati_: **potrebbero essere presenti**, oppure no.
Inoltre, sono assenti anche i pesi negli archi.
Tale mancanza di informazioni è dovuta in gran parte dalla presenza di $$\omega$$: un nodo con all'interno $$\omega$$ rappresenta **diverse marcature**.

{% responsive_image path: assets/15_esempio-da-albero-a-rete.png %}

È importante notare come le marcature **sicuramente raggiungibili** siano quelle i cui nodi nell'albero di copertura non contengono $$\omega$$: delle altre non si può essere certi.

# Rappresentazione matriciale
Prima di procedere con la spiegazione delle tecniche di analisi statiche, è necessario introdurre una nuovo modo per rappresentare le reti di Petri: la **rappresentazione matriciale**.
Essendo tutte rappresentazioni _formali_, _non ambigue_ e _complete_, data una qualsiasi rete rappresentata graficamente o in forma logica, è possibile **trasformarla automaticamente** in una rete in forma matriciale, e viceversa.

Il vantaggio principale della rappresentazione matriciale è la **maggiore semplicità** ed **efficienza** nel **trattamento matematico** delle reti.

Le matrici che verranno utilizzate sono diverse, tra cui:
- $$I$$: rappresenta gli **archi in ingresso**, ovvero le coppie di flussso che da un posto vanno nelle transizioni;
- $$O$$: rappresenta gli **archi in uscita**, ovvero le coppie di flussso che da una transizione vanno nei posti;
- vettore $$m$$: rappresenta la **marcatura** dei posti.

## Definizione parte statica

### Matrici $$I$$ e $$O$$

Diversamente dalla rappresentazione logica in cui venivano utilizzati degli indicatori alfanumerici per riferirsi ai posti e alle transizioni, nella rappresentaziona matriciale viene assegnato un **indice** ad ogni posto e ad ogni transizione.
Ogni indice deve essere possibilmente **continuo** (senza salti) e **biunivoco**: ogni indice corrisponde ad un posto e ogni posto corrisponde ad un indice.

- indice dei **posti**: $$p: 1..\vert P \vert \rightarrow P$$
- indice delle **transizioni**: $$t: 1..\vert T \vert \rightarrow T$$

La **dimensione** delle due matrici è $$\vert P \vert \times \vert T \vert$$: la **cardinalità dei posti** corrisponde al numero di righe e il **numero delle transizioni** corrisponde al numero delle colonne.

Per ogni flusso uscente dal posto $$i$$-esimo ed entrate nella transazione $$j$$-esima, l'elemento $$I[i][j]$$ equivale al **peso** di tale flusso, oppure $$0$$ se il flusso non esiste.
In sintesi:

$$
\forall i \in 1..\vert P \vert , \, \forall j \in 1..\vert T \vert \quad I[i][j] = \begin{cases}
W(\langle p(i), \, t(j) \rangle) &\text{se} \ \langle p(i), \, t(j) \rangle \in F, \\
0 &\text{altrimenti}.
\end{cases}
$$

Analogamente, per la matrice degli output $$O$$:

$$
\forall i \in 1..\vert P \vert , \, \forall j \in 1..\vert T \vert \quad O[i][j] = \begin{cases}
W(\langle t(j), \, p(i) \rangle) &\text{se} \ \langle t(j), \, p(i) \rangle \in F, \\
0 &\text{altrimenti}.
\end{cases}
$$

Per indicare il vettore colonna $$k$$ da una matrice $$X$$ spesso verrà utilizzata la notazione $$X[.][k]$$.

{% responsive_image path: assets/15_esempio-rappresentazione-matriciale-I-O.png %}

### Marcatura $$m$$

Per ogni posto, il vettore $$m$$ di dimensione $$\vert P \vert$$ indica la __marcatura corrente__.

$$
\forall i \in 1..\vert P \vert \: \Big \vert \: m[i] = M(p(i))
$$

Che **differenza** c'è tra il vettore $$m$$ e $$M$$? Entrambi logicamente indicano la **stessa cosa**, ma:
- gli indici di $$m$$ sono nell'insieme $$1..\vert P \vert$$;
- gli indici di $$M$$ sono nell'insieme $$P$$.

## Definizione parte dinamica

### Abilitazione di una transizione

La transizione $$j$$-esima è __abilitata in una marcatura__ (espressa dal vettore $$m$$) se e solo se il _vettore colonna_ della sua matrice di **input** $$I[.][j]$$ è minore o uguale alla marcatura corrente $$m$$:

$$
\boxed{m \ [ \ t (j) >} \Longleftrightarrow I[.][j] \leq m \\
\textit{o se proprio vogliamo essere precisi...} \\
\boxed{m \ [ \ t(j) >} \Longleftrightarrow \forall i \in 1..\vert P \vert \quad I[i][j] \leq m[i].
$$

In sostanza, si controlla che il numero dei gettoni di ogni posto $$p(i)$$ del _preset_ sia maggiore o uguale del peso dell'arco che collega $$p(i)$$ alla transizione.

{% responsive_image path: assets/15_esempio-marcature-abilitate.png %}

### Scatto di una transizione
Lo **scatto** di una transizione $$j$$ in una marcatura $$m$$ produce una marcatura $$m'$$ che si ricava sottraendo elemento per elemento al vettore di partenza la colonna $$j$$-esima della matrice di input e squindi ommando al risultato la colonna j-esima della matrice output.

$$
\boxed{\boxed{m [ \ t(j) >} \: m'} \Longleftrightarrow m' = m - I[.][j] + O[.][j] \\
\textit{o se proprio vogliamo essere precisi...} \\
\boxed{\boxed{m [ \ t(j) >} \: m'} \Longleftrightarrow \forall i \in 1..\vert P \vert \quad m'[i] = m[i] - I[i][j] + O[i][j]. \\
$$

{% responsive_image path: assets/15_esempio-scatto-transizione.png %}

È importante notare come nell'operazione sopra due operandi su tre sono matrici costanti ($$I$$ e $$O$$): è quindi possibile **precalcolare** $$O - I$$ per efficienza.

### Matrice di incidenza $$C$$
La matrice $$O - I$$ presentata sopra è infatti chiamata __matrice di incidenza__ e si indica con la lettera $$C$$: \\
è utile per ottimizzare l'operazione _scatto_ di una rete in forma matriciale.
In formule:

$$
\forall i \in 1..\vert P \vert, \, \forall j \in 1.. \vert T \vert \quad C[i][j] = O[i][j] - I[i][j].
$$

{% responsive_image path: assets/15_esempio-matrice-incidenza.png %}

$$C$$ **non sostituisce** le matrici di input $$I$$ e output $$O$$, in quanto $$I$$ è ancora necessaria per calcolare l'abilitazione di una transazioni.
Per le **reti non pure**, infatti, il valore presente in un qualsiasi posto della matrice potrebbe essere dato da una _qualsiasi combinazione_ di pesi relativi ad archi in ingresso ed uscita, in quanto per la stessa posizione $$\langle i, \, j \rangle$$ entrambe le matrici potrebbero assumere un valore.

### Sequenze di scatti
Si consideri una **sequenza** di **$$n$$ scatti** che porti la rete da una marcatura iniziale $$M$$ a una marcatura $$M^n$$. \\
Ripetendo il seguente processo per $$n$$ scatti

$$
\boxed{\boxed{M [ \ t_1 >} \: M' \vphantom{M''}}, \; \boxed{\boxed{M' [ \ t_2 >} \: M''} \rightarrow \boxed{\boxed{M [ \ t_1t_2 >} \: M''},
$$

si rinomini la sequenza ottenuta nel seguente modo:

$$
\boxed{\boxed{M [ \ s >} \: M^{(n)}}.
$$

Esiste un **legame diretto** tra la marcatura iniziale e quella finale, che non preveda eseguire i **singoli passi**?
Matricialmente, l'esecuzione in sequenza di $$x_1$$ volte di $$t_1$$, $$x_2$$ volte di $$t_2$$ fino a $$x_n$$ volte di $$t_n$$ è **fattorizzabile**.
Definendo un vettore $$s$$ tale per cui

$$
\forall j \in 1..\vert T \vert \quad s[j] = \text{# di volte in cui $t(j)$ scatta}
$$

è facile notare come l'__ordine di scatto non conta__.
Calcolando quindi $$Cs$$ è quindi possibile calcolare l'**effetto netto** dell'intera sequenza di scatti, svolgendo un'unica operazione.
Sommando $$Cs$$ alla marcatura iniziare $$M$$, si ottiene lo stato della marcatura finale $$M^{(n)}$$.

$$
M^{(n)} = M + C s.
$$

È opportuno specificare che $$s$$ non è in grado di determinare l'**esistenza** o l'**ordine** della sequenza presa in considerazione.
Non è quindi possibile sapere se $$s$$ corrisponde a una _sequenza ammissibile_ di scatti, ma è facile escluderlo: se $$M^{(n)}$$ contiene numeri negativi, allora $$s$$ corrisponde sicuramente ad una **sequenza inammissibile**.
In generale, se anche in un solo passo intermedio $$M^{(i)}$$ è negativo, allora la sequenza considerata non è ammissibile.

In conclusione, è possibile effettuare questo calcolo solo se si è **certi** che la sequenza di scatti sia **ammissibile**.

Di seguito è presente un **esempio** che potrebbe chiarire le idee.

{% responsive_image path: assets/15_esempio-sequenza-scatti.png %}

# Analisi statica

È ora possibile introdurre due tecniche di **analisi statica** che si pongono come obiettivo la ricerca di **invarianti** all'interno della rete.
Più nello specifico, esistono:

- __$$P$$-invarianti__: invarianti relative alla **marcatura dei posti**;
- __$$T$$-invarianti__: invarianti relative alla **sequenza di scatto**.

## $$P$$-invarianti

Una $$P$$-invariante è una caratteristica relativa alla marcatura dei posti che **non cambia**; viene rappresentata da un **vettore di pesi** $$h$$ di dimensione $$\vert P \vert$$.

Il vettore $$h$$ ricorda la funzione $$H: P \Rightarrow \mathbb N \setminus \{ 0 \}$$ dalla definizione di **rete conservativa**, con l'unica differenza che gli elementi di $$h$$ possono essere nulli. \\
Nel caso in cui una $$P$$-invariante abbia tutti i pesi maggiori di zero allora $$h \equiv H$$: la rete sarebbe quindi conservativa e quindi anche **limitata**.

Tramite l'analisi delle $$P$$-invarianti è quindi possibile stabilire se una rete è conservativa e quindi limitata, fornendo un'**alternativa** al metodo dell'albero di copertura.

Per ogni marcatura $$m'$$ _raggiungibile_ da $$m$$, l'**invariante** è la somma pesata del numero di gettoni ($$m$$) per $$h$$.

$$
\forall m' \text{ raggiungibile da }m \: \vert \: hm = hm' \\
\textit{o se proprio vogliamo essere precisi...} \\
\forall m' \text{ raggiungibile da }m \: \Big \vert \: \sum_{i=1}^{\vert P \vert} h[i] m[i] = \sum_{i=1}^{\vert P \vert} h[i] m'[i].
$$

Se $$m'$$ è raggiungibile da $$m$$, allora esiste una **sequenza di scatti** ammissibile $$s$$ tale per cui 

$$
m' = m + C s,
$$

ma allora, sapendo che $$hm' = hm$$ è possibile **sostituire** $$m'$$ e $$m$$ con $$hm$$ in modo da avere

$$
hm = hm + hCs
$$

quindi, semplificando i due $$hm$$,

$$
\boxed{hCs = 0}.
$$

Ritornando alle assunzioni iniziali, tale proprietà vale solo se esiste una **sequenza di scatti ammissibile**: le informazioni su $$m$$ non sono andate perse.

Nell'ultima formula è presente la matrice $$C$$ (**nota**), il vettore di pesi $$h$$ (**incognita**) e il vettore $$s$$ (**variabile libera**). 
La relazione vale infatti **per ogni** sequenza di scatti ammissibile $$s$$.
La **formula precisa** è quindi:

$$
\forall s \quad hCs = 0 \\ 
\text{con $s$ rappresentante una sequenza di scatti ammissibile.}
$$

Assumendo per un momento che $$hC = 0$$, allora qualsiasi sia $$s$$ il risultato è sempre zero, **perdendo informazione** su quest'ultima. \\
Analogamente, in una rete che possiede una **transazione morta** la corrispondente posizione in $$s$$ sarà sempre zero causando l'azzeramento anche della relativa posizione nel risultato.

Non è quindi **necessario** che $$hC = 0$$ per far sì che $$hCs = 0$$, ma è sicuramente **sufficiente**.

In conclusione, considerando solo $$hC = 0$$ è possibile **escludere** la **componente dinamica** dalla proprietà ragionando solo in base alle informazioni topologiche ($$C$$) della rete.
Trovare l'$$h$$ che rende $$hC = 0$$ è quindi **condizione sufficiente** ma non necessaria per cui $$h$$ è una $$P$$-invariante, tenendo a mente che esistono comunque $$h$$ che non rendono $$hC = 0$$ ma potrebbero essere $$P$$-invarianti.

I $$P$$-invarianti determinati con l'espressione $$hC = 0$$ non dipendono dalla marcatura iniziale ma solo dalla **topologia** della rete: se venisse considerato anche $$s$$ sarebbero $$P$$-invarianti per qualunque evoluzione della rete _a partire dalla marcatura $$m$$_.

Il sistema $$hC = 0$$ è un **sistema di equazioni lineare**, risolvibile con varie tecniche presentate successivamente.

### Copertura di $$P$$-invarianti
Una **combinazione lineare** di $$P$$-invarianti (e quindi di soluzioni del sistema) è anch'essa una \\
$$P$$-invariante.

Una $$P$$-invariante $$h$$ avente tutti i pesi $$\geq 0$$ è detta __semi-positiva__.
Se un posto ha _peso positivo_ in una \\
$$P$$-invariante semi-positiva, allora  è **limitato** nel numero di gettoni massimi che può contenere. \\
Se così non fosse, infatti, il contributo nella sommatoria vista precedentemente di $$h[i]s[i]$$ (con $$h[i] \geq 0$$ e $$s[i] > 0$$) sarebbe **potenzialmente illimitato**. \\
Se un posto ha peso nullo, potrebbe quindi essere **illimitato**.

Avere pesi dei posti **negativi** non fornisce nessuna informazione sulla limitatezza degli stessi nella rete.

Infine, se **per ogni posto** esiste una $$P$$-invariante semi-positiva il cui peso del posto è positivo, allora la rete è **limitata**.
Matematicamente:

$$
\begin{align*}
&\forall i \in 1..\vert P \vert, \, \exists h \in \mathbb{R}^{\vert P \vert} \quad hC = 0 \land h[.] \geq 0 \land h[i] > 0 \\
&\Rightarrow \text{$C$ rappresenta una rete limitata.}  
\end{align*}
$$

Si può anche dire che se esiste una **combinazione lineare** di $$P$$-invarianti tale per cui il $$P$$-invariante risultante è **strettamente positivo**, allora ci si riconduce alla **funzione di conservatività**.
### Esempio

Di seguito è illustrato un esempio sulle proprietà viste delle $$P$$-invarianti.

{% responsive_image path: assets/15_esempio-p-invarianti.png %}

Date le matrici $$I$$, $$O$$ e $$C = O - I$$ sopra è necessario risolvere il sistema $$hC = 0$$

$$
h \begin{bmatrix}
-1 & 1 & 0 & 0 \\
1  & -1 & 0 & 0 \\
-1 & 1 & -4 & 4 \\
0 & 0 & -1 & 1 \\
0 & 0 & 1 & -1
\end{bmatrix} \! = 0,
$$

che si trasforma nel seguente sistema di equazioni lineari:

$$
\begin{cases}
-h_0 &+h_1 &-h_2 & & \hphantom{+h_4} = 0 \\
+h_0 &-h_1 &+h_2 & & \hphantom{+h_4} = 0 \\
& &-4h_2 &-h_3 &+h_4 = 0 \\
& &+4h_2 &+h_3 &-h_4 = 0.
\end{cases}
$$

È facilmente notabile che la prima e la seconda equazioni sono uguali a meno di una costante moltiplicativa: sono quindi **linearmente dipendenti**, insieme alla terza e alla quarta. \\
Chiedendo quindi a Wolfram|Alpha di risolvere il sistema

$$
\begin{cases}
-h_0 &+h_1 &-h_2 & & \hphantom{+h_4} = 0 \\
& &-4h_2 &-h_3 &+h_4 = 0,
\end{cases}
$$

otteniamo le seguenti **basi**:

$$
\{ \langle -1, 0, 1, 0, 4 \rangle, \, \langle 1, 0, -1, 4, 0 \rangle, \, \langle 1, 1, 0, 0, 0 \rangle \},
$$

che se combinate linearmente generano **infinite soluzioni**.

Tra le tre basi ottenute, l'ultima è **particolare** in quanto ha tutti gli elementi semi-positivi: di conseguenza i posti corrispondenti alle prime due posizioni (con pesi strettamente positivi) sono **limitati**. \\
Rimane comunque difficile stabilire se la **rete** è limitata oppure no.

### Algoritmo di Farkas (1902)

E se esistesse un algoritmo che predilige la ricerca di **basi minime** per un sistema di equazioni, privilegiando quelle **semipositive**?
L'algoritmo in questione è l'__algoritmo di Farkas__.

{% responsive_image path: assets/15_algoritmo-farkas.png %}

Sia $$n$$ il numero di righe e $$m$$ il numero di colonne della matrice di incidenza $$C$$. \\
L'algoritmo inizia creando una matrice $$D_0$$ ottenuta da $$C$$ alla quale viene appesa una matrice di identità $$E_n$$ di dimensione $$n \cdot n$$.
Quindi, **per ogni colonna** $$i$$ da $$1$$ a $$m$$ si considerano le **coppie di righe** $$\langle d_1, \, d_2 \rangle$$ aventi nella $$i$$-esima riga numeri di segno opposto (non necessariamente uguali in valore assoluto).

Per **ogni coppia di righe** $$\langle d_1, \, d_2 \rangle$$: 
- si crea una riga temporanea $$d$$ ottenuta **combinando linearmente** la linea $$d_1$$ moltiplicata per il valore assoluto dell'$$i$$-esimo elemento della riga $$d_2$$ e sommando il viceversa. \\
Così facendo, l'$$i$$-esimo argomento della riga $$d$$ è uguale a **zero**;
- per evitare instabilità numerica dovuta a numeri troppo grandi si divide $$d$$ per il **massimo comun divisore** dei suoi elementi, assegnando il risultato a $$d'$$;
- si estende la matrice $$D_{i-1}$$ aggiungendo una nuova ultima riga $$d'$$.

Una volta terminato il ciclo sulla coppia di righe, si **scartano** tutte le righe della matrice $$D_{i-1}$$ cui $$i$$-esimo elemento è diverso da $$0$$.
Infine, al termine del ciclo esterno si eliminano le prime $$m$$ colonne di $$D_{m}$$, essendo azzerate.
Nella matrice risultante (corrispondente alla matrice $$E_n$$) sono presenti i $$P$$-invarianti.

### Continuazione dell'esempio con Farkas

Nell'esempio iniziato in precedenza si era arrivati ad un punto in cui si necessitava ottenere **basi semi-positive** e quindi $$P$$-invarianti semi-positivi: per fare ciò si può applicare l'algoritmo sopra descritto. 

Si inizia creando la matrice $$D_0 = [C \: \vert \: E_n]$$:

$$
D_0 = \begin{bmatrix}
-1  &1  &0  &0  &1 &0  &0  &0  &0 \\
 1  &-1 &0  &0  &0 &1  &0  &0  &0 \\
-1  &1  &-4 &4  &0 &0  &1  &0  &0 \\
 0  &0  &-1 &1  &0 &0  &0  &1  &0 \\
 0  &0  &1  &-1 &0 &0  &0  &0  &1
\end{bmatrix}.
$$

Osservando la **prima colonna** ($$i = 1$$) si nota che sono presenti due coppie di righe aventi segno opposto: la prima e la seconda, la seconda e la terza.

A questo punto si possono **combinare linearmente** le coppie appendendo i risultati come **ultima riga**:

$$
D_0 = \begin{bmatrix}
-1  &1  &0  &0  &1 &0  &0  &0  &0 \\
 1  &-1 &0  &0  &0 &1  &0  &0  &0 \\
-1  &1  &-4 &4  &0 &0  &1  &0  &0 \\
 0  &0  &-1 &1  &0 &0  &0  &1  &0 \\
 0  &0  &1  &-1 &0 &0  &0  &0  &1 \\
 0  &0  &0  &0  &1  &1  &0  &0  &0 \\
 0  &0  &-4 &4  &0  &1  &1  &0  &0
\end{bmatrix}.
$$

Le prime tre righe contengono nella colonna $$i$$-esima (la prima) elementi non nulli; si **scartano**:

$$
D_1 = \begin{bmatrix}
 0  &0  &-1 &1  &0 &0  &0  &1  &0 \\
 0  &0  &1  &-1 &0 &0  &0  &0  &1 \\
 0  &0  &0  &0  &1  &1  &0  &0  &0 \\
 0  &0  &-4 &4  &0  &1  &1  &0  &0
\end{bmatrix}.
$$

Si procede iterativamente senza ulteriori azioni fino alla terza colonna, dove sono presenti **due coppie di righe** aventi segni opposti in posizione $$i$$: la prima e la seconda, la prima e la quarta.\\
Applicando gli stessi passaggi di prima, la matrice $$D_3$$ che si ottiene è la seguente:

$$
D_3 = \begin{bmatrix}
 0  &0  &0  &0  &1  &1  &0  &0  &0 \\
 0  &0  &0  &0  &0  &1  &1  &0  &4 \\
 0  &0  &0  &0  &0  &0  &0  &1  &1
\end{bmatrix}.
$$

Infine, considerando la matrice $$D_m$$ senza le prime colonne nulle, si ottengono le seguenti basi di $$h$$:

$$
\{ \langle 1, 1, 0, 0, 0 \rangle, \, \langle 0, 1, 1, 0, 4 \rangle, \, \langle 0, 0, 0, 1, 1 \rangle \}.
$$

### Interpretazione dei risultati ottenuti
Una volta fatto tutto ciò l'unico risultato ottenuto è che la rete è limitata? no, è necessario interpretare i risultati ottenuti per capire di più.

gli $$h$$ sono stati finalmente ricavati, gli $$m_0$$ sono noti, quindi le uniche incognite sono gli $$m$$ della marcatura generica che è possibile raggiungere.
Sapendo che la formula iniziale era $$hm = hm_0$$ e sostituendo, si scopre che moltiplicando il p-invariante $$(1, 1, 0, 0, 0)$$ per la marcatura iniziale $$m_0$$ (ovvero il vettore colonna $$(4, 0, 4, 2, 0)$$), si ottiene come risultato che $$hm = 4$$.
Questo significa che: 

$$
\text{LettoriPronti} + \text{LettoriAttivi} = 4
$$

I posti il cui peso è 1 (peso dato dal p-invariante) sono LettoriPronti e LettoriAttivi, mentre il $$4$$ dipende dal numero di gettoni in LettoriPronti nella marcatura iniziale (quinidi ciò che c'è a sinistra dell'uguaglianda dipende dai p-invarianti, mentre ciò he c'è a destra dalla marcatura iniziale).
Questo sta a significare che i lettori non possono aumentare o diminuire, erano 4 e rimarranno sempre 4, quinsi la somma dei due è costante.
Questo risultato potevamo già saperlo ma ora l'abbiamo ricavato automaticamente tramite dei calcoli.
Lo stesso vale anche per gli scrittori, si può fare lo stesso ragionamento per cui rimangono costanti.

Esiste un terzo risultato più interessante, ovvero facendo la somma dei lettori attivi, più la risorsa, più quattro volte gli scrittori attivi deve risultare sempre 4 (che è la marcatura iniziale in risorsa), ovvero:

$$
\text{LettoriAttivi} + \text{Risorsa} + 4 \cdot \text{ScrittoriAttivi} = 4
$$

Come prima, la parte a sinistra di questo risultato è dato dal p-invariante $$(0, 1, 1, 0, 4)$$, in cui zero è il peso del posto "LettoriPronti", uno quello di "LettoriAttivi", uno quello di "Risorsa", zero quello di "ScrittoriPronti" e infine quattro quello di "ScrittoriAttivi".
Invece la parte a destra deriva dalla marcatura iniziale moltiplicata per il p-invariante preso in considerazione (quindi $$(0 \cdot 4)+(1 \cdot 0)+(1 \cdot 4)+(0 \cdot 2)+(4 \cdot 0) = 4$$).

In tutti questi risultati è implicito che tutti gli operandi (quindi LettoriAttivi, ScrittoriAttivi, ecc...) devono essere maggiori o uguali a zero

Ma questo cosa significa? facendo degli spostamenti è possibile riscrivere l'ultimo risultato in questo modo:

$$
\frac{4 \cdot \text{ScrittoriAttivi}}{4} = \frac{4 - \text{LettoriAttivi} - \text{Risorsa}}{4} = \\
\text{ScrittoriAttivi} = 1 - \frac{\text{LettoriAttivi}}{4} -\frac{\text{Risorsa}}{4} = \\
\text{ScrittoriAttivi} = 1 - (\frac{\text{LettoriAttivi} + \text{Risorsa}}{4})
$$

A questo punto "LettoriAttivi" + "Risorsa" si sa essere un valore positivo, che diviso per 4 rimane un numero positivo, a meno che non siano entrambi 0.
Questo vuol dire che il numero di scrittori attivi è al massimo uno, di conseguenza gli scrittri attivi sono al massimo uno, ovvero si escludono a vicenda.
Se i lettori attivi sono almeno 1, non c'è più posto per uno scrittore attivo, questo sta a significare che gli scrittori attivi e i lettori attivi sono in __mutua esclusione__ (se ho lettori attivi non posso avere scrittori attivi).

Ora se si fa la stessa cosa ma per i lettori attivi, si ottiene che:

$$
4 \cdot (1 - \text{ScrittoriAttivi}) -  \text{Risorsa} = \text{LettoriAttivi}
$$

Per cui se esiste un limite superiore sul numero di lettori (ovvero $$4$$, che però questo limite è dato dalla risorsa), che rimangono incompatibili con il numero di scrittori (se c'è uno scrittore attivo avremo come risultato che i lettori attivi sono un numero negativo, il che non è possibile).
<!-- Penso sia giusto ma ricontrollare quest'ultima cosa -->
In conclusione è possibile affermare che:
- se lettori attivi $$> 0 \rightarrow $$ scrittori attivi $$= 0$$;
- se scrittori attivi $$> 0 \rightarrow $$ lettori attivi $$= 0$$;
- scrittori attivi $$\leqslant 1$$
- lettori attivi $$\leqslant 4 $$ (dato dal numero di gettoni in risorsa).

## T-invarianti
Concettualmente è molto simile ai p-invarianti, ma pone dei vincoli di costanza di invariabilità sulle sequenze di scatti, ovvero:
- si possono _ripetere ciclicamente_ delle occorrenze di scatti;
- queste sequenze di scatti cicliche portano alla situazione iniziale, ovvero allo __stato base__.

Anche in questo caso si consideri l'equazione per trovare una marcatura raggiungibile a partire da una marcatura dopo una sequenza di scatti.

$$
Mn = M + C \cdot s
$$

Ora però è necessario applicare i vincoli appena esposti, quindi è necessario tornare allo stato base, questo significa che:

$$
m' = m
$$

Di conseguenza, vuol dire che si pone $$C \cdot s = 0$$, e risolvendo questa operazione è possibile ricavare $$s$$ (che ricordiamo essere un vettore delle occorrenze di scatti __non per forza a qualcosa di sensato__). 
Se si trova almeno una sequenza di scatti ammissibile relativa al vettore $$s$$ allora significa che è stata trivata una sequenza ciclica, per cui un t-invariante.

Rispetto ai p-invarianti, che non era possibile trovare tutti ma sicuramente erano validi (condizione sufficiente), abbiamo una situazione opposta, ovvero sicuramente trovo dei t-invarianti ma non c'è la sicurezza che siano validi (soddisfare l'equaizone è condizione necessaria ma non sufficiente, per essere t-invariante).

Se una rete è limitata e è copribile da t-invarianti, allora è dimostrabile che è anche viva.

# Controllori con specifica a stati proibiti
Tramite le reti di Petri, oltre ai sistemi reali si possono modellare anche dei __controllori__ che forzano o limitano certi comportamenti del sistema.

Trattiamo questa modellizzazioni nel mondo ideale in cui:

* Transizioni osservate
* Transizioni controllate

possono sempre applicabili senza problemi

CONTROLLARE significa assicurarsi che vengano rispettate certe proprietà: esprimiamo il comportamento desiderato del nostro sistema dicendo che una combinazione lineare delle marcature non deve superare un certo valore

## Mutua esclusione

Devono escludersi dalla zona critica:
* P1 + P2 <= 1
* Aggiungioamo un posto controllore Pc
  * P1+P3+Pc = 1
* Poi
  * aggiungiamo una riga opportuna a c e un elemento a m


{Latex}

LMs + Mc = [L I]M = b

Ma allora vogliamo dire che [L I] è un P-Invariante e quindi deve valere:

[L I]C = O

LCs + ICc = 0

Cc

{Latex,Latex,Latex, sintesi in LAtex}


### Sintesi del controllore


{{{PAPAPAPAAAAAAPAAAAPAPAPAPAAAAAAAAAAAAA}}}



# Estensioni delle reti di petri

* Reti temporizzate (ci interessano)
  * Temporizzate ad alto livello
* Stocastiche (nope)
* Generiche ad alto livello (interessanti ma nope)


Tutto questo ci serve per modellare sistemi Hard Real-time, sistemi critice che devono garantire molte cose. Vogliamo quindi avere modelli DETERMINISTICI

# Modelli temporali

* Esistono diverese proposte sulla maniera migliore per aggiungere il tempo alle reti di Petri:
  * Ritardi sui posti
  * Ritardi sulle transizioni
  * Tempi di scatto sulle transizioni
    * Tempi che possono essere unici o multipli, in un intervallo ecc...
    * Possono essere fissi o variabili
    * Assoluti o relativi

{...}
