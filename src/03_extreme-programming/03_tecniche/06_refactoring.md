# Refactoring

Anche da novizi, non bisogna avere paura di apportare modifiche che semplificano il progetto: bisogna avere coraggio.

Il refactoring è l'operazione che __modifica solo le proprietà interne__ del software, ad esempio la leggibilità, la semplicità e la facilità di aggiungere nuove funzioni ma __non le funzionalità stesse__.

L'obiettivo è eliminare l'entropia generata dalle continue modifiche e aggiunte.

Il refactoring deve essere __graduale e continuo__ in modo da poter aggiungere funzionalità in maniera semplice. 
Chiaramente, in caso di ristrutturazioni architetturali di grosse dimensioni di sistemi legacy non è sempre possibile procedere in questa maniera.

Le parti di codice che vengono aggiunte o modificate devono essere stimolate da test per garantirne la correttezza, se ciò non accade: o si aggiungono test per gestire i casi specifici, altrimenti si possono rimuovere _in toto_.

Il refactoring è una delle tecniche più __importanti__ e __fondamentali__ dell'XP.
