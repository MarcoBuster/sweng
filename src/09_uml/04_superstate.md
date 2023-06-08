# Superstate

Ulteriore evoluzione dello State Diagram, il **Superstate** consente di rappresentare più facilmente una "gerarchia" di stati.

La transizione in uno stato può quindi condurre ad un'altra FSM concettualmente "innestata".

![Esempio superstate](/assets/11_superstate-example.png)

Nel caso d'esempio, lo stato `acceso` possiede al suo interno un ulteriore diagramma di stato.

## Ulteriori aggiunte

* è possibile associare al diagramma uno stato **_history_**, il cui scopo è memorizzare lo stato storico prima dell'interruzione dell'FSM;
* è possibile rendere il diagramma capace di rappresentare il concetto di **concorrenza** tramite la divisione in **regioni** (ognuna regolata da una propria FSM).
Le regioni possono essere attive contemporaneamente. I confini tra regioni, come mostrato nell'esempio, sono identificati da linee tratteggiate.

![Esempio concorrenza](/assets/11_concurrency-example.png)
