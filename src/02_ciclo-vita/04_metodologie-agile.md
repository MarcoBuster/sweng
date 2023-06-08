# Metodologie Agili

Finora i modelli visti erano di tipo prettamente descrittivo; vediamo ora dei modelli più prescrittivi, che dicano cioè che cosa fare effettivamente durante lo sviluppo.

Le metodologie agili _"nascono dal basso"_, ovvero solitamente da chi sviluppa, per colmare un disagio prevalente nell'usare i metodi tradizionali. Per tale motivo, di tali metodologie esiste un...

## [Manifesto](https://agilemanifesto.org/iso/it/manifesto.html)

Nelle parole di Fowler e i suoi collaboratori, per migliorare il modo in cui sviluppiamo il software dobbiamo dare più importanza ad alcuni valori rispetto agli altri:

- Gli __individui__ e la __collaborazione tra individui__ è più importante di processi e strumenti.
- Il __software che funziona__ è più importante della documentazione ben fatta.
- La __collaborazione con il cliente__ è più importante del contratto.
- __Rispondere al cambiamento__ è più importante che seguire un piano.

> LIBRO: __Agile!__ di Bertrand Meyer

Come si vede, si tratta di un drastico cambio di rotta rispetto allo sviluppo tradizionale, che si evolve anche in un business model diverso: piuttosto che farsi pagare a programma finito, adesso gli sviluppatori vogliono farsi pagare a tempo di sviluppo, dando però la garanzia al cliente di lavorare durante tale periodo esclusivamente per lui e al massimo delle proprie capacità. Al rapporto confluttuale con il cliente, in cui ciascuno cerca di fregare l'altro, si sostituisce dunque una collaborazione più estesa in cui, come vedremo, anche il cliente diventa parte del team di sviluppo.

Vediamo dunque adesso alcune delle più famose metodologie agili, mettendone in evidenza gli aspetti peculiari.

## Lean Software

Nato dal progetto di _Lean Manufactioring_ della Toyota, ha l'obiettivo di __ridurre gli sprechi__, ovvero quei prodotti e sottoprodotti che non vengono consegnati al cliente  (es. testing, prototipi...) e dunque non generano valore: essi possono essere ignorati.

Un'altra idea interessante è quella di posticipare il più possibile le scelte vincolanti per aiutare a risparmiare risorse: più possibilità mi lascio aperte, più mi sarà facile adattarmi (a patto però che l'adattamento sia veloce).

## Kanban

![Kanban](/assets/02_kanban.jpg)

L'obiettivo è qui invece di __minimizzare il lavoro in corso__ (work in progress), ovvero concentrarsi in ogni momento su una sola cosa in modo da evitare i continui _context switch_ che costituiscono una perdita di tempo.
Le attività possono per esempio essere organizzate in una tabella con 5 colonne:

- __backlog__: richieste dal cliente
- __da fare__: attività da fare in questa iterazione
- __in esecuzione__
- __in testing__
- __fatto__

La tabella dà a colpo d'occhio informazioni sullo stato del progetto per tutti. Ogni __card__ (storia) è assegnata a uno sviluppatore (o coppia nel _pair programming_), in modo che nella colonna in esecuzione vi sia una sola card per sviluppatore (o coppia); qualora il lavoro di un altro blocchi il mio lavoro in qualche modo è poi mia responsabilità aiutarlo per rimuovere il blocco.

## _Scrum_

L'obiettivo è __fissare i requisiti__ durante le iterazioni (__brevi__, da 2 a 4 settimane), in modo da permettere agli sviluppatori di lavorare in pace senza doversi adattare continuamente a nuove richieste. Solo al termine di ogni iterazione, infatti, si permette al cliente di rimettere in discussione i requisiti.

## Crystal

Sebbene non sia molto apprezzata o usata, questa tecnica introduce l'interessante concetto di __comunicazione osmotica__. Nel modello a cascata la comunicazione è fatta tramite documenti rigidi, ed è settorializzata; in Crystal la conoscenza viene condivisa nel team tramite _"osmosi"_, in modo che tutti sappiano un po' di tutto.

Questo rende il processo più robusto, perché l'assenza di una persona esperta in un campo non è più in grado di bloccare completamente i lavori. Il pair programming è in quest'ottica: tra i due componenti la conoscenza è condivisa; Crystal estende questo concetto all'intero team.

Si capisce però facilmente che questa tecnica funziona solo con team piccoli (max 8-10 persone), sebbene altre metodologie agili (_SAFE_) tentino di scalarla anche a team più massicci.  

## eXtreme Programming (XP)

Si tratta di una tecnica a cui dedicheremo una trattazione più approfondita nella prossima lezione. Per il momento accontentiamoci di enunciarne i due motti:

- __incrementa quindi semplifica__;
- __sviluppo guidato dal test__ (_test-first_: prima testa poi sviluppa).
