# Refactoring

Anche da novizi, non bisogna avere paura di apportare modifiche che semplificano il progetto: bisogna avere coraggio.

Il refactoring è l'operazione che __modifica solo le proprietà interne__ del software, __non le funzionalità__.
L'obiettivo è eliminare l'entropia generata dalle continue modifiche e aggiunte.

Il refactoring deve essere __graduale e continuo__ in modo da poter aggiungere funzionalità in maniera semplice. 
Chiaramente, in caso di ristrutturazioni architetturali di grosse dimensioni di sistemi legacy non è sempre possibile procedere in questa maniera.

Parti di codice non stimolate da test non sono utili ai fini della soluzione: o si aggiungono test per gestire i casi specifici, altrimenti si possono rimuovere _in toto_.

Il refactoring è una delle tecniche più __importanti__ e __fondamentali__ dell'XP.
