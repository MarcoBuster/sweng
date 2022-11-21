# Appunti di Ingegneria del Software

Questa repository è relativa ai contenuti del corso di Ingegneria del Software dei prof. Carlo Bellettini e Mattia Monga, per l'anno accademico 2022/23.

Gli appunti sono presi in collaborazione secondo i principi dello sviluppo di software _open source_.
Contribuire non è solo un modo per studiare, ma anche per utilizzare Git e alcuni concetti dell'Ingegneria del Software in un contesto reale.

I _maintainer_ ufficiali sono:
- Marco Aceti
- Daniele Ceribelli
- Matteo Mangioni

ma _chiunque_ può contribuire e proporre _Merge Request_. 
Se utilizzi questi appunti per studiare, non solo è _galante_ contribuire ma è anche un modo per controllare e sistemare l'enormità di errori che prevediamo saranno presenti e per espandere o integrare nozioni e concetti.

I docenti del corso sono a conoscenza di questo progetto e sembrano apprezzarlo.

Tutti i contenuti sono rilasciati sotto licenza [Creative Commons BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

## Visualizzare

È possibile visualizzare gli appunti approdati sul branch `master` a questa pagina di GitLab Pages: https://silab-gang.gitlab.io/sweng.

## Contribuire

### Stack tecnologico

Tutti i contenuti sono scritti in Markdown e quindi convertiti in HTML autoamticamente da [Jekyll](https://jekyllrb.com/). 
Le pagine su GitLab Pages sono automaticamente _compilate_ in HTML da un workflow di GitLab CI, ma solo quando approdano sul branch `master`.

Utilizziamo alcuni plugin di Jekyll per consentire di utilizzare LaTeX, immagini responsive e tabelle.
Per strutture complesse, è possibile embeddare dell'HTML (e del CSS) nel file Markdown.

Riferirsi al sito di Jekyll per installare Ruby e Jekyll a livello di sistema. 
Una volta fatto, per installare i componenti necessari i seguenti comandi dovrebbero funzionare:

```bash
$ cd Cartella_Progetto
$ bundle install
$ bundle exec jekyll serve --livereload
```

Con l'ultimo comando aprendo la pagina https://localhost:4000/sweng nel nostro browser potremo visualizzare un'anteprima della pagina HTML compilata, aggiornata ad ogni modifica del file Markdown originale.
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
