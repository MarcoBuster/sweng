# Gerrit

Gerrit, prima conosciuto come Mondrian, è un __sistema di review__ del codice sviluppato internamente da Google per gestire i suoi progetti _Open Source_ ormai diventati troppo grandi, come __Android__. Nasce dal numero troppo elevato di pull-request, data la grande partecipazione al progetto, e si basa sul concetto di "peer review": tutti gli sviluppatori sono autorizzati a fare review delle proposte di modifica di qualsiasi zona di codice.

Nel processo di review di Gerrit, i __developer__ possono sottoporre proposte di cambiamento utilizzando un sistema di "patch" che descrive le modifiche apportate al codice. 
I __reviewer__, ovvero gli altri sviluppatori del progetto, possono quindi esaminare le patch e decidere se accettarle o rifiutarle. 
Una volta che una patch ha ricevuto un numero sufficiente di review positivi, viene automaticamente integrata nel __repository principale autoritativo__ in cui tutti hanno accesso in sola lettura.

Gerrit obbliga a strutturare le modifiche proposte non come una storia di commit ma come un unico commit (_changeset_) al momento dell'accettazione. 
Ciò significa che tutte le modifiche apportate devono essere fuse in un unico commit (sotto git utilizza degli amend), in modo da rendere più facile la gestione del repository e per evitare la nascita di troppi rami. 
Al momento della review, invece, le modifiche rimangono separate in versioni singole, ovvero ogni modifica viene presentata come un commit separato (quindi vi è la storia), in modo che i reviewer possano esaminarle più facilmente.

Due figure importanti devono fare parte di questo processo:

## Verifier

Il verifier è uno strumento o un processo che viene utilizzato in Gerrit per verificare che le modifiche proposte siano corrette e funzionino come dovrebbero. 
In particolare, il verifier scarica la patch, la compila, esegue i test e controlla che ci siano tutte le funzioni necessarie. 
Se il verifier rileva dei problemi, può segnalarli al team di sviluppo perché vengano corretti prima che la patch venga accettata.

È un processo semplice quindi può essere anche automatizzato o eseguito da utenti poco esperti o riconosciuti.

Una volta terminato il proprio processo, approva le modifiche votandole positivamente.
Solitamente sono necessari 1 o 2 voti per procedere.

## Approver

Una volta verificata, una proposta di modifiche deve essere anche approvata. 
L'approvatore, che dovrà avere una certa esperienza, dato che non si tratta più di un lavoro meccanico ma "_filosofico_" deve determinare la risposta alle seguenti domande riguardo la proposta di modifiche:
- _è valida per lo scopo del progetto?_
- _è valida per l'architettura del progetto?_
- _introduce nuove falle nel design che potrebbero causare problemi in futuro?_
- _segue le best practices stabilite dal progetto?_
- _è un buon modo per implementare la propria funzione?_
- _introduce rischi per la sicurezza o la stabilità?_

Se l'approver ritiene che la proposta di modifiche sia valida, può approvarla scrivendo "LGTM" (acronimo di _"Looks Good To Me"_) nei commenti della pull request.

Esiste poi una gerarchia di approver, data dalla loro esperienza e contributo, i cui voti avranno valori diversi, in questo modo è possibile fare una review distribuita migliore (ad esempio se le modifiche riguardano l'interfaccia grafica, i voti di un esperto di interfacce grafiche avranno un peso maggiore).

## Architettura
![Gerrit](/assets/06_gerrit.png)

L'architettura di gerrit è composta da due repository:
- __Authoritative repository__: repository in cui vi è solo il diritto di lettura dall'esterno (_fetch_), mentre è presente il diritto di scrittura solo dall'interno da parte dell'altro repository (submit);
- __Pending Changes__: repository in cui i developer hanno solo diritto in scrittura, mentre i reviewer hanno dei diritti speciali che gli permettono di scaricare le modifiche, valutarle e commentarle.

I developer inviano delle modifiche al repository di pending Changes, da cui i reviewer faranno tutte le verifiche e valuteranno il lavoro proposto.
A questo punto, una volta che una patch raggiunge un certo numero di valutazioni positive verrà migrata sull'authoritative repository (compilando e ricontrollato tutto automaticamente) e i developer potranno vedere le nuove modifiche aggiunte.