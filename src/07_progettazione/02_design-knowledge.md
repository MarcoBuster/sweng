# Design knowledge

La design knowledge è la __conoscenza del design__ architetturale di un progetto. 
È possibile utilizzare:
- la __memoria__: non è efficace perché nel tempo si erode, specialmente in coppia;
- i __documenti di design__ (linguaggio naturale o diagrammi): se non viene aggiornato di pari passo con il codice rimane disallineato, risultando più dannoso che d'aiuto.
- le __piattaforme di discussione__ (version control, issue management): possono aiutare ma le informazioni sono sparse in luoghi diversi e di conseguenza difficili da reperire e rimane il problema di mantenere aggiornate queste informazioni.
- gli __UML__: tramite diagrammi UML si è cercato di sfruttare l'approccio ___generative programming___, ovvero la generazione automatica del codice a partire da specificazioni di diagrammi.
Con l'esperienza si è visto che non funziona.
- il __codice__ stesso: tramite la lettura del codice è possibile capire il design ma è difficile rappresentare le ragioni della scelta.

È bene sfruttare tutte le tecniche sopra proposte __combinandole__, partendo dal codice. \
È inoltre importante scrivere documentazione per spiegare le ragioni dietro le scelte effettuate e non le scelte in sé, che si possono dedurre dal codice.

## Condivisione

Per condividere tali scelte di design (il _know how_) è possibile sfruttare:
- __metodi__: con pratiche (come Agile) o addirittura l'object orientation stessa, che può essere un metodo astratto per condividere scelte di design.
- __design pattern__: fondamentali per condividere scelte di design, sono utili anche per generare un vocabolario comune (sfruttiamo dei nomi riconosciuti da tutti per descrivere i ruoli dei componenti) e aiutano l'implementazione (i pattern hanno delle metodologie note per essere implementati). 
I pattern non si concentrano sulle prestazioni di un particolare sistema ma sulla generalità e la riusabilità di soluzioni a problemi comuni;
- __principi__: per esempio i principi SOLID.
