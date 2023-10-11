# Testing

È consolidato su due fronti:
- i clienti scrivono i __test di accettazione__ (o funzionali) sulle schede per aumentare la loro fiducia nel programmi;
- i programmatori scrivono i __test di unità__ perché la fiducia nel codice diventi parte del programma stesso.

Nell'XP ogni aspetto viene massimizzato, ma in particolare il testing viene esasperato di più in quanto, oltre ad essere molto importante, molti altri aspetti si basano su di esso (vedi la figura all'inizio della sezione). 
Ha il ruolo di __rete di protezione__ in tutte le fasi: ogni cambiamento è verificabile tramite i test.

Il testing aiuta molto anche quando non si parte da zero con il programma, ma quando si deve modificare un programma proprietario precedentemente sviluppato anche in modalità non agile.
Prima di apportare modifiche al codice scrivo i test e solo successivamente procedo, in modo da non causare problemi (solitamente non si fanno test su cose che non modifico).

Il testing solitamente viene lasciato alla fine, dopo lo sviluppo del progetto, ma facendo in questo modo è facile trascurare la fase di testing non identificando possibili errori.
Infatti è preferibile anticipare la scrittura del test al momento precedente della scrittura del codice, in modo tale da guidare lo sviluppo e garantire una migliore correttezza.

Infine il testing facilita la fase di refactoring, questo perchè se il test non fallisce anche dopo aver modificato il codice della feature abbiamo la sicurezza di non aver alterato la feature.

Un altro concetto importante è che i test dovrebbero __coprire tutte le righe di codice__.