---
layout: post
title: "[02] Modelli di ciclo di vita del software"
date:   2022-10-05 14:30:00 +0200
toc: true
---
il meglio è nemico del bene

# Modelli di ciclo di vita del software
non esiste un modello migliore degli altri
## Modello a Cascata
nasce negli anni 50 famoso negli anni 70, abbiamo una serie di operazioni messe in modo sequenziale in cui non è possibile tornare indietro. ongi modello con certe caratteristiche rientrerà nel modello a cascata.

caratteristica importante: sequenzialità delle diverse fasi.

1. requisiti
2. progetto
3. codifica
4. testing
5. prodotto

non è come una catena di montaggio in quanto non dobbiamo riprodurre la stessa cosa più volte.

### caratteristiche
- forza di progressione lineare di una fase alla siccessiva
- le diverse fasi comunicano tramite dei documenti (semilavorati) rigirosi e formali, quindi permette la separazione dei compiti. __document based__
- permette la pianificazione dei tempi e del monitorin dell'avanzamento del progetto (steering = scrivi). questa metodologia è a senso unico, cioè non posso cambiare metodi per metterci meno tempo, non si può tornare indietro.

### problemi di comunicazione

molto spesso il cliente non sa cosa vuole di preciso o non lo sa esprimetre,

fai

### manutenzione

molto spesso è considerata un eccezione in quanto se il progetto finisce non ci dovrebbe essere bisogo di manutenzione, anche se non è vero, perchè più un software viene usato più cambia.

ma questo non si può fare nel modello a cascata, siccome non si può tornare indietro, e nel caso in cui si mettano delle toppe al progetto dopo la consegna non si docimenta.

la maggio parte dei costi dello sviluppo ricadono nella fase di manutenzione, ma questo si pensa sia causa del modello a cascata, che si porta certi problemi a dierto per molto tempo (perche non si torna indietro), e questo aumenta i costi come gia visto

### problemi
- rigidità
- congelamento dei sottoprodotti (non posso rivedere cio che e gia fatto)
- monoliticita, tutta la pianificazione viene fatta a fronte di una sinfola consegna finale
- rilascio: la manutenzione è fatta solo sul codice alla fine

## modello a V
anche questo modello è ancora sequenziale

migliora il testing in testing di specificazione di integrazione e di sistema

non si può fare un confronto tra un semilavorato e ciò che voleva il cliente, questo è un test di accettazione (alpha e beta test) (freccia grigia).

freccie grigie (__validazione__)-> controlla la correttezza rispetto alle specifiche date dal cliente. faccio vedere ciò che ho fatto per capite se soddisfa chi commissiona
fraccie bianche (__verifica__) -> controlla la correttezza rispetto alla desctrizione formale

modello prescrittivo
	modelli che dicono come deve essere fatto un progetto
modello descrittivo
	modelli che cercano di spiegare come fare un progetto, si focalizzano su cose che secondo loro sono importanti

## varianti processo a cascata

### con singola retroazione
possiamo tornare indietro di un passo alla volta, non posso però tornare indietro dopo la consegna anche qui. abbiamo __iterazione__, ovvero possiamo "ciclare" tra due fasi in modo da migliorare il progetto.

### modello ciclo di vita a fontana
al posto di tornare indietro un passo alla volta ma da capo, da capo nel senso che ad un errore non cerco di risolverlo al passo precedente, ma controllo dove il problema si presenta inizialmente. per fare ciò parto dall'inizio e ricontrollo.

anche dopo la consegna si continua a fare qualcosa, ovvero manutenzione ed evoluzione. non come prima che dopo la consegna non potevi tornare indietro. quindi la consegna del prodotto non è più il punto di arrivo, quindi abbiamo in questo caso iun aversion e __incrementale__

## modelli iterativi vs incrementali

<!--fai-->
__implementazione iterativa__
	
__sviluppo incrementale__
	qui non abbiamo più la fase di testing perche vinee fatto implicitamente

## modelli prototipali
prototipi usa e getta, faccio un prototipo di quello che vuole, lo mostro e poi lo butto via

lo scopo del prototipo è capire cosa voleva fare il cliente, poi devo buttarlo, questo modello ci permette di capire se ho fatto tutti come si deve, obbligandomi a ripetere il lavoro

l'aspetto negativo è che se ho scritto un codice che poi non posso modificare facilmente allora non va bene. piu lascio una cosa fatta male nel mio progetto più "fara male" nel tempo (debito tecnico)

possono essere: 
- essere pubblici o esterni = 
- privati o interni =
- una volta fatta una cosa la seconda volta so come fare e ci metto meno

