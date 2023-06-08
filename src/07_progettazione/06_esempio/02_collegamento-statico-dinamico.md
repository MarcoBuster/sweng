# Collegamento statico e dinamico

Notare come è necessario specificare __staticamente__ che `Deck` implementi `CardSource`, ovvero occorre forzare la dichiarazione del fatto che `Deck` sia un _sottotipo_ di `CardSource` (Java è strong typed) e quindi sia possibile mettere un oggetto `Deck` ovunque sia richiesto un oggetto `CardSource`. \
In altri linguaggi come __Go__ c'è una __maggiore dinamicità__ perché non c'è bisogno di specificare nel codice che un oggetto è sottotipo di qualcos'altro, è sufficiente solo che implementi un metodo con la stessa signature.
Il controllo che l'oggetto passato ad una funzione abbia le capacità necessarie avviene a runtime e non prima.

Un problema della troppa dinamicità (__duck typing__) è che se i metodi di un oggetto non hanno dei nomi abbastanza specifici si possono avere dei problemi. 
Per esempio, in un programma per il gioco del tennis se una funzione richiede un oggetto che implementa il metodo `play()`, e riceve in input un oggetto che non c'entra nulla con il tennis (per esempio un oggetto di tipo `GiocatoreDiScacchi`) che ha il metodo `play()`, si possono avere degli effetti indesiderati.
