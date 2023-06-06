# Component diagram

## Concetto e struttura

Lo scopo del __diagramma dei componenti__ è rappresentare e raggruppare i componenti del sistema. \
_"Componente"_ è un termine trasversale che include file, librerie, documenti _etc._ (ma che è diverso dal concetto di _classe_!).

Il diagramma include:
* __componenti__: rettangoli che rappresentano una funzione di sistema ben determinata. \
Possono essere _annidati_;
* __interfacce__: cerchi che indicano le interfacce implementate o utilizzate dai componenti. \
I collegamenti con i componenti indicano la presenza di una dipendenza;
* __stereotipi__: racchiusi tra i caratteri `<<>>`, etichettano e identificano una serie di funzionalità appartenenti ad uno stesso "gruppo".

![Esempio component diagram](/assets/11_component-diagram-example.png)

Si noti che un componente può usarne un altro conoscendone solo l'interfaccia.

## Identificare i componenti

Alcune linee guida per identificare e rappresentare correttamente i componenti sono:
- capire quali parti del sistema sono rimpiazzabili facilmente e/o sono versionate separatamente;
- identificare quali parti del sistema svolgono una funzione ben determinata;
- pensare in termini di "gerarchia" dei componenti;
- chiarire l'esistenza di dipendenze con altri componenti e di dipendenze con le interfacce.
