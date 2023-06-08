# Criterio di \\(n\\)-copertura dei cicli

_Un test \\(\ T\\) soddisfa il __criterio di \\(\bf{\it{n}}\\)-copertura__ se e solo se ogni cammino del grafo contenente al massimo un numero d'iterazioni di ogni ciclo non superiore a \\(n\\) viene percorso per almeno un caso di test \\(\ t \in T\\)._

La definizione sopra non significa che il test deve eseguire \\(n\\) volte un ciclo, ma che per ogni numero \\(k\\) compreso tra 0 e \\(n\\) deve esistere un caso di test che esegue tale ciclo \\(k\\) volte.
Si sta quindi __limitando il numero massimo di percorrenze__ dei cicli. \
Di conseguenza, al crescere di \\(n\\) il numero di test aumenta molto rapidamente.
Inoltre, fissare \\(n\\) a livello di programma può non essere un'azione così semplice: il numero d'iterazioni che necessita un ciclo per essere testato a fondo può essere __molto differente__ a seconda del caso.

Per cercare di minimizzare il numero di test spesso il criterio applicato è quello di __\\(\bf{2}\\)-copertura dei cicli__.
Si tratta infatti del numero minimo che permette comunque di testare tutte le casistiche principali:

- zero iterazioni;
- una iterazione;
- _più di una_ iterazione.

Il caso \\(n = 2\\) è cioè il minimo per considerare casistiche non banali: dando uno sguardo all'esempio sopra, infatti, con \\(n = 1\\) il ciclo (`while`) sarebbe stato indistinguibile da una semplice selezione (`if`); testando due iterazioni si incominciano a testare le vere caratteristiche del ciclo.
Esso permette cioè di testare non solo i comandi che compongono il ciclo, ma anche sue le pre/post-condizioni ed eventuali invarianti.

A differenza del criterio di copertura dei cammini, il criterio di \\(n\\)-copertura è considerato __applicabile__ a programmi reali.
