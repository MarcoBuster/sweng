---
layout: post
title: "[04] Open source"
date: 2022-10-12 14:40:00 +0200
toc: true
---

# Open source

Apriamo ora le porte a un nuovo modo di sviluppare software che si è molto diffuso negli ultimi decenni ed è ora alla base di progetti applicativi molto importanti e famosi: il processo __open-source__. In due parole, un software open-source è un software il cui codice è liberamente consultabile online e il cui sviluppo si basa non su un singolo team ma su una community di sviluppatori indipendenti.

Queste prospettive stravolgono l'idea di sviluppo classico, per cui affrontiamo le numerose differenze a partire da una famosa metafora forgiata da Eric Raymond.

## _The Cathedral and the Bazaar_

Raymond propone nel suo [articolo](http://www.catb.org/~esr/writings/cathedral-bazaar/cathedral-bazaar/) due immagini per descrivere i due mondi contrapposti closed-source e open-source:

- la __cattedrale__ (closed source): si tratta di un ambiente molto gerarchizzato, fortemente legato al progetto iniziale di un unico "architetto" responsabile dei lavori;
- il __bazaar__ (open source): è l'ambiente più anarchico possibile, in cui ognuno lavora per sé e costruisce espandendo ciò che gli altri hanno già fatto.

Entrambe le costruzioni risultano splendide e attraenti, ma sono chiaramente legate a modi di pensare la costruzione e la progettazione totalmente opposti.

### Vita e vantaggi di un progetto open-source

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

<p><!-- ugly spacer --></p>

## _Care and Feeding of FOSS_

Ma come si inserisce il modello di sviluppo open-source in un panorama tecnologico sempre più accentrato nelle mani di poche e potenti aziende? Il timore è infatti quello che rendendo il codice disponibile a tutti si potrebbe essere subito vittima di plagio da parte di giganti del settore in grado di realizzare in poco tempo ciò che prenderebbe a un team open-source svariati mesi, accaparrandosi così una larga fetta di mercato. Craig James smentisce tuttavia tale visione nel suo [articolo](https://web.archive.org/web/20081015010505/http://www.moonviewscientific.com/essays/software_lifecycle.htm), in cui descrive il ciclo di vita di un software FOSS (Free and Open Source Software) come la sequenza delle seguenti fasi:

1. __Invenzione__: qualcuno ha un'idea e la implementa facendola funzionare.
Dal momento in cui l'idea viene resa pubblica si assiste una grossa esplosione di progetti in tal senso finanziati da varie aziende che cercano di diventare leader nel nuovo mercato.
2. __Espansione e innovazione__: il mondo si accorge dell'invenzione e la tecnologia inizia a espandersi in quanto le aziende si 'rincorrono' a vicenda cercando di aggiungere più funzionalità possibili. Questa fase non rappresenta un buon momento per far nascere un progetto open source: un piccolo gruppo non riuscirebbe a prevalere sulle grandi aziende; poiché inoltre le specifiche non sono ancora ben definite si rischierebbe di implementare funzioni inutili.
3. __Consolidamento__: i prodotti di alcune aziende iniziano a dominare il mercato, mentre i competitor vengono assorbiti, falliscono o diventano di nicchia. Diminuisce complessivamente il numero di player e l'innovazione rallenta.
4. __Maturità__: il problema e le specifiche sono ora ben chiare e consolidate. Per un prodotto commerciale è ormai difficile entrare nel mercato, ma per uno open source è paradossalmente il momento migliore: il piccolo team ha uno slancio innovativo che le grosse aziende non hanno più e il loro prodotto può brillare dei vantaggi del mondo open-source, tra cui sicurezza e flessibilità.
5. __FOSS Domination__: lentamente, il prodotto open-source inizia a erodere il vantaggio tecnologico dei competitor commerciali, che d'altra parte non hanno alcun interesse ad innovare ulteriormente: ciascuna loro innovazione potrebbe infatti essere facilmente copiata ed essi sono inoltre già largamente rientrati del loro investimento iniziale. Il prodotto open-source inizia ad accaparrarsi fette di mercato.
6. __The FOSS era__: alla fine il progetto open-source domina completamente il nuovo mercato, mentre le grandi aziende devono ripiegare sulla vendita di servizi più che di software.

Il vantaggio di un progetto open-source non è dunque tanto la rapidità di espansione o l'abilità di intercettare il mercato, quanto il fatto che esso permetta una continua innovazione che _segue_ le necessità del mercato, cosa che le grandi aziende faticano a conseguire in quanto ancora legate a un paradigma di investimento in cui una volta fatto il lavoro e guadagnato un tot è più costoso fare manutenzione del software piuttosto che lasciarlo morire.

## _The Emerging Economic Paradigm Of Open Source_

Affrontiamo ora un fenomeno interessante: perché sempre più aziende investono in software open-source? A prima vista parrebbe un controsenso, perché da sempre i produttori di software proteggono il proprio prodotto tramite segreto aziendale: avere codice liberamente consultabile distrugge tale privatezza ed espone all'ascesa di competitor. Per rispondere a questa domanda ci serviamo di un [articolo](http://web.archive.org/web/20120724095330/http://perens.com/works/articles/Economic.html) di Bruce Perens sull'argomento.

Perens fa in primo luogo notare che spesso per diverse aziende il software da sviluppare non è il prodotto, ma una __tecnologia abilitante essenziale__: per esempio, Amazon sviluppa molto software per il sito di e-commerce ma il suo prodotto non è il sito. In tali ambiti la scrittura di codice è un _costo_, non il prodotto su cui guadagnare.

Dal punto di vista economico è poi importante stabilire se la tecnologia dà un vantaggio competitivo, ovvero se essa è __differenziante__ o __non differenziate__. Per fare ciò è sufficiente rispondere alle seguenti domande:

- __Il cliente si accorge degli effetti del software?__ Per esempio, le persone si accorgono dell'esistenza del sistema di raccomandazione dei libri di Amazon?
- __I competitor non hanno accesso allo stesso software?__ Se Amazon usasse il sistema di raccomandazione venduto anche a Feltrinelli allora non avrebbe senso mantenerlo privato.

Se la risposta a una delle due domande è no, avere un software proprietario non apporta alcun vantaggio: un modello di sviluppo open-source sparpaglia invece i costi e genera valore, motivo per cui sempre più aziende lo scelgono.

Perens conclude il suo articolo riportando una matrice in cui confronta 4 diversi modelli di sviluppo, ognuno con le sue caratteristiche che ne determinano l'applicabilità in diverse situazioni:

- __Retail__: il software è sviluppato per poter essere venduto a chiunque lo desideri;
- __In-House & Contract__: il software è sviluppato per un singolo committente;
- __Consortium & Non-Open-Source Collaboration__: un modello secondo cui diverse aziende concorrenti si mettono insieme per sviluppare un software comune (molto poco diffuso);
- __Open Source__: il software è disponibile gratuitamente e il suo codice è pubblico.

Tali modelli vengono valutati in base all'efficienza (_quanti soldi vanno agli sviluppatori_), al tasso di fallimento del progetto, ai costi di distribuzione, al rischio di plagio, al fatto di proteggere o meno la differenziazione a livello commerciale del cliente e/o del venditore e alla dimensione richiesta del mercato perché il progetto sia un successo.

{% responsive_image path: 'assets/04_confronto.png' %}

Come si può notare dalla tabella, non tutti i paradigmi proteggono il vantaggio competitivo, con differenze dal punto di vista del cliente e del produttore: è dunque importante scegliere il modello di sviluppo che più si confà alle proprie esigenze.

## _An empirical study of open-source and closed-source software products_

Concludiamo il discorso sul mondo open-source riportando uno [studio](https://www.researchgate.net/publication/3188403_An_empirical_study_of_open-source_and_closed-source_software_products) portato avanti da J.W. Paulson e altri con lo scopo di verificare alcune affermazioni ritenute vere nei riguardi del software open-source.

{% responsive_image path: 'assets/04_empirical-study.png' %}

Per ognuna di tali affermazioni l'articolo definisce una metrica e la calcola nei riguardi di progetti open-source e closed-source, concludendo così che solo alcune delle dicerie sull'open-source risultano vere mentre molte altre (es. _è più sicuro_, _è più veloce_) si rivelano essere al più circostanziali.

## Le sfide del modello open-source

Per sua natura il sistema di sviluppo open-source pone delle sfide peculiari sconosciute all'ambiente di sviluppo tradizionale; prima di affrontare dunque gli strumenti di design e organizzazione del lavoro che sono nati per risolvere queste problematiche diamone una breve panoramica.

### Difficile integrazione del software

Quella dell'integrazione del software è in realtà una vecchia sfida che viene enormemente amplificata nell'ambito FOSS. Per integrare le nuove feature sviluppate in un software stabile diversi modelli avevano costruito le proprie pratiche:

- Nel modello a cascata l'integrazione era una fase circoscritta e a sé stante.
- A tale struttura molto rigida si contrappone lo schema innovativo _Stabilize & Synchronize_ nato in ambiente Microsoft: durante il giorno gli sviluppatori lavorano sul proprio pezzo di codice in cui sono responsabili, e di notte il software viene ricompilato da zero. La mattina dopo, si avevano dunque due possibilità:
  - la compilazione falliva, il responsabile veniva trovato e _"punito"_;
  - la compilazione aveva successo, il software integrato è quindi nella _"versione migliore possibile"_.
- In XP l'integrazione veniva eseguita più volte al giorno in modo esclusivo: un solo sviluppatore alla volta poteva integrare il proprio lavoro sull'unica macchina di integrazione disponibile; questo permetteva di individuare facilmente eventuali problemi di integrazione e risolverli con rapidità.

Ma come organizzare l'integrazione nel mondo open-source? Per sua natura, in questo ambito l'integrazione viene eseguita continuamente e senza coordinazione a priori: è anarchia totale, con lo svantaggio che da un giorno all'altro una enorme parte della codebase potrebbe cambiare in quanto un singolo sviluppatore potrebbe integrare mesi e mesi di lavoro in un'unica botta. Vedremo più avanti che strumenti si sono costruiti per contenere tale problematica.

### Sfaldamento del team

Nell'open source nascono inoltre problemi riguardanti la gestione del team. Occorre decidere:

- come comunicare
- come tenersi uniti
- come coordinarsi
- come ottenere nuove collaborazioni

Per comunicare si utilizza di solito __internet__: si potrebbe dire che senza internet non potrebbe esistere il concetto stesso di open source. In particolare si utilizzano spesso dei __forum__ per organizzare il lavoro, in modo da tenere la community unita e rispondere dubbi ai nuovi utenti.

Per quanto riguarda il coordinamento del lavoro approfondiremo nelle prossime lezioni vari strumenti per la sincronizzazione del lavoro e di versioning per codice e documentazione (come __git__).

Deve poi essere facile, addirittura banale, poter compilare il codice e ricreare l'ambiente di sviluppo omogeneo per tutti; si utilizzano quindi strumenti di __automatizzazione delle build__ (come i __Makefile__) in modo che chiunque voglia partecipare possa farlo indipendentemente dalla propria configurazione software e hardware.

È infine importante _educare_ i reporter dei bug e avere un sistema per organizzare per le __segnalazioni di errori__: il sistema dovrebbe essere accessibile a tutti in modo da evitare segnalazioni duplicate e consentire una facile organizzazione delle stesse. Vedremo più avanti come anche una segnalazione d'errore avrà il suo "ciclo di vita".
