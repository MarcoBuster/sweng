---
layout: post
title: "[16] Reti di Petri temporizzate"
date:   2023-01-09 14:30:00 +0200
toc: true
---

# Reti Temporizzate

Abbiamo visto come le reti di Petri siano un modello estremamente potente per modellare un'infinita varietà di situazioni anche molto diverse tra loro.
Tuttavia, alcune categorie di problemi richiedono un approccio più mirato, ovvero un'__estensione delle reti di Petri__ specifica per il loro studio: è questo il caso dei __sistemi Hard Real-time__, di cui ora tratteremo approfonditamente.

In molte applicazioni il __tempo__ è un fattore essenziale: si pensi per esempio ad un termostato intelligente che deve accendere e spegnere i termosifoni di una casa in base ad un programma giornaliero oppure ad un autovelox, che in base al tempo di andata e ritorno di un'onda elettromagnetica dev'essere in grado di calcolare la velocità di un veicolo. \\
Ma non tutti i sistemi basati sul tempo sono uguali: alcuni di essi richiedono infatti il rispetto assoluto di una serie di __vincoli temporali stretti__, ovvero requisiti sul tempo di esecuzione di certe operazioni che devono essere rispettati per evitare gravi conseguenze.
Considerando per esempio il sistema di controllo di una centrale nucleare, qualora si inizi a rilevare un'aumento eccessivo delle temperature nel reattore tale software dev'essere in grado di reagire entro un certo tempo strettissimo, pena l'esplosione dell'apparato.
Sistemi di questo tipo prendono il nome, come già detto, di __sistemi Hard Real-time__, dove l'aggettivo "Hard" indica proprio la durezza richiesta nel rispetto dei vincoli temporali.

Visto il loro tipico impiego in situazioni di rischio o di pericolo, i committenti di sistemi di questo tipo potrebbero voler avere __prova del loro corretto funzionamento__ prima ancora che questi vengano installati.
I modelli finora descritti potrebbero però non essere sufficienti: non è per esempio abbastanza un'_analisi stocastica_ della rete, in quanto in virtù dei rischi a cui un malfunzionamento del sistema esporrebbe bisogna essere assolutamente __certi__ del suo corretto funzionamento, certezza che può essere ottenuta solo con un __modello deterministico__. \\
Ecco quindi che come strumento di specifica e comunicazione col cliente vengono sviluppate una serie di estensioni alle reti di Petri progettate specificamente per trattare il concetto di _tempo_ e _ritardo_: tra queste distingueremo in particolare le __reti Time Basic__ (_Ghezzi et al., 1989_), oggi le più usate.

## Modelli temporali

Esistono una serie di proposte per modellare il concetto di __tempo__ (_deterministico_) all'interno delle reti di Petri.
Esse si dividono sostanzialmente in due grandi categorie:

- quelle che introducono __ritardi sui posti__;
- quelle che introducono __ritardi sulle transizioni__.

### Tempo sui posti

Il tempo associato a ciascun posto rappresenta il __tempo che un gettone deve rimanere in tale posto prima di essere considerato per l'abilitazione__ di transizioni che hanno tale posto nel proprio preset.

{% responsive_image path: assets/16_tempo-sui-posti.png %}

Dopo lo scatto di una transizione i gettoni generati in un posto non fanno cioè funzionalmente parte della sua marcatura prima che sia passato un dato intervallo di tempo $$\Delta$$.
Tale $$\Delta$$ può quindi essere considerato la __durata minima di permanenza__ del gettone in tale posto, bloccando così quella porzione di stato del sistema per un certo periodo.

### Tempo sulle transizioni

Quando si associa un tempo ad una transizione è bene indicare che cosa esso rappresenti.
Il tempo di una transizione può infatti rappresentare due concetti molto differenti:

- la __durata della transizione__, ovvero il tempo richiesto dopo lo scatto della transizione perché vengano generati i gettoni nel suo postset (una sorta di _ritardo di scatto_);
- il __momento dello scatto__ della transizione, che può essere espresso in modo diverso a seconda del modello.

Esistono a dire il vero anche modelli misti che permettono di specificare sia la durata di una transizione che il suo tempo di scatto.

#### Equivalenza tra tempi sui posti e sulle transizioni

È facile dimostrare che sia le reti che definiscono tempi sui posti che quelle che definiscono tempi sulle transizioni, sia come durata che come momento dello scatto, sono __funzionalmente equivalenti__, ovvero permettono di rappresentare lo stesso insieme di sistemi.

Ciò è testimoniato dal fatto che, come mostra la figura sottostante, ogni rete avente tempo sui posti può essere trasformata in una rete con durata delle transizioni semplicemente aggiungendo una transizione di "ritardo" e separando il posto in due.
Ovviamente vale anche il viceversa.

{% responsive_image path: assets/16_tempo-posti-to-durata.png %}

Similmente, reti con durata delle transizioni possono essere trasformate in reti con tempi di scatto per le transizioni modellando esplicitamente con un posto il ritardo con cui vengono generati gettoni nel postset della transizione originale.

{% responsive_image path: assets/16_durata-to-tempo-scatto.png %}

#### <big>Tempi di scatto</big>

Ritornando un attimo sui nostri passi, diamo ora un'occhiata migliore a come si possono definire i tempi di scatto di una transizione.

Nella definizione dei tempi di scatto delle transizioni esistono infatti una serie di alternative molto differenti.
Innanzitutto, i tempi possono essere:

- __unici__, ovvero ogni transizione scatta (o può scattare) in _uno e un solo_ specifico momento;
- __multipli__, ovvero ogni transizione scatta (o può scattare) in _uno in un insieme_ di momenti.
    A seconda del modello considerato tali insiemi possono essere veri e propri __insiemi matematici__ (_es. reti TB_) oppure __intervalli__.

Si noti come i primi possono essere visti come casi particolari dei secondi. \\
Considerando ciò, gli insiemi (anche unitari) di tempi di scatto si distinguono poi in due categorie:

- __insiemi costanti__, ovvero tali per cui l'insieme dei tempi di scatto è __definito staticamente__ ed è sempre uguale indipendentemente dall'evoluzione della rete;
- __insiemi variabili__, ovvero tali per cui l'insieme dei tempi di scatto può __variare dinamicamente__ in base allo stato della rete o a porzioni di esso (_es. reti TB e HLTPN_).

Anche in questo caso i primi possono essere visti come un caso particolare dei secondi, in cui cioè l'insieme _potrebbe_ variare ma non varia mai. \\
Infine, i tempi di scatto stessi possono essere divisi in base a come vengono definiti:

