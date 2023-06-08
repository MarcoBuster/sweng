# Gerrit

Gerrit è un __sistema di review__ del codice sviluppato internamente da Google per gestire i progetti interni; si basa sul concetto di "peer review": tutti gli sviluppatori sono autorizzati a fare review delle proposte di modifica di qualsiasi zona di codice.

Nel processo di review di Gerrit, i __developer__ possono sottoporre proposte di cambiamento utilizzando un sistema di "patch" che descrive le modifiche apportate al codice. 
I __reviewer__, ovvero gli altri sviluppatori del progetto, possono quindi esaminare le patch e decidere se accettarle o rifiutarle. 
Una volta che una patch ha ricevuto un numero sufficiente di review positivi, viene automaticamente integrata nel __repository principale autoritativo__   in cui tutti hanno accesso in sola lettura.

Gerrit obbliga a strutturare le modifiche (_changeset_) in un unico commit (tecnica _squash_) al momento dell'accettazione. 
Ciò significa che tutte le modifiche apportate devono essere fuse in un unico commit, in modo da rendere più facile la gestione del repository. 
Al momento della review, invece, le modifiche rimangono separate in versioni singole, ovvero ogni modifica viene presentata come un commit separato, in modo che i reviewer possano esaminarle più facilmente.

## Verifier

Il verifier è uno strumento o un processo che viene utilizzato in Gerrit per verificare che le modifiche proposte siano corrette e funzionino come dovrebbero. 
In particolare, il verifier scarica la patch, la compila, esegue i test e controlla che ci siano tutte le funzioni necessarie. 
Se il verifier rileva dei problemi, può segnalarli al team di sviluppo perché vengano corretti prima che la patch venga accettata.

Una volta terminato il proprio processo, approva le modifiche votandole positivamente.
Solitamente sono necessari 1 o 2 voti per procedere.

## Approver

Una volta verificata, una proposta di modifiche deve essere anche approvata. 
L'approvatore deve determinare la risposta alle seguenti domande riguardo la proposta di modifiche:
- _è valida per lo scopo del progetto?_
- _è valida per l'architettura del progetto?_
- _introduce nuove falle nel design che potrebbero causare problemi in futuro?_
- _segue le best practices stabilite dal progetto?_
- _è un buon modo per implementare la propria funzione?_
- _introduce rischi per la sicurezza o la stabilità?_

Se l'approver ritiene che la proposta di modifiche sia valida, può approvarla scrivendo "LGTM" (acronimo di _"Looks Good To Me"_) nei commenti della pull request.
