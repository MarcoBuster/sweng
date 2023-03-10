---
layout: post
title: "[14] Reti di Petri"
date: 2022-12-12 14:40:00 +0200
toc: true
---

# [Reti di Petri](https://www2.informatik.uni-hamburg.de/TGI/PetriNets/index.php)

In questa lezione verranno mostrate le reti di Petri come esempio di **linguaggio formale**: fin dall'inizio del corso è stato possibile apprendere come l'ingegneria del software si occupi di linguaggi e comunicazione.

Partendo infatti dai processi che sfruttano un linguaggio poco formale e con poca terminologia tecnica (ad esempio le _user story_) e passando per la progettazione in cui è stato utilizzato un linguaggio più rigoroso, si arriva infine a un vero linguaggio formale utile a **raccogliere delle specifiche**.

Esiste un modello standard di rete di Petri e delle possibili estensioni di quest'ultimo: ad esempio nelle prossime lezioni saranno illustrati alcuni possibili dialetti come le **reti temporizzate**, utili a descrivere sistemi real time che necessitano di requisiti formali per ridurne le criticità.

In generale utilizzare linguaggi complessi e formali per descrivere le specifiche può essere costoso: vengono infatti utilizzati perlopiù in **contesti critici** dove i fallimenti provocano conseguenze molto gravi e in cui la **sicurezza deve essere garantita** prima di mettere in funzione il software.

Le reti di Petri sono in parte simili agli __automi a stati finiti__ (FSM), ma nascono specificatamente per descrivere sistemi concorrenti.
Tra gli altri aspetti, i concetti di _stato_ e _transizione_ per le reti di Petri differiscono rispetto a quelli già conosciuti per le FSM:
- lo __stato__ nelle reti di Petri non è più un'informazione atomica osservata a livello di sistema ma è frammentata in __parti diverse__ la cui composizione avviene tramite la loro visione generale;
- di conseguenza le __transizioni__ non operano sullo stato globale ma si limitano a variarne una parte.

Nelle FSM esiste un unico stato attivo e gli stati disponibili sono dati dal prodotto cartesiano di tutti i possibili valori delle diverse entità.
Per contro nelle reti di Petri ci sono __diversi stati attivi__ in un dato momento, cosa che permette di semplificarne notevolmente la rappresentazione e l'analisi.

## Definizione informale

Un vantaggio delle reti di Petri è che possono essere viste in maniera informale dal cliente.
È infatti facile rappresentare una rete di Petri come un grafo in cui ogni nodo rappresenta o un __posto__ o una __transizione__ e gli archi i collegamenti presenti tra le transizioni e i posti.
Il grafo è __bipartito__, ovvero un grafo in cui nodi di un tipo sono messi in relazione __solo__ con nodi dell'altro tipo: in questo caso _i posti possono essere collegati soltano a transizioni e viceversa_.

Ad ogni posto è assegnato un certo numero di ___gettoni___ (o __token__) – sarà successivamente approfondito il senso dell'assegnamento di un numero infinito di gettoni a un posto.

La **disposizione dei gettoni nei posti** in un dato momento all'interno della rete di Petri ne determina il suo __stato complessivo__.

{% responsive_image path: 'assets/14_rete-petri-informale.png' %}

Per far evolvere lo stato della rete, l'__assegnamento dei gettoni deve poter variare__. \\
La trasformazione dello stato è effettuata dallo scatto di una transizione:
- una transizione si dice ___abilitata___ (_enabled_) quando la somma dei gettoni dei posti collegati ingresso è maggiore di un certo numero;
- una transizione ___scatta___ (_fire_) quando, dopo essere stata abilitata, consuma i gettoni dei posti collegati in ingresso e ne genera altri all'interno dei posti collegati in uscita.
È importante notare come i gettoni __non si spostano__ da un posto a un altro conseguentemente a uno scatto, ma vengono __distrutti__ nei posti in ingresso alla transizione e __generati__ nei posti in uscita.
Quest'ultima considerazione è importante per capire che i gettoni _non sono necessariamente sempre dello stesso numero in ingresso e in uscita_.

Tramite questo __modello operativo__ è facile mostrare al cliente quando qualcosa cambia all'interno del sistema, perché risulta più intuitivo rispetto a un linguaggio logico e descrittivo.

Lo **svantaggio** è che fornisce informazioni parziali su _come_ il sistema compie le azioni che dovrebbe eseguire, rischiando di essere una via di mezzo tra _specifica_ e _documento di design_.
Si può comunque chiamare specifica perché _viene definito totalmente e inequivocabilmente il comportamento del sistema_.

La rete descritta è quindi una **macchina di riferimento** da utilizzare come confronto per stabilire la validità del sistema sotto esame, come se fosse un _oracolo_.

## Definizione matematica

Come già detto, esistono numerosi dialetti di reti di Petri. 
In questo caso vediamo le __PT net__ (reti con posti e transizioni) che sono le più classiche, successivamente verranno descritte delle estensioni e riduzioni di queste reti.

Una rete di Petri classicamente è una 5-tupla $$[P, \, T; \; F, \, W, \, M_0]$$ in cui:
- $$P$$ è l'insieme degli **identificatori dei posti**;
- $$T$$ è l'insieme degli **identificatori delle transizioni**;
- $$F$$ è l'insieme delle **relazioni di flusso**;
- $$W$$ è una funzione che associa un **peso ad ogni flusso**; 
- $$M_0$$ è la **marcatura iniziale**, ovvero l'assegnamento iniziale dei _gettoni_.

In generale definiamo come __marcatura__ una _particolare configurazione dell'assegnamento dei gettoni all'interno della rete di Petri_, sia essa _iniziale_ o una sua  _evoluzione_.

Da notare che $$P$$ e $$T$$ a livello matematico sono degli insiemi di __identificatori__ che non si sovrappongono (dato che si tratta di entità differenti) a cui poi verrà assegnato un significato, quindi precedentemente sono stati associati a posti e transizioni, ma di fatto sono tutti __identificatori__.