- __tempi relativi__, ovvero espressi _solo_ in termini relativi al tempo di abilitazione della transizione (_es. "2 ms dopo l'abilitazione"_);
- __tempi assoluti__, ovvero espressi in termini relativi a tempi assoluti e ai tempi associati ai gettoni che compongono l'abilitazione (_es. "dopo 3 minuti dall'avvio del sistema" o "dopo 4 ms dal tempo associato all'ultimo gettone nell'abilitazione"_) (_es. reti TBe TCP_).

Nuovamente, i primi possono essere visti come un sottoinsieme dei secondi.

Tutto questo insieme di variabili permette di definire reti temporizzate basate su tempi di scatto delle transizioni anche molto diverse tra di loro.
Avremo per esempio le _reti Time Petri_, che utilizzano tempi di scatto relativi, multipli e a intervalli costanti; le _reti Time Petri colorate_, simili alle precedenti ma che usano tempi assoluti; le _reti Time Petri ad alto livello_, che usano insiemi variabili, e molte altre.

Tra tutte queste tipologie, tuttavia, ci concentreremo sulle __reti Time Basic__.
In virtù delle inclusioni di cui abbiamo già detto tali reti saranno quindi le più generali possibile e, dunque, anche le più interessanti.

# Reti Time Basic

Prima di darne una vera e propria definizione matematica iniziamo a introdurre le __reti Time Basic__ (__TB__) in modo informale.

Introdotte per la prima volta da Ghezzi e dai suoi collaboratori nel 1989, le reti TB associano __insiemi variabili__ di tempi di scatto __assoluti__ alle transizioni: ciascuna transizione possiede cioè un insieme di tempi in cui _potrebbe_ scattare, definito in maniera dinamica a seconda dello stato.
Tali tempi di scatto potrebbero poi essere definiti sia in termini assoluti che in termini dei __tempi associati ai gettoni__.

{% responsive_image path: assets/16_TBN-intro.png %}

Nelle reti TB infatti i gettoni non sono più anonimi, ma caratterizzati ciascuno da un __timestamp__ che indica il __momento in cui sono stati creati__ ($$\operatorname{t}(posto)$$).
A differenza delle normali reti di Petri i gettoni sono quindi __distinguibili__: questo non significa che due gettoni non possano avere lo stesso timestamp, ma solo che non tutti i gettoni sono uguali (_mentre gettoni generati dalla stessa transizione o da transizioni diverse scattate in parallelo avranno invece lo stesso timestamp_).

Per ogni transizione viene poi introdotto il concetto di __tempo di abilitazione__ ($$\bf{enab}$$), ovvero il __momento in cui la transizione viene abilitata__: poiché una transizione è abilitata quando tutti i posti nel suo preset contengono tanti gettoni quanto il peso dell'arco entrante in essa, il tempo di abilitazione di una transizione sarà pari al __massimo tra i timestamp__ dei gettoni che compongono la __tupla abilitante__. \\
Poiché i posti nel preset della transizione potrebbero contenere più gettoni di quelli necessari per farla scattare, una transizione potrebbe avere __più tempi di abilitazione diversi__ in base ai gettoni considerati per la tupla abilitante.

Ovviamente i __tempi di scatto__ delle transizioni __non potranno essere minori__ del tempo di abilitazione, in quanto una transizione non può scattare prima di essere abilitata.
Gli insiemi dei tempi di scatto potranno invece _dipendere_ dal tempo di abilitazione: così, per esempio, una transizione potrebbe scattare 2 secondi dopo essere stata abilitata, oppure tra 3 e 5 minuti dall'abilitazione. \\
A tal proposito, molto spesso i tempi di scatto saranno rappresentati come __intervalli__ $$[min,max]$$ piuttosto che come insiemi: nei nostri esempi adotteremo questa convenzione, ma è bene tenere in mente che tali insiemi potrebbero avere qualunque possibile forma.

## Definizioni matematiche

Facciamo un po' di chiarezza introducendo delle definizioni rigorose per tutto quanto citato nell'introduzione. \\
Una rete Time Basic è una __6-tupla__ del tipo $$\langle P, T, \Theta, F, tf, m_0 \rangle$$, dove:

- $$P, T, F$$ sono identici all'insieme dei posti, delle transizioni e al flusso delle normali reti di Petri;
- $$\Theta$$ (_theta_) è il __dominio temporale__, ovvero l'insieme numerico che contiene le rappresentazioni degli istanti di tempo;
- $$tf$$ è una funzione che associa ad ogni transizione $$t \in T$$ una __funzione temporale__ $$\operatorname{tf_{t}}$$ che data in input la __tupla abilitante__ $$\bf{en}$$, ovvero l'__insieme dei timestamp__ dei gettoni scelti per l'abilitazione nel preset, restituisce un __insieme di tempi di scatto possibili__:

  $$\operatorname{tf_{t}}(en) \subseteq \Theta$$

  Per esempio, se per una transizione $$t$$ i tempi di scatto sono nell'intervallo $$[min, max]$$, allora $$\operatorname{tf_{t}}(en) = \{r \, \vert \, min \leq r \leq max\}$$.

- $$m_0$$ è un multiset che esprime la __marcatura iniziale__: si tratta cioè di una funzione che ad ogni __posto__ associa un insieme di coppie __timestamp-molteplicità__ che indicano il numero di gettoni con tale timestamp all'interno del posto:

  $$m_0 : P \rightarrow \{ (\theta, \operatorname{mul}(\theta)) \, \vert \, \theta \in \Theta \}$$

  Tutte le __marcature__ esprimibili per le reti Time Basic assumeranno la forma di simili funzioni.

Con questi costrutti matematici siamo in grado di descrivere completamente lo stato di una rete Time Basic.
Tuttavia sorge ora spontanea una domanda: dovendo modellare il concetto di tempo, come __evolve__ una rete TB?

## Evoluzione

Dovendo modellare lo __scorrere del tempo__, le reti Time Basic dovranno operare una serie di accortezze per quanto riguarda la loro evoluzione.

Abbiamo per esempio già detto che il tempo di scatto di una transizione dovrà necessariamente essere maggiore del suo tempo di abilitazione, e che tale tempo di scatto sarà pari al timestamp dei gettoni generati dalla transizione.
Tuttavia, questo non è abbastanza: il concetto di tempo è particolarmente sfuggente e, soprattutto, __difficile da definire in maniera univoca__. \\
Al contrario, per le reti Time Basic vengono definite diverse __semantiche temporali__, ovvero diverse interpretazioni del concetto di "tempo" che richiederanno il rispetto di una serie di assiomi durante l'evoluzione della rete.
Tali interpretazioni, ciascuna utile per modellare diversi sistemi e requisiti di tempo, variano anche in complessità; in questo corso partiremo dunque dalla semantica più semplice per poi costruire su di essa quelle più complesse.

### Semantica temporale debole (WTS)

