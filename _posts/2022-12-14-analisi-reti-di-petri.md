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
\forall p \in P (p) \: \vert \: M(p) \geq M'(p).
$$

Ovvero _se per ogni posto in $$P$$, la marcatura $$M(p)$$ è maggiore o uguale a $$M'(p)$$_.

Al contrario, $$M$$ si dice __copribile__ da $$M'$$ se:

$$
\exists M'' \! \in R(M') \: \vert \: M'' \! \textit{ copre } M.
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
Prima di procedere con la spiegazione delle tecniche di analisi statiche, è necessario introdurre una nuovo modo per rappresentare le reti di Petri, ovvero la rappresentazione matriciale.
Ovviamente è possibile passare da una rappresentazione all'altra tramite una trasformazione automatica in quanto sono rappresentazioni formali, non ambigue e complete.
Quindi data una rete rappresentata graficamente o in forma logica, è possibile tradurla in modo automatico in una rete in forma matriciale, e viceversa.
Il vantaggio di questa rappresentazione è la maggiore semplicità nel trattare le reti in modo matematico, e sopratutto in maniera più efficiente.

Le matrici che verranno utilizzate sono diverse, tra cui:
- matrice $$I$$: rappresenta gli archi in ingresso, ovvero le coppie di flussso che da un posto vanno nelle transizioni;
- matrice $$O$$: rappresenta gli archi in uscita, ovvero le coppie di flussso che da una transizione vanno nei posti;
- vettore $$M$$: rappresenta la marcatura dei posti.

## Definizione parte statica

### Matrici $$I$$ e $$O$$

Diversamente dalla rappresentazione logica in cui venivano utilizzati degli indicatori alfanumerici per riferirsi ai posti e alle transizioni, nella rappresentaziona matriciale viene assegnato un indice ad ogni posto e ad ogni transizione.
Ogni indice deve essere possibilmente continuo, quindi senza salti, e deve essere biunivoco, ovvero ogni indice corrisponde ad un posto e ogni posto corrisponde ad un indice.

- posti: $$p: 1..\mid P \mid  \rightarrow P$$
- transizioni: $$t: 1..\mid T \mid  \rightarrow T$$

La dimensione di ognuna delle due matrici è $$\mid P \mid \times \mid T \mid$$, ovvero la cardinalità dei posti corrisponde al numero di righe e il numero delle transizioni corrisponde al numero delle colonne.

La definizione matematica della matrice degli input $$I$$ è:

$$
\forall <p(i), t(j)> \in F \qquad I[i][j] = W(<p(i),t(j)>)
$$

Per ogni flusso che va dal posto i-esimo alla transizione j-esima appartenente all'insieme dei flussi della rete, allora l'elemento $$[i][j]$$ della matrice $$I$$ è uguale al peso del flusso che va dal posto i-esimo alla transizione j'esima.
Mentre per tutti gli altri flussi che non esistono all'interno della rete la posizione corispondendte della matrice $$I$$ conterrà 0 (è come dire che se un arco non esiste, esso ha peso zero).

$$
\forall <p(i), t(j)> \notin F \qquad I[i][j] = 0
$$

Lo stesso vale per la matrice degli output $$O$$:

$$
\forall <t(j), p(i)> \in F \qquad O[i][j] = W(<t(j),p(i)>)
$$

$$
\forall <t(j), p(i)> \notin F \qquad O[i][j] = 0
$$

Per indicare il vettore colonna $$k$$ do una matrice $$X$$ spesso verrà utilizzata la notazione $$X[.][k]$$

{% responsive_image path: assets/15_esempio-rappresentazione-matriciale-I-O.png %}

### Marcatura $$m$$
È un vettore di colonna di dimensione $$\mid P \mid$$ e indica la marcatura (corrente) per ogni posto, si calcola a partire dalla funzione marcatura e si indica in questo modo:

$$
m[i] = M(p(i))
$$

## Definizione parte dinamica

### Abilitazione di una transizione
La transizione j-esima è __abilitata in una marcatura__ espressa dal vettore $$m$$ se e solo se il vettore colonna della matrice di input è minore o uguale al vettore colonna $$m$$.

La formula per definire ciò è la seguente;

$$
\text{m[tj>} \iff I[.][j] \leqslant m
$$

Ovviamente il confronto si deve fare tra tutti gli elementi corrispondenti dei due vettori colonna (gli elementi totali per ogni vettore colonna sono $$\mid P \mid$$).
In sostanza si va a controllare se il numero dei gettoni di ogni posto $$j$$ del preset è maggiore o uguale del peso dell'arco che collega il j-esimo posto alla transizione.

{% responsive_image path: assets/15_esempio-marcature-abilitate.png %}

### Scatto di una transizione
Lo scatto di una transizione $$j$$ in una marcatura $$m$$ produce una marcatura $$m'$$ che si ricava sottraendo elemento per elemento al vettore di partenza la colonna j-esima della matrice di input, e sommando al risultato la colonna j-esima della matrice output.

in formula, m [ tj > m' allora:

$$
m' = m - I[.][j] + O[.][j]
$$

{% responsive_image path: assets/15_esempio-scatto-transizione.png %}

Una caratteristica importante dell'operazione matriciale per trovare $$m'$$ è che due operandi su tre sono matrici fisse ($$I$$ e $$O$$), di conseguenza è possibile precalcolare $$O - I$$.

### Matrice di incidenza C
la matrice $$O - I$$ appena presentata è chiamata __matrice di incidenza__, di indica con la lettera $$C$$, ed è utile per ottiimzzare lo scatto.
dati due identidicatori $$a$$ e $$b$$, il valore in ogni posizione della matrice è dato dalla sottrazione tra il peso dell'arco che collega $$b$$ a $$a$$ meno il peso dell'arco che va da $$a$$ a $$b$$.  

{% responsive_image path: assets/15_esempio-matrice-incidenza.png %}

Questa matrice non va a sostituire le matrici di input e di output, infatti $$C$$ serve per calcolare lo scatto ma non per calcolare l'abilitazione.
Infatti per reti non pure (le reti pure sono le reti che non hanno elementi in comune tra preset e postset di ogni posto) il valore presente in un qualsiasi posto della matrice potrebbe essere dato da una qualsiasi combinazione di pesi relativi ad archi in ingresso ed uscita.
In altre parole, viene persa l'informazione necessaria per capire se una transizione è abilitata, ovvero il numeto di gettoni richiesti dlla transizione per essere abilitata.

### Sequenze di scatti
Si consideri una sequenza di $$n$$ scatti che porta la rete da una marcatura iniziale $$m$$ alla marcatura $$M^n$$, ovvero:

M [ t1 > M', M'[ t2 > M'', $$\rightarrow$$ M [ t1t2 > M''

e cosi via per $$n$$ scatti, e si rinomini questa sequenza in questo modo

M [ Sn > Mn

Ci si può chiedere se esiste un legame tra la marcatura iniziale e quella finale più diretto rispetto all'esecuzione di tutti i singoli passi.
La risposta è si, infatti matricialmente questo si traduce nell'esecuzione di $$x$$ volte (dove $$x$$ è il numero di volte in cui scatta $$t_1$$) l'effetto netto di ciò che succede quando scatta $$t_1$$, e cosi via per tutte le transizioni scattate.
In altre parole facendo matricialmente $$C \cdot s$$ (dove $$s$$ è il vettore di dimensione $$\mid T \mid$$ contenente il numero degli scatti per ogni transizione), è possibile calcolare l'effetto netto dell'intera sequenza di scatti con un'unica operazione.
Questo risultato sommato alla marcatura iniziale restituisce la marcatura dopo gli $$n$$ scatti.

La seguente formula descrive ciò che è stato appena spiegato:

$$
Mn = M + C \cdot s
$$

È necessario specificare che $$s$$ non è in grado di specificare se la sequenza presa in considerazione esista o no, e non dice neanche quale sequenza è, infatti non specifica in che ordine sono avvenuti gli scatti.
Quindi non è possibile sapere se $$s$$ rappresenta una sequenza ammissibile di scatti, però potrebbe dirmi se non lo è (quindi se il vettore non è compatibile con alcuna sequenza), e per farlo basta applicare la formula $$Mn = M + C \cdot s$$, e verificare se il vettore $$Mn$$ contenga elementi negativi.
È possibile però che anche se $$Mn$$ contiene solo elementi positivi, la sequenza non sia ammissibile, e questo si verifica nel caso in cui anche nei risultati intermedi siano stati presenti dei numeri negativi nel vettore.
<!-- Questa roba significa che facendo i calcoli uno alla volta, se ad un certo punto in un risultato intermedio sono presenti dei numeri negativi nel vettore, allora non va bene, non so se è chiaro nella spiegazione -->

In conclusione è possibile effettuare questo calcolo solo se si è certi che la sequenza di scatti sia ammissibile.

Di seguito è presente un esempio che potrebbe chiarire le idee:

{% responsive_image path: assets/15_esempio-sequenza-scatti.png %}

# Analisi Statica

Ora è possibile introdrre le due tecniche di analisi statica, che consistono nella ricerca di invarianti all'niterno di una rete, più nello specifico esistono:

- __P-invarianti__: ovvero invarianti sui posti, relativi alla marcatura dei posti;
- __T-invarianti__: ovvero invarianti relativi alle sequenze di scatto.

## P-invarianti

Un P-invariante è una caratteristica che non varia, relativa ai gettoni dei posti, e viene rappresentato da un vettore di pesi $$h$$ di dimensione $$\mid P \mid$$.
Questo vettore ricorda la funzione $$H$$ della definizione di una rete conservativa, con la differenza che i pesi non sono obbligatoriamente maggiori di zero.
Quindi nel caso in cui il P-invariante ha tutti i pesi maggiori di zero, corrisponderebbe ad una funzione $$H$$ tale per cui la rete è conservativa, e sfruttare i P-invarianti è un classico modo per trovare le funzioni $$H$$.
Inoltre siccome una rete conservativa rispetto ad una funzione $$H$$ è anche limitata, sfruttare i P-invarianti è un metodo alternativo per verificare che la rete sia limitata, oltre a fare l'albero di copertura e verificare che non ci siano $$\omega$$.

Ciò che deve essere invariante (costante) è la somma pesata del numero di gettoni (quindi del vettore marcatura $$m$$) per $$h$$, questo per ogni marcatura $$m'$$ raggiungibile da $$m$$.

in formula:

$$
\forall m' \text{ raggiunguibile da }m \quad hm = hm'
$$

A questo punto però se $$m'$$ è raggiungibile da $$m$$, significa che esiste una sequenza di scatti ammissibili che permette di passare da $$m$$ a $$m'$$, allora per quanto è stato detto in precedenza, vale la relazione $$m' = m + C \cdot s$$.
Ma allora, possiamo sostuire $$m'$$ e $$m$$ con $$hm$$, in modo tale da avere

$$
hm = hm + hCs
$$

in cui abbiamo lo stesso elemento sia a destra che a sinistra, quindi possiamo eliminarlo

$$
hCs = 0
$$

questo però per ogni $$s$$ che rappresenti una sequenza ammissibile a partire da $$m$$, quindi non sono andate perse tutte le informazioni su $$m$$.

A questo punto però ci si trova di fronte ad una formula in cui è presente:
- La martice $$C$$ che è nota;
- il vettore di pesi $$h$$ che è l'incognita;
- $$s$$ che è un insieme di vettori potenzialmente infinito. <!-- non è chiaro perchè un insieme di vettori e non un vettore-->

Se si assume che $$hC = 0$$ si perde completamente l'informazione che indica cosa rappresenta $$s$$, infatti se $$hC$$ è un vettore di zeri, qualsiasi vettore sia $$s$$, moltiplicato per un vettore di zeri risulterà uno scalare che è zero.
Un esempio abbastanza semplice è quello di una rete che possiede una transizione morta, il cui vettore $$s$$ conterrà nella posizione corrispondente ad essa sempre 0.
A questo punto anche se $$hC$$ conterrà un qualsiasi valore, avremo come risultato della moltiplicazione con il posto della transizione morta nel vettore $$s$$, il valore zero.
Questo ci dimostra che non è necessario che $$hC$$ sia uguale a zero per far si che $$hCs$$ sia uguale a 0.
Però sicuramente se $$hC = 0$$ allora anche $$hCs = 0$$, di conseguenza è condizione sufficiente ma non necesaria.
In altre parole togliendo il vettore $$s$$ non c'è più il problema della parte dinamica, e quindi è possibile risolvere il sistema (ricordiamo che dobbiamo trovare $$h$$ e abbiamo la matrice $$C$$) solo sulla base delle informazioni topologiche ($$C$$) della rete.
Però questa diventa una coddizione sufficiente e non necessaria per cui $$h$$ sia un P-invariante (non necessaria perchè esistono degli $$h$$ che non rendono $$hC = 0$$ che potrebbero essere P-invarianti).

In conclusione, $$hC = 0$$ è una condizione sufficiente e verificabile staticamente (perchè implicitamente vale per tutti gli $$s$$) per trovare i P-invarianti (gli $$h$$) della rete.
Questi sono gli invarianti che non dipendono dalla marcatura iniziale, ma solo dall parte topologica della rete, perchè togliendo $$s$$ è stata rimossa la dipendenza da $$m$$.
Quindi questi P-invarianti valgono per qualunque marcatura venga assegnata alla rete, se invece venisse considerato $$s$$ sarebbero P-invarianti per qualunque evoluzione della rete a paretire dalla marcatura $$m$$.

Quindi si è arrivati a dire che $$hC = 0$$, che è un sistema di equazioni linerare, risolvibile con varie tecniche presentate successivamente.

### Copertura di P-Invarianti
Una combinazione lineare di P-invarianti (e quindi di soluzioni del sistema) è anch'essa un P-invariante.
Inoltre un P-Invariante che ha tutti pesi $$\geqslant$$ 0 è detto __semi-positivo__, di conseguenza se un posto ha peso positivo in un P-invariante semi-positivo allora il posto è limitato, questo perchè se almeno una volta la somma di queste componenti (positive) è finita, allora lo è per tutte (è lo stesso discorso fatto per le reti conservative).<!-- il perchè non mi è chiarissimo-->
Ciò che è stato appena detto riguarda i posti con peso positivo, per quelli con peso zero invece potrebbe succedere di avere gettoni illimitati, questo perchè avendo pesi negativi i gettoni in posti aventi pesi uguali ma opposti si elidono.
Quindi avere dei pesi negativi non dice nulla sulla limitatezza dei posti nella rete, mentre se tutti sono maggiori o uguali a zero si ha la garanzia che i posti sono limitati.
Questo mi porta dire che se una rete è ricoperta da P-invarianti, ovvero esiste per ogni posto almeno un p-invariante semi-positivo il cui peso di tale posto sia positivo, ovvero la rete è limitata.
Un altro modo più complesso per dire ciò è:
Se esiste una combinazione lineare di p-invarianti per cui il p-invariante è tutto strettamente positivo, allora si arriva ad avere la funzione di conservatività.

### Esempio p-invarianti
Ecco finalmente un esempio su ciò che è appena stato spiegato, riprendendo una vecchia rete già utilizzata come esempio.

{% responsive_image path: assets/15_esempio-p-invarianti.png %}

Partendo da ciò per trovare i p-invarianti è necessario risolvere il seguente sistema considerando $$hC = 0$$, ovvero moltiplicando il vettore delle incognite $$h$$ per ogni colonna della matrice $$C$$.

{% responsive_image path: assets/15_sistema.png %}

Ci si accorge facilmente che la prima e la seconda equazione lineare sono uguali a meno di una costante moltiplicativa, quindi non sono linearmente indipendenti, cosi come la terza e la quarta.
Quindi basta prendere un'equazione per coppia per risolvere il sistema.
Facendo i calcoli si ottengono tre basi di questo sistema, ovvero 3 vettori che combinati linearmente danno qualunque soluzione.

Le basi sono:

$$
(-1, 0, 1, 0, 4) \\
(1, 0, -1, 4, 0) \\
(1, 1, 0, 0, 0)
$$

Avendo 5 incognite e 2 equazioni è facile capire che le soluzioni sono infinite, però tra queste ce ne sono alcune particolari.
Infatti di queste tre basi, l'ultima ha tutti gli elementi semi-positivi, di conseguenza i posti corrispondenti alle prime due posizioni (quelle con i numeri strttamente positivi), sono limitati.
Però non si riesce ancora a caprire da ciò che è stato appena ricavato se la rete è limitata oppure no (cosa che in realtà era già nota), allora si può sfruttare un algoritmo utile a trovare le basi minime privilegiando però quelle semipositive.

### Algoritmo di Farkas (1902)

L'algoritmo in questione è __l'algoritmo di Farkas__, che come già detto serve a trovare le basi minime si un sistema di equazioni, però privilegiando però quelle semipositive.

{% responsive_image path: assets/15_algoritmo-farkas.png %}

L'algoritmo inizia creando una matrice $$D_0$$ a partire dalla matrice di incidenza $$C$$ a cui viene appesa una matrice identità di dimensione $$n$$ (dove $$n$$ è il numero di linee della matrice $$C$$).
Successivamente per ogni colonna da 1 a $$m$$ si prendono le coppie di righe che nella colonna i-esima hanno dei numeri di segno opposto (non per forza con lo stesso valore assoluto), e per ognuna di queste coppie si devono fare i seguenti calcoli:
- si crea la linea $$d$$ ottenuta combinando linearmente la linea $$d_1$$ moltiplicata per il valore assoluto dell'elemento i-esimo della riga $$d_2$$, con la linea $$d_2$$ moltiplicata per il valore assoluto dell'elemento i-esimo della riga $$d_1$$.
Facendo questo si farantisce che l'elementi i-esimo della riga $$d$$ sia uguale a 0.
- Successivamente per non far crescere troppo i numeri si divide $$d$$ per il massimo comun divisore, e questa colonna la si chiama $$d'$$ (teoricamente non è un passaggio necessario). <!-- non si capisce bene di cosa, penso degli elementi della colonna  -->
- Si aggiunge la riga cosi ottenuta alla matrice $$D$$, questo per ogni coppia di righe che hanno sengi opposti (siccome ci si trova ancora nel ciclo).

Una volta finito terminato il ciclo, si scartano tutte le colonne il cui i-esimo elemento è diverso da 0, questo si fa per tutte le colonne $$i$$ della matrice di incidenza iniziale.
A questo punto si eliminano le prime $$m$$ della matrice complessiva ($$D$$), siccome sono tutti zeri, e alla fine rimangono solo i p-invarianti.

### Continuazione esempio utilizzando Farkas
Nell'esempio iniziato in precedenza si era arrivati ad un punto in cui si necessitava di basi particolari, ovvero quelle semi-positive (i p-invarianti semi-positivi in pratica).
Per fare ciò si applica l'algoritmo appena descritto, quindi si crea la matrice $$D_0$$ in questo modo.

{% responsive_image path: assets/15_matrice-D.png %}

Successivamente, guardando la prima colonna, le uniche coppie di righe che hanno segno opposto sono la prima e la seconda, e la seconda e la terza.
A questo punto ne faccio la combinazione lineare e tolgo le linee in cui la prima colonna contiene un elemento diverso da 0 (quindi le prime 3 della matrice colorata), e mi rimane la seguente matrice. 

{% responsive_image path: assets/15_giro-prima-colonna.png %}

Successivamente faccio lo stesso per tutte le altre colonne, e l'unico caso in cui bisogna effettivamente fare qualcosa è la colonna 3, in cui le righe con segni opposti sono la prima e la terza, e la seconda e la terza (in questo esempio non c'è bisogno di dividere mer l'mcd, i numeri sono piccoli).
Applicando gli stessi passaggi di prima, questo è ciò che risulta.

{% responsive_image path: assets/15_giro-terza-colonna.png %}

A questo punto, togliendo tutte le prime 4 colonne di 0, la matrice che rimane è quella finale, contenente i 3 vettori $$h$$ che sono basi, con la caratteristica che per costruzione non possono essere negativi.

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
