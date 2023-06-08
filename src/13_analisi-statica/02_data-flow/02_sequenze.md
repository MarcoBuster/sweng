<!-- KaTeX op macro definitions -->
<div style="display: none; margin: 0;">
$$
\require{color}
% Regular operations
\def\op#1{
  \fcolorbox{black}{white}{$\vphantom{d} \sf{#1}$}
}
\def\d{\op{d} \,}
\def\a{\op{a} \,}
\def\u{\op{u} \,}
% Erroneous operations
\def\opR#1{
  \fcolorbox{black}{orangered}{$\vphantom{d} \color{white}{\sf{#1}}$}
}
\def\dR{\opR{d} \,}
\def\aR{\opR{a} \,}
\def\uR{\opR{u} \,}
% Subscript operations
\def\Op#1#2{
  \fcolorbox{black}{white}{$\vphantom{d_6} \sf{#1}_{#2}$}
}
\def\D#1{\Op{d}{#1} \,}
\def\A#1{\Op{a}{#1} \,}
\def\U#1{\Op{u}{#1} \,}
% Warning subscript operations
\def\OpW#1#2{
  \fcolorbox{black}{orange}{$\vphantom{d_6} \sf{#1}_{#2}$}
}
% Green subscript operations
\def\OpG#1#2{
  \fcolorbox{black}{lightgreen}{$\vphantom{d_6} \sf{#1}_{#2}$}
}
\def\DG#1{\OpG{d}{#1} \,}
\def\AG#1{\OpG{a}{#1} \,}
\def\UG#1{\OpG{u}{#1} \,}
% Error
\def\Err{
  \color{red}{\sf{ERROR}}
}
\def\err{
  \, \Err
}
$$
</div>

# Sequenze

Abbiamo accennato più volte al concetto di "sequenza" di operazioni su una variabile.
Più formalmente, definiamo __sequenza__ di operazioni per la variabile \\(\mathtt{a}\\) secondo il cammino \\(p\\) la concatenazione della tipologia delle istruzioni che coinvolgono tale variabile, e la indichiamo con \\(\operatorname{P}(p, \\, \mathtt{a})\\).

Considerando per esempio il seguente programma C:

```c
01  void main() {
02      float a, b, x, y;
03      read(x);
04      read(y);
05      a = x;
06      b = y;
07      while (a != b)
08          if (a > b)
09              a = a - b;
10          else
11              b = b - a;
12      write(a);
13  }
```

possiamo dire che:

$$
\begin{align*}
&\operatorname{P}([1, 2, 3, 4, 5, 6, 7, 8, 9, 7, 12, 13], \\, \mathtt{a}) \\\\
&= \A{2} \D{5} \U{7} \U{8} \U{9} \D{9} \U{7} \U{12} \A{13}
\end{align*}
$$

Eseguendo questo tipo di operazione su tutte le variabili e per tutti i cammini del programma si potrebbe verificare la presenza eventuali anomalie, ma come sappiamo __i cammini sono potenzialmente infiniti__ quando il programma contiene cicli e decisioni: per scoprire quali percorsi segue effettivamente l'esecuzione del programma dovremmo eseguirlo e quindi uscire dal campo dell'analisi statica.

#### Espressioni regolari

Tuttavia non tutto è perduto: un caso di cammini contenenti __cicli__ e __decisioni__ è possibile rappresentare un insieme di sequenze ottenute dal programma \\(P\\) utilizzando delle __espressioni regolari__.
Con \\(\operatorname{P}([1 \rightarrow], \\, \mathtt{a})\\) si indica infatti l'espressione regolare che rappresenta __tutti i cammini__ che partono dall'istruzione \\(1\\) per la variabile \\(\mathtt{a}\\).

Questo perché nelle espressioni regolari è possibile inserire, oltre che una serie di parentesi che isolano sotto-sequenze, anche due simboli molto particolari:

- la __pipe__ (\|), che indica che i simboli (o le sotto-sequenze) alla propria destra e alla propria sinistra si _escludono_ a vicenda: _una e una sola_ delle due è presente;
- l'__asterisco__ (\*), che indica che il simbolo (o la sotto-sequenza) precedente può essere _ripetuto da 0 a \\(n\\) volte_.

Grazie a questi simboli è possibile rappresentare rispettivamente decisioni e cicli.
Prendendo per esempio il codice precedente, è possibile costruire \\(\operatorname{P}([1 \rightarrow], \\, \mathtt{a})\\) come:

$$
\begin{align*}
&\A{2} \D{5} & & &&&  && && & & \\\\
&\A{2} \D{5} &\U{7} &\Big( &\phantom{\U8} &&\textit{while body} &&\phantom{\U{7}} &&\Big)* &\quad \quad \U{12} &\A{13} \\\\
&\A{2} \D{5} &\U{7} &\Big( &\U{8} &&\textit{if body} &&\phantom{\U{7}} &&\Big)* &\quad \quad \U{12} &\A{13} \\\\
&\A{2} \D{5} &\U{7} &\Big( &\U{8} &&\Big(\, \U{9} \D{9} \Big | \: \U{11} \Big) && &&\Big)* &\quad \quad \U{12} &\A{13} \\\\
&\A{2} \D{5} &\OpW{u}{7} \\, &\Big( \\, &\U{8} &&\Big(\, \U{9} \D{9} \Big | \: \U{11} \Big)
  &&\OpW{u}{7} \\,
&&\Big)* &\quad \quad \U{12} &\A{13}
\end{align*}
$$

Osserviamo come \\(\OpW{u}{7}\\) si ripeta due volte: questo può rendere _fastidioso_ ricercare errori, per via della difficoltà di considerare cammini multipli.
Comunque sia, una volta ottenuta un'espressione regolare è facile verificare l'eventuale presenza di errori applicando le solite regole (nell'esempio non ce n'erano).

Bisogna però fare attenzione a un'aspetto: le espressioni regolari così costruite rappresentano __tutti i cammini__ possibili del programma, ma __non tutti e i soli__!
Trattandosi di oggetti puramente matematici, infatti, le espressioni regolari sono necessariamente _più generali_ di qualunque programma: esse non tengono infatti conto degli _effetti_ che le istruzioni hanno sui dati e delle relative proprietà che si possono inferire. \
Riprendendo a esempio l'espressione regolare di cui sopra, essa contiene la sequenza nella quale il ciclo viene eseguito _infinite volte_, ma osservando il programma è facile indovinare che tale comportamento non sia in realtà possibile: diminuendo progressivamente \\(\mathtt{a}\\) e \\(\mathtt{b}\\) a seconda di chi sia il maggiore si può dimostrare che prima o poi i due convergeranno allo stesso valore permettendo così di uscire dal ciclo.

In effetti, uno stesso programma può essere rappresentato tramite __un numero infinito di espressioni regolari__ valide.
Si potrebbe addirittura argomentare che l'espressione regolare

$$
\Big ( \\, \u \Big | \: \d \Big | \: \a \Big)*
$$

possa rappresentare qualsiasi programma. \
Allontanandosi però dai casi estremi, si dimostra essere impossibile scrivere un algoritmo che dato un qualsiasi programma riesca a generare un'espressione regolare che rappresenti __tutti e soli__ i suoi cammini possibili senza osservare i valori delle variabili.
Bisogna dunque accontentarsi di trovare espressioni regolari che rappresentino __al meglio__ l'esecuzione del programma, ovvero con il minor numero di cammini impossibili rappresentati.

Nell'analisi Data Flow tramite espressioni regolari è quindi necessario tenere conto che il modello generato è un'__astrazione pessimistica__: se viene notificata la presenza di un errore non si può essere certi che esso ci sia veramente, in quanto esso potrebbe derivare da un cammino non percorribile.