# Testing

È consolidato su due fronti:
- i clienti scrivono i __test di accettazione__ (o funzionali) sulle schede per aumentare la loro fiducia nel programmi;
- i programmatori scrivono i __test di unità__ perché la fiducia nel codice diventi parte del programma stesso.

Nell'XP ogni aspetto viene massimizzato, ma in particolare il testing viene esasperato di più in quanto, oltre ad essere molto importante, molti altri aspetti si basano su di esso (vedi la figura all'inizio della sezione). 
Ha il ruolo di __rete di protezione__ in tutte le fasi: ogni cambiamento è verificabile tramite i test.

Il testing aiuta molto anche quando non si parte da zero con il programma, ma quando si deve modificare un programma proprietario precedentemente sviluppato anche in modalità non agile.
Prima di apportare modifiche al codice scrivo i test e solo successivamente procedo, in modo da non causare problemi (solitamente non si fanno test su cose che non modifico).

Un altro concetto importante è che i test dovrebbero __coprire tutte le righe di codice__.