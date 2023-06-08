# Reti temporizzate

Abbiamo visto come le reti di Petri siano un modello estremamente potente per modellare un'infinita varietà di situazioni anche molto diverse tra loro.
Tuttavia, alcune categorie di problemi richiedono un approccio più mirato, ovvero un'__estensione delle reti di Petri__ specifica per il loro studio: è questo il caso dei __sistemi Hard Real-time__, di cui ora tratteremo approfonditamente.

In molte applicazioni il __tempo__ è un fattore essenziale: si pensi per esempio ad un termostato intelligente che deve accendere e spegnere i termosifoni di una casa in base ad un programma giornaliero oppure ad un autovelox, che in base al tempo di andata e ritorno di un'onda elettromagnetica dev'essere in grado di calcolare la velocità di un veicolo. \
Ma non tutti i sistemi basati sul tempo sono uguali: alcuni di essi richiedono infatti il rispetto assoluto di una serie di __vincoli temporali stretti__, ovvero requisiti sul tempo di esecuzione di certe operazioni che devono essere rispettati per evitare gravi conseguenze.
Considerando per esempio il sistema di controllo di una centrale nucleare, qualora si inizi a rilevare un'aumento eccessivo delle temperature nel reattore tale software dev'essere in grado di reagire entro un certo tempo strettissimo, pena l'esplosione dell'apparato.
Sistemi di questo tipo prendono il nome, come già detto, di __sistemi Hard Real-time__, dove l'aggettivo "Hard" indica proprio la durezza richiesta nel rispetto dei vincoli temporali.

Visto il loro tipico impiego in situazioni di rischio o di pericolo, i committenti di sistemi di questo tipo potrebbero voler avere __prova del loro corretto funzionamento__ prima ancora che questi vengano installati.
I modelli finora descritti potrebbero però non essere sufficienti: non è per esempio abbastanza un'_analisi stocastica_ della rete, in quanto in virtù dei rischi a cui un malfunzionamento del sistema esporrebbe bisogna essere assolutamente __certi__ del suo corretto funzionamento, certezza che può essere ottenuta solo con un __modello deterministico__. \
Ecco quindi che come strumento di specifica e comunicazione col cliente vengono sviluppate una serie di estensioni alle reti di Petri progettate specificamente per trattare il concetto di _tempo_ e _ritardo_: tra queste distingueremo in particolare le __reti Time Basic__ (_Ghezzi et al., 1989_), oggi le più usate.

- [**Modelli temporali**](./01_modelli-temporali.md)
- [**Reti Time Basic**](./02_reti-tb.md)
- [**Evoluzione**](./03_evoluzione/00_index.md)
- [**Analisi delle reti Time Basic**](./04_analisi/00_index.md)
