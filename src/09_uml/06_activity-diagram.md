# Activity diagram

## Concetto e struttura

Gli _activity diagram_ nascono per rappresentare sistemi concorrenti, inoltre presentano una conformazione simile agli _state diagram_, ma con svariate differenze:

* al posto degli stati vi sono le **attività**;
* non si usano più le transizioni etichettate tramite eventi &#8211; queste sono quasi tutte **implicitamente
  temporizzate** (quando un'attività termina si passa alla prossima implicitamente);
* possono esserci ***azioni* dentro le attività**;
* le *attività* possono rappresentare **elementi esterni** al sistema.

La peculiarità che distingue questo tipo di diagrammi con lo state diagram è la capacità di collegarsi con 
attività esterne (ovvero non fatte dal sistema) fa sì che sia possibile utilizzare gli activity diagram come 
**collante** con e tra diversi casi d'uso.

Inoltre la **visuale parzialmente informale**, eppure leggermente più tecnica e profonda rispetto ai diagrammi dei casi
d'uso, rende gli activity diagram un **ottimo mezzo di comunicazione interna** (*e.g.* con un manager).

## Livelli di astrazione

Si possono utilizzare i diagrammi delle attività per:

- descrivere la logica interna di un __business process__ (caso più comune);
- descrivere il __flusso interno di un metodo__, con eventuali indicazioni di (pseudo)concorrenza;
- dettagliare il __flusso di un caso d'uso__, ovvero chiarire meglio il suo flusso di esecuzione rispetto ad altri
  diagrammi (*e.g.* Sequence Diagram).
  Questa rappresentazione è assai utile nei casi in cui, ad esempio, la concorrenza è un fattore rilevante.

## Sincronizzazione

![Esempio activity diagram](/assets/11_activity-example.png)

Attraverso l'uso di barre si possono stabilire dei punti di sincronizzazione (JOIN). \
I JOIN, se non diversamente specificato, vengono considerati in ___AND___.

È però possibile porre dei vincoli diversi per stabilire i criteri di soddisfacimento della barra di sincronizzazione 
(come una __*OR*__).

## Decisioni

![Esempio activity decision diagram](/assets/11_activity-decision-example.png)

È possibile specificare nel flusso di esecuzione dei momenti di __decisione__.
I corsi d'azione intraprendibili in questi frangenti sono rappresentati tramite degli archi.

Le decisioni devono rispettare due proprietà:

* gli archi collegati alla decisione devono essere __mutualmente esclusivi__;
* l'__unione__ delle condizioni di decisione deve essere sempre vera.

È bene puntualizzare che i punti di decisione sono _veri_ momenti di decisione umana, non banali valutazioni di una
condizione logica.

## Swim lane

![Swim lane esempio](/assets/11_activity-swim-lane-example.png)

Si può partizionare il diagramma al fine di rappresentare, sulle singole _activity_, delle particolari responsibilità
che è bene dividere dalle altre.
Queste vengono visualizzate tramite delle _"corsie"_ verticali che identificano _chi_ svolge una determinata attività.
