# Documentazione
La __documentazione__ cartacea __non è necessaria__: 
il cliente, il compagno di peer programming e il codice _sono la documentazione_.

La documentazione è sostituita dal codice in quanto:
- i __test di unità__ che sono delle _specifiche eseguibili_, infatti li scrivo prima di fare il codice (prima dico cosa voglio tramite il test);
- il __continuo refactoring__ consente di avere un codice estremamente leggibile e quindi elimina il bisogno dei commenti.
Scrivere codice semplice tramite refactoring in modo che sia facilmente comprensibile è in realtà molto complesso.

## CRC cards
Le __Class Responsibility and Collaboration cards__ permettono di rappresentare classi e le relazioni tra di esse.
Nate in ambiente didattico per spiegare l'OOP, sono ora utilizzati da alcuni team agile per discutere di design e il modo di utilizzo è simile a quello del planning game.

> Le carte CRC sono realizzate su piccole schede di carta o cartoncino. Ciascuna carta descrive una classe (o un oggetto) in modo sommario, indicando:
> 
> - Il nome della classe
> - Le sue superclassi e sottoclassi (dove applicabile)
> - Le sue responsabilità
> - Il nome di altre classi con cui questa classe collabora per svolgere i compiti di cui è responsabile
> - L'autore
> 
> L'uso di schede di piccole dimensioni ha lo scopo di limitare la complessità della descrizione, evitando che vengano riportate troppe informazioni di dettaglio. Serve anche a impedire che a una classe vengano assegnate troppe responsabilità. Il supporto cartaceo consente una serie di attività gestuali utili in fase di brainstorming, come piazzare le carte su un tavolo e spostarle, riorganizzarle, o anche eliminarle e sostituirle facilmente con altre nel corso della discussione. Il posizionamento delle carte su un tavolo può essere usato intuitivamente per rappresentare informazioni aggiuntive; per esempio, due carte possono essere parzialmente sovrapposte per indicare una relazione di stretta collaborazione, o una carta può essere posta sopra un'altra per indicare una relazione di controllo/supervisione.
> 
> _Da [Wikipedia](https://it.wikipedia.org/wiki/Carte_di_Class_Responsibility_Collaboration), l'enciclopedia libera (licenza CC BY-SA 3.0)_.
