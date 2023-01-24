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

##### <big>Esempio di traduzione</big>

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

## Modellare un passaggio a livello con una rete di petri

<!-- Fare la review da qui! Grazie, review solitario -->

-- img

abbiamo parlato 2 famiglie di linguaggi , quelli operativi e quelli relazionali

dichiarativi : linguaggi logici , vanno ad indicare le proprietà che deve avere il nostro sistema

operazionali: sono tipi di linguaggi che a modellare fisicamente una possibile implementazione/rappresentazione del nostro sistema senza vincolare di come la struttura va fatta.Appunto è interpretata come una modellizazione di riferimento , agli effetti esterni si dovrà comportare seguendo il modello.

Se noi facciamo una rete di petri dove mettiamo 50 stati da una parte, 30 da un altra, non vuol dire che nel codice avro' una classe con il sottoinsieme degli stati. Significa che il programma si dovrà comportare come esso.

L utilità di queste specifiche scritte in maniera formale oltre a essere per la comunicazione con il cliente(se fosse solo per questo gli aprocci agile magari con attenzione al vocabolario delimitandole ad un certo significato(no sinonimi) sarebbe sufficiente), questo linguaggio piu formale e logico è che posso ragionarci sopra in modo molto più automatica, posso avviare fasi di verifica e convalida prima ancora di iniziare a scrivere il codice. quei pericoli di fraintendimenti di avere interpretato male o di non aver capito un problema possono essere risolti.

Problema: Passaggio a livello , con sensore prima del passaggio , noi dovevamo garantire che quando passava il treno noi abbasavamo la sbarra.
un secondo sensore ci avvisava del uscita del treno.

Soluzione:

2 parti del sistema: treno , passaggio a livello

-- img 2

la cosa che mette insiemde queste due parti del sistema è il fatto che perchè venga aperto qualcosa devo essere sicuro che sia uscito il treno , perchè venga chiesto di chiudere qualcosa deve essere segnato il treno è entrato in r .

se io provassi a simulare questa rete, non avrei solo i comportamenti voluti.

questa di per se non puo funzionare se non ha una informazione temporale, perchè se per eroore faccio scattare entraInL il treno passa con le sbarre alzate.

non posso mettere un test di entrata e uscita da chiuso a entra in l , perchè corrisponderebbe a dire al treno se sei su l e non è chiuso fai una frenata per inchiodare, è irreliastico , qui devo essere sicuro che quando il treno passa deve trovare il verde.

Per far questo dobbiamo intredurre i tempi

-- img3

per far questo dobbiamo ragionare sui tempi , abbiamo ragionato fin ad ora su zone e aree, da quando cè il sensore e si arriva l si ha un tempo t1, annalizziamo che c'è un limite di velocità dunque d'orario che deve rispettare , noto il limite di velocità che deve mantere,da li deriviamo il tempo minimo di percorrenza del treno nel lasso di tempo [sensore: i] è t1.

questa distanza del sensore con la messa a distanza adatta per darci il giusto preavviso per abbassare le sbarre.

cè un tempo t2, che è il tempo che dovrà percorrere la zona.
dispoenndo di queste 2 informazioni , possiamo arricchire la nostra specifica, ragionare con il cliente:
che in EntrainR non mi devo far trovare impreparato e posso aspettare un tempo t [0,infinito] , invece quando entro inL so passerà un tempo x(che calcolerò in base alla velocità massima  del treno).

non controllo i malfunziomenti sui sistema.

Chiamo il tempo G il tempo di chiusora del passaggio a livello

il ci dovrà t2 unità di tempo e puo aspettare un y di signalazione di uscita , t2 è poco affidabile, magari è in una falltollarenge dove controllo se t2+ numero alto no passa il treno creao un errore.

t2 è un dato superfluo , non mi serve per dare la risposta, l abbiamo messo 

quando il segnale mi arriva posso rialzare la sbarra

t1-G deve essere positivo. perchè altrimenti arriva il treno e la sbarra non è ancora abbassata.

 Questa rete sta usando una semantica temporale forte.
 
 nel momento in cui devo controllare un sistema , avere un tempo indefinito ci obliga ad avere una semantica forte.
 
 oltre al sistema se modelliamo anche l ambiente è piu facile avere una semantica debole dato che abbiamo meno controllo della situazione.
 
 il rischio di questo sistema è il fatto che ho dato per scontanto il fatto che io lavori solo con un treno, potrebbe essere sia interpretata come errore di specifiche o errore di cose non espresse,dunque la nostra soluzione non è corretta.
 