Informalmente, la __semantica temporale debole__ (_Weak Time Semantic_, __WTS__) impone che una transizione possa scattare _solo_ in uno degli __istanti identificati dalla sua funzione temporale__ e __non possa scattare _prima_ di essere stata abilitata__.

Tuttavia, ___una transizione non è costretta a scattare___ anche se abilitata: essa _potrebbe_ scattare, ma non è forzata a farlo.
Questo permette di modellare eventi solo __parzialmente definiti__, ovvero che potrebbero accadere sotto determinate condizioni ma non è possibile dire se lo faranno o no: esempi notevoli sono guasti o decisioni umane, eventi cioè non completamente prevedibili.
Si noti che a differenza dei modelli stocastici delle reti di Petri in questo caso non ci interessa la _probabilità_ con cui gli eventi potrebbero accadere, ma solo che potrebbero accadere.

Per imporre questa interpretazione del concetto di tempo l'evoluzione di una rete Time Basic deve seguire i seguenti __assiomi temporali__:

- (__A1__) __Monotonicità rispetto alla marcatura iniziale__: tutti i tempi di scatto di una sequenza di scatto devono essere __non minori__ ($$\geq$$) di uno qualunque dei timestamp dei gettoni della marcatura iniziale. \\
  Ogni marcatura deve cioè essere __consistente__, ovvero non contenere gettoni prodotti "nel futuro".

- (__A3__) __Divergenza del tempo__ (_non-zenonicità_): __non__ è possibile avere un __numero infinito__ di scatti in un intervallo di __tempo finito__. \\
  Questo assioma serve ad assicurarsi che il tempo __avanzi__!
  Esso assicura cioè che il tempo non si possa fermare e soprattutto che esso non possa essere suddivisibile in infinitesimi: il sistema evolve soltanto quando il tempo va avanti.

Le sequenze di scatti che soddisfano questi due assiomi vengono dette __sequenze ammissibili in semantica debole__.

### Semantica temporale monotonica debole (MWTS)

Come i più attenti avranno notato, nell'elencare gli assiomi necessari per la semantica temporale debole abbiamo saltato un ipotetico assioma A2.
Ebbene, ciò non è un caso: esiste infatti un'estensione della semantica WTS che aggiunge tra i propri requisiti il rispetto di tale assioma.

Si tratta della __semantica temporale monotonica debole__ (_Monotonic WTS_, __MWTS__), e differisce dalla semantica WTS perché impone necessariamente che i tempi di scatto delle transizioni all'interno di una sequenza siano monotoni non decrescenti, forzando così il fatto che nell'intera rete __il tempo non possa tornare indietro__. \\
Più formalmente, la semantica introduce il seguente assioma:

- (__A2__) __Monotonicità dei tempi di scatto di una sequenza__: tutti i tempi di scatto di una sequenza di scatti devono essere ordinati nella sequenza in maniera __monotonicamente non decrescente__ ($$\geq$$). \\
  Anche questo serve a garantire la proprietà intuitiva di __consistenza__, evitando cioè che il tempo torni indietro.
  Non richiedendo però che i tempi siano disposti in modo strettamente crescente ma ammettendo che nella sequenza lo __stesso tempo sia ripetuto__ si lascia aperta la possibilità che nella rete più transizioni scattino in contemporanea, oppure che due transizioni scattino in tempi talmente ravvicinati che la granularità temporale del modello non è in grado di rilevare la differenza.

Le sequenze di scatti che soddisfano gli assiomi A1, A2 e A3 vengono dette __sequenze ammissibili in semantica monotonica debole__. \\
Sebbene sembri una differenza da nulla, imporre la monotonicità dei tempi di scatto ha in realtà ripercussioni piuttosto grandi: in una rete che segue la MWTS quando si analizzano gli scatti è necessario non solo fare un'analisi locale del preset e del tempo di abilitazione e scatto della transizione, ma anche assicurarsi che non ci sia nessuna transizione nella rete in grado di scattare prima.
Si __perde cioè la caratteristica di località__, introducendo la necessità di mantenere un'informazione comune sull'__ultimo scatto__ nella rete.

#### WTS $$\equiv$$ MWTS

Fortunatamente per noi esiste un teorema che afferma che _per ogni sequenza di scatti ammissibile in semantica debole $$S_{WTS}$$ __esiste__ una sequenza di scatti ammissibile in semantica monotonica debole $$S_{MWTS}$$ __equivalente__ ottenibile per semplice __permutazione__ delle occorrenze degli scatti._

Non si tratterà di sequenze uguali, ma entrambe le sequenze produrranno la __stessa marcatura finale__.
Questo è un enorme vantaggio, in quanto ciò ci permette di infischiarcene della monotonicità degli scatti durante l'analisi della rete, potendo così sfruttare la __località__ e conseguentemente le __tecniche di analisi per le reti di Petri__ (ad alto livello) già viste in precedenza.

##### <big><u>Esempio di traduzione</u></big>

Si prenda in esame la rete in figura:

{% responsive_image path: assets/16_esempio-wts-mwts.png %}

Assumendo i timestamp iniziali di tutti i gettoni uguali a zero, si consideri la seguente sequenza ammissibile WTS di scatti:

$$ \text{T1 scatta al tempo 12} \rightarrow \text{T3 scatta al tempo 14} \rightarrow \text{T2 scatta al tempo 4}$$

Tale sequenza non rispetta la monotonicità, in quanto T2 scatta "nel passato" dopo lo scatto di T3, e produce la marcatura $$\langle0, 0, 1, 0, 1\rangle$$.
Tuttavia, riordinando la sequenza come:

$$ \text{T2 scatta al tempo 4} \rightarrow \text{T1 scatta al tempo 12} \rightarrow \text{T3 scatta al tempo 14}$$

è possibile ottenere una marcatura identica ma con una sequenza che rispetta ora la monotonicità, essendo cioè ammissibile in semantica temporale monotonica debole.

### Semantica temporale forte (STS)

Finora abbiamo lasciato aperta la possibilità che una transizione pur _potendo_ scattare non lo facesse.
Questa alternativa non è però contemplata in molti modelli temporizzati, in cui il __determinismo__ gioca un forte ruolo: spesso si vuole che se una transizione può scattare, allora __deve__ scattare entro il suo massimo tempo di scatto ammissibile.

Per forzare questo comportamento viene creata una semantica temporale apposita, che prende il nome di __semantica temporale forte__ (_Strong Time Semantic_, __STS__): essa impone che _una transizione __deve scattare__ ad un suo possibile tempo di scatto __a meno che non venga disabilitata__ prima del proprio massimo tempo di scatto ammissibile_.
Aggiungere quest'ultima clausola permette alle transizioni di non dover prevedere il futuro: se esse fossero programmate per scattare in un certo istante ma prima di esso lo scatto di un'altra transizione le disabilitasse non si richiederebbe che esse tornino indietro nel tempo per scattare all'ultimo istante di tempo _utile_.

