# Archi inibitori

Esiste un'altra estenzione delle reti di petri in cui si utilizzano gli __archi inibitori__, ovvero degli archi che indicano la situazione in cui una transizione ha bisogno che **non siano presenti gettoni nel posto** in modo che possa essere abilitata.
Un _arco inibitore di peso \\(n\\)_ indica che la transizione collegata è abilitata se nel posto collegato sono presenti **meno di** \\(n\\) gettoni.

In caso di **rete limitata** la **potenza espressiva** di una rete che sfrutta gli archi inibitori **non cambia**, perché esistendo un limite massimo \\(k\\) di gettoni all'interno della rete sarà sufficiente creare un posto complementare contente un numero di gettoni tali per cui la somma tra quest'ultimi e i gettoni presenti nel posto considerato sia minore di \\(k\\). \
A questo punto è necessario che siano presenti due archi (uno in ingresso e uno in uscita) di peso \\(k\\), in modo da permettere lo scatto della transizione solo nel caso in cui tutti i gettoni siano all'interno del posto complementare. \
In realtà **non è necessario** che tutta la rete sia limitata, è sufficiente che il singolo posto lo sia: è necessario garantire che qualunque sia lo _stato generale_ della rete, in quel preciso posto non ci siano più di \\(k\\) gettoni.

Nel caso di una rete **non limitata** invece non è sempre possibile avere una traduzione equivalente della rete di Petri: la **potenza espressiva** delle reti con gli archi inibitori **aumenta**.

Il problema degli archi inibitori è che rendono **inutilizzabili** alcune **tecniche di analisi** che verranno affrontate successivamente.

<!-- *nessuno* ne sentiva la mancanza :) -->