si potrebbe far si che non puo entrare un secondo treno fino a quando non è uscito quello precedente , come se ci fosse un semaforo entraInR è rosso fino a quando non esce da l.

se ho un treno esce e la zona è tutta libera e io cerco di chiudere prima che si sia aperta il treno mozza qualche persona.
possiamo far si che il treno si riabbassi appena un altro treno entraInR, prendiamo un tempo cuscinetto, lo facciamo ripartire da una situazione stabile. Dunque il treno passerà solo se sono in una situazione stabile e sotto controllo.

Oppure per ottimizzare facciamo abbasare la sbarra anche se sta aprendo ed è a metà.

questa rete potremmo simularla , potremmo costruire l albero di raggiungibilità. 
Però prima bisogna definirlo per poterlo fare.

## Fine esempio

Potevamo fare a meno del tempo? dunque considerando il tempo come concetto derivato?

non abbiamo guardato le reti ad alto livello , i gettoni hanno un contenuto informatico/dato arbitrariamente complesso (pure una classe per gettone). i gettoni gli distruggiamo e creiamo la nostra transizione deve guardare dentro i dati per farsene qualcosa ma il contenuto informatico è quello che io mi aspetto che sia abilitante alla transizione? la mia transizione scatta per un certo dato non per tutti i tipi di gettoni. Metto una ulteriore condizione per lo scatto della transizione ragionando sul contenuto informativi dei gettoni. Cosi' posso distruggerli in pace dato che gli ho analizzati , magari i gettoni che produciamo saranno uguali a quelli che distruggiamo , dunque abbiamo una guardia e una azione.

una rete di questo livello tra i campi di una classe avremo il campo che si chiama tempo , variabile associata ai gettoni (chronos), i predicati determinano la possibilità di scatto di una transizione a partire dai valori dei gettoni, gli definisce la stessa funzione che prima esprimevamo come l insieme dei tempi di possibile scatto come guardia della mia transizione che lavora sui cui posti , le azioni determinano e garantiscono i valori dei gettoni creati, calcoleranno i tempi dei gettoni in uscita stando attenti a produrre lo stesso valore per i gettoni creati e devono essere non minori dei valori dei chronos(tempi) dei gettoni rimossi.

Sintatticamente la parte di avere una rete con un certo contenuto informativo lo posso rappresentare.

dire che posso modellare come concetto secondario il tempo con semantica debole vuol dire che deve rispettare:
 
 - Chronos + assiomi 1,3 = WTS(weak time semantic), marcatura iniziale e definizione dei tempi di scatto(la guardia).
 - chronos + assiomi 1,2,3 = MWTS(monotonic weak time semantic), deve avanzare e mai tornare indietro, prendiamo un posto lo mettiamo in incresso e uscita a tutte le transizione in quel posto c'è sempre un getto con un tempo che è l ultimo scatto, visto che tutte le transizioni non possono scattare ad un tempo precendente a un gettone che hanno in ingresso. il gettono che forza l ultimo scatto porta alla monotonicità.Per far cio il costo è ancora accettabile.
 - chronos + assiomi 1,2,3,4,5 = STS, l interazione fra le varie entità è molto piu complicato dato che si basa su molti piu parametri in confronto dall' ultimo tempo di scatto, è possibile se c'è un posto in cui l informazione collegata a quel gettone in quelle transioni è l intera topologia di quella rete e l intero stato di quella rete.

Questo non vuol dire che non sia utile mettere insieme i linguaggi semanticamente deboli a quelli semanticamente forti, HLTPN(high level timed petri net) ,nel caso delle reti precedentemente usate si parlava di ER net(tunnel enviroment relationship net), le HLTPN possono modellare :
- aspetti funzionali (ER net), tipici della verifica ad alto livello
- aspetti temporali (TB net), il timestamp gestito tramite le funzioni Tmin e Tmax
- Dipendenze di aspetti funzionali da aspetti temporali , posso ragionare in maniera piu sensata ai problemi

immagine slide 9

sul esempio del sistema controaerea: se aggiungo la variabile del tempo, la variabile dipende  dalla velocità dei due oggetti , e non piu' in modo arbitrario, non sappiamo piu' solo in che tempo siamo ma anche altre informazioni del sistema diventano temporizzate. Queste reti qua sono piu' complesse , ma si nota che la parte complessa rimane quella temporale , i problemi rimangono gli stessi , se noi defianiamo delle tecniche di analisi per le reti time basic che ragionano sulla parte temporale, queste poi sono mutuabili in maniera identica sulle reti di alto livello temporizzate, perchè sono 2 aspetti ortogonali, la complessità rimane uguale nei due casi , ed è la parte piu' complessa dei due modelli. Appunto per questo i sistemi realtime sono molto piu' critici.

