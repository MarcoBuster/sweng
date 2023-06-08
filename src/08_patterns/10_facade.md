# <big>F</big>ACADE

Costruendo un sistema complesso può capitare di dover definire una serie di interfacce molto specifiche e dettagliate per i propri componenti in modo che questi possano lavorare correttamente in concerto tra di loro.
Il problema sorge però quando un Client, dovendo accedere al sistema, si ritrova costretto a dover interagire direttamente con i sottosistemi che lo compongono, cosa che lo obbliga a sviscerare i funzionamenti interni dello stesso per ottenere un comportamento tutto sommato semplice.

Lo scopo del pattern Facade è allora quello di __fornire un'interfaccia unificata e semplificata a un insieme di interfacce separate__: spesso infatti l'uso comune di un sistema si riduce un paio di operazioni ottenibili combinando varie funzionalità fornite dal package; invece di richiedere al Client di operare tale composizione facciamo ricadere sulle nostre spalle tale compito costruendo una _classe_ che faccia da _interfaccia standard_ al sistema.

![Facade](/assets/09_facade.png)

Si noti come questo non impedisca al Client di usare anche le funzionalità più complesse, ma metta solo ulteriormente a disposizione un'interfaccia che gli permetta di sfruttare facilmente quelle più frequentemente utilizzate.
Volendo fornire un esempio nella vita reale, un telecomando fornisce un'interfaccia semplice ai controlli della televisione, permettendo di regolare il volume e cambiare canale con semplicità: aprendo però uno sportellino ecco che ci vengono forniti tutti i comandi più specifici.