Essendo un ulteriore irrigidimento rispetto alla semantica temporale monotonica debole, la STS dovrà sia rispettare gli assiomi A1, A2 e A3, sia la seguente nuova coppia di assiomi, che porta il totale a cinque:

- (__A4__) __Marcatura forte iniziale__: il __massimo tempo di scatto__ di tutte le transizioni abilitate nella __marcatura iniziale__ dev'essere __maggiore o uguale del massimo timestamp__ associato ad un gettone in tale marcatura. \\
  Questo assicura cioè che la marcatura iniziale sia __consistente con la nuova semantica__ temporale: un gettone dotato di timestamp superiore al tempo di scatto massimo di una transizione abilitata non sarebbe potuto essere generato _prima_ che la transizione scattasse (cosa che deve fare!), rendendo quindi la marcatura in questione non più quella iniziale.

- (__A5__) __Sequenza di scatti forte__: una sequenza di scatti ammissibile in semantica __MWTS__ che parta da una __marcatura forte iniziale__ è una __sequenza di scatti _forte___ se per ogni scatto il tempo di scatto della transizione __non è maggiore__ del massimo tempo di scatto di un'altra transizione abilitata. \\
  Si sta cioè accertando che ogni transizione scatti entro il suo tempo massimo se non viene disabilitata prima da un altro scatto: per fare ciò, si permette alle transizioni di scattare _solo_ se non ci sono altre transizioni abilitate che sarebbero già dovute scattare, costringendo quindi queste ultime a farlo per far continuare a evolvere la rete.

Ecco dunque che sequenze di scatto che soddisfano gli assiomi A1, A2, A3, A4 e A5 vengono dette __sequenze ammissibili in semantica forte__.

#### STS $$\not\equiv$$ MWTS

In virtù dell'ultimo assioma si potrebbe pensare che esista un modo per trasformare ogni sequenza di scatti MWTS in una sequenza STS, realizzando così un'equivalenza.
Purtroppo, però, non è così: una sequenza STS è sempre anche MWTS, ma __non è sempre vero il contrario__.

Poiché infatti non è più possibile a causa dell'assioma A2 riordinare le sequenze per ottenerne altre di equivalenti, è possibile trovare numerose sequenze che sono MWTS ma non STS.
Riprendendo la rete già vista in precedenza e assumendo anche in questo caso dei timestamp iniziali nulli per i gettoni:

{% responsive_image path: assets/16_esempio-wts-mwts.png %}

è facile vedere che la sequenza ammissibile in semantica monotonica debole:

$$\text{T1 scatta al tempo 6} \rightarrow \text{T1 scatta al tempo 12} \rightarrow \text{T3 scatta al tempo 14}$$

non è invece una sequenza ammissibile in semantica forte, in quanto lo scatto di T2 abilita la transizione T3, che dovrebbe quindi scattare entro il tempo 9 ($$enab = 6$$) ma non lo fa.

### Semantica temporale mista

Può però capitare che dover imporre una semantica temporale fissa per l'intera rete si riveli limitante nella modellazione di sistemi reali: questi potrebbero infatti includere sia agenti deterministici (_es. computer_) che agenti stocastici (_es. esseri umani_).

Si introduce quindi una nuova __semantica temporale mista__ (_Mixed Time Semantic_), in cui la semantica temporale debole (monotonica) o forte viene associata alle __singole transizioni__ piuttosto che all'intera rete.
In questo modo:

- le __transizioni forti__ _dovranno_ scattare entro il loro tempo massimo a meno che non vengano disabilitate prima;
- le __transizioni deboli__ _potranno_ scattare in uno qualunque dei loro possibili tempi di scatto.

Essendo meno comuni, solitamente sono le transizioni deboli ad essere esplicitamente indicate graficamente nelle reti con una $$W$$ all'interno del rettangolo che le rappresenta: tutte le altre transizioni sono invece di default considerate forti.

#### <big>Analisi di abilitazione in presenza di transizioni forti</big>

Introdotta quindi la possibilità che esistano all'interno delle reti delle transizioni forti che devono necessariamente scattare entro il loro tempo massimo di scatto non è ora più tanto semplice fare __analisi di abilitazione__, vale a dire quel tipo di analisi che cerca di tracciare su una linea temporale gli intervalli durante i quali certe transizioni sono abilitate.

Per capire perché, osserviamo la seguente rete Time Basic, che segue una semantica temporale mista:

{% responsive_image path: assets/16_analisi-rete.png %}

Analizzando localmente le singole transizioni, come se avessero tutte semantica temporale debole, si può ottenere il seguente diagramma temporale di abilitazione:

{% responsive_image path: assets/16_analisi-1.png %}

Tuttavia, questo diagramma è __scorretto__.
La presenza di una transizione forte che deve scattare entro il tempo 10, ovvero T2, non ci permette di dire nulla oltre tale tempo, in quanto _il suo scatto potrebbe disabilitare altre transizioni_.
Questo era vero anche per la transizione debole T1, ma il suo essere debole permetteva comunque di ignorare tale eventualità nella prospettiva che la transizione, pur potendo, non scattasse: questo tipo di ragionamento non è però purtroppo più possibile in semantica temporale forte.

In sostanza, __le transizioni forti bloccano il nostro orizzonte temporale__. \\
Ecco dunque che il vero diagramma temporale di abilitazione della rete è il seguente:

{% responsive_image path: assets/16_analisi-2.png %}

# Analisi delle reti Time Basic

Definite le reti Time Basic in ogni loro aspetto è dunque arrivato il momento di __analizzarle__.

Esattamente come le reti di Petri, infatti, le reti TB fanno parte di quei __linguaggi operazionali__ utilizzati per illustrare il funzionamento di un sistema senza entrare nei dettagli della sua effettiva implementazione ($$\neq$$ _linguaggi dichiarativi/logici, che si usano invece per costruire il sistema a partire dalle proprietà richieste_).
Visto questo ruolo, è necessario possedere una serie di __strumenti di analisi__ specifici che permettano di "simulare" il funzionamento della rete per comprenderne l'evoluzione e le proprietà: ciò appare particolarmente evidente se si ricorda che le reti TB vengono spesso utilizzate per modellare sistemi _Hard Real-Time_ in cui si deve avere la __certezza__ del fatto che il sistema rispetterà tutta una serie di caratteristiche prima ancora di iniziare i lavori.

## Reti TB come reti ad Alto Livello?

Ma è davvero necessario sviluppare un'intera serie di nuove tecniche di analisi specifiche per le reti Time Basic, o è possibile riutilizzare almeno in parte metodologie già discusse?

