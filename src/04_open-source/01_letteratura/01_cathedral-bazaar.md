# _The Cathedral and the Bazaar_

Raymond propone nel suo [articolo](http://www.catb.org/~esr/writings/cathedral-bazaar/cathedral-bazaar/) due immagini per descrivere i due mondi contrapposti closed-source e open-source:

- la __cattedrale__ (closed source): si tratta di un ambiente molto gerarchizzato, fortemente legato al progetto iniziale di un unico "architetto" responsabile dei lavori;
- il __bazaar__ (open source): è l'ambiente più anarchico possibile, in cui ognuno lavora per sé e costruisce espandendo ciò che gli altri hanno già fatto.

Entrambe le costruzioni risultano splendide e attraenti, ma sono chiaramente legate a modi di pensare la costruzione e la progettazione totalmente opposti.

## Vita e vantaggi di un progetto open-source

Nell'articolo Raymond prosegue a descrivere come nasce un progetto open-source, esordendo con la seguente citazione:

> Ogni buon lavoro software inizia dalla frenesia personale di un singolo sviluppatore.

Si delinea dunque la seguente timeline di un progetto open-source:

1. Uno sviluppatore ha un problema e intende risolverlo sviluppando un'applicazione.
2. Lo sviluppatore chiede ad amici o colleghi cosa sanno sull'argomento: alcuni hanno lo stesso problema o problemi simili, ma nessuno ha una soluzione.
3. Le persone interessate cominciano a scambiarsi pareri e conoscenze sull'argomento.
4. Coloro che intendono spendere delle risorse (di fatto il proprio tempo libero) per risolvere il problema danno il via ad un progetto informale.
5. I membri del progetto lavorano sul problema finché non raggiungono dei risultati presentabili.

    Fino a qui però il progetto non è ancora definibile open-source in quanto vi lavora solo un gruppo ristretto di amici e conoscenti: il vero progetto open nasce quando __viene messo online a disposizione di tutti il codice sorgente__. Continuando, dunque:

6. Si rende noto il lavoro online e arrivano i primi suggerimenti esterni al gruppo: questi saranno tanto più frequenti quanto più il progetto pubblicato presenterà errori in quanto la comunità, principalmente composta da altri sviluppatori, sarà motivata a risolverli.
7. Si crea interazione tra i vecchi e i nuovi membri del gruppo di sviluppo.
8. Nuove informazioni e competenze vengono acquisite e si ritorna al punto 5.

Raymond continua esponendo alcune delle caratteristiche e dei vantaggi dei progetti open-source, primo fra tutti il fatto che:

> Se dai a tutti il codice sorgente, ognuno di essi diventa un tuo ingegnere.

dove con questo si intende che la possibilità di vedere e commentare il codice sorgente permette a utenti esperti di suggerire modifiche e prendere parte attiva allo sviluppo. Talvolta si tende però a pensare che un progetto di questo tipo sia destinato unicamente ad altri informatici o sviluppatori, ma ciò non è affatto vero: tante attività utili a portare avanti un progetto open-source non richiedono necessariamente competenze informatiche, come per esempio la segnalazione di bug o la moderazione di contenuti nella comunità.

A tal proposito, è importante il seguente concetto:

> Se ci sono abbastanza occhi [che cercano errori], gli errori diventano di poco conto.

Non c'è molto da spiegare: più sono le persone che controllano e leggono il codice più sarà probabile trovare gli errori in esso contenuti; inoltre, gli errori rilevati possono essere risolti più facilmente grazie al supporto della community di sviluppatori, che potrebbe già conoscere una soluzione. \
L'accento posto sulla community viene ulteriormente rimarcato dal valore che viene attribuito ai beta-tester, che in un progetto open-source è chiunque utilizzi l'applicazione in qualunque suo stadio vista la sua estrema malleabilità:

> Se tratti i tuoi beta-tester come se fossero la tua risorsa più importante, essi risponderanno diventando la tua risorsa più importante.

Per mantenere attiva la community di sviluppatori è però necessario un costante monitoraggio e cura; per permettere al progetto open-source di sopravvivere anche quando l'interesse dei creatori originali si è spento è fondamentale passarne il controllo a qualcuno di fidato e competente, come ci ricorda Raymond nell'ultima citazione che riportiamo:

> Quando hai perso interesse in un programma, l'ultimo tuo dovere è passarlo a un successore competente.

Spesso questo passaggio di testimone non viene fatto e il progetto muore: occorre invece trovare qualcuno di interessato allo sviluppo, anche perché un programma in uso dovrà necessariamente cambiare ed evolvere in futuro.

## Confronto tra modelli

Per capire meglio i concetti fondanti del mondo open-source mostriamo in un modo sintetico un confronto tra lo stesso e i metodi di sviluppo tradizionale e agile nel riguardo di svariati concetti:

| Cosa | Tradizionale | Agile | Open source |
|------|--------------|-------|-------------|
| __Documentazione__ | La documentazione è enfatizzata come strumento di controllo qualità e gestione. | La documentazione è de-enfatizzata. | Tutti i manufatti di sviluppo sono disponibili a chiunque, compresi il codice e la documentazione. |
| __Requisiti__ | Gli analisti traducono le necessità dell'utente in specifiche software. | Gli utenti fanno parte del team. | Gli sviluppatori spesso sono anche gli utenti. |
| __Assegnamento dello staff__ | Gli sviluppatori sono assegnati ad un unico progetto. | Gli sviluppatori sono assegnati ad un unico progetto. | Gli sviluppatori tipicamente lavorano su più progetti con diversi livelli di partecipazione (_impossibile pianificare lo sviluppo_). |
| __Revisione del codice paritaria__ | La revisione del codice tra pari è ampiamente accettata ma raramente effettuata. | La _pair programming_ introduce una forma di revisione del codice tra pari. | La revisione del codice è una necessità ed è praticata quasi universalmente. |
| __Tempi di rilascio__ | Tante feature in poche release massicce. | Tante piccole release incrementali. | Gerarchia dei tipi di release: _nightly_ (compilazione giornaliera dal branch master), _development_ e _stable_. |
| __Organizzazione__ | I team sono gestiti dall'alto. | I team sono auto-organizzati. | I contributori individuali decidono per sé come organizzare la propria partecipazione. |
| __Testing__ | Il testing è gestito dallo staff di _Quality Assurance_ (QA), che segue le attività di sviluppo. | Il testing è parte integrante dello  sviluppo (TDD). | Il testing e la QA possono essere svolti da tutti gli sviluppatori. |
| __Distribuzione del lavoro__ | Parti differenti della codebase sono assegnate a persone differenti. | Chiunque può modificare qualsiasi parte della codebase. | Chiunque può modificare qualsiasi parte della codebase, ma solo i _committer_ possono rendere ufficiali le modifiche. |