Analisi di reti temporizzate , solo aproccio dinamico

Analisi di raggiunbilità, consiste nell enumerazioni degli stati finiti raggiungibili, potevamo dominare le reti non limitate con l 'albero di copertura pero' andando a perdere delle informazioni pero' riuscendo a mantere una struttura capece a rispondere a varie domande , i problemi che saltano subito fuori quando si parla di una rete temporizzata sono:
- il momento che avviene lo scatto di una transizione puo' produrre infiniti stati che si differenziano tra loro per il tempo associati ai gettoni prodotti, stati tra di loro molto simili pero' il loro contenuto informativo è sempre diverso
- la rete puo evolvere all'infinito , quindi il tempo avanza dunque gli stati sono sempre diversi , quindi l albero di raggiungibilità è infinito , dunque è un problema utilizzarlo, non puo essere trattato nella stessa maniera dele reti non limitate, perchè li il concetto di copertura stava sul fatto che i gettoni fossero anonimi, qui abbiamo gettoni che si distuinguono tra di loro.

Rappresentazione simbolica degli stati , è una marcatura in termini di reti temporizzate, multiset di valori assegnati ad ogni posto , i vari valori dei vari gettoni per ogni posto ,  rappresenta un insime possibili stati con in comune lo stesso numero di gettoni in ogni posto (Marcatura P/T), uno stato simbolico dunque numerico è una coppia [µ, C], dove µ associa multiset di identificatori simbolici ai posti quindi associo degli identificatori invece di numeri, oltre agli insieme di simboli gli diamo C che sono i vincoli (dis)equazioni che rappresentano le relazioni tra gli identificatori simbolici.

Funzioni temporali , assumiamo che tf_t sia un intervallo con estremi inclusi esprimibili mediante espressioni lineari funzioni dei tempi dei token in ingresso e di tempi assoluti , fissiamo un tmin_t limite inferiore, tmax_t limite superiore che corrisponde a dire:

formula latex slide 12

immagine pag 13

Sample Reachability Tree

questa rete che abbiamo già studiato che aveva una transizione weak time semantic, e due a strong time semantic, le prime due erano in concorrente per i gettoni in t1 t2 invece t3 indipendente, similmente come era l albero di copertura c'è la prima fase che è l inizializzazione che vuol dire costrire un nodo radice del nostro albero che corrisponde alla marcatura iniziale, quando la facciamo simbolica possiamo definire un insieme di marcature:
S0: Marcatura: µ (P1) = {τ1} µ (P2) = {τ0} µ (P3) = {τ0} , C0 := 0 ≤ τ0 ∧ τ0 ≤ 10 ∧ τ0 ≤ τ1 ∧ τ1 ≤ τ0 + 15 , dunque adesso abbiamo uno stato creato con una sua definizione, ne prendiamo uno e indentifichaimoi gli enabling, S1: Marcatura: µ (P3) = {τ0} µ (P4) = {τ2} ,C1 := C0 ∧ τ2 ≤ τ0 + 5 ∧ τ1 ≤ τ ,  non ragiona su valori numeri ma su valori simbolici , almeno siamo sicuro che da s0 abbiamo le evoluzioni di tutte e 3 le transizioni,adesso vogliamo creare i nodi che vengono creati seguendo le possibili evoluzioni dunque Aggiornamento di marcatura e
vincoli S2: Marcatura: µ (P3) = {τ0} µ (P5) = {τ3},C2 := C0 ∧ τ3 ≥ τ1 + 8 ∧ τ3 ≤ τ0 + 10, alla fine è lo stesso ragionamento che faccio per cercare gli enabling, se trovo vincoli che si scontrano si a disabilitare la transizione, per l S3: Marcatura: µ (P1) = {τ1} µ (P2) = {τ0} µ (P6) = {τ4},C3 := C0 ∧ τ4 ≥ τ0 + 3 ∧ τ4 ≤ τ0 + 15 ∧ τ4 ≥ τ1 ∧ ( τ4 ≤ τ0 + 10 ∨ τ1 > τ0 + 2 ), è piu complicata perchè ha dei vincoli dati anche dalle altre transizioni dunque dovrà aspettare lo scatto di s2 a meno che non sia disabilitata.

immagine slide 14
notiamo che t2 non è abilitata , dunque non ha influenza sulle altra transizioni e qui t3 è molto piu' abilitata, t1 non ha influenza perchè è debole , dunque quello che accade è che dobbiamo dire che deve essere minore di τ0 + 4 oppure il suo tempo è vuoto ed ecco perchè il vincolo risulta molto piu complicato.