Si potrebbe infatti immaginare di considerare le reti TB come un tipo particolare di __reti ad Alto Livello__ (ER).
Come abbiamo già accennato, questo tipo di reti permettono infatti ai gettoni di avere un __qualunque contenuto informativo__ e di definire le transizioni come una coppia __predicato-azione__: il predicato descrive la condizione di abilitazione della transizione in funzione dei valori dei gettoni nel preset, mentre l'azione determina che valore avranno i gettoni creati nel postset. \\
Volendo modellare il __tempo come concetto derivato__, ovvero non delineato esplicitamente ma che emerga comunque dal _funzionamento_ della rete, si potrebbero quindi creare delle reti ad Alto Livello con le seguenti caratteristiche:

- __contenuto informativo dei gettoni__: un'unica variabile temporale __chronos__ che contiene il timestamp della loro creazione;
- __predicati delle transizioni__: funzioni che controllano i timestamp dei gettoni nel preset e i propri tempi di scatto per determinare l'abilitazione o meno;
- __azioni delle transizioni__: generazione di gettoni dotati tutti dello _stesso dato temporale_, il quale è _non minore dei timestamp di tutti i gettoni nella tupla abilitante_.

Con queste accortezze è possibile riprodurre i timestamp e le regole di scatto di una rete TB.
Come sappiamo bene, tuttavia, questo non basta per modellare il _concetto_ di tempo: per avere un'espressività simile a quella delle reti Time Basic è infatti necessario anche il rispetto di una __semantica temporale__ e, in particolare, di quella più stringente, ovvero la semantica temporale forte (STS).

Nelle reti ad Alto Livello bisognerà dunque far rispettare i cinque assiomi temporali perché la traduzione da reti TB a reti ER sia completa.
Vediamo dunque come ciò potrebbe essere fatto:

- gli assiomi __A1__ e __A3__ sono sufficientemente semplici da modellare all'interno dei predicati delle transizioni, rendendo così la __semantica temporale debole__ rappresentabile nelle reti ad Alto Livello;

- l'assioma __A2__ è già più complesso da realizzare, in quanto richiede che lo scatto di una transizione generi dei gettoni con un timestamp maggiore di quello di tutti gli altri gettoni nella rete (_imponendo così che il tempo avanzi_).
  Tuttavia tale limite può essere aggirato con l'aggiunta di un __posto globale__ contenente il __gettone dell'ultimo scatto__ e aggiunto al preset di ogni transizione: in questo modo il gettone nel posto globale rappresenterà il _tempo corrente della rete_ e imporrà che i nuovi gettoni generati abbiano timestamp maggiore di esso.
  In questo modo una rete ER può realizzare anche la __semantica temporale monotonica debole__;

- gli assiomi __A4__ e __A5__, invece, si rivelano __estremamente problematici__: essi richiedono infatti che ciascuna transizione conosca il massimo tempo di scatto di tutte le altre transizioni per "decidere" se poter scattare oppure no.
  I predicati delle transizioni dovrebbero cioè avere in input l'intero stato della rete: sebbene questa cosa sia _teoricamente_ realizzabile con l'aggiunta di un posto globale in ingresso e uscita da ogni transizione in cui un gettone contenga come _contenuto informativo l'intero stato della rete_, nella pratica cio è __irrealizzabile__.

Come si vede, dunque, la necessità di modellare la __semantica temporale forte__ fa sì che __non si possa ridurre le reti TB a un caso particolare delle reti ER__, perdendo così anche la possibilità di utilizzare le tecniche di analisi già sviluppate per esse.

### Reti Time Petri ad Alto Livello (HLTPN)

Appurato che non è possibile tracciare un'equivalenza tra le reti TB e le reti ER viene dunque introdotto un modello ancora più completo, che racchiuda al suo interno sia gli __aspetti funzionali__ delle reti ad Alto Livello sia gli __aspetti temporali__ delle reti Time Basic: si tratta delle __reti Time Petri ad Alto Livello__ (_High-Level Time Petri Nets_, __HLTPN__).

{% responsive_image path: assets/16_HLTPNs.png %}

Come appare chiaro dalla figura, all'interno delle reti HLTPN __gli aspetti funzionali possono dipendere da quelli temporali e viceversa__, espandendo così incredibilmente le capacità rappresentative del modello.
Si tratta di reti ovviamente molto complesse, anche se a dire il vero gran parte della complessità giunge dall'analisi della componente temporale: se riusciremo ad analizzare le reti temporizzate potremo riuscire ad analizzare anche le reti HLTPN.

## Analisi di raggiungibilità temporale

Rassegnatici dunque alla necessità di creare nuove tecniche di analisi specifiche per le reti temporizzate iniziamo a parlare di __analisi dinamica__ a partire dall'__analisi di raggiungibilità__, ovvero la tecnica con cui nelle reti di Petri classiche eravamo in grado di __enumerare gli stati finiti raggiungibili__.

Provando ad adottare lo stesso approccio nei confronti delle reti TB ci si rende però subito conto di un enorme __problema__: le reti temporizzate hanno sempre __infiniti stati__, in quanto lo scatto di una singola transizione può produrre un'infinità di stati di arrivo che si differenziano unicamente per il timestamp dei gettoni generati.
Sebbene la marcatura sia identica, le informazioni temporali legate ai gettoni sono differenti, distinguendo così ciascuno di tali stati della rete. \\
Bisogna inoltre considerare che per sua stessa natura il tempo avanza, rendendo così le reti temporizzate in grado di __evolvere all'infinito__: anche raggiungendo una marcatura che non abilita alcuna transizione, la rete continua ad evolvere in quanto il _tempo corrente_ continua ad avanzare.

Dovendo costruire un __albero di raggiungibilità__ questo sarebbe quindi sicuramente __infinito__, anche se in un modo diverso rispetto a quanto già visto per le reti non limitate: in quel caso infatti i gettoni non erano distinguibili, cosa che ci aveva permesso di raggrupparne un numero qualsiasi sotto il simbolo $$\omega$$, mentre in questo caso le differenze nei timestamp impediscono un simile approccio.

Al contrario, per ottenere per le reti TB un'analisi simile all'analisi di raggiungibilità delle reti classiche è necessario __ridefinire__ completamente il concetto di __stato raggiungibile__.

### Stati simbolici

Per riformulare il concetto stesso di raggiungibilità partiamo da innanzitutto da quello di __marcatura__: nelle reti temporizzate queste associavano infatti a ciascun posto un _multiset_ in cui ad ogni timestamp era associato il numero di gettoni con tale timestamp presente nel posto.

Per evitare la difficoltà di distinguere tra gettoni con timestamp diversi viene introdotto nelle reti TB il concetto di __stato simbolico__, un oggetto matematico che sostituendo ai timestamp specifici degli identificatori simbolici dei gettoni permette di _rappresentare un __insieme di possibili stati__ con in comune lo stesso numero di gettoni in ciascun posto_ (esattamente come la marcatura delle reti classiche).

