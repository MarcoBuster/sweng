# Appunti di Ingegneria del Software

Questa repository è relativa ai contenuti del corso di Ingegneria del Software dei prof. Carlo Bellettini e Mattia Monga, per l'anno accademico 2022/23.

Gli appunti sono presi in collaborazione secondo i principi dello sviluppo di software _open source_.
Contribuire non è solo un modo per studiare, ma anche per utilizzare Git e alcuni concetti dell'Ingegneria del Software in un contesto reale.

I _maintainer_ ufficiali sono:
- Marco Aceti
- Daniele Ceribelli
- Matteo Mangioni

e gli altri contributori sono stati:
- Matteo Yon
- Francesco Protospataro
- Ilyaas Ouardi
- Armani Islam
- Mattia Mendecino
- Andrea Cambiaghi

ma _chiunque_ può contribuire e proporre _Merge Request_. 

Nel file [AUTHORS.md](./AUTHORS.md) sono presenti tutti i contributori per ogni lezione.

Se utilizzi questi appunti per studiare, non solo è _galante_ contribuire ma è anche un modo per controllare e sistemare l'enormità di errori che prevediamo saranno presenti e per espandere o integrare nozioni e concetti.

I docenti del corso sono a conoscenza di questo progetto e sembrano apprezzarlo.

Tutti i contenuti sono rilasciati sotto licenza [Creative Commons BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/), consulta il file [LICENSE](./LICENSE) per ulteriori dettagli.

## Visualizzare

