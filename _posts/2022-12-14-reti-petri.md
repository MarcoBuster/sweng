---
layout: post
title: "[14] Reti di Petri"
date: 2022-12-12 14:40:00 +0200
toc: true
---

# [Reti di Petri](https://www2.informatik.uni-hamburg.de/TGI/PetriNets/index.php)

In questa lezione verranno mostrate le reti di Petri come esempio di linguaggio formale; fin dall'inizio del corso è stato possibile apprendere come l'ingegneria del software si occupi di linguaggi e comunicazione.
Infatti partendo dai processi, che sfruttano un linguaggio poco formale e con poca terminologia tecnica (ad esempio le user story), passando per la progettazione in cui è stato utilizzato un linguaggio più rigoroso, si arriva infine a un vero linguaggio formale utile a raccogliere delle specifiche.
Per descrivere le reti di Petri esistono diversi modi, noi vedremo alcuni dialetti di cui uno utile a descrivere i sistemi real time (temporizzati), che avendo diverse criticità è fondamentale andare formalizzare i requisiti per ridurle al minimo.
Formalizzare e utilizzare linguaggi complessi può essere costoso, infatti questa pratica viene utilizzata quando l'applicazione può avere delle conseguenze gravi in caso di fallimento (ad esempio un software per gestire un razzo spaziale se dovesse avere dei problemi potrebbe causare molti danni, economici e non solo);
Quindi bisogna almeno garantire la safety prima di mettere in funzione il software.

Le reti di Petri sono in parte simili agli automi a stati finiti, ma nascono specificatamente per descrivere sistemi concorrenti.
Cambiano però il concetto di stato e transizione, in quanto lo __stato__ non è più un'informazione atomica vista a livello di sistema ma è divisa in tante parti diverse, e la sua composizione avverrà tramite la visione generale di tutti questi stati parziali.
Quindi sarà rappresentare entità distinte, avente ognuna un suo stato, ma allo stesso tempo avere un'evoluzione globale del sistema.
Di conseguenza le __transazioni__ non operano sullo stato globale ma si limitano a variarne una parte, da ciò è possibile notare la differenza con gli automi a stati finiti in cui esisteva un unico stato attivo, e gli stati disponibili erano dati dal prodotto cartesiano di tutti i possibili valori delle diverse entità.

## Definizione informale
Un vantaggio delle reti di Petri è che possono essere viste in maniera informale dal cliente, infatti è facile definire una rete di Petri in cui i nodi sono _posti_ e _transizioni_, collegati tra loro tramite degli archi.
Possiamo quindi dire che questa struttura è un grafo bipartito, ovvero un grafo in cui i nodi sono messi in relazione __solo__ con nodi dell'altro tipo, quindi i posti possono essere collegati soltanto a transizioni e viceversa.
Ai posti sono assegnati dei ___token___, ovvero degli elementi che vengono assegnati ai posti.
Ogni posto può contenere da 0 a un numero potenzialmente infinito di token (successivamente si approfondirà questo punto per capire se ha senso o no assegnare infiniti gettoni a un posto), ed è proprio la disposizione di questi gettoni nella rete a determinarne il suo stato complessivo.

{% responsive_image path: 'assets/14_rete-Petri-informale.png' %}

Essendo che i gettoni determinano lo stato di ogni parte della rete, allora sicuramente il loro assegnamento ai posti può cambiare, questo perché lo stato della rete può evolvere.
Ciò accade tramite la trasformazione effettuata dalla transizione; possiamo quindi dire che una transizione è _abilitata_ quando all'interno dei posti collegati in ingresso a essa esistono un certo numero di gettoni.
Inoltre una transizione abilitata si dice che __scatta__ (fire) quando consuma i gettoni nei posti in ingresso e ne vengono generati altri nei posti collegati in uscita.
È importante notare come i gettoni __non si spostano__ da un posto a un altro conseguentemente a uno scatto, ma vengono proprio __distrutti__ nei posti in ingresso alla transizione e __generati__ nei posti in uscita.
Quest'ultima considerazione è importante per capire che i gettoni non sono sempre nello stesso numero.

