# Analisi delle reti di Petri

Le reti di Petri sono state introdotte per poter **analizzare un sistema** ancora prima di avere il codice.
Alcune domande da porsi sono:

- può essere raggiunta una determinata marcatura?
- è possibile una certa sequenza di scatti?
- esiste uno stato di deadlock all'interno della rete?
- la rete (o una certa transizione) è viva? E di che grado?

Per rispondere a queste domande esistono diverse tecniche, suddivise in:

- **tecniche dinamiche**:
  - albero (grafo) delle marcature raggiungibili (chiamato anche **grafo di raggiungibilità**);
  - albero (grafo) di copertura delle marcatura raggiungibili (chiamato anche **grafo di copertura**);
- **tecniche statiche**:
  - identificazione delle **\\(P\\)-invarianti** (caratteristiche invarianti riguardanti i posti);
  - identificazione delle **\\(T\\)-invarianti** (caratteristiche invarianti riguardanti alle transizioni).

Le tecniche dinamiche ragionano sugli **stati raggiungibili** durante l'esecuzione della rete di Petri (o di un programma), mentre le statiche sulla **topologia della rete**.

  - [**Albero di raggiungibilità**](./01_albero-raggiungibilita.md)
  - [**Albero di copertura**](./02_albero-copertura.md)
  - [**Rappresentazione matriciale**](./03_rappresentazione-matriciale.md)
  - [**Analisi statica**](./04_analisi-statica/00_index.md)
  - [**Controllori con specifica a stati proibiti**](./05_controllori.md)
  - [**Reti con priorità**](./06_reti-priorita.md)
