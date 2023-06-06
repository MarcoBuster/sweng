# Criterio di copertura dei cammini DU

Nel criterio precedente si richiedeva di testare _un_ cammino da ogni definizione ad ogni suo uso, ma come sappiamo i cammini tra due istruzioni di un programma possono essere molteplici.
Potrebbe dunque sorgere l'idea di testarli _tutti_: da questa intuizione nasce il __criterio di copertura dei cammini DU__.

$$
\begin{align*}
T \in C_{pathDU} \Longleftrightarrow& \forall i \in P, \  \forall x \in \operatorname{def}(i), \ \forall j \in \operatorname{du}(i, \\, x), \\\\
&\forall \text{ cammino da $i$ a $j$ senza ulteriori definizioni di $x$} \\\\
& \exists t \in T \ \text{che lo esegue}.
\end{align*}
$$

Questo criterio può essere __utile da ipotizzare__, ma a causa dell'esplosione combinatoria del numero dei cammini è considerato __impraticabile__ (_"sopra la barra rossa"_).
