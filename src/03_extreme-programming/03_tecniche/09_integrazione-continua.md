# Integrazione continua
Nell'ottica di ricevere feedback rapidi dal cliente è necessario __integrare spesso__, anche __più volte al giorno__. 
Questo non significa far passare i test d'unità per integrare tutto in un'unica operazione, ma essere graduali: è frequente scoprire che parti testate e funzionanti singolarmente una volta integrate nel prodotto finale non funzionano. 

L'integrazione continua e graduale è una tecnica largamente utilizzata in tutti i campi, non solo nello sviluppo software. Se effettuata spesso dovrebbe risultare in un azione semplice e veloce, date le poche modifiche dalla versione precedente.

Al termine dello sviluppo di una _feature_, è compito della coppia integrarla nella __macchina di riferimento__.
L'accesso a tale macchina deve essere regolato in maniera __esclusiva__: in situazioni di lavoro da remoto si può utilizzare un token.
La macchina di riferimento si trova, per quanto riguarda le funzionalità, in una situazione __monotona crescente__.
Ad ogni integrazione è necessario produrre sempre qualcosa di consegnabile al cliente. 

Una _user story_ si definisce __completata__ solo dopo aver terminato l'integrazione, superato dei test di integrazione e aver mostrato al cliente il risultato della macchina complessiva dopo l'integrazione.

Un'altro punto a favore della continua integrazione è che evita la situazione in cui una coppia modifichi la macchina __dopo molto tempo__ dalla propria ultima integrazione, aumentando di molto la probabilità di errori per le altre coppie. 

Se una coppia __non riesce ad integrare__ blocca anche tutte le altre che non possono andare avanti con le use story, quindi sarà necessario che quella coppia rinunci, ritorni sulla sua macchina e cerchi di risolvere lì - tutte le coppie hanno una propria macchina su cui testano prima di farlo su quella comune.
