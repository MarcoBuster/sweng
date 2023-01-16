layout: post
title: "[01] Introduzione"
date:   2023-11-09 14:30:00 +0200
toc: true
---

# Reti Temporizzate

Modellare un passaggio a livello con una rete di petri

-- img

abbiamo parlato 2 famiglie di linguaggi , quelli operativi e quelli relazionali

dichiarativi : linguaggi logici , vanno ad indicare le proprietà che deve avere il nostro sistema

operazionali: sono tipi di linguaggi che a modellare fisicamente una possibile implementazione/rappresentazione del nostro sistema senza vincolare di come la struttura va fatta.Appunto è interpretata come una modellizazione di riferimento , agli effetti esterni si dovrà comportare seguendo il modello.

Se noi facciamo una rete di petri dove mettiamo 50 stati da una parte, 30 da un altra, non vuol dire che nel codice avro' una classe con il sottoinsieme degli stati. Significa che il programma si dovrà comportare come esso.

L utilità di queste specifiche scritte in maniera formale oltre a essere per la comunicazione con il cliente(se fosse solo per questo gli aprocci agile magari con attenzione al vocabolario delimitandole ad un certo significato(no sinonimi) sarebbe sufficiente), questo linguaggio piu formale e logico è che posso ragionarci sopra in modo molto più automatica, posso avviare fasi di verifica e convalida prima ancora di iniziare a scrivere il codice. quei pericoli di fraintendimenti di avere interpretato male o di non aver capito un problema possono essere risolti.

Problema: Passaggio a livello , con sensore prima del passaggio , noi dovevamo garantire che quando passava il treno noi abbasavamo la sbarra.
un secondo sensore ci avvisava del uscita del treno.

Soluzione:

2 parti del sistema: treno , passaggio a livello

-- img 2

la cosa che mette insiemde queste due parti del sistema è il fatto che perchè venga aperto qualcosa devo essere sicuro che sia uscito il treno , perchè venga chiesto di chiudere qualcosa deve essere segnato il treno è entrato in r .

se io provassi a simulare questa rete, non avrei solo i comportamenti voluti.

questa di per se non puo funzionare se non ha una informazione temporale, perchè se per eroore faccio scattare entraInL il treno passa con le sbarre alzate.

non posso mettere un test di entrata e uscita da chiuso a entra in l , perchè corrisponderebbe a dire al treno se sei su l e non è chiuso fai una frenata per inchiodare, è irreliastico , qui devo essere sicuro che quando il treno passa deve trovare il verde.

Per far questo dobbiamo intredurre i tempi

-- img3

per far questo dobbiamo ragionare sui tempi , abbiamo ragionato fin ad ora su zone e aree, da quando cè il sensore e si arriva l si ha un tempo t1, annalizziamo che c'è un limite di velocità dunque d'orario che deve rispettare , noto il limite di velocità che deve mantere,da li deriviamo il tempo minimo di percorrenza del treno nel lasso di tempo [sensore: i] è t1.

questa distanza del sensore con la messa a distanza adatta per darci il giusto preavviso per abbassare le sbarre.

cè un tempo t2, che è il tempo che dovrà percorrere la zona.
dispoenndo di queste 2 informazioni , possiamo arricchire la nostra specifica, ragionare con il cliente:
che in EntrainR non mi devo far trovare impreparato e posso aspettare un tempo t [0,infinito] , invece quando entro inL so passerà un tempo x(che calcolerò in base alla velocità massima  del treno).

non controllo i malfunziomenti sui sistema.

Chiamo il tempo G il tempo di chiusora del passaggio a livello

il ci dovrà t2 unità di tempo e puo aspettare un y di signalazione di uscita , t2 è poco affidabile, magari è in una falltollarenge dove controllo se t2+ numero alto no passa il treno creao un errore.

t2 è un dato superfluo , non mi serve per dare la risposta, l abbiamo messo 

quando il segnale mi arriva posso rialzare la sbarra

t1-G deve essere positivo. perchè altrimenti arriva il treno e la sbarra non è ancora abbassata.

 Questa rete sta usando una semantica temporale forte.
 
 nel momento in cui devo controllare un sistema , avere un tempo indefinito ci obliga ad avere una semantica forte.
 
 oltre al sistema se modelliamo anche l ambiente è piu facile avere una semantica debole dato che abbiamo meno controllo della situazione.
 
 il rischio di questo sistema è il fatto che ho dato per scontanto il fatto che io lavori solo con un treno, potrebbe essere sia interpretata come errore di specifiche o errore di cose non espresse,dunque la nostra soluzione non è corretta.
 