Tramite questa struttura è facile mostrare al cliente quando qualcosa cambia all'interno del sistema, quindi è molto utile perché risulta essere più intuitivo rispetto a un linguaggio logico e descrittivo.
Questo è il vantaggio dei __modelli operativi__ come questo, la cui pecca però è che oltre a descrivere che cosa fa il sistema da informazioni anche su come lo fa, quindi rischia di diventare una via di mezzo tra una specifica ed un oggetto di design.
Il motivo per cui è possibile chiamarla specifica è che non viene effettivamente detto come il sistema deve svolgere il suo compito ma si deve comportare nello stesso modo descritto. <!-- Questa frase può essere scritta meglio -->
Quindi la rete descritta è una macchina di riferimento da utilizzare come confronto per capire se il funzionamento del sistema finale si comporta come dovrebbe (si può quindi dire che è come se fosse un oracolo).

## Definizione matematica

Di reti di Petri ne esistono numerosi dialetti, in questo caso vediamo le __PT net__ (reti con posti e transizioni) che sono le più classiche, successivamente verranno descritte delle estensioni e riduzioni di queste reti.

Una rete di Petri classicamente è una 5-tupla $$[P, \, T; \; F, \, W, \, M_0]$$:
- $$P$$ è l'insieme degli identificatori dei posti;
- $$T$$ è l'insieme degli identificatori delle transizioni;
- $$F$$ è la relazione di flusso;
- $$W$$ è una funzione che associa un peso ad ogni flusso; 
- $$M_0$$ è la marcatura iniziale, ovvero l'assegnamento iniziale dei _gettoni_.

Da notare che P e T a livello matematico sono degli insiemi di identificatori che non si sovrappongono (ovvero sono tutti entità differenti) a cui poi verrà assegnato un significato, quindi precedentemente sono stati associati a posti e transizioni, ma di fatto sono tutti identificatori.