> legge di Boehm
> la prototipazione riduce gli errori sui requisiti e sul design specialmente per l'interfaccia utente 

### problemi dei modelli incrementali

- la parte di pianificazione delle attività si complica
	- stato del processo meno visibile
	- bisogna pianificare tutte le iterazioni, e non sappiamo quante saranno
- fare un progetto icrementale significa anche togliere cose
	- potenzialmente potremmo arrivare ad un punto in cui continuo a scrivere e concellare codice, e in questo modo non si finisce mai il progetto
- problema con le iterazioni 
	- identidicare come mettere nella prima iterazione e farlo in modo che col passare del tempo possa cresceree
	- le itetazione molto spesso si sovrappongono, per esempio le patch dei programmi di anni differenti si sovrappongono (esempio: office 20 e 19 vengono sviluppati contemporaneamente)

### pinball life-cycle
fare software engeneerinf è come il pinball, l'ordine con cui faccio le diverse fasi è indefinito, al massimo è possibile indirizzarlo un po, e inolree non è misurabile.

## Modelli trasformazionali

vogliono controllare perfettamente tutto cio che accade in maniera formale, partendo però da cose informalei. tramite passi specifici posso __trasformare__ da una cosa informale ad informale. raffinamenti delle specifiche che passo passo traforma (con prova di correttezza) in modo da arrivare alla versione finale.

approccio che nel software viene usato solo in alcuni casi critici ???

## Metamodello a spirale
Livello di astrazione superiore che mi permette di inquadrare altri modelli.
modello basato sui rischi, il focus è su cosa può andare male.
è un modello incrementale, ad ogni "giro" ho una fase di decisione.
fasi:
- determinazione obbiettivi, alternative e vincoli
- valutazione delle alternative, identificazione rischi
- sviluppo e verifica ?
- pinaificazione prossima iterazopne ?
evoluzione modello a spirale -> __modello spirale win win__

## Modello spirale win win 
evidenzia le comunicazioni con i clienti che non sono di tipo pacifico, ,ma necessitano contrazioni e negazione. win win nel senso che entrambi pensano di aver vintoi
bisogna far convergere tutti ad un idea comune, non è facile

## Modello COTS
Partire da una disponibilità interna o comunque da cose già esistenti

- requirements specification
- analisi dei componenti -> prima di progettare cio che mi serve controllo che gia ci esista
- modifica dei requisiti -> cerco di cambiare i requisiti del clinete in modo da utilizzare cio che ho trovato
- system descign con riutilizzo -> progetto, ma cerco di far dialogare componenti troavti che però non comunicano, quindi devo sistemare queste cose. quindi questa faseè di sviluppo e integrazione
- system validation

# Metodologia agili
nascono dal basso, ovvero da chi sviluppa solitamente, a causa di un disagio nascono queste metodologie

### manifesto delle metodologie agili
Cercano di rivedere il punto di vista, invece di ragionare su processi e tool, ragionano sugli individui e la comunicazione tra loro, invece di ragionare sulle docs e meglio avere un programma che va.
preferiscono la collaborazione rispetto ad avere un approccio conflittuale tra cliente e chi fa.
non è importante riseguire un piano ma rispondere ai cambiamenti.

## Lean Software
non nasce nel mondo dell'informatica, ma nasce da toyota
cosa primcipale ridurrre gli sprechi, questa cosa è attuabile anche nel software, eliminando cio che è inutile e che non viene consegnato al clinte (non testing o cose cosi)
posticipare un qualcosa può aiutarmi a risparmiare risorse. scelte vincolanti possono venire ritardate.

responsabiliazione del team e fuffa simile

## Kanban
minimizzare work in progress

vedo le diverse attivita e le sistemo in 5 colonne
- cosa cje si vorrebbero fare
- da fare
- in progresss
- testing
- fatta

## Scrum

congelare le richieste per periodi di tempo in modo tale da avere "un periodo tranqiollo" per progredire nel progetto. di solito dalle 2 alle 4 settimane, non deve esserci pero troppo tempo in cui il cliente non mi da feedback.

## Crystal 
comunicazione osmotica -> nel modello a cascata si comunica tramite modelli rigidi (documenti), qui invece non ci deve essere solo uno che  ha la conoscenza, ma il team dovrebbe averla in generale.
conoscenza diffusa nel team, e bisogna avere dei metodi per aumentare sta cosa (come faremo noi a coppie per esempio)

questo modo non è per la competenza settoriale. non va bene su team grandi, ma da 8-10 persone.

## Extreme programming
lo vedremo nello specifico, incrementa rispetto a semplificare.
sviluppo guidato dal test



