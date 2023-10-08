# Metodologie Agili

Finora i modelli visti erano di tipo prettamente descrittivo; vediamo ora dei modelli più prescrittivi, che dicano cioè che cosa fare effettivamente durante lo sviluppo.

Le metodologie agili _"nascono dal basso"_, ovvero solitamente da chi sviluppa, per colmare un disagio prevalente nell'usare i metodi tradizionali. Si tratta di un mix di buone pratiche o deduzioni che già esisitono nell'ingegneria del software classica. Per tale motivo, di queste metodologie esiste un...

## [Manifesto](https://agilemanifesto.org/iso/it/manifesto.html)

Nelle parole di Fowler e i suoi collaboratori, per migliorare il modo in cui viene sviluppato il software, è necessario dare più importanza ad alcuni valori rispetto agli altri:

- Gli __individui__ e la __collaborazione tra individui__ è più importante di processi e strumenti.
- Il __software che funziona__ è più importante della documentazione ben fatta.
- La __collaborazione con il cliente__ è più importante del contratto.
- __Rispondere al cambiamento__ è più importante che seguire un piano.

> LIBRO: __Agile!__ di Bertrand Meyer

Come si vede, si tratta di un drastico cambio di rotta rispetto allo sviluppo tradizionale, che si evolve anche in un business model diverso.
Piuttosto che farsi pagare a programma finito, gli sviluppatori vengono pagati a tempo di sviluppo, dando però la garanzia al cliente di lavorare durante tale periodo esclusivamente per lui e al massimo delle proprie capacità. Al rapporto confluttuale con il cliente, in cui ciascuno cerca di fregare l'altro, si sostituisce dunque una collaborazione più estesa in cui, come vedremo, anche il cliente diventa parte del team di sviluppo.

Vediamo dunque alcune delle più famose metodologie agili, mettendone in evidenza gli aspetti peculiari.

## Lean Software
L'azienda Toyota, per migliorare la propria qualità, investì risorse per migliorare il suo processo produttivo. In questo modo nacque il progetto di _Lean Manufactioring_, che mirava ad una mass production in stile americano, ma cercando di ridurre gli sprechi al massimo, data la scarsità di risorse del paese.
Da questo evento presero ispirazione anche alcuni sviluppatori agile, che idearono il concetto di _lean software_, che ha l'obiettivo di __ridurre gli sprechi__, ovvero rimuovere tutti quei prodotti e sottoprodotti che non vengono consegnati al cliente  (es. testing, prototipi...) e dunque non generano valore: essi possono essere ignorati.
L'azienda Toyota dovette cercare di evitare sprechi di materiali e incentivò il riutilizzo per più tempo possibile degli stessi strumenti; parallelamente gli sviluppatori dovranno cercare di evitare di produrre funzionalità (o più in generale codice) inutili, ma puntare a riutilizzare codice già esistente o framework per semplificare il lavoro.

Come per Toyota, anche nell'ingegneria del software l'utilizzo della parallelizzazione dei processi porta grossi vantaggi, ad esempio sarà più semplice individuare prima possibili errori, e quindi bloccare gli altri processi prima che vengano terminati, limitando gli sprechi.
Un altro metodo interessante che viene utilizzato è quello di posticipare il più possibile le scelte vincolanti per aiutare a risparmiare risorse, più possibilità mi lascio aperte, più mi sarà facile adattarmi (a patto però che l'adattamento sia veloce).

Infine oltre al processo si cercherà di prendersi cura degli sviluppatori, l'azienda vorrà investire nel loro benessere per assicurarsi che restino "_fedeli_" e possano lavorare al meglio.

## Kanban

![Kanban](/assets/02_kanban.jpg)

L'obiettivo è quello di __minimizzare il lavoro in corso__ (work in progress), ovvero concentrarsi in ogni momento su una sola cosa in modo da evitare i continui _context switch_ che costituiscono una perdita di tempo, che accumulandosi può generare un grosso over-head.
Le attività possono per esempio essere organizzate in una tabella con 5 colonne:

- __backlog__: richieste dal cliente
- __da fare__: attività da fare in questa iterazione
- __in esecuzione__
- __in testing__
- __fatto__

La tabella dà a colpo d'occhio informazioni sullo stato del progetto per tutti. Ogni __card__ (storia) è assegnata a uno sviluppatore (o coppia nel _pair programming_), in modo che nella colonna "_in esecuzione_" vi sia una sola card per sviluppatore (o coppia).
Qualora il lavoro di uno sviluppatore ne blocchi il lavoro di un altro, è opportuno che quest'ultimo non inizi ad occuparsi di una nuova card, ma deve fornire supporto a chi sta lavorano sulla funzionalità di cui necessita.

## _Scrum_

È importante che l'intero team si focalizzi sull'iterazione corrente in maniera organizzata, infatti ogni membro deve sapere precisamente cosa fare senza un continuo cambio di richieste da parte del cliente.
Per permetterlo è opportuno __fissare i requisiti__ durante le iterazioni (__brevi__, da 2 a 4 settimane), in modo da permettere agli sviluppatori di lavorare in maniera stabile senza doversi adattare continuamente a nuove richieste.
Solo al termine di ogni iterazione, infatti, si permette al cliente di rimettere in discussione i requisiti.

## Crystal

Sebbene non sia molto apprezzata o usata, questa tecnica introduce l'interessante concetto di __comunicazione osmotica__. Nel modello a cascata la comunicazione è fatta tramite documenti rigidi, ed è settorializzata.
Con Crystal invece, la conoscenza viene vista come se fosse appartenente all'intero team, e non al singolo, questo perchè viene condivisa tra i vari membri tramite _"osmosi"_.
In questo modo il codice e le sue responsabilità non appartengono più al singolo sviluppatore ma all'intero gruppo, quindi ogni persona deve occuparsi e curare ogni parte del progetto.

Questo rende il processo più robusto, perché l'assenza di una persona esperta in un campo non è più in grado di bloccare completamente i lavori.
Il pair programming si basa su questo concetto, tra i due componenti la conoscenza è condivisa, e Crystal estende questo concetto all'intero team.

Si capisce però facilmente che questa tecnica funziona solo con team piccoli (max 8-10 persone), sebbene altre metodologie agili (_SAFE_) tentino di scalarla anche a team più massicci.  

## eXtreme Programming (XP)

Si tratta di una tecnica a cui dedicheremo una trattazione più approfondita nella prossima lezione. Per il momento accontentiamoci di enunciarne i due motti:

- __incrementa quindi semplifica__;
- __sviluppo guidato dal test__ (_test-first_: prima testa poi sviluppa).
