# Le sfide del modello open source

Per sua natura il sistema di sviluppo open source pone delle sfide peculiari sconosciute all'ambiente di sviluppo tradizionale; prima di affrontare dunque gli strumenti di design e organizzazione del lavoro che sono nati per risolvere queste problematiche diamone una breve panoramica.

## Difficile integrazione del software

Quella dell'integrazione del software è in realtà una vecchia sfida che viene enormemente amplificata nell'ambito FOSS. Per integrare le nuove feature sviluppate in un software stabile diversi modelli avevano costruito le proprie pratiche:

- Nel modello a cascata l'integrazione era una fase circoscritta e a sé stante.
- A tale struttura molto rigida si contrappone lo schema innovativo _Stabilize & Synchronize_ nato in ambiente Microsoft: durante il giorno gli sviluppatori lavorano sul proprio pezzo di codice in cui sono responsabili, e di notte il software viene ricompilato da zero. La mattina dopo, si avevano dunque due possibilità:
  - la compilazione falliva, il responsabile veniva trovato e _"punito"_;
  - la compilazione aveva successo, il software integrato è quindi nella _"versione migliore possibile"_.
- In XP l'integrazione veniva eseguita più volte al giorno in modo esclusivo: un solo sviluppatore alla volta poteva integrare il proprio lavoro sull'unica macchina di integrazione disponibile; questo permetteva di individuare facilmente eventuali problemi di integrazione e risolverli con rapidità.

Ma come organizzare l'integrazione nel mondo open-source? Per sua natura, in questo ambito l'integrazione viene eseguita continuamente e senza coordinazione a priori: è anarchia totale, con lo svantaggio che da un giorno all'altro una enorme parte della codebase potrebbe cambiare in quanto un singolo sviluppatore potrebbe integrare mesi e mesi di lavoro in un'unica botta. Vedremo più avanti che strumenti si sono costruiti per contenere tale problematica.

## Sfaldamento del team

Nell'open source nascono inoltre problemi riguardanti la gestione del team. Occorre decidere:

- come comunicare
- come tenersi uniti
- come coordinarsi
- come ottenere nuove collaborazioni

Per comunicare si utilizza di solito __internet__: si potrebbe dire che senza internet non potrebbe esistere il concetto stesso di open source. In particolare si utilizzano spesso dei __forum__ per organizzare il lavoro, in modo da tenere la community unita e rispondere dubbi ai nuovi utenti.

Per quanto riguarda il coordinamento del lavoro approfondiremo nelle prossime lezioni vari strumenti per la sincronizzazione del lavoro e di versioning per codice e documentazione (come __git__).

Deve poi essere facile, addirittura banale, poter compilare il codice e ricreare l'ambiente di sviluppo omogeneo per tutti; si utilizzano quindi strumenti di __automatizzazione delle build__ (come i __Makefile__) in modo che chiunque voglia partecipare possa farlo indipendentemente dalla propria configurazione software e hardware.

È infine importante _educare_ i reporter dei bug e avere un sistema per organizzare per le __segnalazioni di errori__: il sistema dovrebbe essere accessibile a tutti in modo da evitare segnalazioni duplicate e consentire una facile organizzazione delle stesse. Vedremo più avanti come anche una segnalazione d'errore avrà il suo "ciclo di vita".
