# Testing funzionale

Introduciamo ora una nuova attività di testing che parte da presupposti completamente diversi rispetto a quelli del test strutturale.

Il __test funzionale__ è infatti un tipo di test che si concentra sulla verifica del comportamento del programma dal punto di vista dell'__utente finale__, senza considerare il suo funzionamento interno.
In altre parole, il test funzionale è un approccio __black box__ in cui non si ha (o non comunque non si sfrutta) la conoscenza del codice sorgente.

Talvolta questo può essere l'__unico approccio possibile__ al testing, come nel caso di validazione del lavoro di un committente esterno; altre volte invece si decide volontariamente di farlo, concentrandosi sul __dominio delle informazioni__ invece che sulla struttura di controllo. \
Il test funzionale, che prende in considerazione le __specifiche__ (e non i requisiti) del progetto per discriminare un comportamento corretto da uno scorretto, permette infatti di identificare errori che __non possono essere individuati__ con criteri strutturali, come per esempio funzionalità non implementate, flussi di esecuzione dimenticati o errori di interfaccia e di prestazioni.

Le tecniche di test funzionale si possono raggruppare in:

- __metodi basati su grafi__: oltre alle tecniche già viste in precedenza, si può per esempio lavorare anche sui diagrammi di sequenza;
- __suddivisioni del dominio in classi di equivalenza__: si possono raggruppare i valori del dominio che causano lo stesso comportamento in classi d'equivalenza, così da testare tutti i _comportamenti distinti_ piuttosto che tutti i possibili valori del dominio.
Occorre fare attenzione a non fare l'inverso, ovvero a concentrarsi sui soli valori appartenenti ad una classe di equivalenza ignorando il resto;
- __analisi dei valori limite (test di frontiera)__: si testano, tra tutti i possibili valori del dominio, quelli _"a cavallo"_ tra una categoria e l'altra, in quanto essi possono più facilmente causare malfunzionamenti;
- __collaudo per confronto__: si confronta la nuova versione del programma con la vecchia, assicurandosi che non siano presenti regressioni.
Non solo si possono confrontare gli eseguibili, ma anche _specifiche formali eseguibili_ che rappresentino le caratteristiche importanti del software;

Non tutte le metodologie di testing funzionale ricadono però in una di queste categorie, e la più notevole è sicuramente il __testing delle interfacce__, di cui diamo un assaggio prima di passare a parlare di classi di equivalenza.

- [**Testing delle interfacce**](./01_interfacce.md)
- [**Classi di equivalenza**](./02_classi-equivalenza.md)
- [**Test di frontiera**](./03_test-frontiera.md)
- [**Category partition**](./04_category-partition.md)
- [**Object orientation e testing funzionale**](./05_object-orientation.md)