Data la 5-tupla appena descritta esistono le seguenti proprietà:
- $$P \cap T = \varnothing$$; 
- $$P \cup T \neq \varnothing$$ (una rete in cui non c'è nulla non è una rete: almeno un posto o una transizione ci devono essere);
- $$F \subseteq (P \times T) \cup (T \times P)$$;
- $$W: \: F \rightarrow \mathbb N \setminus \{ 0 \}$$;
- $$M_0: P \rightarrow \mathbb N$$.

Utilizziamo inoltre alcune _scorciatoie_:

- $$\operatorname{Pre}(a) = \{ d \in (P \cup T) \quad \langle d, \, a \rangle \in F \}$$. \\
Il **preset** di un nodo $$a$$ è l'insieme degli elementi $$d$$ appartenenti all'unione degli insiemi degli identificatori di posti e transizioni tali che esiste una relazione di flusso tra $$d$$ e $$a$$ appartenente a $$F$$. \\
In sostanza questo insieme rappresenta l'insieme degli **identificatori antecedenti** ad $$a$$;
- $$\operatorname{Post}(a) = \{ d \in (P \cup T) \quad \langle a,\, d \rangle \in F \}$$. \\
Il **postset** di un nodo $$a$$ è l'insieme degli elementi $$d$$ appartenenti all'unione degli insiemi degli identificatori di posti e transizioni tali che esiste una relazione di flusso tra $$a$$ e $$d$$ appartenente a $$F$$. \\
In sostanza questo insieme rappresenta l'insieme degli **identificatori successivi** ad $$a$$.

Tutto questo rappresenta la parte statica delle reti di Petri, ovvero quando vengono osservate in un preciso istante di tempo, senza considerare i cambiamenti che potrebbero avvenire al suo interno.

### Comportamento dinamico

Una transizione $$t \in T$$ è __abilitata__ in una particolare marcatura $$M$$ se e solo se

$$
\boxed{
    \forall p \in \operatorname{Pre}(t) \quad M(p) \geq W( \langle p, \, t \rangle )
}.
$$

In notazione, $$\boxed{M \ [ \ t >}$$ significa che _$$t$$ è abilitata in $$M$$._ 

Significa che per ogni elemento collegato in ingresso a $$t$$ esiste un numero di gettoni maggiore del peso dell'arco che collega $$p$$ a $$t$$.
Un aspetto interessante di questa definizione è che non si sta ragionando su tutti i posti della rete, ma solo su quelli collegati in ingresso a $$t$$. 
Di conseguenza, non è necessario conoscere l'intera rete per poter affermare che una transizione sia abilitata o meno, ma è sufficiente controllare la zona che comprende i posti appartenenti a $$ \operatorname{Pre}(a) $$. 
Questa proprietà è chiamata __località dell'analisi__.

Lo __scatto__ di una transizione $$t \in T$$ in una particolare marcatura $$M$$ produce nel momento successivo una nuova marcatura $$M'$$ tale per cui

$$
\begin{aligned}
\forall p \in \operatorname{Pre}(t) \setminus \operatorname{Post}(t) &\quad  M'(p) = M(p) - W(\langle p, \, t \rangle); \\
\forall p \in \operatorname{Post}(t) \setminus \operatorname{Pre}(t) &\quad M'(p) = M(p) + W(\langle t, \, p \rangle); \\
\forall p \in \operatorname{Post}(t) \cap \operatorname{Pre}(t) &\quad M'(p) = M(p) - W(\langle p, \, t \rangle) + W(\langle t, \, p \rangle); \\
\forall p \in P - \left ( \operatorname{Post}(t) \cup \operatorname{Pre}(t) \right ) &\quad M'(p) = M(p).
\end{aligned}
$$

Specificando in modo descrittivo le notazioni precedenti:
- per ogni identificatore $$p$$ appartenente al preset ma non al postset della transizione $$t$$, il numero di gettoni della nuova marcatura $$M'$$ sarà uguale al numero di gettoni della marcatura precedente $$M$$ \\
meno il peso dell'arco che collega $$p$$ a $$t$$;
- per ogni identificatore $$p$$ appartenente al postset ma non al preset della transizione $$t$$, il numero di gettoni della nuova marcatura $$M'$$ sarà uguale al numero di gettoni della marcatura precedente $$M$$ \\
più il peso dell'arco che collega $$t$$ a $$p$$;
- per ogni identificatore $$p$$ appartenente sia al preset sia al postset della transizione $$t$$, il numero di gettoni della nuova marcatura $$M'$$ sarà uguale al numero di gettoni della marcatura precedente $$M$$ \\
meno il peso dell'arco che collega $$p$$ a $$t$$ più il peso dell'arco che collega $$t$$ a $$p$$;
- per ogni identificatore $$p$$ appartenente all'insieme dei posti meno l'unione tra preset e postset di $$p$$ la marcatura non cambia.

In notazione, $$\boxed{\boxed{M \ [ \ t >} \, M'}$$ significa che lo scatto di $$t$$ in $$M$$ produce $$M'$$.

È importante notare come una transizione può scattare nel caso in cui non abbia alcun elemento nel suo preset; questo significa che la transizione in questione **non possiede prerequisiti** per scattare.

## Da FSM a rete di Petri

È _meccanicamente_ possibile trasformare una macchina a stati finiti in una rete di Petri.

{% responsive_image path: 'assets/14_produttore.png' %}

Riferendosi all'esempio del produttore, l'unico problema è l'**esistenza di collegamenti diretti tra posti**: come è stato detto in precedenza questo non è possibile in una rete di Petri. 
Sarà quindi necessario interporre tra i posti delle transizioni per avere una rete di Petri valida. \\
Immaginando di mettere un solo gettone in uno dei due posti della rete appena creata, questo indicherà lo **stato attivo** presente nella macchina a stati finiti. \\
Seguendo questi passaggi diventa banale mappare una macchina a stati finiti su una rete di Petri: di seguito è possibile osservare l'operazione analoga eseguita sulle FSM di un consumatore e di un buffer.

{% responsive_image path: 'assets/14_consumatore-buffer.png' %}

Componendo le reti di Petri di _produttore_, _consumatore_ e _buffer_ appena create, si crea la seguente.

{% responsive_image path: 'assets/14_produttore-consumatore-buffer.png' %}

In termini di automi a stati finiti, per trovare gli **stati raggiungibili** da questa composizione sarebbe stato necessario eseguire il prodotto cartesiano tra gli stati delle tre macchine a stati finiti combinate tra loro. \\
Trattandosi invece di una rete di Petri, è sufficiente unire tutti gli identificatori uguali in un unico identificatore (ad esempio la transizione deposita della rete _produttore_ e della rete _buffer_) e aggiungere a quest'ultimo tutti collegamenti posseduti dagli identificatori uniti.

<span style="color: red">__ATTENZIONE__</span>: nell'esempio della rete composta le coppie di transizioni _"preleva"_ e _"deposita"_ dovrebbero avere due nomi differenti, ma siccome sono indicate con due rettangoli diversi è stato omesso questo particolare. 
In termini matematici **devono avere nomi differenti**.

Precedentemente è stato detto che, _nel caso di una rappresentazione di una FSM in termini di una rete di Petri_, si rappresenta lo stato attivo nella FSM con un gettone: di conseguenza, portando all'interno della rete composta tutti i gettoni delle varie reti si arriva ad ottenere il risultato descritto dall'immagine precedente, in cui tutte le "entità" (_consumatore_, _produttore_ e _buffer_) mantengono la propria individualità (è infatti presente un gettone per ogni entità).

In questo caso si può quindi notare che il produttore è pronto a produrre, il buffer è vuoto e il consumatore è pronto a consumare una volta che il buffer avrà al suo interno qualcosa.

### Come evolve questa rete?
Per rispondere a questa domanda la prima cosa da considerare è quali sono le **transizioni abilitate**: in questo caso si tratta solo della transizione _produci_ sotto a $$p_0$$, in quanto è l'unica ad avere tutti gli elementi del suo preset con un numero di gettoni sufficienti a farla scattare; $$p_0$$ possiede infatti un gettone e l'arco ha peso 1 (_quando non è specificato il peso è 1_). \\
Una rete di Petri _non forza lo scatto di alcuna transizione_, quindi volendo si potrebbe rimanere nello stato corrente all'infinito senza far mai scattare _produci_. 
Se però _produci_ scatta, il gettone in $$p_0$$ viene distrutto e in $$p_1$$ viene generato un nuovo gettone.

{% responsive_image path: 'assets/14_primo-scatto.png' %}

Dopo questo scatto la rete di Petri si trova in una situazione in cui il produttore ha prodotto qualcosa ed è pronto a depositarlo nel buffer: a questo punto non resta che porsi nuovamente la domanda _"quali transizioni sono abilitate?"_ per capire come può procedere l'evoluzione della rete. \\
È facile notare come la transizione _deposita_ sotto $$b_0$$ sia l'unica abilitata e di conseguenza, _se dovesse scattare_, il risultato sarebbe il seguente:

{% responsive_image path: 'assets/14_secondo-scatto.png' %}

Ora è possibile identificare una situazione particolare, ovvero quella in cui le transizioni pronte a scattare sono due. Sorge spontanea la domanda: _"quale delle due transizioni scatta prima?"_.
Nelle reti di Petri descritte fino ad ora non è stato presentato lo **scatto simultaneo** delle transizioni, ma nulla vieta che possa avvenire in un contesto reale.
In tal caso si tratterebbe di un'istanza di __non determinismo__, ovvero _non si può dire quale transizione deve scattare_. 
Sono quindi 3 le situazioni che si possono verificare:
- scatta la prima transizione;
- scatta la seconda transizione;
- non scatta nessuna transizione (la _non evoluzione_ è comunque un'evoluzione).

Nel caso in cui fosse stato necessario definire che una delle due transizioni scatti prima dell'altra, ci si troverebbe di fronte ad una rete **non corretta**: è infatti possibile modificare la rete in modo tale che imponga un ordine di scatto alle transizioni.

### Sfruttare le reti di Petri
A questo punto è possibile chiedersi se si stiano sfruttando realmente tutte le potenzialità delle reti di Petri, siccome la rete dell'esempio precedente è stata ricavata da un automa a stati finiti.
Per capire ciò è possibile osservare un secondo esempio in cui è presentata una rete alternativa alla precedente, ma con lo stesso scopo.

{% responsive_image path: 'assets/14_rete-alternativa.png' %}

La differenza che salta subito all'occhio è il numero di gettoni presenti all'interno di $$b_0$$ che indicano il numero di posizioni libere nel buffer.
Questo è un vantaggio perchè se il buffer dovesse cambiare la sua capienza, sfruttando questa rete è sufficiente modificare la marcatura di $$b_0$$ e il problema sarebbe risolto; la rete precedente avrebbe invece bisogno di una pesante modifica per essere adattata. \\
Di conseguenza si può applicare lo stesso concetto per il consumatore e per il produttore: aumentandone il numero dei gettoni (rispettivamente in $$p_0$$ e $$c_0$$) aumenterebbe il numero di entità in grado di produrre e consumare.

{% responsive_image path: 'assets/14_rete-alternativa-diverse-entita.png' %}

È possibile affermare quindi che cambiando il **numero di gettoni** è possibile moltiplicare gli elementi del sistema di cui si vuole tracciare l'evoluzione. Si sottolinea ancora che questo risulterebbe molto oneroso in termini di dimensioni se fosse stato riadattato in una macchina a stati finiti.

Per definizione le macchine a stati finiti __non__ possono rappresentare **situazioni infinite**, se si volesse quindi modificare ulteriormente l'esempio appena visto imponendo una capienza illimitata al buffer, non sarebbe possibile utilizzando una macchina a stati finiti.
Sfruttando le reti di Petri invece è sufficiente eliminare l'identificatore del posto $$b_0$$: in questo modo abbiamo una situazione in cui i produttori possono depositare senza limiti all'interno del buffer, mentre i consumatori non possono prelevare più elementi di quelli presenti nel buffer.
Questo vincolo è imposto dalla marcatura di $$b_1$$, infatti la transizione "preleva" può scattare al massimo $$n$$ volte consecutivamente, dove $$n$$ è la marcatura di $$b_1$$ &mdash; assumendo che nel mentre non avvengano depositi da parte dei produttori.

Un altra modifica applicabile all'esempio sfrutta i pesi degli archi: ponendo un peso di 3 all'arco che collega _deposita_ a $$b_1$$ si può dire che il produttore crea e deposita tre prodotti, occupando tre posizioni nel buffer.
Ponendo invece un peso di 2 all'arco che collega $$b_1$$ a _preleva_ si specifica che è possibile prelevare dal buffer due elementi alla volta.
Questo esempio, in parte forzato, è utile per chiarire il fatto che nelle reti di Petri _gli archi non sono semplici collegamenti, ma è possibile attribuirgli un significato_.

Vengono infatti informalmente chiamati _archi_, rifacendosi alla terminologia dei grafi, ma in realtà indicano una relazione più profonda che coinvolge due identificatori: in questo esempio esiste infatti una relazione per cui ogni elemento prodotto occupa tre posizioni all'interno del buffer e un'altra relazione in cui ogni consumatore può prelevare obbligatoriamente due elementi alla volta.
Tramite il peso degli archi è possibile creare delle situazioni ambigue: ad esempio se la relazione che coinvolge _deposita_ e $$p_0$$ avesse un peso di 2, ogni volta che viene prodotto qualcosa i produttori si moltiplicherebbero e ovviamente questa situazione indicherebbe che la rete è sbagliata, quindi è necessario fare attenzione ad evitare questo tipo di situazioni.

{% responsive_image path: 'assets/14_archi-con-pesi.png' %}

È da sottolineare che è possibile ridurre una rete P/T avente pesi sugli archi in una rete P/T senza pesi sugli archi: successivamente verrà illustrato come ciò è possibile.

## Relazioni

Di seguito verranno elencati le tipologie di relazioni che possono coinvolgere i diversi identificatori e cosa comporta la loro presenza.

### Sequenza

Una transizione $$t_1$$ è __in sequenza__ con una transizione $$t_2$$ in una marcatura $$M$$ se e solo se

$$\boxed{M \ [ \ t_1 >} \: \land \: \lnot \, \boxed{ M \ [ \ t_2 > } \: \land \: \boxed{ M \ [ \ t_1 t_2 > } \, .$$

Questa formula indica che:
- $$t_1$$ è abilitata in $$M$$;
- $$t_2$$ NON è abilitata in $$M$$;
- $$t_2$$ viene abilitata dallo scatto di $$t_1$$ in $$M$$.

Si può notare una **relazione d'ordine non simmetrica** in cui _lo scatto di $$t_1$$_ è una condizione sufficiente per cui $$t_2$$ possa scattare: questo tipo di relazione permette quindi di creare un **ordine di scatto** delle transizioni.
È condizione sufficiente e non necessaria perchè osservando l'esempio sottostante è facile capire che lo sacatto di $$t_0$$ non è necessario per far si che $$t_2$$ scatti: infatti anche se dovesse avvenire lo scatto di $$t_2$$, la transizione $$t_1$$ diventerebbe comunque abilitata.

{% responsive_image path: 'assets/14_sequenza.png' %}

### Conflitto

Due transizioni $$(t_1, \, t_2)$$ sono in:
- __conflitto strutturale__ $$\Longleftrightarrow \operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) \neq \varnothing $$;
- __conflitto effettivo__ in una marcatura $$M$$ $$\Longleftrightarrow$$:
    - $$\boxed{M \ [ \ t_1 >} \land \boxed{M \ [ \ t_2 >}$$;
    - $$\exists p \in \operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) \mid M(p) < W(\langle p, \, t_1 \rangle) + W(\langle  p, \, t_2\rangle)$$.

Analizzando i due tipi di conflitto è possibile notare che:
- due transizioni sono in __conflitto strutturale__ se l'intersezione dei due preset non è vuota e quindi hanno posti in ingresso in comune: possono quindi interferire tra loro.
Il conflitto strutturale dipende solo dalla topologia dela rete, infatti non vengono citate le marcature;
- due transizioni sono in __conflitto effettivo__ se sono entrambe abilitate in una marcatura $$M$$ ed esiste un posto in ingresso in comune ai due preset tale per cui il numero di gettoni in quel posto è minore della somma dei pesi dei due flussi che vanno dal posto alla transizione (quindi il posto in ingresso non ha abbastanza gettoni per far scattare entrambe le transizioni).
Entrano quindi in conflitto sulla disponibilità di gettoni nel preset.

Esiste una versione __rilassata__ della definizione di conflitto esplicitata dalla seguente formula:

$$
\boxed{M \ [ \ t_1 >} \: \land \: \boxed{M \ [ \ t_2 >} \: \land \: \lnot \, \boxed{M \ [ \ t_1 t_2 >}.
$$

Questa proposizione indica che il conflitto è presente se $$t_1$$ e $$t_2$$ sono abilitate in una marcatura $$M$$ e non è possibile la sequenza $$t_1$$ $$t_2$$ a partire da $$M$$.
Ma cosa vuol dire che è una _versione rilassata_? 
Per capirlo si osservi questo l'esempio sottostante:

{% responsive_image path: 'assets/14_esempio-conflitto1.png' %}

Secondo le definizioni di conflitto che sono state date, in questa rete di Petri è presente un conflitto sia per la prima definizione che per la seconda.
È possibile però fare in modo che rimanga in conflitto per la prima definizione data ma non più per la definizione rilassata introducendo una piccola modifica:

{% responsive_image path: 'assets/14_esempio-conflitto1-differenza.png' %}

Aggiungendo una relazione tra $$t_1$$ a $$p_1$$ si può notare che dopo lo scatto di $$t_1$$ quest'ultima è ancora abilitata e quindi non rientra più sotto la definizione rilassata di conflitto.

Lasciando da parte la definizione rilassata, è facile osservare a questo punto che la definizione per il conflitto strutturale si basa solo sui preset, ignorando quindi qualsiasi arco in uscita, mentre la quella per il conflitto effettivo ragiona anche sugli effetti dello scatto delle transizioni. Si noti che la presenza di un conflitto strutturale __non implica__ obbligatoriamente la presenza di un conflitto effettivo in quanto quest'ultimo per esistere necessita che venga soddisfatta una condizione in più.
Al contrario invece un conflitto effettivo __implica__ la presenza di un conflitto strutturale in qunato le condizioni di quest'ultimo sono comprese in quelle del conflitto effettivo. \\
Di seguito viene mostrato un esempio di conflitto _effettivo_ e _strutturale_.

{% responsive_image path: 'assets/14_conflitto-effettivo-e-strutturale.png' %}

### Concorrenza

È in qualche modo intuitivo considerare la relazione di concorrenza come la relazione opposta alla relazione di conflitto: due transizioni $$(t_1, \, t_2)$$ sono in:
- __concorrenza strutturale__ $$\Longleftrightarrow \operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) = \varnothing$$;
- __concorrenza effettiva__ in una marcatura $$M \Longleftrightarrow$$
    - $$\boxed{M \ [ \ t_1 >} \cap \boxed{M \ [ \ t_2 >} $$;
    - $$\forall p \in \operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) \quad M(p) \geq W(\langle p, \, t_1 \rangle) + W(\langle  p, \, t_2\rangle)$$.

Quest'ultima formula indica che due identificatori delle transizioni sono in concorrenza effettiva se e solo se per tutti i posti che hanno in comune c'è un numero di gettoni sufficienti per farle scattare entrambe.

In questo caso non esiste alcun legame tra concorrenza strutturale ed effettiva, diversamente da quanto abbiamo visto in precedenza per le relazioni di conflitto.
Se si verificano le condizioni per avere una concorrenza strutturale è __possibile__ che le due transizioni non siano abilitate, oppure se si verificano le condizioni per avere concorrenza effettiva è __possibile__ che $$t_1$$ e $$t_2$$ abbiano posti in comune che posseggano abbastanza gettoni per entrambe.

Questo però non esclude il fatto che sia possibile avere concorrenza strutturale ed effettiva contemporaneamente, infatti di seguito sono riportati degli esempi che confermano ciò:

{% responsive_image path: 'assets/14_esempio-concorrenza.png' %}

Ovviamente è anche possibile che non ci sia alcun tipo di concorrenza: è sufficiente che due transizioni abbiano in comune un posto e una delle due non sia abilitata.

## Insieme di raggiungibilità 

<span style="display: none;">$$\def\pt{\mathcal{P/T}}$$</span>
L'insieme di raggiungibilità $$R$$ di una rete $$\pt$$ a partire da una marcatura $$M$$ è il più piccolo insieme di marcature tale che:
- $$M \in R(\pt, \, M)$$;
- $$M' \in R(\pt, \, M) \land \exists t \in T \quad \boxed{\boxed{M' \ [\ t >} \, M''} \Longrightarrow M'' \in R(\pt, \, M)$$.

Questa definizione induttiva viene interpretata nel seguente modo:
- __passo base__: la marcatura $$M$$ appartiene all'insieme di raggiungibilità $$R(\pt, \, M)$$ \\
($$M$$ indica la marcatura iniziale mentre $$\pt$$ indica la rete posti-transizioni);
- __passo induttivo__: se $$M'$$ appartiene all'insieme di raggiungibilità (quindi si dice che _è raggiungibile_) ed esiste una transizione della rete tale per cui è abilitata in $$M'$$ e porta in $$M''$$ &mdash; per cui con uno scatto è possibile passare dalla marcatura $$M'$$ alla marcatura $$M''$$ &mdash; _allora_ anche quest'ultima è __raggiungibile__.

Procedendo ricorsivamente con questa definizione è possibile ottenere tutte le marcature raggiungibili.

## Limitatezza
<span id="limitatezza"></span>
Una proprietà importante delle reti di Petri è la __limitatezza__, che indica se le possibili evoluzioni della rete possono essere limitate o illimitate, quindi se gli stati raggiungibili sono in numero finito oppure infiniti.
Volendo dare una definizione più formale è possibile dire che una rete posti-transizioni ($$\pt$$) con marcatura $$M$$ si dice __limitata__ se e solo se:

$$
\exists k \in \mathbb N, \: \forall M' \! \in R(\pt, \, M), \: \forall p \in P \quad M'(p) \leq k
$$

cioè se esiste un numero naturale $$k$$ tale per cui per ogni marcatura $$M'$$ raggiungibile da $$M$$, per ogni posto $$p$$ all'interno della rete il numero di gettoni in quella marcatura _raggiungibile_ è minore o uguale di $$k$$ &mdash; ovvero se è possibile porre un numero finito tale per cui dopo qualsiasi evoluzione non esista alcun posto che possiede un numero di gettoni maggiore di $$k$$ &mdash; allora è possibile affermare che **la rete è limitata**. \\
Se ciò non si verifica esiste almeno un posto in cui è possibile aumentare tendenzialmente all'infinito il numero di gettoni, tramite una certa evoluzione della rete.
È importante sottolineare che la limitatezza di una rete può dipendere dalla sua **marcatura iniziale**.

{% responsive_image path: 'assets/14_esempio-rete-illimitata.png' %}

## Da reti di Petri a Automi

Precedentemente è stato mostrato come a partire da un automa a stati finiti sia possibile ricavare una rete di Petri, ma è possibile fare **il contrario**?
Se la rete è limitata allora l'insieme di raggiungibilità è finito, di conseguenza è possibile definire un corrispondente automa a stati finiti che prende ogni marcatura raggiungibile come un proprio _stato_ e ne traccia le transizioni di stato dell'automa conseguenti alla transizione scattata nella rete di Petri.
Due considerazioni:
- gli **stati** sono le possibili marcature dell'insieme di raggiungibilità;
- le **transizioni** sono gli eventi che permettono il passaggio da una configurazione alla successiva.

Riuscire a passare dalle reti di Petri agli automi ci permette di modellare un problema in modo più sintetico, ma allo stesso tempo rimane possibile utilizzare i **tool di analisi** che sfruttano proprietà già consolidate per gli automi.
L'unico problema è che questo approccio vale solo per **reti limitate**.

## Vitalità di una transizione

Una transizione $$t$$ in una marcatura $$M$$ si può dire _viva_ con un certo __grado__:
- __grado 0__ (o __morta__): non è abilitata in nessuna marcatura appartanente all'insieme di raggiungibilità, quindi qualunque evoluzione avvenga nella rete, la transizione non portà mai scattare (non è sempre un aspetto negativo);
- __grado 1__: esiste almeno una marcatura raggiungibile a partire da $$M$$ in cui la transizione è abilitata;
- __grado 2__: per ogni numero $$n$$ naturale escluso lo zero esiste almeno una sequenza di scatti ammissibile a partire da $$M$$ in cui la transizione scatta $$n$$ volte, ovvero è possibile far scattare la transizione un numero $$n$$ grande a piacere di volte;
- __grado 3__: esiste una sequenza di scatti ammissibile a partire da $$M$$ per cui la transizione scatta _infinite_ volte;
- __grado 4__ in _qualunque marcatura raggiungibile_ esiste una sequenza ammissibile in cui è possibile far scattare la transizione almeno una volta, di conseguenza può scattare infinite volte in qualunque situazione ci si trovi (ovvero in qualunque marcatura).  \\
In questo caso si dice che la transizione è __viva__ _in maniera assoluta_.

Si noti come il concetto di _$$n$$ grande a piacere_ presente nel grado 2 sia differente dal concetto di _infinite volte_ nel grado.

Gli esempi seguenti rappresentano delle situazioni verosimili riguardanti la vitalità delle transizioni:
- __grado 0__: qualunque cosa accada _la centrale nucleare non può esplodere_;
- __grado 1__: in un certo momento se si assume il controllo di tutto ciò che avverrà _è possibile portare la centrale nucleare allo spegnimento_;
- __grado 2__: Duccio, ingegnere della centrale nucleare che si trova in coffee break, è in grado di interagire con la macchinetta del caffé appena accesa in modo da avere un numero di caffé _grande a piacere_, almeno finchè qualcuno non inserisce una moneta nella macchinetta;
- __grado 3__: Biascica, guardia giurata della centrale, è in grado di fare alzare la sbarra per il parcheggio _un numero infinito di volte_;
- __grado 4__: se succede qualcosa fuori dal controllo all'interno della centrale si può comunque riuscire ad eseguire lo spegnimento (René urla _"chiudi tutto, Duccio!"_).

Una rete viene chiamata __viva__ quando tutte le sue transizioni sono vive.

### Esempio

{% responsive_image path: 'assets/14_esempio-vitalita-transizioni.png' %}

- Da questo esempio pratico è possibile notare come la transizione $$t_0$$ è di **grado 0** in quanto non potrà mai scattare, perchè è impossibile che abbia i gettoni necessari nel preset per scattare (al massimo o in $$p_0$$ o in $$p_1$$).
- La transizione $$t_1$$ è di **grado 1** perchè esiste almeno una marcatura raggiungibile per cui essa scatti, infatti la marcatura corrente è quella che ne _permette_ lo scatto (ricordando ancora che se una transizione è abilitata allo scatto non significa che debba scattare).
- Osservando la transizione $$t_3$$ è possibile notare che essa scatti infinite volte (e non $$n$$ grande a piacere, quindi non si tratta di una transizione di grado 2), ma nel caso avvenga lo scatto di $$t_1$$ la transizione $$t_3$$ non potrà mai più essere abilitata (quindi esiste una marcatura in cui non sarà possibile il suo scatto) garantendo che non si tratta di una transizione di grado 4, ma bensì di **grado 3**.
- Il caso più particolare è quello della transizione $$t_2$$: è noto che $$t_3$$ può scattare infinite volte e quindi in $$p_2$$ possono esserci infiniti gettoni; inoltre, conseguentemente allo scatto di $$t_1$$ il posto $$p_1$$ conterrà un gettone, ma comunque la transizione $$t_2$$ non può scattare infinite volte.
Questo perchè è vero che all'infinito posso generare gettoni in $$p_2$$, ma dal momento che scatta $$t_1$$ si perde questa possibilità, permettendo a $$t_2$$ di scattare tante volte quanti sono i gettoni in $$p_2$$. 
La transazione è quindi di **grado 2**.
- Infine $$t_4$$ è una transizione viva (di **grado 4**), perchè qualunque sia la marcatura raggiungibile dalla marcatura corrente è possibile prendere il controllo e sicuramente esiste una sequenza di scatti tale per cui $$t_4$$ diventi abilitata.

## Capacità dei posti 

Inizialmente è stato detto che esistono diversi dialetti riguardanti le reti di Petri.
Una possibile estensione consiste infatti nel fissare una **capacità massima** rispetto al numero di gettoni ammissibili in un posto.
Un esempio potrebbe essere quello in cui in un sistema possono essere presenti $$k$$ lettori contemporaneamente e non più di $$k$$.
Avendo la possibilità di definire una capacità dei posti, è facile intuire che diventa possibile _forzare la limitatezza della rete_.

Tale estensione aumenta la potenza espressiva oppure è semplicemente una scorciatoia?
Tramite l'esempio sottostate si può notare che questa estensione non è altro che una tecnica per facilitare la scrittura della rete.

{% responsive_image path: 'assets/14_simulazione-capacita-posti.png' %}

Nella rete con capacità dei posti limitata per far sì che ad esempio la transizione $$t_0$$ scatti, è necessario sia che i posti nel suo preset abbiano gettoni sufficienti sia che dopo il suo scatto il posto $$p_0$$ non superi il limite assegnatogli.
Volendo scrivere la stessa rete utilizzando il metodo classico visto fino ad ora basta aggiungere un __posto complementare__ che quindi rende le reti __equipollenti__, ossia aventi lo stesso valore espressivo.

Fino a che nel posto complementare esistono dei gettoni, la transizione $$t_0$$ può infatti scattare; dal momento però che tutti i gettoni di $$p_0(\text{compl})$$ vengono bruciati, $$t_0$$ non sarà più abilitata e nel posto $$p_0$$ ci sarà il numero massimo di gettoni possibili.
Notare come la somma dei gettoni del posto considerato sia esattamente la capacità massima scelta in precedenza.

Questa proprietà vale solo per le reti __pure__, ovvero _le reti che_ ___per ogni transizione___ _hanno preset e postset disgiunti_.

### Posto complementare
Un posto complementare è un posto avente in uscita verso ognuna delle transizioni del posto considerato un **arco di ugual peso** ma di **direzione opposta**.

Matematicamente è possibile scivere questa definizione nel seguente modo: \\
un posto $$pc$$ è _complementare_ di $$p$$ se e solo se

$$
\begin{align}
\forall t \in T \: \Big [ \exists \langle p, \, t \rangle \in F &\Longleftrightarrow \exists \langle t, \, pc \rangle \in F \quad W(\langle p,\, t \rangle) = W(\langle t, \, pc \rangle) \Big ] \\
\land \
\forall t \in T \: \Big [ \exists \langle t, \, p \rangle \in F
&\Longleftrightarrow \exists \langle pc, \, t \rangle \in F \quad W(\langle pc, \, t \rangle) = W(\langle t, \, p \rangle) \Big ] .
\end{align}
$$

Per ogni transizione appartenente a $$T$$ in uscita da $$p$$, quindi tale per cui esiste una relazione di flusso dal posto $$p$$ alla transizione $$t$$ deve esistere un flusso che va dalla transizione $$t$$ al posto complementare $$pc$$ avente lo stesso peso. \\
Inoltre, per le transizioni in ingresso al posto $$p$$ (quindi per ogni transizione $$t$$ appartenente a $$T$$ in ingresso a $$p$$) tali per cui esista un flusso da $$t$$ al posto $$p$$, deve esistere un flusso che va dal posto complementare $$pc$$ a $$t$$ di direzione opposta e avente lo stesso peso.

Questa formula garantisce che la **somma** del numero di gettoni tra il posto e il suo complementare sia costante, permettendo quindi di formulare la **condizione di abilitazione** (lavorando sul preset della transizione) in modo da dipendere anche dal numero di gettoni presenti nel posto in arrivo.

### Abilitazione con capacità
Come è possibile definire la condizione di abilitazione nel caso di **reti con capacità sui posti**?

La definizione di _abilitazione_ per reti con capacità sui posti è la seguente: \\
$$t \in T$$ è __abilitata__ in $$M$$ se solo se:

$$
\begin{align*}
\forall p \in \operatorname{Pre}(t) &\quad M(p) \geq W(\langle p, t \rangle) \\
\forall p \in \operatorname{Post}(t) \setminus \operatorname{Pre}(t) &\quad M(p) + W(\langle t, p \rangle) \leq C(p) \\
\forall p \in \operatorname{Post}(t) \cap \operatorname{Pre}(t) &\quad M(p) - W(\langle p, t \rangle) + W(\langle t, p \rangle) \leq C(p).
\end{align*}
$$

Considerando l'immagine seguente, infatti, possiamo notare come la rete di sinistra abbia ancora una transazione abilitata, mentre quella di destra no.
Nella seconda rete è come se **lo scatto venisse spezzato in due fasi**: la prima in cui vengono generati i gettoni nel posto (in questo caso $$p_3$$), la seconda invece in cui vengono tolti tanti gettoni quanto è il peso dell flusso da $$p_3$$ a $$t_1$$. \\
Nella prima rete invece questo non accade, è come se si verificasse tutto nello stesso istante.

{% responsive_image path: 'assets/14_esempio-abilitazione-reti-capacita.png' %}

A questo punto, ci si potrebbe chiedere se fosse possibile generare la situazione equivalente nel caso di una rete $$\pt$$ classica: la risposta è **no**, ad eccezione del caso in cui si usano delle reti con posti complementari.
Utilizzando i __posti complementari__ è infatti possibile rappresentare **solo le _reti pure equivalenti_**, ma _non tutte le reti in generale_: finché non sono presenti archi in entrata e uscita allo stesso posto dalla stessa transizione non sorge alcun tipo di problema.

Come è possibile superare questa limitazione? 
Si possono pensare due approcci:
- si trova un altro approccio diverso dai posti complementari;
- si cerca di dimostrare che una rete non pura ha sempre una equivalente rete pura; \\
quindi, si procede a rimuovere la capacità utilizzando i posti complementari.

Entrambe le soluzioni non sono così immediate.

<!-- aggiungere esempio / marcature pure / pure-equivalenti / ecc .. -->
<!-- Si è fermato a questo punto durante la lezione, nella lezione 20 non ha spiegato ancora quale approccio utilizzare -->
## Archi inibitori

Esiste un'altra estenzione delle reti di petri in cui si utilizzano gli __archi inibitori__, ovvero degli archi che indicano la situazione in cui una transizione ha bisogno che **non siano presenti gettoni nel posto** in modo che possa essere abilitata.
Un _arco inibitore di peso $$n$$_ indica che la transazione collegata è abilitata se nel posto collegato sono presenti **meno di** $$n$$ gettoni.

In caso di **rete limitata** la **potenza espressiva** di una rete che sfrutta gli archi inibitori **non cambia**, perché esistendo un limite massimo $$k$$ di gettoni all'interno della rete sarà sufficiente creare un posto complementare contente un numero di gettoni tali per cui la somma tra quest'ultimi e i gettoni presenti nel posto considerato sia minore di $$k$$. \\
A questo punto è necessario che siano presenti due archi (uno in ingresso e uno in uscita) di peso $$k$$, in modo da permettere lo scatto della transizione solo nel caso in cui tutti i gettoni siano all'interno del posto complementare. \\
In realtà **non è necessario** che tutta la rete sia limitata, è sufficiente che il singolo posto lo sia: è necessario garantire che qualunque sia lo _stato generale_ della rete, in quel preciso posto non ci siano più di $$k$$ gettoni.

Nel caso di una rete **non limitata** invece non è sempre possibile avere una traduzione equivalente della rete di Petri: la **potenza espressiva** delle reti con gli archi inibitori **aumenta**.

Il problema degli archi inibitori è che rendono **inutilizzabili** alcune **tecniche di analisi** che verranno affrontate successivamente.
<!-- *nessuno* ne sentiva la mancanza :) -->

## Eliminazione pesi sugli archi

In precedenza è stato accennato che per ogni rete avente dei pesi sugli archi è possibile crearne una **equivalente** senza pesi sugli archi (ovvero avente tutti gli archi di peso 1). \\
Per fare ciò è necessario considerare due casi distinti, ovvero quello con peso sugli archi in **ingresso ad una transizione** e quello con peso sugli archi **in uscita** ad una traniszione.

### Pesi su archi in ingresso

Per poter effettuare questa modifica è necessario avere lo **scatto di una nuova transizione** (in quanto ovviamente non è possibile collegare due archi dallo stesso posto alla stessa transizione), ma non basta.
Dopo lo scatto di $$t_0$$ è infatti possibile che $$t_0^\text{BIS}$$ non scatti e la rete evolva senza che in $$p_1$$ ci sia il giusto numero di gettoni (problema di concorrenza).

Per risolvere questo problema si sfrutta una sorta di __lock__, ovvero un posto collegato bidirezionalmente con tutte le transizioni della rete tranne per $$t_0$$, a cui è collegato solo in ingresso, e per $$t_0^\text{BIS}$$, a cui è collegato solo in uscita.
In questo modo è come se lo scatto di $$t_0$$ sia scomposto logicamente in due parti: quando $$t_0$$ scatta viene attivato il lock in modo tale che nessun'altra transizione sia abilitata e, successivamente, lo scatto di $$t_0^\text{BIS}$$ lo rilascia.
Questo ovviamente non obbliga $$t_0^\text{BIS}$$ a scattare immediatamente, però è certo che la rete non potrà evolvere in alcun altro modo e quindi non si creeranno marcature non esistenti nella rete originale.
Questa soluzione non è molto elegante perchè esiste un posto avente in ingresso un arco per ogni transizione della rete.

{% responsive_image path: 'assets/14_eliminazione-archi-ingresso.png' %}

### Pesi su archi in uscita

In questo caso il peso da rimuovere è su un arco che esce da un posto ed entra in una transizione, quindi è necessario che vengano **distrutti due gettoni** dallo stesso scatto. \\
L'approccio da utilizzare è simile: è infatti presente un **posto globale** che fa da **lock** in modo da risolvere il problema di concorrenza tra $$t_8$$ e $$t_1$$.
In questo caso però è presente un ulteriore problema, ovvero al momento dello scatto di $$t_8$$ il gettone in $$p_0$$ viene consumato, di conseguenza $$t_1$$ non può scattare. Inoltre il resto della rete rimane bloccata, in quanto all'interno del posto globale non è più presente il gettone che è stato consumato sempre dallo scatto di $$t_8$$. \\
Questo **deadlock** può essere risolto aggiungendo un controllo sul posto $$p_0$$, in modo tale che possa scattare solo quando possiede due o più gettoni: in questo modo non può verificarsi la situazione in cui $$t_8$$ scatti senza un successivo scatto di $$t_1$$.

Il meccanismo della rete inizia ad essere **molto complesso**; nell'esempio viene mostrato solo il caso in cui devono essere consumati due gettoni.
In altri casi con più gettoni, o con situazioni differenti, la rete aumenterebbe ulteriormente di complessità. 
Risulta quindi più facile pensare la rete in modo differente.

La tenica descritta sopra non è infatti l'unica esistente per modellare il sistema: nonostante possa essere adatta per questo particolare esempio, è comunque possibile trovarne un'altra per modellare una rete senza fruttare i pesi o una loro **traduzione meccanica**.

{% responsive_image path: 'assets/14_eliminazione-archi-uscita.png' %}

### Reti $$\mathcal{C/E}$$
Le reti $$\mathcal{C/E}$$ (condizioni eventi) sono delle particolari reti **più semplici**, in cui tutti gli archi hanno **peso uno** e tutti i posti hanno capacità massima uno.
A prima vista, questo tipo di rete può risultare poco modellabile, ma è in realtà più semplice ed immediata da capire: infatti _i posti rappresentano delle condizioni_ che possono essere __vere__ o __false__ ed in base ad esse è possibile il verificarsi di certi eventi, rappresentati dalle transizioni.
Ogni rete $$\pt$$ __limitata__ è **traducibile** in un'equivalente rete $$\mathcal{C/E}$$. \\
Per le reti illimitate non è invece possibile trovare una traduzione, siccome non si possono rappresentare infiniti stati con un tipo di rete che per definizione è limitata.

## Conservatività 
La conservatività è una proprietà di una rete rispetto ad una funzione $$H$$ che assegna un peso ad ogni posto della rete, e ognuno di questi pesi è positivo. \\
Esiste quindi una **funzione di pesi** $$H: P \rightarrow \mathbb N \setminus \{ 0 \}$$ tale per cui una rete $$\pt$$ con una marcatura $$M$$ si dice __conservativa rispetto ad $$H$$__ se e solo se:

$$
\forall M' \in R(\pt, \, M) \quad \sum_{p \in P} H(p) M'(p) = \sum_{p \in P} H(p) M(p).
$$

Ovvero, per ogni marcatura $$M'$$ raggiungibile dalla marcatura iniziale data una certa marcatura e una funzione $$H$$, si dice che la rete è conservativa se la sommatoria dei gettoni di ogni posto (quest'ultimi pesati attraverso la funzione $$H$$) è _**costante** per qualunque marcatura raggiungibile_.

### Conservatività $$\Rightarrow$$ limitatezza

Esiste inoltre un **legame** tra **conservatività** e **limitatezza**, ovvero _una rete che garantisce la conservatività è limitata, ma non è detto il viceversa_ (quindi _la limitatezza è una condizione necesaria ma non sufficiente per la conservatività_).

#### Dimostrazione

Assumendo che $$\sum_{p \in P} H(p) M(p)=k$$, allora

$$
\forall M' \in R(\pt, \, M) \quad \sum_{p \in P} H(p) M'(p) = k.
$$

Sapendo inoltre che $$\forall p \in P \quad H(p) > 0$$, allora ogni elemento della sommatoria ha un **contributo nullo o positivo**.
Infatti, se non ci sono gettoni all'interno del posto il contributo della sommatoria sarà un numero positivo ($$H(p)$$) moltiplicato per 0, quindi nullo. 

Quindi, se esiste almeno una marcatura di $$p$$ cui numero di gettoni è diverso da 0, il suo contributo è positivo ma limitato da $$k$$.
Questo vale per ogni posto all'interno della rete, riconducendosi di conseguenza alla definizione di <a href="#limitatezza">limitatezza</a>.
<span markdown="1" style="float: right;">$$\blacksquare$$</span>

### Rete strettamente conservativa
La _conservatività stretta_ è un particolare caso di conservatività definibile come segue: una rete $$\pt$$ conservativa rispetto alla funzione $$H$$ che assegna pesi tutti uguali a 1 si dice _strettamente conservativa_.

$$
\forall M' \in R(\pt, \, M) \quad \sum_{p \in P} M'(p) = \sum_{p \in P} M(p).
$$

La sommatoria del numero di gettoni per ogni posto in una _qualsiasi marcatura_ è **costante**, ovvero è uguale alla sommatoria dei gettoni della marcatura iniziale per ogni posto. 
In altre parole, dopo lo scatto di una transazione viene forzata la **distruzione del gettone in ingresso** e la **generazione di un'altro in uscita**. 

Matematicamente questo concetto si può esprimere anche tramite questa espressione:

$$
\forall t \in T \quad \sum_{p \in \operatorname{Pre}(t)} W(\langle p, \,  t \rangle) = \! \sum_{p \in \operatorname{Post}(t)} \! W(\langle t, \, p \rangle)
$$

Per ogni transizione $$t$$ la somma dei pesi degli archi che collegano ogni elemento del preset di $$t$$ alla transizione $$t$$ deve essere uguale alla sommatoria dei pesi degli archi che collegano la transizione $$t$$ con ogni posto nel postset di $$t$$.

Le due espressioni sopra esprimono lo stesso concetto, ma la prima si riferisce alle **marcature** (stati) analizzando dinamicamente calcolando gli stati raggiungibili mentre l'altra all'**aspetto topologico** della rete (ovvero i pesi degli archi).

Si precisa che per quanto riguarda la seconda formula, le espressioni da considerare sono quelle __non morte__ (di grado $$\geq 1$$).
La seconda è anche più generale rispetto alla prima, ma potrebbe erroneamente considerare **non** strettamente conservative reti che **invece lo sono**.

## Stato base e rete revertibile
Una marcatura $$M'$$ si dice __stato base__ di una rete se per ogni marcatura $$M$$ in $$R(M_0)$$, $$M'$$ è raggiungibile da $$M$$, ovvero _qualunque_ sia lo stato attuale della rete è **sempre possibile** raggiungere la marcatura $$M'$$.

Quando la marcatura iniziale $$M_0$$ è lo stato base della rete per ogni marcatura $$M$$ in $$R(M_0)$$ allora la rete si dice __reversibile__, ovvero lo stato iniziale è uno stato base.
