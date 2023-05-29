# Storia
Il Configuration Management negli anni '50 nell'ambito dell'industria aerospaziale. 
Alla fine degli anni '70 inizia ad essere applicato all'ingegneria del software.

Gli oggetti di cui si controlla l'evoluzione sono detti _configuration item_ o _artifact_ (manufatti, solitamente file).
Dunque l'SMC ci permette di controllare le revisioni degli _artifact_ e il risultato di tali revisioni,questo processo è molto utile per la generazione di un prodotto a partire da una configurazione ben determinata.

## Manufatti
Gli _"oggetti"_ di cui si controlla l'evoluzione sono detti _configuration item_ o manufatti; generalmente sono file.
Se si cambia nome a un file è come eliminarne uno e partire da zero con uno nuovo. 
Originariamente i tool tracciavano i file indipendentemente, senza un senso logico (una _configurazione_) comune. 

![Definizione di configurazione](/assets/05_configuration-management.png)

- anni '80: strumenti locali (SCCS, ...)
- anni '90: strumenti client-server centralizzati (CVS, subversion, ...)
- anni '00: strumenti distribuiti peer-to-peer (git, mercurial, bazaar, ...)

git nasce da un'esigenza di Linus Torvalds con il kernel Linux.

## Centralizzato vs decentralizzato
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/4XpnKHJAok8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Il mondo open source preferisce un approccio decentralizzato al version control. Perché?
- è possibile lavorare offline;
- è molto più veloce, perché la rete non fa più da _bottleneck_;
- supporta diversi modi di lavorare:
    - simil centralizzato: un repository viene considerato "di riferimento";
    - due peer che collaborano direttamente;
    - gerarchico a più livelli (kernel Linux).

Non c'è sincronizzazione automatica, ma ci sono comandi espliciti per fare _merge_ tra repository remote.
In git, per via della sua struttura modulare, è possibile utilizzare il proprio algoritmo _merge_ rispetto a quelli già inclusi. 
