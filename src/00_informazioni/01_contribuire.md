# Come contribuire

## Stack tecnologico

Tutti i contenuti sono scritti in Markdown e quindi convertiti in HTML automaticamente da [mdbook](https://rust-lang.github.io/mdBook/). 
Per strutture complesse, è possibile embeddare dell'HTML (e del CSS) nel file Markdown.

> ### CONSIGLIATO: installazione di tutte le dipendenze tramite Docker
> Prima di iniziare, è necessario avere Docker installato. Quindi:
> 1. entra nel branch `master` e sincronizzalo con l'ultima versione remota:
>
>       ```
>       $ git switch master
>       $ git pull
>       ```
> 
> 2. costruisci l'immagine Docker: 
> 
>       ```
>       $ docker build -t appunti_sweng .
>       ```
> 3. crea un container ed eseguilo, ricondandoti di:
>       - mappare le porte 3000/tcp sul tuo host;
>       - mappare la cartella del progetto a `/usr/src/app` nel container;
>       - mappare correttamente l'utente;
>
>       In ambiente UNIX, ho creato uno script che permette di fare tutte le cose di cui sopra con un comando. Per eseguirlo fare:
>
>       ```
>       $ ./docker-run.sh
>       ```

Aprendo la pagina https://localhost:3000/ nel nostro browser potremo visualizzare un'anteprima della pagina HTML compilata, aggiornata ad ogni modifica del file Markdown originale.
È estremamente consigliato arrivare a questo punto prima di continuare: non inviare patch prima di aver verificato che mdbook compili il file in una pagina sensata.

Oltre a mdbook, è naturalmente necessario avere Git installato sulla propria macchina.
Come editor di testo, consigliamo VSCode (meglio ancora [VSCodium](https://vscodium.com/)) ma qualsiasi va bene.

## Regole base di Git

- Utilizziamo GitLab e non GitHub perché abbiamo iniziato con GitLab e non abbiamo motivo per cambiare.
- Abilita l'[autenticazione a due fattori](https://docs.gitlab.com/ee/user/profile/account/two_factor_authentication.html). 
- Consigliamo l'utilizzo dell'[autenticazione SSH](https://docs.gitlab.com/ee/user/ssh.html) con GitLab. 
- Imposta il tuo nome e cognome reale; per esempio: `git config --global user.name "Carlo Bellettini"`;
- Utilizza la tua email universitaria, se vuoi; per esempio: `git config --global user.email "carlo.bellettini@unimi.it"`. Ricordati di aggiungere l'email al tuo account GitLab.
- Consigliamo di impostare e attivare la [firma dei commit](https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/) tramite GPG.

## The _"Silab Gang" Notes Engineering Development Process_
Per ogni __argomento__ (spesso corrispondente a una _lezione_) N...
![](https://i.imgur.com/tJhGSaN.png)

Ad ogni argomento corrisponde una directory sotto la directory di mdbook `src/`. 

### Organizzazione dei branch

La gestione dei branch è simile a GitFlow, ma non è uguale.
Osserviamo le tipologie di branch:
- `master`: contiene l'ultima versione stabile di tutti gli appunti. Ad ogni commit viene azionata una GitLab CI che aggiorna la pagina su GitLab Pages. Solo i maintainer possono mergiare su questo branch. 
- `lezioni/N` (ma forse avremmo dovuto chiamarli `argomenti/N`): contiene l'ultima versione _instabile_ di uno specifico argomento. 
I contributori della lezione `N` pulleranno dal branch `lezioni/N` per sincronizzare i contributi degli altri nel proprio branch, e mergieranno (o chiederanno di mergiare) i propri contributi nel branch `lezioni/N`. Nel nome c'è un _leading zero_: `lezioni/04`, `lezioni/12`.
- __branch utente__: iniziano con il nome dell'utente (lower case e breve) e sono utilizzati come _"sandbox"_ personale. 

Tutti i branch devono essere creati partendo da `master`.
È consentito e apprezzato il fast forward in caso di merge banali. 

Essendo i branch `lezioni/N` condivisi, è __NECESSARIO__ aggiornare il branch con il remoto facendo `git pull`. Prima di mergiare in `lezioni/N`, quindi:
1. entra nel branch `lezioni/N`: `git switch lezioni/N`;
2. scarica le ultime modifiche: `git pull`;
3. entra nel tuo branch: `git switch mio/branch`;
4. mergia il branch `lezioni/N`: `git merge lezioni/N`;
5. risolvi gli eventuali conflitti;
6. entra nel branch `lezioni/N`;
7. mergia il tuo branch: `git merge lezioni/N`;
8. carica le tue modifiche: `git push lezioni/N`.

> `lezioni/N` contiene sempre l'___ultima versione instabile___ e tutti i contributori la utilizzano come riferimento per quell'argomento.
> I contributi non mergiati in `lezioni/N` non saranno considerati da nessuno e sono quindi inutili.
> In ogni caso, non si committa mai direttamente a `lezioni/N` ma prima si passa sempre per un _branch utente_.

### Esempio
Lo studente Carlo Bellettini prende appunti durante la (sua?) lezione 5 e crea un branch `carlo/05-appunti`. Anche lo studente Mattia Monga prende appunti e pubblica le modifiche su `mattia/05-appunti`. 
Carlo, da bravo contributore, si impegna a integrare gli appunti; crea il branch `carlo/05-integrazione` e mergia inanzitutto i suoi appunti (`carlo/05-appunti`) quindi quelli di Mattia (`mattia/05-appunti`). 

Il secondo merge da parte di Carlo degli appunti di Mattia causerà sicuramente dei conflitti, che Carlo dovrà risolvere: non è codice, è testo, e due studenti prenderanno gli appunti in modo completamente diverso!
Il concetto stesso di _integrazione_ è proprio questo. 

Una volta terminato il lavoro, Carlo mergierà il suo branch `carlo/05-integrazione` in `lezioni/05`, quindi aprirà una Merge Request da `lezioni/05` verso il branch `master`.

Inizia il processo di _review_: altri contributori (ovvero tutti a parte Carlo) controlleranno la correttezza e la __completezza__ (!) degli appunti proposti. 
Se (ancora, per esempio) Marco trova dei problemi, può creare un proprio branch `marco/05-review` partendo dal branch `lezioni/05`, committare le proprie proposte e quindi rimegiarle in `lezioni/05`.

Infine, una volta che tutti i reviewer sono contenti, la Merge Request viene mergiata in master e gli appunti vengono aggiunti in GitLab Pages.

## Issues e Merge Requests

Per coordinare il lavoro tra di noi, utilizziamo principalmente la funzione "Issue" di GitLab. 
Tutte le issues sono elencate [qui](https://gitlab.com/silab-gang/sweng/-/issues).

C'è una issue per ogni argomento. Ogni issue...
- ha un titolo con il numero (corrispondente all'`N` nei nomi di branch) e al nome dell'argomento;
- ha una descrizione, contentente i riferimenti alle lezioni relative all'argomento (come la data) e altre note opportune (_"il prof. ha spiegato il pattern Observer in questa lezione"_, ...);
- ha un label per tracciare lo stato nel processo (Da Fare / In esecuzione / In attesa di review / Fatto); 
- ha un epico per tracciare il progresso dei [4 macro argomenti](https://gitlab.com/silab-gang/sweng/-/milestones/) del corso.
- ha un utente assegnato: solitamente è l'integratore principale della issue.

Nelle issue si può discutere e coordinare il lavoro, ma le review si fanno nelle merge request.
Le osservazioni sul _processo_ si fanno nell'issue, quelle sul _contenuto_ nella merge request.

Le merge request sono collegate alla relativa issue semplicemente citandola.
È possibile utilizzare la [revisione GitLab](https://docs.gitlab.com/ee/user/project/merge_requests/reviews/) per indicare i problemi: se trovi un problema sei invitato a risolverlo subito, per velocizzare il processo.

# Convenzioni mdBook

Il Markdown scritto su mdBook è particolare e richiede l'utilizzo di alcune convenzioni, specialmente per lavorare insieme.

## Nomi di file e intestazione

Tutti i _file_ vanno creati in una sottocartella della cartella `src/`. 
Ogni file all'interno di `src/` DEVE avere come il seguente nome: `PROGRESSIVO_nome-argomento.md` dove PROGRESSIVO è il numero progressivo del file all'interno della cartella. I numeri progressivi iniziano da zero e hanno un _leading zero_.

Ogni file deve essere poi aggiunto in [`SUMMARY.md`](https://rust-lang.github.io/mdBook/format/summary.html). 

## Diagrammi UML

(Quasi) tutti i diagrammi UML mostrati durante le lezioni dal prof. Bellettini sono generati utilizzando [PlantUML](https://plantuml.com/), uno strumento open source che genera diagrammi in formato vettoriale partendo da del semplice testo.
È quindi perfetto per il nostro caso d'uso (_pun intendend_).

La sintassi per generare un diagramma dal Markdown di mdBook è la seguente:

    ```plantuml
    @startuml
    Object <|-- ArrayList
    Object : equals()
    ArrayList : Object[] elementData
    ArrayList : size()
    @enduml
    ```

Informazioni complete sulla sintassi con esempi sono sul sito di PlantUML.

Oltre al plugin, per generare i diagrammi è necessario installare l'eseguibile `plantuml`. Nei sistemi UNIX-like: 
1. in una cartella che vuoi (come nella HOME), scarica il file `.jar` con `$ wget https://github.com/plantuml/plantuml/releases/download/v1.2022.13/plantuml-1.2022.13.jar -O plantuml.jar`;
2. crea un file chiamato `/usr/bin/plantuml` avente come contenuto
```bash
#!/bin/bash
java -jar /path/to/plantuml.jar "$1" "$2"
```
3. rendi il file eseguibile: `$ sudo chmod +x /usr/bin/plantuml`.

Se possibile, __cerca sempre di utilizzare un diagramma UML al posto di uno screenshot__.