Data la 5-tupla appena descritta esistono le seguenti proprietà:
- $$P \cap T = \varnothing$$; 
- $$P \cup T \neq \varnothing$$ (una rete in cui non c'è nulla non è una rete, almeno un posto o una transizione ci devono essere);
- $$F \subseteq (P \times T) \cup (T \times P)$$;
- $$W: \: F \rightarrow \mathbb N - \{ 0 \}$$;
- $$M_0: P \rightarrow \mathbb N$$.

Utilizziamo alcune _scorciatoie_:
- $$\operatorname{Pre}(a) = \{ d \in (P \cup T) \ \text{t.c.} \ \langle d, \, a \rangle \in F \}$$;
- $$\operatorname{Post}(a) = \{ d \in (P \cup T) \ \text{t.c.} \ \langle a,\, d \rangle \in F \}$$.

esplicitando queste ultime due scritture:
- Il preset di un nodo _a_ è un insieme di quegli elementi _d_ appartenenti all'unione degli insiemi degli identificatori di posti e transizioni tali che esiste una relazione di flusso tra _d_ e _a_ appartenente a F, in sostanza questo insieme rappresenta l'insieme degli identificatori precedenti di _a_ <!-- al posto di precedenti si può mettere antecedenti -->
- Il postset di un nodo _a_ è un insieme di quegli elementi _d_ appartenenti all'unione degli insiemi degli identificatori di posti e transizioni tali che esiste una relazione di flusso tra _a_ e _d_ appartenente a F, in sostanza questo insieme rappresenta l'insieme degli identificatori successivi di _a_ <!-- al posto di precedenti si può mettere conseguenti, anche se forse è un po brutto -->

Tutto questo rappresente la parte statica delle reti di Petri, ovvero prendendo la situazione in un preciso istante, senza considerare i cambiamenti che potrebbero avvenire.

### Comportamento dinamico

Una transizione $$t \in T$$ è __abilitata__ in una particolare marcatura $$M$$, ovvero dato un particolare assegnamento di gettoni (marcatura iniziale oppure una sua evoluzione) se e solo se

$$
\forall p \in \operatorname{Pre}(t) \quad M(p) \geq W( \langle p, \, t \rangle )
$$

In notazione, `M [ t >` significa che $$t$$ è abilitata in $$M$$. 

Significa che per ogni elemento collegato in ingresso a t esiste un numero di gettoni maggiore del peso dell'arco che collega $$p$$ a $$t$$.
Un aspetto interessante di questa definizione è che non si sta ragionando su tutti i posti della rete, ma solo su quelli collegati in ingresso a _t_, di conseguenza non è necessario conoscere l'intera rete per poter affermare che una transizione sia abilitata o meno, ma basta controllare la zona che comprende i posti appartenenti a $$ \operatorname{Pre}(a) $$, questa situazione è chiamata __località dell'analisi__.

Lo __scatto__ di una transizione $$t \in T$$ in una particolare marcatura $$M$$, produce nel momento successivo una nuova marcatura $$M'$$ tale per cui

$$
\begin{align*}
\forall p \in \operatorname{Pre}(t) - \operatorname{Post}(t)& \quad M'(p) = M(p) - W(\langle p, \, t \rangle) \\
\forall p \in \operatorname{Post}(t) - \operatorname{Pre}(t)& \quad M'(p) = M(p) + W(\langle t, \, p \rangle) \\
\forall p \in \operatorname{Post}(t) \cap \operatorname{Pre}(t)& \quad M'(p) = M(p) - W(\langle p, \, t \rangle) + W(\langle t, \, p \rangle) \\
\forall p \in P - \left ( \operatorname{Post}(t) \cap \operatorname{Pre}(t) \right )& \quad M'(p) = M(p)
\end{align*}
$$

<!-- L'ultimo elemento di questa lista di formule non viene allineato bene non so per quale motivo -->

specificando in modo descrittivo le notazioni precedenti:
- Per ogni identificatore $$p$$ appartenenti al preset ma non al postset della transizione in esame, il numero di gettoni della nuova marcatura $$M'$$ sarà uguale al numero di gettoni della marcatura precedente $$M$$ meno il peso dell'arco che collega $$p$$ a $$t$$;
- Per ogni identificatore $$p$$ appartenenti al postset ma non al preset della transizione in esame, il numero di gettoni della nuova marcatura $$M'$$ sarà uguale al numero di gettoni della marcatura precedente $$M$$ più il peso dell'arco che collega $$p$$ a $$t$$;
- Per ogni identificatore $$p$$ appartenenti sia al preset sia al postset della transizione in esame, il numero di gettoni della nuova marcatura $$M'$$ sarà uguale al numero di gettoni della marcatura precedente $$M$$ meno il peso dell'arco che collega $$p$$ a $$t$$ più il peso dell'arco che collega $$t$$ a $$p$$;
- Per ogni identificatore $$p$$ appartenenti all'insieme dei posti meno l'intersezione tra preset e postset di $$p$$ la marcatura non cambia.

In notazione, `M [ t > M'` significa che lo scatto di $$t$$ in $$M$$ produce $$M'$$.

È importante notare come una transizione può scattare nel caso in cui non abbia alcun elemento nel suo preset, questo significa che la transizione in questione non possiede prerequisiti per scattare.

## Da FSM a rete di Petri

È _meccanicamente_ possibile trasformare una macchina a stati finiti in una rete di Petri.

{% responsive_image path: 'assets/14_produttore.png' %}

Riferendosi all'esempio produttore, l'unico problema è che ci sono dei collegamenti diretti tra posti, ma come è stato detto in precedenza questo non è possibile in una rete di Petri, di conseguenza basterà interporre tra i posti delle transizioni per avere una rete di Petri valida.
Immaginando di mettere un solo token in uno dei due posti della rete appena creata, questo indicherà lo stato attivo che avevamo nella macchina a stati finiti.
Seguendo questi passaggi diventa banale mappare una macchina a stati finiti su una rete di Petri, quindi applicandoli anche all'esempio del consumatore e del buffer avremo altre due reti valide.

{% responsive_image path: 'assets/14_consumatore-buffer.png' %}

Componendole, andranno a creare la seguente rete di Petri.

{% responsive_image path: 'assets/14_produttore-consumatore-buffer.png' %}

A questo punto se stessimo parlando di automi a stati finiti per trovare gli stati raggiungibili da quest'ultima composizione sarebbe stato necessario fare il prodotto cartesiano tra gli stati delle altre tre macchine a stati finiti ricavate precedentemente.
In questo caso però siamo davanti ad una rete di Petri, quindi basterà fondere tutti gli identificatori uguali (ad esempio la transizione deposita della reteproduttore e della rete buffer) e aggiungere i collegamenti che possedevano.

<span style="Color: red">__ATTENZIONE__</span>: nell'esempio della rete composta le transizioni "preleva" e "deposita" dovrebbero avere due nomi differenti, ma siccome sono indicate con due rettangoli diversi è stato omesso questo partivolare, matematicamente però devono avere due nomi differenti.

Precedentemente è stato detto che il con un token nella rete si andava a rappresentare lo stato attivo, di conseguenza portando all'interno della rete composta tutti i token delle varie reti si arriva ad ottenere un risultato descritto dall'immagine sopra, in cui tutte le "entità"mantengono la propria individualità.
Quindi in questo caso si può notare che il produttore è pronto a produrre, il buffer è vuoto e il consumatore è pronto a consumare una volta che il buffer avrà al suo interno qualcosa.

### Come evolve questa rete?
Per rispondere a questa domanda la prima cosa da considerare è quali sono le transizioni abilitate, che in questo caso è solo la transizione produci sotto a $$p_0$$, in quanto è l'unica ad avere tutti gli elementi del suo preset con un numero di gettoni necessari a farla scattare, infatti $$p_0$$ possiede un gettone e l'arco ha peso 1 (quando non è specificato il peso è 1).
Una rete di Petri non forza lo scatto di alcuna transizione, quindi volendo si potrebbe rimanere nello stato corrente senza far scattare "produci" all'infinito, però se scatta il risultato è che il gettone in $$p_0$$ viene bruciato, e in $$p_1$$ viene generato un nuovo token.

{% responsive_image path: 'assets/14_primo-scatto.png' %}

Dopo questo scatto la rete di Petri si trova in una situazione in cui il produttore ha prodotto qualcosa, ed è pronto a depositarlo nel buffer, e a questo punto non resta che porsi nuovamente la domanda "quali transizioni sono abilitate?" per capire come può procedere l'evoluzione della rete.
È facile notare come la transizione "deposita" sotto $$b_0$$ sia l'unica abilitata, e di conseguenza se dovesse scattare il risultato sarebbe il seguente.

{% responsive_image path: 'assets/14_secondo-scatto.png' %}

Ora è possibile identificare una situazione particolare, ovvero quella in cui le transizioni pronte a scattare sono due, e la domanda sorge spontanea, ovvero "quale delle due transizioni scatta prima?".
Nelle reti di Petri descritte fino ad ora non è stato presentato lo scatto simultaneo delle transizioni, nulla vieta che possa avvenire in un contesto reale, ma in questo caso non è una solizione ammissibile, quindi quale delle due transizioni scatta per prima? e secondo quale criterio?
Questo è un caso di non determinismo, ovvero non posso dire quale transizione deve scattare, quindi abbiamo 3 situazioni che si possono verificare:
- viene attivata la prima transizione;
- viene attivata la seconda transizione;
- non viene attivata nessuna transizione (la _non evoluzione_ è comunque un'evoluzione).

Nel caso in cui fosse stato necessario definire che una delle due transizioni scattasse prima dell'altra, ci si troverebbe di fronte ad una rete non corretta, in quanto sarebbe possibile modificare la rete in modo tale che imponga un ordine di scatto alle transizioni. <!-- forse si potrebbe scrivere meglio -->

### Sfruttare le reti di Petri
A questo punto è possibile chiedersi se si stiano sfruttando realmente tutte le potenzialità delle reti di Petri, siccome la rete dell'esempio precedente è stata ricavata da un automa a stati finiti.
Per capire ciò è possibile osservare un secondo esempio in cui abbiamo una rete alternativa alla precedente, ma con lo stesso scopo.

{% responsive_image path: 'assets/14_rete-alternativa.png' %}

La differenza che salta subito all'occhio è il numero di gettoni presenti all'interno di $$p_0$$, e stanno ad indicare il numero di posizioni libere nel buffer.
Questo è un vantaggio perché se dovessimo cambiare lo scenario e avere una situazione in cui il buffer passa da avere capienza due, ad avere capienza 20, sfruttando questa rete basta modificare la marcatura di $$b_0$$ e il problema sarebbe risolto, la rete precedente invece avrebbe bisogno di una pesante modifica per essere adattata.
Di conseguenza si può applicare lo stesso concetto per il consumatore e per il produttore, che aumentandone il numero dei gettoni (rispettivamente in $$p_0$$ e $$c_0$$) aumenterebbe il numero di entità in grado di produrre e consumare.

{% responsive_image path: 'assets/14_rete-alternativa-diverse-entità.png' %}

È possibile affermare quindi che cambiando il numero di gettoni è possibile moltiplicare gli elementi del sistema di cui si vuole tracciare l'evoluzione, e questo sarebbe molto oneroso in termini di dimensioni se fosse stato fatto con una macchina a stati finiti.

Per definizioni le macchine a stati finiti __non__ possono rappresentare situazioni _infinite_, quindi se si volesse modificare ulteriormente l'esempio appena visto imponendo una capienza illimitata al buffer, con una macchina a stati finiti non sarebbe possibile.
Con le reti di Petri invece basterebbe eliminare l'identificatore del posto $$b_0$$, in questo modo avremmo una situazione in cui i produttori possono depositare senza limiti all'interno del buffer, mentre i consumatori non potrebbero prelevare più elementi di quelli presenti nel buffer.
Questo vincolo è imposto dalla marcatura di $$b_1$$, infatti, la transizione "preleva" potrebbe scattare al massimo _n_ volte consecutivamente, dove _n_ è la marcatura di $$b_1$$ (assumendo che nel metre non avvengano depositi da parte dei produttori).

Un altra modifica applicabile all'esempio sfrutta i pesi degli archi, ovvero ponendo un peso di 3 all'arco che collega "deposita" a $$b_1$$ si potrebbe dire che il produttore crea e deposita tre prodotti, occupando tre posizioni nel buffer.
Invece ponendo un peso di 2 all'arco che collega $$b_1$$ a "preleva" si specifica che vengono prelevati dal buffer due elementi alla volta.
Questo esempio, in parte forzato, è utile per chiarire il fatto che nelle reti di Petri gli archi non sono semplici collegamenti, ma è possibile attribuirgli un significato.
Infatti informalemente sono chiamati archi, ma in realtà indicano una relazione che coinvolge due identificatori, e in questo esempio esiste una relazione per cui ogni elemento prodotto occupa tre posizioni all'interno del buffer, e un'altra relazione in cui ogni consumatore può prelevare obbligatoriamente due elementi alla volta.
Tramite il peso degli archi è possibile creare delle situazioni ambigue, ad esempio se la relazione che coinvolge "deposita" e $$p_0$$ avesse un peso di 2, ogni volta che viene prodotto qualcosa i produttori si moltiplicherebbero, e ovviamente questa situazione indicherebbe che la rete è sbagliata, quindi è necessario fare attenzio ad evitare queste strane situazioni.

{% responsive_image path: 'assets/14_archi-con-pesi.png' %}

## Relazioni

Di seguito verranno elencati dei tipi di relazioni che possono coinvolgere i diversi identificatori e cosa comporta la loro presenza.

### Sequenza

Una transazione $$t_1$$ è __in sequenza__ con una transizione $$t_2$$ in una marcatura $$M$$ se e solo se

$$M \ [ \ t_1 > \land \ M \ [ \ t_2 > \land \ M \ [ \ t_1 t_2 >$$

Questa formula sta ad indicate:
- $$t_1$$ è abilitata in $$M$$;
- $$t_2$$ NON è abilitata in $$M$$;
- $$t_2$$ viene abilitata dallo scatto di $$t_1$$ in $$M$$

in questo caso abbiamo una relazione d'ordine non simmetrica, in cui lo scatto di $$t_1$$ è una condizione succificente per cui $$t_2$$ possa scattare, quindi questo tipo di relazione permette di andare a creare un ordine di scatto delle transizioni.
Condizione sufficiente perché osservando l'esempio sottostante è facile capire che lo sacatto di $$t_0$$ non è necessario per far si che $$t_2$$ scatti, infatti anche se dovesse avvenire lo scatto di $$t_2$$ la transizione $$t_2$$ diventerebbe comunque abilitata.

{% responsive_image path: 'assets/14_sequenza.png' %}

### Conflitto

Due transazioni $$(t_1, \, t_2)$$ sono in:
- __conflitto strutturale__ se e solo se $$\operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) \neq \varnothing $$
- __conflitto effettivo__ in una marcatura $$M$$ se e solo se:
    - $$M \ [ \ t_1 > \cap \ M \ [ \ t_2 > $$;
    - $$\exists p \in \operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) \mid (M(p) < W(\langle p, \, t_1 \rangle) + W(\langle  p, \, t_2\rangle))$$.

Analizzando i due tipi di conflitto è possibile notare che:
- due transizioni sono in conflitto strutturale se l'interesezione dei due preset è vuota, quindi non hanno posti in ingresso in comune, e di conseguenza non possono interferire tra loro per quanto riguarda le condizioni di abilitazione.
Il conflitto strutturale dipende solo dalla topologia dela rete, infatti non vengono citate le marcature;
- due transizioni sono in conflitto effettivo se sono entrambe abilitate in una marcatura $$M$$ ed esiste un posto in ingresso in comune ai due preset tale per cui il numero di gettoni in quel posto è minore della somma dei pesi dei due flussi che vanno dal posto alla transizione (quindi il posto in ingresso non ha abbastanza gettoni per far scattare entrambe le transizioni).
Quindi entrano in conflitto sulla disponibilità di gettoni nel preset.

Esiste una versione rilassata del conflitto, ed è esplicitata dalla seguente formula:

$$
M \ [ \ t_1 > \land \ M \ [ \ t_2 > \land \ \lnot M \ [ \ t_1 t_2 > 
$$

Andandola ad analizzare il suo significato è che $$t_1$$ e $$t_2$$ sono abilitate in una marcatura $$M$$ e non è possibile la sequenza $$t_1$$ $$t_2$$ a partire da $$M$$.
Ma cosa vuol dire che è una versione rilassata? per capirlo si osservi questo l'esempio sottostante:

{% responsive_image path: 'assets/14_esempio-conflitto1.png' %}

Questa prima versione rimane in conflitto secondo la prima e la seconda definizione, ma facendo una piccola modifica è facile fare in modo che il conflitto rimanga per la prima definizione ma non per la seconda.

{% responsive_image path: 'assets/14_esempio-conflitto1-differenza.png' %}

Aggiungendo una relazione tra $$t_1$$ a $$p_1$$ è facile notare che dopo lo scatto di $$t_1$$ quest'ultima è ancora abilitata, e quindi la seconda definizione non è più rispettata.
Da questo possiamo capire che la prima definizione si basa solo sui preset, ignorando qualsiasi arco in uscita, invece la seconda ragiona anche sugli effetti dello scatto, ma allora perchè viene usata la prima definizione solitamente?
Perché denota come le transizioni non possiedono abbastanza risorse per scattare entrambe nello stesso istante, ma solo in momenti diversi e a seguito di uno scatto hanno questa capacità, quindi di fatto è possibile vederli come due conflitti differenti. <!-- Verificare se questa parte è abbastanza chiara -->

È possibile fare qualche ulteriore osservarione riguardo alla relazione di conflitto, ovvero la presenza di un conflitto strutturale __non implica__ obbligatoriamente la presenza di un conflitto effettivo in quanto quest'ultimo per esistere necessita che venga soddisfatta una condizione in più.
Al contrario invece un conflitto effettivo __implica__ la presenza di un conflitto strutturale in qunato le condizioni di quest'ultimo sono comprese in quelle del conflitto effettivo.
Di seguito viene mostrato un esempio di conflitto effettivo e strutturale.

{% responsive_image path: 'assets/14_conflitto-effettivo-e-strutturale.png' %}

### Concorrenza

La relazione di concorreza è possibile considerarla la relazione opposta alla relazione di conflitto, quindi due transazioni $$(t_1, \, t_2)$$ sono in:
- __concorrenza strutturale__ se e solo se $$\operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) = \varnothing$$
- __concorrenza effettiva__ in una marcatura $$M$$ se e solo se:
    -  $$M \ [ \ t_1 > \cap \ M \ [ \ t_2 > $$;
    - $$\forall p \in \operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) \quad (M(p) \geqslant W(\langle p, \, t_1 \rangle) + W(\langle  p, \, t_2\rangle))$$.

Quest'ultima formula sta a significare che due identificatori delle transizioni sono in concorrenza effettiva che se e solo se per tutti i posti che hanno in comune ci sono un numero di gettoni sufficienti per farle scattare entrambe.

In questo caso non esiste alcun legame tra concorrenza strutturale ed effettiva, diversamente da quanto abbiamo visto in precedenza per le relazioni di conflitto.
Infatti se si verificano le condizioni per avere una concorrenza strutturale è __possibile__ che le due transizioni non siano abilitate, oppure se si verificano le condizioni per avere concorrenza effettiva è __possibile__ che $$t_1$$ e $$t_2$$ abbiamo posti in comune, e quindo sarebbe impossibile avere concorrenza strutturale.
<!-- verificare quest'ultima parte perché non sono sicuro di aver scritto giusto -->
Questo però non esclude il fatto che sia possibile avere concorrenza strutturale ed effettiva contemporaneamente, infatti di seguito sono riportati degli esempi che confermano ciò.

{% responsive_image path: 'assets/14_esempio-concorrenza.png' %}

Ovviamente è anche possibile che non ci sia alcun tipo di concorrenza, è sufficiente che due transizioni abbiano in comune un posto una delle due non sia abilitata.

## Insieme di raggiungibilità 

L'insieme di raggiungibilità $$R$$ di una rete a partire da una marcatura $$M$$ è il più piccolo insieme di marcature tale che:
- $$M \in R(P/T, \, M)$$;
- $$(M' \in R(P/T, \, M) \land \exists t \in T \ M' [t> M'') \Rightarrow M'' \in R(P/T, \, M)$$.

Questa definizione induttiva viene interpretata nel seguente modo:
- passo base $$\rightarrow$$ la marcatura $$M$$ appartiene all'insieme di raggiungibilità $$R(P/T, \, M)$$ ($$M$$ indica la marcatura iniziale mentre $$P/T$$ indica la rete posti-transizioni);
- passo induttivo $$\rightarrow$$ se $$M'$$ appartiene all'insieme di raggiungibilità (quindi si dice che è raggiungibile) ed esiste una transizione della rete tale per cui è abilitata in $$M'$$ e mi porta in $$M''$$, per cui con uno scatto è possibile passare dalla marcatura $$M'$$ alla marcatura $$M''$$, allora quest'ultima è __raggiungibile__.

procedendo ricorsivamente con questa definizione è possibile ottenere tutte le marcature raggiungibili.

## Limitatezza

Una proprietà importante delle reti di Petri è la __limitatezza__, ovvero la proprietà che indica se le possibili evoluzioni della rete possono essere limitate o illimitate, quindi se gli stati raggiungibili sono infiniti oppure infiniti.
Volendo dare una definizione più formale è possibile dire che una rete posti-transizioni $$(P/T)$$ con marcatura $$$M$$ si dice __limitata__ se e solo se:

$$\exists k \in \mathbb N \quad \forall M' \in R(P/T, \, M) \\
\forall p \in P \quad M'(p) \leq k$$

cioè se eisite un numero $$k$$ appartenente all'insieme dei numeri naturali tale per cui per ogni marcatura $$M'$$ raggiungibile da $$M$$, per ogni posto $$p$$ all'interno della rete il numero di gettoni in quella marcatura raggiungibile è minore di $$k$$, ovvero se è possibile porre un numero finito tale per cui dopo qualisasi evolizione non esista alcun posto che possiede un numero di gettoni maggiore di $$k$$, allora è possibile affermare che  la rete è limitata.
Se ciò non si verifica esiste almeno un posto in cui è possibile aumentare tendenzialmente all'infinito il numero di gettoni, tramite una certa evoluzione della rete.
È importante sottolienare che la limitatezza di una rete può dipende dalla sua marcatura iniziale.

{% responsive_image path: 'assets/14_esempio-rete-illimitata.png' %}

## Da RtP a automi

Se la rete è limitata allora l'insieme di raggiungibilità è finito allora è possibile definire un automa a stati finiti corrispondente.

- gli stati sono le possibili marcature dell'insieme di raggiungibilità
- le transizioni sono ...

## Vitalità di una transizione

Una transazione $$t$$ in una marcatura $$M$$ è detta _viva_ in..
- __grado 0__ se non è abilitata in nessuna marcatura appartanente all'insieme di raggiungibilità (è __morta__);
- __grado 1__ se esiste almeno una marcatura raggiungibil$$ in cui è abilitata;
- __grado 2__ se per ogni numero $$n$$ esiste almeno una sequenza ammissibile in cui la transizione scatta $$n$$ volte;
- __grado 3__ se esiste una sequenza di scatti ammissibile in cui scatta infinite volte;
- __grado 4__ se in qualunque marcatura raggiungibile esiste una sequenza ammissibile in cui scatta (è __viva__).

## Capacità dei posti 

Una possibile estensione delle reti di Petri consiste nel fissare un massimo numero di token ammissibili in un posto.
Si può forzare la limitatezza.

Tale estensione aumenta la potenza espressiva oppure è semplicemente una scorciatoia? 
È solo una scorciatoia, sono equipollenti.

### Posto complementare

Un posto $$pc$$ è complementare di $$p$$ se e solo se:

$$
\forall t \in T ( \exists \langle p, t \rangle \in F) \Leftrightarrow \exists \langle t,pc \rangle \in F \quad W(\langle ......... \rangle) .........
$$

### Abilitazione co ncapacità

In caso di reti con capacità sui posti la definizione di _abilitazione_ è

$$t \in T$$ è __abilitata__ in $$M$$ se e solo se 

$$
\begin{align*}
\forall p \in \operatorname{Pre}(t) &\quad M(p) \geq W(\langle p, t \rangle) \\
\forall p \in \operatorname{Post}(t) &\quad M(p) + W(\langle t, p \rangle) \leq C(p)
\end{align*}
$$

oppure si può ragionare diversamente

$$t \in T$$ è __abilitata__ in $$M$$ se solo se:

$$
\begin{align*}
\forall p \in \operatorname{Pre}(t) &\quad M(p) \geq W(\langle p, t \rangle) \\
\forall p \in \operatorname{Post}(t) \setminus \operatorname{Pre}(t) &\quad M(p) + W(\langle t, p \rangle) \leq C(p) \\
\forall p \in \operatorname{Post}(t) \cap \operatorname{Pre}(t) &\quad M(p) + W(\langle p, t \rangle) - W(\langle t, p \rangle) \leq C(p)
\end{align*}
$$

<!-- aggiungere esempio / marcature pure / pure-equivalenti / ecc .. -->

## Archi inibitori
Permettono di dire che non deve essere presente un token perché la transizione sia abilitata.

Permettono di impedire che ci siano più di $$k$$ gettoni in un posto.

In caso di rete limitata non cambia la potenza. Perché?
se sappiamo già che un posto è limitato o non ci sono più di $$k$$ gettoni generabili in ogni caso allora diventa inutile.

Un arco inibitore può avere un peso che è di fatto $$k$$ citato prima.
Normalmente il peso è 1.

## Eliminazione pesi archi

primo caso.

secondo caso.

### Reti C/E

- tutti gli archi hanno peso 1
- tutti i posti hanno capacità 1

## Conservatività 

Esiste una funzione di pesi $$H: P \rightarrow \mathbb N \setminus \{ 0 \}$$ una rete P/T con una marcatura $$M$$ si dice conservativa rispetto a tale funzione se e solo se

$$
\forall M' \in R(P/T, \, M) \quad \sum_{p \in P} H(p) M'(p) = \sum_{p \in P} H(p) M(p)
$$

relazione conservatività e limitatezza.

### Rete strettamente conservativa

Una rete P/T conservativa rispetto alla funzione che assegna pesi tutti uguale a 1 si dice _strettamente conservativa_.

$$
\forall M' \in R(P/T, \, M) \quad \sum_{p \in P} M'(p) = \sum_{p \in P} M(p)
$$

Il numero di token consumati dallo scatto di una trnaiszione è uguale al numero di gettoni generati dallo stesso

$$
\forall t \in T \quad \sum_{p \in \operatorname{Pre}(t)} W(\langle p, t \rangle) = \sum_{p \in \operatorname{Post}(t)} W(\langle t, p \rangle)
$$

t non è morta
