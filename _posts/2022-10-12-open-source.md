---
layout: post
title: "[04] Open source"
date: 2022-10-12 14:40:00 +0200
toc: true
---
# Open source

## _The Cathedral and the Bazaar_

Raymond descrive nel suo [articolo](http://www.catb.org/~esr/writings/cathedral-bazaar/cathedral-bazaar/) due analogie, relative al modo di costruire un software opensource:
- la __cattedrale__: c'è un progettista che è responsabile dei lavori;
- il __bazaar__: ognuno lavora per sé.

Dal suo articolo abbiamo estratto alcune frasi importanti.

### Frasi

> Ogni buon lavoro software inizia dalla frenesia personale del singolo sviluppatore

Lo sviluppatore ha un problema e chiede ad amici o colleghi cosa sono sull'argomento.
Alcuni hanno lo stesso problema o problemi simili, ma nessuno ha una soluzione.

Le persone interessate cominciano a scambiarsi pareri e conoscenze sull'argomento. 
Coloro che intendono spendere delle risorse (di fatto il proprio tempo libero) per risolvere il rpoblema danno il via ad un progetto informale.
I membri del progetto lavorano al problema fino a che non raggiungono dei risultati presentabili.

Il progetto open source nasce quando __viene messo a disposizione il codice sorgente__.
È più facile coinvolgere più persone se il progetto pubblicato presenta errori, perché la comunità (principalemnte composta da sviluppatori) vorrà sistemare gli errori. 

I membri del progetto lavorano al problema fino a che non raggiungono dei risultati presentabili.
Ci deve essere interazione tra vecchi e nuovi membri del gruppo.

> Se dai a tutti il codice sorgente, ognuno di essi diventa un tuo ingegnere

Ci sono tanti ruoli utili per portare avanti il progetto ricoperti da persone non necessariamente con competenze informatiche, come la segnalazione di bachi o la moderazione di contenuti nella comunità.

D'altro canto, il rilascio del codice sorgente permette agli utenti sviluppatori di contribuire al progetto, offrendo una possibilità in più.

> Se ci sono abbastanza occhi [che cercano errori], gli errori diventano di poco conto

Più sono le persone capaci a controllare il mio codice più gli errori si trovano e si risolvono più facilmente.

> Se tratti i tuoi beta-tester come se fossero la tua risorsa più importante, essi risponderanno diventando la tua risorsa più importante

> Quando hai perso interesse in un programma, l'ultimo tuo dovere è passarlo a un successore competente

Spesso questa cosa non viene fatta, e il programma muore.
Occorre trovare qualcuno perché un programma in uso dovrà necessariamente cambiare ed evolvere in futuro.

## Confronto tra modelli

| Cosa | Tradizionale | Agile | Open source |
|------|--------------|-------|-------------|
| __Documentazione__ | La documentazione è enfatizzata come il mezzo di controllo della qualità e come un mezzo di gestione. | La documentazione è de-enfatizzata. | Tutti i manufatti di sviluppo sono globalmente disponibili, compresi il codice e la documentazione. |
| __Requirements__ | Gli analisti traducono le necessità dell'utente in specifiche software. | Gli utenti fanno parte del team. | Gli sviluppatori spesso sono anche gli utenti. |
| __Assegnamento dello staff__ | Gli sviluppatori sono assegnati ad un unico progetto. | Gli sviluppatori sono assegnati ad un unico progetto. | Gli sviluppatori tipicamente lavorano su più progetti con diversi livelli di partecipazione |
| __Revisione del codice__ | La revisione del codice è ampiamente accettata ma raramente eseguita. | La _pair programming_ introduce una forma di revisione del codice. | La revisione del codice è una necessità ed è praticata quasi universalmente. |
| __Tempi di rilascio__ | Tanti features in poche, grandi rilasci. | Rilascia presto, rilascia spesso. | Gerarchia dei tipi di rilasci: _notturni_ (compilazione giornaliera dal branch master), sviluppo e stabili. | 
| __Organizzazione__ | I team sono gestiti dall'alto. | I team sono auto organizzati. | I contributori individuali decidono per sé. |
| __Testing__ | Il testing è gestito dallo staff di _Quality Assurance_ (QA), che segue le attività di sviluppo | Il testing è parte integrante dello  sviluppo (TDD). | Il testing e la QA possono essere svolti da tutti da tutti gli sviluppatori. |
| __Distribuzione del lavoro__ | Parti differenti della codebase sono assegnate a persone differenti | Chiunque può modificare qualsiasi parte della codebase | Chiunque può modificare qualsiasi parte della codebase, ma solo i _committer_ possono renderla ufficiale. |

<p><!-- ugly spacer --></p>

## _Care and Feeding of FOSS_

Craig James [descrive](https://web.archive.org/web/20081015010505/http://www.moonviewscientific.com/essays/software_lifecycle.htm) il ciclo di vita di un software FOSS (Free and Open Source Software) come una sequenza delle seguenti fasi:

1. __Invenzione__: qualcuno ha un'idea e la implementa facendola funzionare. 
Dal momento in cui l'idea viene resa pubblica, c'è una grossa esplosione di idee finanziata dalle aziende che cercano di competere sugli altri prodotti.
2. __Expansion and Innovation__: il mondo si accorge dell'invenzione e la tecnologia inizia a espandersi.
Le aziende si 'rincorrono' a vicenda cercando di aggiungere più funzioni possibili.
In questa fase non è un momento buono per far nascere un progetto open source: un piccolo gruppo non riesce a prevalere sulle grandi aziende, e le specifiche non sono ancora ben definite; il rischio è implementare funzioni inutili. 
3. __Consolidamento__: alcuni progetti iniziano ad uscire fuori dominando gli altri. 
Alcuni progetti vengono assorbiti da altri o falliscono - diminusice quindi complessivamente il numero di player.
4. __Maturity__: il problema e le specifiche sono ora ben chiare e consolidate. Per un prodotto commerciale è difficile entrare nel mercato, ma per uno open source pian piano è possibile, sfruttando i vantaggi del monodo open source tra cui sicurezza e flessibilità.
5. __FOSS Domination__: il prodotto opensource raggiunge / sorpassa e diventa dominante nel mercato;
6. __The FOSS era__: _"alla fine ci sarà solo il mondo open source"_.

## Open Source vs Closed Source

{% responsive_image path: 'assets/04_confronto.png' %}

Come si può notare dalla tabella, non tutti i paradigmi proteggono il vantaggio competitivo, con differenze dal punto di vista del cliente e del produttore.

### _The Emerging Economic Paradigm Of Open Source_

Perché le aziende investono in open source? 

In diverse aziende il software non è il prodotto, ma una __tecnologia abilitante essenziale__.
Per esempio Amazon sviluppa molto software per il sito di e-commerce ma non vende il sito di e-commerce; la scrittura di codice è un _costo_ non il prodotto su cui guadagnare.

Dal punto di vista economico è importante stabilire se la tecnologia dà un vantaggio competitivo (è __differenziante__ o __non differenziate__). 
Per fare ciò possiamo rispondere alle seguenti domande:
- il cliente si accorge degli effetti del software? Per esempio, le persone si accorge dell'esistenza del sistema di raccomandazione dei libri di Amazon;
- i competitor hanno accesso allo stesso software? Se Amazon usa il sistema di raccomandazione venduto anche a Feltrinelli allora non conviene.

Se la risposta a una delle due domande è no, perché dovrei tenermi il software per me? 
Renderlo open source sparpaglia i costi e porta valore.

### _An empirical study of open-source and closed-source software products_

È stato fatto uno [studio](https://www.researchgate.net/publication/3188403_An_empirical_study_of_open-source_and_closed-source_software_products) 
che confronta la qualità del codice open source e closed source. 

{% responsive_image path: 'assets/04_empirical-study.png' %}

### Integrazione
L'integrazione del software, nel modello a cascata era una fase circoscritta e a sé stante.

Microsoft ha ipotizzato uno schema che sembra molto innovativo: _Stabylize & Synchronize_.
Durante il giorno gli sviluppatori lavorano sul proprio pezzo di codice in cui sono responsabili; di notte il software viene ricompilato da zero. 
La mattina dopo, si potevano avere due possibilità:
- la compilazione falliva, il responsabile veniva trovato e _"punito"_;
- la compilazione aveva successo, il software integrato è quindi nella _"versione migliore possibile"_.

Nel modello XP l'integrazione viene eseguita più volte al giorno, escludendosi a vicenda (solo un accesso alla macchina per volta).

Nell'open source l'integrazione viene eseguita continuamente e senza coordinazione a priori.

### Team
Nell'open source, inoltre, ci sono problemi con la gestione del team.
Occorre decidere come comunicare, tenersi uniti, coordinarsi e ottenere nuove collaborazioni.

Per comunicare si utilizza di solito:
- in generale __internet__: si potrebbe dire che senza internet non potrebbe esistere l'open source;
- __forum__, per tenere la community unita e rispondere dubbi ai nuovi utenti.

Inoltre, ci sono strumenti per la sincronizzazione del lavoro e di versioning per codice e documentazione (come __git__).

Deve essere facile (addirittura banale) poter compilare il codice e ricreare l'ambiente di sviluppo omogeneo per tutti; 
si utilizzano quindi strumenti di __automatizzazione delle build__ (come i __Makefile__).

È importante _educare_ i reporter dei bug e avere un sistema per organizzare per le __segnalazioni di errori__.
Il sistema dovrebbe essere accessibile a tutti in modo da evitare segnalazioni duplicate.
Anche la segnalazione d'errore avrà il suo "ciclo di vita". 
