# State diagram

## Concetto e struttura

L'obiettivo del **diagramma di stato** è fornire un'astrazione di comportamento significativa che sia comune all'intera classe.

La sua struttura deriva dai classici *State Charts*, dei quali costituisce un'ulteriore astrazione.

Al fine di comprendere meglio i diagrammi di stato, può essere utile ricordare che:

> Negli _State Charts_, un automa è una sestupla \\(\langle S, \\, I, \\, U; \\; \delta, \\, t, \\, s_0 \rangle\\).
> - \\(S\\): insieme finito e non vuoto degli stati;
> - \\(I\\): insieme finito dei possibili ingressi;
> - \\(U\\): insieme finito delle possibili uscite;
> - \\(\delta\\): funzione di transizione;
> - \\(t\\): funzione di uscita;
> - \\(s_0\\): stato iniziale.

Negli _State Diagram_, ogni _stato_ è rappresentato da un rettangolo e lo _stato iniziale_ è indicato da un pallino nero.

![](/assets/11_state-diagram-example.png)

Nel diagramma le frecce possono avere diversi significati:
- **evento/azione**: semplice e immediata transizione da uno stato ad un altro;
- **guardie**: disambiguano le transazioni in uscita da uno stato che sono legate ad uno stesso evento;
- **_time event_**: rappresentano eventi temporizzati. 
    * *After(duration)*: indicano un tempo massimo di permanenza nello stato destinazione. \
    Allo scadere del timer, lo stato cambia.
* **_change event_**: rappresentano eventi che si innescano al verificarsi di un cambiamento.
    * *When(condition)*: indicano eventi espressi in termini di valori degli attributi.

Il verificarsi di eventi non esplicitamente marcati da un arco deve portare alla terminazione dell'esecuzione e al sollevamento di un errore.