Più formalmente, uno stato simbolico è una __tupla__ $$[\mu, C]$$, dove:

- $$\mu$$ è la __marcatura simbolica__, che associa a ciascun posto un _multiset_ di __identificatori simbolici__ che rappresentano i timestamp dei gettoni in tale posto.
  Timestamp uguali saranno rappresentati dallo stesso simbolo, anche se si trovano in posti diversi: questo permette di mantenere l'__identità__ tra timestamp;

- $$C$$ è un sistema di __vincoli__ (_constraint_), ovvero equazioni e disequazioni che rappresentano le relazioni tra gli identificatori simbolici dei gettoni.
  In questo modo è possibile mantenere le __relazioni__ tra i timestamp dei gettoni pur non rappresentando esplicitamente il loro valore.

Un'esempio aiuterà a chiarire ogni dubbio.
Immaginiamo di avere una rete TB con 3 posti $$(P1, P2, P3)$$, ciascuno con un solo gettone al loro interno, e la seguente marcatura iniziale: $$\langle \{0\}, \{1\}, \{0\} \rangle$$.
Volendoci disfare dei timestamp espliciti dei gettoni, che tutto sommato ci interessano relativamente, dobbiamo __mantenere due informazioni__:

- che i gettoni in $$P1$$ e $$P3$$ hanno lo _stesso timestamp_;
- che il gettone in $$P2$$ ha _timestamp maggiore_ di 1 del timestamp dei gettoni negli altri due posti.

Per fare ciò lo stato simbolico generato assegnerà lo stesso identificatore ai gettoni in $$P1$$ e $$P3$$ e espliciterà nei vincoli la relazione tra tempi.
Otterremo dunque lo stato simbolico iniziale:

$$\mu(P1)=\{\tau_0\}, \: \: \: \mu(P2)=\{\tau_1\}, \: \: \: \mu(P3)=\{\tau_0\}$$

$$C_0: \: \: \: \tau_1=\tau_0+1$$

Infine, ci si potrebbe accorgere che in realtà non ci interessa che il timestamp del gettone in $$P2$$ sia esattamente $$\tau_0+1$$, ma solamente che esso sia maggiore di $$\tau_0$$.
Ecco dunque che spesso si mutano i vincoli in __disequazioni__:

$$C_0: \: \: \: \tau_0<\tau_1$$

### Albero di raggiungibilità temporale

Utilizzando la definizione di stato simbolico appena vista è possibile costruire tramite un algoritmo un __albero di raggiungibilità temporale__, in cui gli stati distinguibili solo dai timestamp vengono condensati in stati simbolici che conservano però le _molteplicità_ dei gettoni nei posti e le _relazioni_ tra i timestamp.

Prima di fare ciò, però, è necessario rinnovare un'assunzione già fatta in precedenza: anche in questa analisi assumeremo che le funzioni temporali $$tf_{t}$$ associate alle transizioni siano esprimibili come __intervalli con estremi inclusi__ $$\bf{[tmin_t, tmax_t]}$$, dove questi ultimi possono dipendere ovviamente dai timestamp dei token in ingresso nonché da tempi assoluti.

Fatte queste premesse, possiamo partire a costruire effettivamente l'albero di raggiungibilità temporale di una rete TB secondo il seguente algoritmo:

1. __Inizializzazione__: si trasforma la marcatura iniziale della rete in uno stato simbolico, introducendo una serie di vincoli che descrivano le (pre-)condizioni iniziali della rete.
  Tale stato viene poi trasformato in un nodo, diventando la radice dell'albero, e aggiunto alla lista dei nodi da esaminare;

2. __Scelta del prossimo nodo__: tra i nodi dell'albero non ancora esaminati si seleziona il prossimo nodo da ispezionare;

3. __Identificazione delle abilitazioni__: in base allo stato simbolico rappresentato dal nodo si individuano le transizioni abilitate al suo interno;

4. __Aggiornamento di marcatura e vincoli__: ciascuna transizione abilitata trovata viene fatta scattare generando un nuovo stato simbolico, che viene rappresentato nell'albero come nodo figlio del nodo considerato e aggiunto alla lista dei nodi da esaminare;

5. __Iterazione__: si ritorna al punto 2.

Di questo semplice algoritmo approfondiamo dunque le due fasi più interessanti: l'aggiornamento di marcatura e vincoli e l'identificazione delle abilitazioni.

#### Aggiornamento di marcatura e vincoli

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
Si dimostra quindi che _dato uno stato simbolico precedente avente vincoli $$C_n$$, detto $$maxT$$ il timestamp massimo all'interno della rete e $$\tau_{n+1}$$ l'identificatore simbolico dei gettoni generati dalla transizione $$t$$ è possibile definire i vincoli dello stato simbolico prodotto con la seguente __formula___:

$$
\boxed{
\begin{align*}
C_{n+1} = \: & C_n \wedge \tau_{n+1} \geq maxT \: \wedge tmin_t \leq \tau_{n+1} \leq tmax_t \\
& \bigcap\limits_{t_{STS}}(tmax_{t_{STS}} < tmin_{t_{STS}} \vee tmax_{t_{STS}} < maxT \vee tmax_{t_{STS}} \geq \tau_{n+1} )
\end{align*}
}
$$

dove per $$t_{STS}$$ si intende una qualunque __transizione forte__ diversa da $$t$$; per __ciascuna__ di esse bisognerà infatti aggiungere la condizione tra parentesi, relativa appunto alla semantica STS.

Tale catena di condizioni può ben presto diventare soverchiante, ma fortunatamente essa può essere semplificata sfruttando le __implicazioni__ e le proprietà degli operatori logici.
In particolare:

- se una condizione $$A$$ implica un'altra condizione $$B$$ con cui è in __AND__ ($$\wedge$$), allora la condizione __implicata__ $$B$$ può essere cancellata;
- se una condizione $$A$$ implica un'altra condizione $$B$$ con cui è in __OR__ ($$\vee$$), allora la condizione __implicante__ $$A$$ può essere cancellata.

##### <big><u><b>Identificazione delle abilitazioni</b></u></big>

Al contrario di quanto ci si potrebbe aspettare, però, la creazione di questo nuova catena di vincoli non è relegata alla sola creazione di un nuovo stato simbolico, ma è invece necessaria anche per __identificare le transizioni abilitate__.
Avendo infatti introdotto degli identificatori simbolici che mascherano i timestamp dei gettoni, capire se una transizione sia abilitata o meno non è più così facile.