allora lo scatto simbolico di una transizione t crea uno stato simbolico caratterizzato dal vincolo Cn : formula latex slide 15, la soddisfacibilità del vincolo stabilice anche la abilitazione delle transizione.

Dunque se andiamo a rivedere il calcolo 

nel caso s1 dobbiamo anche aggiungere ∧ (τ2 ≤ τ0 + 10 ∨…) ∧ (τ2 ≤ τ0 + 15 ∨…)  nel caso s2 dobbiamo aggiungere ∧ (τ3 ≤ τ0 + 15 ∨…), invece nel caso s3 dobbiamo aggiungere  ( τ4 ≤ τ0 + 10 ∨ τ1 + 8 > τ0 + 10 ∨ τ1 > τ0 + 10), andando a mutare la parte della dipendenza da t2 con τ4 ≥ τ1.

dunque 

T1 aggiunge τ1 ≤ τn ∧ τn ≤ τ0 + 5 ∧ τn ≥ τ4 ∧ ( τn ≤ τ0 + 10 ∨ τ0 + 10 < τ1 + 8 ∨ τ0 + 10 < τ4 )
T2 aggiunge τ1 + 8 ≤ τn ∧ τn ≤ τ0 + 10 ∧ τn ≥ τ4

dunque T1 è abilitata solo se T1 è abilitata se τ4 ≤ τ0 + 5  e T2 è abilitata se τ1 ≤ τ0 + 2, troviamo un caso è solo abilitato T1: τ0 = 6, τ1 = 9, τ4 = 10, un caso in cui è solo abilitata T2: τ0 = 6, τ1 = 7, τ4 = 15, un caso in cui sono entrambe abilitate : τ0 = 6, τ1 = 7, τ4 = 10, è un caso finale in cui non c'è nessuna evoluzione (deadlock) : τ0 = 6, τ1 = 9, τ4 = 17.

T1,T2,T3 verranno marcati in base ai loro livelli di abilitazione, non abbiamo una forma normale per rappresentare questi stati , dunque non possiamo confrontare stati e scoprire se li abbiamo già visitati come avevamo fatto con gli alberi di copertura precedenti, abbiamo un albero infinito, apparrentemente inutile , puo capitare che faccia simultaneamente la verifica mentre costruisce i vari stati , dunque costruire fino al punto che mi interessa. Possiamo verificare prorità entro un limite finito di tempo, bounded invariance : qualcosa che non cambia ed è sempre vera, bounded liveness: qualcosa che raggiungero con i miei stati e queste cose posso verificarle in un tempo limitato di tempo. 

Vorremmo raggiungere dei grafi , dove il primo passo è arrivare a grafi aciclici per poi avvicinarci a quelli ciclici, se riusciamo a scordarci la sotria di come arriviamo a un nodo è possibile ritrovare degli stati , dunque come siamo arrivati ad arrivare ad una certe marcatura , facendo così riusciamo ad arrivare ad un grafo aciclico , perchè il terzo assioma proibisce di avere eventi infiti in un tempo finito in s0 dato che s0 è finito, pero' possiamo lo stesso muoverci verso i grafi aciclici semplificando dei constraints , esprimendo il costraint solo in termini della marcatura corrente, rimappando i costraint indiretti, dunque non dovrei associarli a nulla, dunque trasformare : µ (P4) = {τ7} µ (P6) = {τ4},C6 := 0 ≤ τ0 ∧ τ0 ≤ 10 ∧ τ0 ≤ τ1 ∧ τ1 ≤ τ0 + 15 ∧ τ4 ≤ τ0 + 15 ∧ τ1 ≤ τ4 ∧ τ4 ≥ τ0 + 3 ∧ (τ4 ≤ τ0 + 10 ∨ τ1 > τ0 + 2) ∧ τ7 ≤ τ0 + 5 ∧ τ4 ≤ τ7 , in µ (P4) = {τ2} µ (P6) = {τ1},C6 := τ1 ≥ 3 ∧ τ1 ≤ τ2 ∧ τ2 ≤ τ1+ 2 ∧ τ2 ≤ 15. rinnominando le mie marcature(τ4 è diventato τ1).

immagine matrice pag 22