si potrebbe far si che non puo entrare un secondo treno fino a quando non è uscito quello precedente , come se ci fosse un semaforo entraInR è rosso fino a quando non esce da l.

se ho un treno esce e la zona è tutta libera e io cerco di chiudere prima che si sia aperta il treno mozza qualche persona.
possiamo far si che il treno si riabbassi appena un altro treno entraInR, prendiamo un tempo cuscinetto, lo facciamo ripartire da una situazione stabile. Dunque il treno passerà solo se sono in una situazione stabile e sotto controllo.

Oppure per ottimizzare facciamo abbasare la sbarra anche se sta aprendo ed è a metà.

questa rete potremmo simularla , potremmo costruire l albero di raggiungibilità. 
Però prima bisogna definirlo per poterlo fare.

Potevamo fare a meno del tempo? dunque considerando il tempo come concetto derivato?

non abbiamo guardato le reti ad alto livello , i gettoni hanno un contenuto informatico/dato arbitrariamente complesso (pure una classe per gettone). i gettoni gli distruggiamo e creiamo la nostra transizione deve guardare dentro i dati per farsene qualcosa ma il contenuto informatico è quello che io mi aspetto che sia abilitante alla transizione? la mia transizione scatta per un certo dato non per tutti i tipi di gettoni. Metto una ulteriore condizione per lo scatto della transizione ragionando sul contenuto informativi dei gettoni. Cosi' posso distruggerli in pace dato che gli ho analizzati , magari i gettoni che produciamo saranno uguali a quelli che distruggiamo , dunque abbiamo una guardia e una azione.

una rete di questo livello tra i campi di una classe avremo il campo che si chiama tempo , variabile associata ai gettoni (chronos), i predicati determinano la possibilità di scatto di una transizione a partire dai valori dei gettoni, gli definisce la stessa funzione che prima esprimevamo come l insieme dei tempi di possibile scatto come guardia della mia transizione che lavora sui cui posti , le azioni determinano e garantiscono i valori dei gettoni creati, calcoleranno i tempi dei gettoni in uscita stando attenti a produrre lo stesso valore per i gettoni creati e devono essere non minori dei valori dei chronos(tempi) dei gettoni rimossi.

Sintatticamente la parte di avere una rete con un certo contenuto informativo lo posso rappresentare.

dire che posso modellare come concetto secondario il tempo con semantica debole vuol dire che deve rispettare:
 
 - Chronos + assiomi 1,3 = WTS(weak time semantic), marcatura iniziale e definizione dei tempi di scatto(la guardia).
 - chronos + assiomi 1,2,3 = MWTS(monotonic weak time semantic), deve avanzare e mai tornare indietro, prendiamo un posto lo mettiamo in incresso e uscita a tutte le transizione in quel posto c'è sempre un getto con un tempo che è l ultimo scatto, visto che tutte le transizioni non possono scattare ad un tempo precendente a un gettone che hanno in ingresso. il gettono che forza l ultimo scatto porta alla monotonicità.Per far cio il costo è ancora accettabile.
 - chronos + assiomi 1,2,3,4,5 = STS, l interazione fra le varie entità è molto piu complicato dato che si basa su molti piu parametri in confronto dall' ultimo tempo di scatto, è possibile se c'è un posto in cui l informazione collegata a quel gettone in quelle transioni è l intera topologia di quella rete e l intero stato di quella rete.

Questo non vuol dire che non sia utile mettere insieme i linguaggi semanticamente deboli a quelli semanticamente forti, HLTPN(high level timed petri net) ,nel caso delle reti precedentemente usate si parlava di ER net(tunnel enviroment relationship net), le HLTPN possono modellare :
- aspetti funzionali (ER net), tipici della verifica ad alto livello
- aspetti temporali (TB net), il timestamp gestito tramite le funzioni Tmin e Tmax
- Dipendenze di aspetti funzionali da aspetti temporali , posso ragionare in maniera piu sensata ai problemi

immagine slide 9

sul esempio del sistema controaerea: se aggiungo la variabile del tempo, la variabile dipende  dalla velocità dei due oggetti , e non piu' in modo arbitrario, non sappiamo piu' solo in che tempo siamo ma anche altre informazioni del sistema diventano temporizzate. Queste reti qua sono piu' complesse , ma si nota che la parte complessa rimane quella temporale , i problemi rimangono gli stessi , se noi defianiamo delle tecniche di analisi per le reti time basic che ragionano sulla parte temporale, queste poi sono mutuabili in maniera identica sulle reti di alto livello temporizzate, perchè sono 2 aspetti ortogonali, la complessità rimane uguale nei due casi , ed è la parte piu' complessa dei due modelli. Appunto per questo i sistemi realtime sono molto piu' critici.