Tuttavia, è possibile dimostrare che _la __soddisfacibilità__ del vincolo generato da un eventuale scatto della transizione __implica__ la sua __abilitazione___: se esiste cioè un assegnamento di timestamp agli identificatori simbolici che __rende vero__ il vincolo allora la transizione è abilitata e può scattare.
Il motivo di ciò appare evidente quando ci si accorge che nella generazione del vincolo abbiamo già tenuto in conto di tutti gli aspetti che avremmo osservato per stabilire se la transizione fosse abilitata o meno.

{% responsive_image path: assets/16_esempio_albero_raggiungibilita_reti_temporizzate-grafico.png %}

Proprio riguardo la soddisfacibilità viene poi fatta una distinzione a livello grafico nell'albero: essendo gli stati simbolici _insiemi_ di marcature è possibile che una transizione sia abilitata in alcune di esse mentre è disabilitata in altre. \\
Quando questo succede, lo stato generato dalla transizione __potrebbe essere uno stato finale__, in quanto potrebbe aver disabilitato tutte le transizioni: ciò si comunica graficamente con un __nodo circolare__, mentre i nodi (e quindi gli stati) i cui vincoli sono __sempre soddisfacibili__ si indicano con dei __nodo rettangolari__.

{% responsive_image path: assets/16_esempio_albero_raggiungibilita_reti_temporizzate.png %}

Alcuni operano poi una distinzione sulle frecce che collegano i nodi dell'albero: una freccia con punta nera indica che la transizione è sempre possibile, mentre una freccia con alla base un pallino bianco indica che per rendere possibile la transizione è stato violato qualche parte del vincolo, per cui non è detto che la transizione sia possibile in nessuna delle marcature rappresentate dallo stato simbolico.

#### Proprietà _bounded_

Eseguendo l'algoritmo a mano per un paio di iterazioni ci si rende ben presto conto di una cosa: il processo __non termina__!

Questo è dovuto al fatto che __non avendo una forma normale__ per i vincoli che permetta di confrontare tra di loro gli stati simbolici non è possibile stabilire se si sia già visitato o meno uno stato: i vincoli si allungano così sempre di più, creando sempre stati simbolici nuovi (almeno sulla carta).

Si ottiene cioè un __albero infinito__.
Nonostante ciò, tale albero è comunque particolarmente utile perché permette di __verificare proprietà entro un certo limite di tempo__: si parla per esempio di __bounded liveness__ e __bounded invariance__, delle caratteristiche molto preziose sopratutto per lo studio dei sistemi Hard Real-Time.

### Dall'albero al grafo aciclico

Esattamente come per le reti di Petri classiche, costruito l'albero di raggiungibilità ci piacerebbe ristrutturarlo per trasformarlo in un __grafo__ che illustri più concisamente l'evoluzione del sistema rappresentato dalla rete.
Di certo non possiamo sperare di ottenere un _grafo ciclico_ in quanto per sua stessa natura _il tempo non può tornare indietro_, ma c'è qualche chance di ottenere un __grafo aciclico__?