Gli appunti sul branch `master` e sui branch `lezioni/*` sono [automaticamente compilati](https://gitlab.di.unimi.it/silab-gang/appunti-deploy) in HTML e disponibili su [https://appunti.studentiunimi.it/sweng/](https://appunti.studentiunimi.it/sweng/).

## Contribuire

### Stack tecnologico

Tutti i contenuti sono scritti in Markdown e quindi convertiti in HTML autoamticamente da [Jekyll](https://jekyllrb.com/). 
Le pagine su appunti.studentiunimi.it sono automaticamente _compilate_ in HTML da un workflow di GitLab CI, ma solo quando approdano sul branch `master` o su un branch `lezioni/*`.
Una volta compilate viene lanciato un webhook a uno [script Python](https://gitlab.di.unimi.it/silab-gang/appunti-deploy/-/blob/master/handler.py) che scarica i file di build e li inserisce nella cartella corrispondente al branch. 
Un container Docker di nginx (dietro Traefik) si occuperà quindi di servirli sul web e gestire l'autenticazione.

Utilizziamo alcuni plugin di Jekyll per consentire di utilizzare LaTeX, immagini responsive e tabelle.
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
>       - mappare le porte 4000/tcp e 35729/tcp sul tuo host;
>       - mappare la cartella del progetto a `/usr/src/app` nel container;
>       - mappare correttamente l'utente;
>       - aggiungere a Jekyll l'opzione `--live-reload`.
>
>       In ambiente UNIX, ho creato uno script che permette di fare tutte le cose di cui sopra con un comando. Per eseguirlo fare:
>
>       ```
>       $ ./docker-run.sh
>       ```

Aprendo la pagina https://localhost:4000/sweng nel nostro browser potremo visualizzare un'anteprima della pagina HTML compilata, aggiornata ad ogni modifica del file Markdown originale.
È estremamente consigliato arrivare a questo punto prima di continuare: non inviare patch prima di aver verificato che Jekyll compili il file in una pagina sensata.

Oltre a Jekyll, è naturalmente necessario avere Git installato sulla propria macchina.
Come editor di testo, consigliamo VSCode (meglio ancora [VSCodium](https://vscodium.com/)) ma qualsiasi va bene. 

### Regole base di Git

- Utilizziamo GitLab e non GitHub perché abbiamo iniziato con GitLab e non abbiamo motivo per cambiare.
- Abilita l'[autenticazione a due fattori](https://docs.gitlab.com/ee/user/profile/account/two_factor_authentication.html). 
- Consigliamo l'utilizzo dell'[autenticazione SSH](https://docs.gitlab.com/ee/user/ssh.html) con GitLab. 
- Imposta il tuo nome e cognome reale; per esempio: `git config --global user.name "Carlo Bellettini"`;
- Utilizza la tua email universitaria, se vuoi; per esempio: `git config --global user.email "carlo.bellettini@unimi.it"`. Ricordati di aggiungere l'email al tuo account GitLab.
- Consigliamo di impostare e attivare la [firma dei commit](https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/) tramite GPG.

### The _"Silab Gang" Notes Engineering Development Process_
Per ogni __argomento__ (spesso corrispondente a una _lezione_) N...
![](https://i.imgur.com/tJhGSaN.png)

Ad ogni argomento corrisponde un file Markdown sotto la directory di Jekyll `_posts/`. 

#### Organizzazione dei branch

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

#### Esempio
Lo studente Carlo Bellettini prende appunti durante la (sua?) lezione 5 e crea un branch `carlo/05-appunti`. Anche lo studente Mattia Monga prende appunti e pubblica le modifiche su `mattia/05-appunti`. 
Carlo, da bravo contributore, si impegna a integrare gli appunti; crea il branch `carlo/05-integrazione` e mergia inanzitutto i suoi appunti (`carlo/05-appunti`) quindi quelli di Mattia (`mattia/05-appunti`). 

Il secondo merge da parte di Carlo degli appunti di Mattia causerà sicuramente dei conflitti, che Carlo dovrà risolvere: non è codice, è testo, e due studenti prenderanno gli appunti in modo completamente diverso!
Il concetto stesso di _integrazione_ è proprio questo. 

Una volta terminato il lavoro, Carlo mergierà il suo branch `carlo/05-integrazione` in `lezioni/05`, quindi aprirà una Merge Request da `lezioni/05` verso il branch `master`.

Inizia il processo di _review_: altri contributori (ovvero tutti a parte Carlo) controlleranno la correttezza e la __completezza__ (!) degli appunti proposti. 
Se (ancora, per esempio) Marco trova dei problemi, può creare un proprio branch `marco/05-review` partendo dal branch `lezioni/05`, committare le proprie proposte e quindi rimegiarle in `lezioni/05`.

Infine, una volta che tutti i reviewer sono contenti, la Merge Request viene mergiata in master e gli appunti vengono aggiunti in GitLab Pages.

### Issues e Merge Requests

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

## Convenzioni Jekyll

Il Markdown scritto su Jekyll è particolare e richiede l'utilizzo di alcune convenzioni, specialmente per lavorare insieme.

Jekyll è orientato alla creazione di blog personali, quindi ogni _argomento_ (pagina) è, secondo la terminologia di Jekyll, un _blog post_.
Questo ha implicazioni fastidiose: per esempio, è necessario assegnare una data ad ogni _"post"_ anche se non ha molto senso se si sta parlando di appunti.
Per convenzione, per ogni _post_ utilizziamo sempre come data (e ora) quello della prima lezione in cui l'argomento è stato introdotto.

### Nomi di file e intestazione

Tutti i _post_ vanno creati nella cartella `_posts/`. 
Ogni file all'interno di `posts/` DEVE avere come il seguente nome: `YYYY-MM-DD-titolo-argomento.md` dove YYYY-MM-DD è la __data__ del post in quel formato e `titolo-argomento` il titolo (breve) che comparirà nell'URL. 

All'inizio di ogni post Markdown DEVE ESSERE PRESENTE il _Jekyll header_.
Di seguito un esempio:
```
---
layout: post
title:  "[01] Introduzione"
date:   2022-10-03 14:30:00 +0200
toc:    true
---
```

Il numero nel titolo racchiuso tra parentesi quadre deve essere uguale al numero di argomento N assegnato nell'issue e nei nomi di branch.
Il parametro `toc: true` serve per generare automaticamente la Table Of Contents all'inizio del file HTML compilato.

Se non vedete un post che avete creato sul vostro Jekyll, molto probabilmente state sbagliando una di queste convenzioni.

È possibile che durante la prima fase di presa degli appunti durante la lezione vengano utilizzati dei nomi di file diversi. 
È compito degli integratori sceglierne uno adatto e degli altri contributori adottarlo.

### Immagini

Per includere immagini utilizziamo il plugin `jekyll-responsive-image`, che le ottimizza per tutti i dispositivi.

Le immagini sono da mettere nella cartella `assets/` e tracciate con Git (altrimenti gli altri non le vedranno!). 
Per convenzione nostra, i nomi dei file immagine è `N_nome-immagine.png` dove `N` è il numero di lezione giù più volte citato in questa guida.

Per includere un'immagine, è sufficiente inserire nel Markdown la seguente stringa e Jekyll si occuperà ad inserire l'immagine.

```
{% responsive_image path: 'assets/N_nome-immagine.png' %}
```

L'immagine deve essere grande almeno 800 pixel in larghezza.
Per convertire un'immagine più piccola, puoi utilizzare il seguente comando (richiede ImageMagick installato):

```bash
$ convert assets/N_nome-immagine.png -filter point -resize 810 assets/N_nome-immagine.png
```

### Diagrammi UML

(Quasi) tutti i diagrammi UML mostrati durante le lezioni dal prof. Bellettini sono generati utilizzando [PlantUML](https://plantuml.com/), uno strumento open source che genera diagrammi in formato vettoriale partendo da del semplice testo.
È quindi perfetto per il nostro caso d'uso (_pun intendend_).

La sintassi per generare un diagramma dal Markdown di Jekyll è la seguente:

```
{% plantuml %}
Object <|-- ArrayList
Object : equals()
ArrayList : Object[] elementData
ArrayList : size()
{% endplantuml %}
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

## Convenzioni di stile e contenuto

Gli appunti devono essere chiari, concisi ma __completi__.
L'obiettivo è creare la _bibbia_ del corso: idealmente studiandola da zero si dovrebbe arrivare al 30L.

In tale prospettiva proponiamo una guida alle fasi di integrazione e di review che chiarifichi che cosa dev'essere presente negli appunti e lo stile di scrittura consigliato.

Naturalmente, queste indicazioni valgono per gli appunti proposti per il branch master: per gli appunti presi a lezione è assolutamente OK essere vaghi o brevi.

### Guida all'integrazione

La fase di integrazione degli appunti dovrebbe servire per riunire gli appunti di tutti i partecipanti in un unico documento.
Per agevolare la fase di review e riscrittura, tuttavia, questo non può limitarsi a un semplice _merge_ dei rispettivi file: l'integratore ha il compito di fornire a colui che dovrà riscrivere gli appunti la miglior base possibile su cui lavorare. \
Ecco dunque alcuni consigli utili in tal senso:

- Assicurarsi che __CI SIA TUTTO__: idealmente la fase di review dovrebbe solo fare "refactoring" degli appunti senza aggiungere nessun concetto, per cui è espressa responsabilità dell'integratore assicurarsi che il risultato finale sia assolutamente completo in quanto nessuno controllerà più i contenuti.

- __Una frase, una riga__: al termine di ciascuna frase (_ndr. una proposizione terminata da punto_) andare a capo in Markdown.
Questo infatti non spezza il paragrafo, come si può vedere dalla preview, ma agevola moltissimo il versioning con Git in quanto ogni frase viene così trattata come una linea di codice indipendente dalle altre.

- Assicurarsi che le stesse cose non siano dette in più punti diversi e, nel caso, integrarle tra di loro;

- Tenere i propri appunti sottomano per accertarsi che ogni concetto citato a lezione sia riportato: è chiaro che all'esame viene chiesto _tutto_, compresi i riferimenti esterni, per cui occorre includere negli appunti ogni nozione rilevante;

- Organizzare gli argomenti in maniera logica, evitando salti logici in avanti e in indietro per agevolare il lavoro di review;

- Sfruttare le potenzialità di Markdown (_es. titoli di vario livello, tabelle, elenchi..._) e rispettarne per quanto possibile le convenzioni (_es. linea vuota dopo i titoli, nessuno spazio alla fine di una riga..._);

- Tenere __sempre__ la preview di jekyll aperta per verificare che immagini e/o schemi vengano mostrati correttamente.

### Guida alla review

Gli appunti definitivi dovrebbero costituire un discorso omogeneo e fluido, come fossero un piccolo libro di testo. \
Per fare ciò, ecco alcune accortezze di stile e consigli utili durante la fase di review e riscrittura: si tratta solo di indicazioni (_"Just rules"_ ^-^), per cui non sentitevi in dovere di seguirle alla lettera.

#### <big>Contenuto</big>

- Immaginare sempre di stare parlando con chi non sa nulla della materia: leggendo gli appunti dall'inizio alla fine si dovrebbe essere in grado di comprendere tutto.
È quindi importante:

  - non citare concetti senza che siano stati già spiegati precedentemente: se invece sono già stati spiegati può essere utile richiamarli con una formula del tipo _"Come sappiamo..."_ o _"Come abbiamo già visto..."_ seguita da un breve accenno al concetto;

  - non dare per scontato nessuna conoscenza;

- Se qualcosa è preso pari pari dalle slide può essere un campanello d'allarme.
Conviene dunque farsi le seguenti domande:

  - La frase si sposa bene con lo stile del discorso?
  Come potrei riscriverla in modo da rendere il fluire del discorso più omogeneo?

  - Il concetto espresso non è affrontato da nessun'altra parte?
  Se sì, tale ripetizione è davvero necessaria e funzionale?

- Mantenere convenzione "una frase, una riga" adottata nella fase di integrazione (_vd. sopra_): specialmente nella fase di review è importante che modificare una singola frase non comporti modificare interi paragrafi.

- Tenere i propri appunti sottomano per verificare ulteriormente che non manchi nulla: sebbene la fase di integrazione dovrebbe in teoria creare un documento completo di tutto, può capitare che qualcosa sia sfuggito.

#### <big>Stile</big>

- Adottare una __sintassi semplice__: gli appunti dovrebbero essere completi ma facili da seguire;

- Avere una qualche estensione di __controllo ortografico__ attiva (_es. Code Spell per vscode_);

- Usare il più possibile l'__impersonale__: non _"possiamo fare X"_ ma _"si può fare X"_;

- Sforzarsi di presentare gli argomenti nel modo più chiaro possibile, legandoli tra di loro in unico discorso logico.
Per favorire questo approccio, ogni argomento dovrebbe essere affrontato nel modo seguente:

    1. __Presentare il problema__: es. _"Spesso capita di dover gestire X, Y e Z"_;

    2. __Discutere e analizzare il problema__: es. _"Il problema ha queste queste e queste caratteristiche, che non possiamo risolvere con quanto visto finora"_;

    3. __Proporre la/le soluzione/i al problema e discuterle__, confrontandole se più di una: es. _"In un primo momento si potrebbe pensare di risolvere così; tuttavia questo approccio ha questi difetti. Ecco allora che si è pensato di fare quest'altro"_;

    4. __Concludere con un breve riassunto__ su quanto visto, che servirà inoltre a introdurre il prossimo argomento: es. _"Abbiamo quindi visto come risolvere sta cosa; la soluzione pone però un nuovo problema..."_.

- Preferire i discorsi omogenei agli elenchi: usare gli elenchi __SOLO__ quando necessari.
Alcuni esempi dei pochi casi in cui un elenco è accettabile sono:

  - un __elenco puntato__ quando si elencano più cose contrapposte tra di loro (_es. diversi approcci o soluzioni a un problema_)

  - un __elenco numerato__ quando si specificano le varie fasi di un processo (_es. ciclo di vita del software_)

- Utilizzare la __separazione in paragrafi__ in modo coscienzioso: all'interno di un paragrafo dovrebbe idealmente essere trattato _un unico concetto_.
Diversi aspetti dello stesso concetto possono essere separati nello stesso paragrafo andando a capo (_con \ al termine della riga_), mentre quando si passa al concetto successivo è bene aprire un nuovo paragrafo.

- Utilizzare la __corretta punteggiatura__.
Può essere utile in tal senso rileggere mentalmente gli appunti appena scritti per assicurarsi che il discorso fluisca in modo scorrevole, ricordando che:

  - la virgola (",") rappresenta una pausa brevissima utilizzata per riprendere fiato o per evidenziare tramite un inciso (_una frase compresa tra due virgole_) determinati concetti che espandono in modo significativo il discorso principale;

  - i due punti (":") rappresentano una pausa breve e sono usati per introdurre elenchi o proposizioni strettamente correlate con quella principale;

  - il punto e virgola (";") rappresentano una pausa media, e vanno utilizzati quando si vuole dare un legame debole alla proposizione con la precedente e al termine di ogni elemento di un elenco tranne l'ultimo (_dove invece si usa il punto_);

  - le parentesi ("(...)") vengono utilizzate per incapsulare proposizioni che espandono la frase principale in modo non significativo: idealmente esse potrebbero essere saltate nella lettura senza togliere nulla al discorso.

- Utilizzare il __grassetto__ per evidenziare concetti chiave e il _corsivo_ per sottolineare frasi importanti; all'interno delle parentesi si può inoltre utilizzare il corsivo per aumentare la rilevanza del contenuto.

- Usare le congiunzioni correttamente per legare le frasi tra di loro (_es. dunque, perché, perciò, allora, in quanto..._);

- __NON IGNORARE I COMMENTI__: si tratta di richieste di aiuto da parte di chi ha fatto l'integrazione, che chiede un consiglio su una determinata questione.
È dunque importante che per il termine della review tale problema sia stato risolto: se vi trovate in difficoltà potete sempre chiedere sul gruppo!