questa cosa è fattibile applicando semplicemente l'algoritmo di Floyd, dove abbiamo una matrice dove mettiamo i nostri vincoli: A+2 <= B <= A+ 5,B <= C <= B + 6, posso togliere B mantenendo i vincoli , applicando floyd , prendendo la matrice basta trovare la relazione tra a e c , sommo le due disequazioni e trovo che a-b <= -2 e b-c <= 0 , scopro meccanicamente(applicando floyd) che converge.


Esempio:
rete di un caldaia immagine pag 24

tutto il sistema mira a guardare se la valvola è aperta(esce gas) e non c'è la fiamma faccio dei controlli dato che altrimenti salterebbe tutto in aria(se non so da quanto tempo c'è il gas aperto), analizziamo la parte sulla fiamma immagine slide 25 , notiamo che già questa singola parte ha stati infiniti , ma dato che abbiamo semplificato l uguaglianze tra gli stati, cerchiamo di contenere uno stato dentro un altro , Stato A è contenuto nello stato B se e solo se tutte le marcature rappresentate da A sono rappresentate anche da B(relazione di inclusione tra stati), dunque avranno lo stesso assegnamento di timestamp e C_A implica C_B, questo quando noto che mi va bene inglobare in uno stato un altro stato dato che coesistono tutte le volte che è vero A è vero anche B.

Esempio immagine slide 27

nella rete scatta t1 mi porta nello stato una volta normalizzato è avere t0 >=1 e il prossimo scatto con t0 >=2 e cosi' via , questo vuol dire che senza inclusione genererebbe infiniti stati (stessa marcatura ma con diversi vincoli, C1: T0 >= 1 , CN: Tn >= n).

immagine slide 28 
con questa piccola verifica siamo riusciti a condenzare un albero infiniti in un grafo finito, tuttavia non è abbastanza per il gas burner, notiamo che ci sono dei ricongiungimenti però ci sono delle costanti alte, abbiamo scale diverse ed abbiamo dei riferimenti sui tempi assoluti e questo non mi permette di trovare stati simili. abbiamo bisogno di osservare se le funzioni temporali non fanno riferimento a tempi assoluti, per essere capre di indentificare ciò che accade a partire da una marcatura bastano i constraint relativi tra i timestamp , ci basta sapere le relazione tra un gettone e un altro.

esempio su tempi relativi slide 30

in questo caso lo stato non include quello successivo , pero' se mi accorgo che non gli interessa di un tempo assoluto , considero i tempi costanti come variabili che possono essere eliminate dato che mantenere i riferimenti ai tempi assoluti genererebbe infiniti stati. questa modifica ci aiuta molto a semplificare la situazione ma non è abbastanza slide 31, ma abbiamo ancora dei tempi assoluti dato che ci sono i gettoni morti che non vengono eliminati, dunque si introducce il Time Anonymous Timestamp il quale dice che se il timestamp associato a un gettone in una marcatura M non verrà mai usato per stabilire come evolverà la rete a partire da quella marcatura, allora è possibile anonimizzare il tempo di tale gettone.

esempio di time Anonymous slide 33 immagine

ci accorgiamo che se scatta T2 abbiamo finito , toglie 2 gettoni e non ne crea, se scatta t1 consuma e rimette un nuovo gettone in p1 , per cui p2 rimane li e di seguito in qualsiasi stato verranno marcati sul fatto che p2 sia vuoto, dunque basta dimenticasi cosa c'è in p2 , quello che accade è che passo da uno stato dove ho p2 che marca in maniera errata i vari stati ad uno stato dove semplifico la situazione anonimizzando i tempi anonimi.

se uniamo queste 3 tecniche appena fatte dunque l inclusione, i tempi relativi e i tempi anonimi arriviamo ad un grafo finito. immagine slide 35.Troviamo soluzioni bounded.

Tuttavia abbiamo perso delle informazioni, con l inclusione abbiamo possibilmente creato dei cammini non percorribili (immagine slide 36), perdo delle relazioni precise tra gli stati per via dei vincoli relativi, possiamo arricchire le informazioni sugli archi per non perdere tutte le informazioni (immagine slide 37) , invece per via dei tempi anonimi vado a non sempre verificare raggiungibilità di una marcatura definita da vincoli sui timestamp, perdo questa informazione cerco di rieseguirlo per vedere cosa avveniva nel caso opposto in caso di necessità di analisi , dunque per concludere siamo passati dal problema di avere gettoni che avevano una informazione che li rendeva distinguibili a gettoni che hanno tempo TA a rendeli equivalenti(anonimizzati) e quindi rappresentabili globalmente da un numero.

non ancora dimostrato:
nelle reti temporizzate se sono non limitate significa che non sono limitate sul numero di gettoni TA che possono generare.

 
 
  