Abbiamo già detto che a causa di come sono costruiti i nuovi stati simbolici è impossibile riottenere più volte lo stesso esatto stato.
Ammettendo tuttavia di __dimenticare la storia__ di come si è giunti in un certo nodo (ovvero l'insieme di transizioni che hanno portato ad esso) si potrebbe sperare di __ritrovare alcuni stati__ che pur caratterizzati da storie diverse possiedono la _stessa marcatura simbolica_ e lo _stesso insieme di vincoli sugli identificatori simbolici_ presenti al suo interno.

Vediamo dunque una serie di tecniche che permettono, al costo di __perdere una serie di informazioni__, di individuare le _somiglianze_ tra diversi stati simbolici in modo da raggrupparli in una serie di "super-stati" che fungano da nodi per il grafo che intendiamo costruire.

#### Semplificare i vincoli: l'algoritmo di Floyd

Per dimenticare la storia di come si è giunti in un certo stato simbolico è innanzitutto necessario __semplificare i vincoli__: come abbiamo visto nella formula precedente, ogni nuovo stato simbolico ereditava infatti i vincoli del precedente, cosa che permette di distinguere marcature identiche a cui si è giunti in modo diverso.

È dunque necessario __esprimere i vincoli solo in termini della marcatura corrente__: possiamo infatti considerare i vincoli sugli identificatori simbolici non più presenti nella rete come sostanzialmente inutili.
Tuttavia, non basta cancellarli per risolvere la questione: sebbene il simbolo a cui fanno riferimento sia scomparso, essi potrebbero ancora esprimere __vincoli indiretti__ sugli identificatori ancora presenti nella marcatura, che vanno ovviamente mantenuti. \\
Si immagini per esempio di avere i vincoli $$B - A \leq 5$$ e $$C - B \leq 6$$ e che l'identificatore $$B$$ sia ormai scomparso dalla rete.
Sebbene si riferiscano a un simbolo ormai non più presente, tali vincoli contengono ancora delle informazioni: sommando le due disequazioni membro a membro si ottiene infatti che $$C - A \leq 11$$, un vincolo su variabili presenti che era espresso _indirettamente_.

{% responsive_image path: assets/16_Floyd-grafo-cut.png %}

Per rimappare in modo semplice gli effetti dei vincoli sulle variabili non più presenti nella marcatura su quelle presenti si utilizza spesso l'__algoritmo di Floyd__, che funziona come segue:

1. Si riconducono tutti i vincoli alla __forma__ $$\bf{A - B \leq k}$$, dove $$A$$ e $$B$$ sono identificatori simbolici e $$k$$ è una costante numerica; per esempio:

    $$A+2 \leq B \leq A+5 \: \: \: \longrightarrow \: \: \: A - B \leq -2 \: \text{ e } \: B - A \leq 5$$

    $$B \leq C \leq B+6 \: \: \: \longrightarrow \: \: \: B - C \leq 0 \: \text{ e } \: C- B \leq 6$$

2. Si costruisce una __matrice__ in cui ad ogni riga e colonna corrisponde un identificatore simbolico e l'intersezione tra la riga $$A$$ e la colonna $$B$$ corrisponde al __valore $$\bf{k}$$ tale per cui__ $$\bf{A - B \leq k}$$ in base ai vincoli ricavati al punto precedente, mentre per i valori non noti si scrive semplicemente un __punto di domanda__;

3. Si __riempiono tutti i posti contrassegnati da punti di domanda__ utilizzando la seguente formula:  

    $$\boxed{m[i,j] = m[i,k] + m[k,j]}$$

    che mima la somma membro a membro delle disequazioni che rappresentano i vincoli.
    In questo modo è possibile scoprire i __vincoli indiretti__ tra variabili;

4. Si __esplicitano i vincoli indiretti__ relativi agli identificatori simbolici presenti nella marcatura corrente e __si eliminano__ i vincoli che contengono gli identificatori non inclusi.

{% responsive_image path: assets/16_Floyd-matrici.png %}

Applicato l'algoritmo di Floyd, ottenuti i vincoli impliciti ed eliminati i vincoli contenenti identificatori simbolici è possibile semplificare di molto l'insieme dei vincoli di nodi del grafo, identificando anche le prime _somiglianze_ tra nodi.

#### Inclusione tra stati

Il raggruppamento offerto dalla semplificazione dei vincoli tramite l'algoritmo di Floyd non è però sufficiente a ottenere grafi aciclici soddisfacenti.
Si consideri per esempio la rete in figura:

{% responsive_image path: assets/16_esempio-inclusione.png %}

Come si vede, essa genera una serie di nodi nel grafo di raggiungibilità tutti diversi nonostante essi abbiano la __stessa marcatura__ e l'unica differenza sia data dalla costante nel vincolo.
Per semplificare situazioni come queste viene introdotto il concetto di __inclusione__ (o _contenimento_) __tra stati__: sapendo infatti che gli stati simbolici rappresentano _insiemi_ di marcature è opportuno chiedersi se alcuni di essi possano essere _sottoinsiemi_ di altri.

Ecco dunque che si dice che _uno stato $$A$$ è __contenuto__ in un altro stato $$B$$ se e solo se __tutte__ le marcature rappresentate da $$A$$ sono rappresentate anche da $$B$$_.
Ciò avviene quando:

- $$A$$ e $$B$$ hanno lo __stesso assegnamento di timestamp__;
- __i vincoli di $$A$$ implicano i vincoli di $$B$$__, ovvero $$C_A \rightarrow C_B$$.

Decidiamo quindi di rappresentare nel grafo __solo gli stati contenuti__, introducendo però una distinzione grafica: la punta bianca della freccia indica che spostandosi lungo di essa si arriva ad un __sottoinsieme__ del "super-stato" di arrivo, ovvero uno stato avente _vincoli più stringenti_ di quelli mostrati.

{% responsive_image path: assets/16_esempio-inclusione-2.png %}

#### Tempi relativi

Osservando l'evoluzione di una rete Time Basic ci si può poi accorgere di un ulteriore fatto: se le funzioni temporali delle transizioni __non fanno riferimento a tempi assoluti__, ovvero a specifici istanti di esecuzione della rete, per comprendere come la rete può evolvere a partire da una certa marcatura è __sufficiente osservare i vincoli relativi tra i timestamp__.

Si prenda per esempio in considerazione la rete in figura:

{% responsive_image path: assets/16_esempio-tempi-relativi-crop.png %}

ci si accorge che mantenere il riferimento ai tempi assoluti $$0$$ e $$10$$ introdotti dai vincoli iniziali farebbe sì che vengano generati __infiniti stati__ anche considerando la possibilità di inclusione.
Poiché _l'unica transizione presente nella rete non fa alcun riferimento a tempi assoluti_, si può quindi __eliminare i vincoli legati a tempi assoluti__ ottenendo il secondo grafo in figura: esso rappresenta alla perfezione l'evoluzione della rete (che può far scattare la transizione $$T1$$ un numero infinito di volte) pur ignorando i vincoli sul valore iniziale del timestamp dell'unico gettone presente.

#### Tempi anonimi

Si può infine introdurre un'ulteriore astrazione: ci si rende infatti conto che _se il timestamp associato ad un gettone in una marcatura M non verrà __mai più utilizzato__ per stabilire come evolverà la rete a partire da quella marcatura_, allora è possibile __anonimizzare__ il tempo di tale gettone.
L'identificatore simbolico del gettone viene cioè sostituito da un __identificatore anonimo__ $$\tau_A$$ e i vincoli che lo coinvolgono cancellati: questo permette di riconoscere la somiglianza tra stati simbolici che, pur diversi a livello di timestamp dei gettoni, __evolvono nello stesso modo__.

Si consideri per esempio la rete in figura:

{% responsive_image path: assets/16_esempio-time-anonymous-crop.png %}

All'interno di questa rete, il timestamp del gettone in $$P2$$ non ha alcuna influenza sull'evoluzione della rete: esso funge infatti unicamente da _zero relativo_ per determinare il timestamp del gettone in $$P1$$, che sarà maggiore di esso di tante unità quanto il numero di volte che è scattata la transizione $$T1$$.
Il gettone può dunque essere reso anonimo, eliminando l'unico vincolo che, a conti fatti, non aggiunge nulla alla nostra conoscenza della rete.

Non esiste una vera e propria regola formale per capire quali gettoni siano anonimizzabili, ma esistono una serie di __euristiche__ che possono suggerire tale eventualità: così, per esempio, è molto probabile che i __gettoni morti__ (gettoni in posti che non appartengono al preset di alcuna transizione) possano essere resi anonimi.

#### Conclusioni

L'utilizzo delle tecniche di __raggruppamento degli stati simbolici__ appena viste permette di costruire dei grafi di raggiungibilità più coincisi per le reti Time Basic, ma non senza __sacrificare__ una serie di __informazioni__.
Infatti:

- la tecnica di __inclusione__ introduce la possibilità che nel grafo esistano dei __cammini non percorribili__ dovuti al fatto che muovendosi tra _sottoinsiemi_ degli stati rappresentati è possibile che lo stato simbolico reale in cui ci si trova non permetta una certa transizione che è invece possibile a parte degli stati rappresentati dal nodo;
- con l'abolizione dei __vincoli assoluti__ si perdono informazioni sulle __relazioni precise__ tra gli stati (anche se è possibile arricchire le informazioni sugli archi per non perderne troppe);
- __anonimizzando__ alcuni gettoni potrebbe non essere sempre possibile verificare la __raggiungibilità__ di una marcatura definita da vincoli sui timestamp.

Si tratta di un equo prezzo da pagare per una rappresentazione semplice ed efficace dell'evoluzione della rete.

### Albero di copertura temporale?

Avevamo detto che sulle reti TB non era possibile utilizzare la tecnica di analisi di copertura vista per le normali reti di Petri a causa della __distinguibilità__ tra gettoni dovuta ai rispettivi timestamp.

Tuttavia, l'introduzione della possibilità di __anonimizzare i gettoni__ è in grado di far riconsiderare tale conclusione: i gettoni anonimi sono infatti tutti __equivalenti__ e indistinguibili, motivo per cui potrebbero essere rappresentati globalmente solo dal loro __numero__ $$\omega_{\tau A}$$.

Non approfondiamo la questione, ma esiste un'ipotesi non dimostrata che suppone che _le reti TB non limitate siano non limitate __solo__ sul numero di gettoni anonimi_ in quanto in caso contrario bisognerebbe avere una rete che si interessi del passato all'infinito.
