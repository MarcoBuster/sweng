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

- [**Definizioni**](./01_definizioni.md)
- [**Macchine a stati finiti**](./02_fsm.md)
- [**Relazioni tra transizioni**](./03_relazioni/00_index.md)
- [**Insieme di raggiungibilità**](./04_insieme-raggiungibilita.md)
- [**Limitatezza**](./05_limitatezza.md)
- [**Vitalità di una transizione**](./06_vitalita.md)
- [**Capacità dei posti**](./07_capacita.md)
- [**Archi inibitori**](./08_archi-inibitori.md)
- [**Eliminazione pesi sugli archi**](./09_pesi-archi.md)
- [**Conservatività**](./10_conservativita.md)
- [**Stato base e rete revertibile**](./11_stato-base.md)
