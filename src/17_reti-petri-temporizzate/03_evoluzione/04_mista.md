# Semantica temporale mista

Può però capitare che dover imporre una semantica temporale fissa per l'intera rete si riveli limitante nella modellazione di sistemi reali: questi potrebbero infatti includere sia agenti deterministici (_es. computer_) che agenti stocastici (_es. esseri umani_).

Si introduce quindi una nuova __semantica temporale mista__ (_Mixed Time Semantic_), in cui la semantica temporale debole (monotonica) o forte viene associata alle __singole transizioni__ piuttosto che all'intera rete.
In questo modo:

- le __transizioni forti__ _dovranno_ scattare entro il loro tempo massimo a meno che non vengano disabilitate prima;
- le __transizioni deboli__ _potranno_ scattare in uno qualunque dei loro possibili tempi di scatto.

Essendo meno comuni, solitamente sono le transizioni deboli ad essere esplicitamente indicate graficamente nelle reti con una \\(W\\) all'interno del rettangolo che le rappresenta: tutte le altre transizioni sono invece di default considerate forti.

## Analisi di abilitazione in presenza di transizioni fortis

Introdotta quindi la possibilità che esistano all'interno delle reti delle transizioni forti che devono necessariamente scattare entro il loro tempo massimo di scatto non è ora più tanto semplice fare __analisi di abilitazione__, vale a dire quel tipo di analisi che cerca di tracciare su una linea temporale gli intervalli durante i quali certe transizioni sono abilitate.

Per capire perché, osserviamo la seguente rete Time Basic, che segue una semantica temporale mista:

![](/assets/16_analisi-rete.png)

Analizzando localmente le singole transizioni, come se avessero tutte semantica temporale debole, si può ottenere il seguente diagramma temporale di abilitazione:

![](/assets/16_analisi-1.png)

Tuttavia, questo diagramma è __scorretto__.
La presenza di una transizione forte che deve scattare entro il tempo 10, ovvero T2, non ci permette di dire nulla oltre tale tempo, in quanto _il suo scatto potrebbe disabilitare altre transizioni_.
Questo era vero anche per la transizione debole T1, ma il suo essere debole permetteva comunque di ignorare tale eventualità nella prospettiva che la transizione, pur potendo, non scattasse: questo tipo di ragionamento non è però purtroppo più possibile in semantica temporale forte.

In sostanza, __le transizioni forti bloccano il nostro orizzonte temporale__. \
Ecco dunque che il vero diagramma temporale di abilitazione della rete è il seguente:

![](/assets/16_analisi-2.png)