Analisi di reti temporizzate , solo aproccio dinamico

Analisi di raggiunbilità, consiste nell enumerazioni degli stati finiti raggiungibili, potevamo dominare le reti non limitate con l 'albero di copertura pero' andando a perdere delle informazioni pero' riuscendo a mantere una struttura capece a rispondere a varie domande , i problemi che saltano subito fuori quando si parla di una rete temporizzata sono:
- il momento che avviene lo scatto di una transizione puo' produrre infiniti stati che si differenziano tra loro per il tempo associati ai gettoni prodotti, stati tra di loro molto simili pero' il loro contenuto informativo è sempre diverso
- la rete puo evolvere all'infinito , quindi il tempo avanza dunque gli stati sono sempre diversi , quindi l albero di raggiungibilità è infinito , dunque è un problema utilizzarlo, non puo essere trattato nella stessa maniera dele reti non limitate, perchè li il concetto di copertura stava sul fatto che i gettoni fossero anonimi, qui abbiamo gettoni che si distuinguono tra di loro.

Rappresentazione simbolica degli stati , è una marcatura in termini di reti temporizzate, multiset di valori assegnati ad ogni posto , i vari valori dei vari gettoni per ogni posto ,  rappresenta un insime possibili stati con in comune lo stesso numero di gettoni in ogni posto (Marcatura P/T), uno stato simbolico dunque numerico è una coppia [µ, C], dove µ associa multiset di identificatori simbolici ai posti quindi associo degli identificatori invece di numeri, oltre agli insieme di simboli gli diamo C che sono i vincoli (dis)equazioni che rappresentano le relazioni tra gli identificatori simbolici.

Funzioni temporali , assumiamo che tf_t sia un intervallo con estremi inclusi esprimibili mediante espressioni lineari funzioni dei tempi dei token in ingresso e di tempi assoluti , fissiamo un tmin_t limite inferiore, tmax_t limite superiore che corrisponde a dire:

formula latex slide 12

immagine pag 13

Sample Reachability Tree

questa rete che abbiamo già studiato che aveva una transizione weak time semantic, e due a strong time semantic, le prime due erano in concorrente per i gettoni in t1 t2 invece t3 indipendente, similmente come era l albero di copertura c'è la prima fase che è l inizializzazione che vuol dire costrire un nodo radice del nostro albero che corrisponde alla marcatura iniziale, quando la facciamo simbolica possiamo definire un insieme di marcature:
S0: Marcatura: µ (P1) = {τ1} µ (P2) = {τ0} µ (P3) = {τ0} , C0 := 0 ≤ τ0 ∧ τ0 ≤ 10 ∧ τ0 ≤ τ1 ∧ τ1 ≤ τ0 + 15 , dunque adesso abbiamo uno stato creato con una sua definizione, ne prendiamo uno e indentifichaimoi gli enabling, S1: Marcatura: µ (P3) = {τ0} µ (P4) = {τ2} ,C1 := C0 ∧ τ2 ≤ τ0 + 5 ∧ τ1 ≤ τ ,  non ragiona su valori numeri ma su valori simbolici , almeno siamo sicuro che da s0 abbiamo le evoluzioni di tutte e 3 le transizioni,adesso vogliamo creare i nodi che vengono creati seguendo le possibili evoluzioni dunque Aggiornamento di marcatura e
vincoli S2: Marcatura: µ (P3) = {τ0} µ (P5) = {τ3},C2 := C0 ∧ τ3 ≥ τ1 + 8 ∧ τ3 ≤ τ0 + 10, alla fine è lo stesso ragionamento che faccio per cercare gli enabling, se trovo vincoli che si scontrano si a disabilitare la transizione, per l S3: Marcatura: µ (P1) = {τ1} µ (P2) = {τ0} µ (P6) = {τ4},C3 := C0 ∧ τ4 ≥ τ0 + 3 ∧ τ4 ≤ τ0 + 15 ∧ τ4 ≥ τ1 ∧ ( τ4 ≤ τ0 + 10 ∨ τ1 > τ0 + 2 ), è piu complicata perchè ha dei vincoli dati anche dalle altre transizioni dunque dovrà aspettare lo scatto di s2 a meno che non sia disabilitata.

immagine slide 14
notiamo che t2 non è abilitata , dunque non ha influenza sulle altra transizioni e qui t3 è molto piu' abilitata, t1 non ha influenza perchè è debole , dunque quello che accade è che dobbiamo dire che deve essere minore di τ0 + 4 oppure il suo tempo è vuoto ed ecco perchè il vincolo risulta molto piu complicato.

allora lo scatto simbolico di una transizione t crea uno stato simbolico caratterizzato dal vincolo Cn : formula latex slide 15, la soddisfacibilità del vincolo stabilice anche la abilitazione delle transizione.

Dunque se andiamo a rivedere il calcolo 

nel caso s1 dobbiamo anche aggiungere ∧ (τ2 ≤ τ0 + 10 ∨…) ∧ (τ2 ≤ τ0 + 15 ∨…)  nel caso s2 dobbiamo aggiungere ∧ (τ3 ≤ τ0 + 15 ∨…), invece nel caso s3 dobbiamo aggiungere  ( τ4 ≤ τ0 + 10 ∨ τ1 + 8 > τ0 + 10 ∨ τ1 > τ0 + 10), andando a mutare la parte della dipendenza da t2 con τ4 ≥ τ1.

dunque 

T1 aggiunge τ1 ≤ τn ∧ τn ≤ τ0 + 5 ∧ τn ≥ τ4 ∧ ( τn ≤ τ0 + 10 ∨ τ0 + 10 < τ1 + 8 ∨ τ0 + 10 < τ4 )
T2 aggiunge τ1 + 8 ≤ τn ∧ τn ≤ τ0 + 10 ∧ τn ≥ τ4

dunque T1 è abilitata solo se T1 è abilitata se τ4 ≤ τ0 + 5  e T2 è abilitata se τ1 ≤ τ0 + 2, troviamo un caso è solo abilitato T1: τ0 = 6, τ1 = 9, τ4 = 10, un caso in cui è solo abilitata T2: τ0 = 6, τ1 = 7, τ4 = 15, un caso in cui sono entrambe abilitate : τ0 = 6, τ1 = 7, τ4 = 10, è un caso finale in cui non c'è nessuna evoluzione (deadlock) : τ0 = 6, τ1 = 9, τ4 = 17.

T1,T2,T3 verranno marcati in base ai loro livelli di abilitazione, non abbiamo una forma normale per rappresentare questi stati , dunque non possiamo confrontare stati e scoprire se li abbiamo già visitati come avevamo fatto con gli alberi di copertura precedenti, abbiamo un albero infinito, apparrentemente inutile , puo capitare che faccia simultaneamente la verifica mentre costruisce i vari stati , dunque costruire fino al punto che mi interessa. Possiamo verificare prorità entro un limite finito di tempo, bounded invariance : qualcosa che non cambia ed è sempre vera, bounded liveness: qualcosa che raggiungero con i miei stati e queste cose posso verificarle in un tempo limitato di tempo. 

Vorremmo raggiungere dei grafi , dove il primo passo è arrivare a grafi aciclici per poi avvicinarci a quelli ciclici, se riusciamo a scordarci la sotria di come arriviamo a un nodo è possibile ritrovare degli stati , dunque come siamo arrivati ad arrivare ad una certe marcatura , facendo così riusciamo ad arrivare ad un grafo aciclico , perchè il terzo assioma proibisce di avere eventi infiti in un tempo finito in s0 dato che s0 è finito, pero' possiamo lo stesso muoverci verso i grafi aciclici semplificando dei constraints , esprimendo il costraint solo in termini della marcatura corrente, rimappando i costraint indiretti, dunque non dovrei associarli a nulla, dunque trasformare : µ (P4) = {τ7} µ (P6) = {τ4},C6 := 0 ≤ τ0 ∧ τ0 ≤ 10 ∧ τ0 ≤ τ1 ∧ τ1 ≤ τ0 + 15 ∧ τ4 ≤ τ0 + 15 ∧ τ1 ≤ τ4 ∧ τ4 ≥ τ0 + 3 ∧ (τ4 ≤ τ0 + 10 ∨ τ1 > τ0 + 2) ∧ τ7 ≤ τ0 + 5 ∧ τ4 ≤ τ7 , in µ (P4) = {τ2} µ (P6) = {τ1},C6 := τ1 ≥ 3 ∧ τ1 ≤ τ2 ∧ τ2 ≤ τ1+ 2 ∧ τ2 ≤ 15. rinnominando le mie marcature(τ4 è diventato τ1).

immagine matrice pag 22

questa cosa è fattibile applicando semplicemente l'algoritmo di Floyd, dove abbiamo una matrice dove mettiamo i nostri vincoli: A+2 <= B <= A+ 5,B <= C <= B + 6, posso togliere B mantenendo i vincoli , applicando floyd , prendendo la matrice basta trovare la relazione tra a e c , sommo le due disequazioni e trovo che a-b <= -2 e b-c <= 0 , scopro meccanicamente(applicando floyd) che converge.


Esempio:
rete di un caldaia immagine pag 24

tutto il sistema mira a guardare se la valvola è aperta(esce gas) e non c'è la fiamma faccio dei controlli dato che altrimenti salterebbe tutto in aria(se non so da quanto tempo c'è il gas aperto), analizziamo la parte sulla fiamma immagine slide 25 , notiamo che già questa singola parte ha stati infiniti , ma dato che abbiamo semplificato l uguaglianze tra gli stati, cerchiamo di contenere uno stato dentro un altro , Stato A è contenuto nello stato B se e solo se tutte le marcature rappresentate da A sono rappresentate anche da B(relazione di inclusione tra stati), dunque avranno lo stesso assegnamento di timestamp e C_A implica C_B, questo quando noto che mi va bene inglobare in uno stato un altro stato dato che coesistono tutte le volte che è vero A è vero anche B.

Esempio immagine slide 27

nella rete scatta t1 mi porta nello stato una volta normalizzato è avere t0 >=1 e il prossimo scatto con t0 >=2 e cosi' via , questo vuol dire che senza inclusione genererebbe infiniti stati (stessa marcatura ma con diversi vincoli, C1: T0 >= 1 , CN: Tn >= n).

immagine slide 28 
con questa piccola verifica siamo riusciti a condenzare un albero infiniti in un grafo finito, tuttavia non è abbastanza per il gas burner, notiamo che ci sono dei ricongiungimenti però ci sono delle costanti alte, abbiamo scale diverse ed abbiamo dei riferimenti sui tempi assoluti e questo non mi permette di trovare stati simili. abbiamo bisogno di osservare se le funzioni temporali non fanno riferimento a tempi assoluti, per essere capre di indentificare ciò che accade a partire da una marcatura bastano i constraint relativi tra i timestamp , ci basta sapere le relazione tra un gettone e un altro.

esempio su tempi relativi slide 30

in questo caso lo stato non include quello successivo , pero' se mi accorgo che non gli interessa di un tempo assoluto , considero i tempi costanti come variabili che possono essere eliminate dato che mantenere i riferimenti ai tempi assoluti genererebbe infiniti stati. questa modifica ci aiuta molto a semplificare la situazione ma non è abbastanza slide 31, ma abbiamo ancora dei tempi assoluti dato che ci sono i gettoni morti che non vengono eliminati, dunque si introducce il Time Anonymous Timestamp il quale dice che se il timestamp associato a un gettone in una marcatura M non verrà mai usato per stabilire come evolverà la rete a partire da quella marcatura, allora è possibile anonimizzare il tempo di tale gettone.

esempio di time Anonymous slide 33 immagine

ci accorgiamo che se scatta T2 abbiamo finito , toglie 2 gettoni e non ne crea, se scatta t1 consuma e rimette un nuovo gettone in p1 , per cui p2 rimane li e di seguito in qualsiasi stato verranno marcati sul fatto che p2 sia vuoto, dunque basta dimenticasi cosa c'è in p2 , quello che accade è che passo da uno stato dove ho p2 che marca in maniera errata i vari stati ad uno stato dove semplifico la situazione anonimizzando i tempi anonimi.

se uniamo queste 3 tecniche appena fatte dunque l inclusione, i tempi relativi e i tempi anonimi arriviamo ad un grafo finito. immagine slide 35.Troviamo soluzioni bounded.

Tuttavia abbiamo perso delle informazioni, con l inclusione abbiamo possibilmente creato dei cammini non percorribili (immagine slide 36), perdo delle relazioni precise tra gli stati per via dei vincoli relativi, possiamo arricchire le informazioni sugli archi per non perdere tutte le informazioni (immagine slide 37) , invece per via dei tempi anonimi vado a non sempre verificare raggiungibilità di una marcatura definita da vincoli sui timestamp, perdo questa informazione cerco di rieseguirlo per vedere cosa avveniva nel caso opposto in caso di necessità di analisi , dunque per concludere siamo passati dal problema di avere gettoni che avevano una informazione che li rendeva distinguibili a gettoni che hanno tempo TA a rendeli equivalenti(anonimizzati) e quindi rappresentabili globalmente da un numero.

non ancora dimostrato:
nelle reti temporizzate se sono non limitate significa che non sono limitate sul numero di gettoni TA che possono generare.

 
 
  







