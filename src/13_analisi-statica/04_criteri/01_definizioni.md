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

# Criterio di copertura delle definizioni

_Un test \\(\ T\\) soddisfa il __criterio di copertura delle definizioni__ se e solo se per ogni nodo \\(i\\) e ogni variabile \\(x \in \operatorname{def}(i)\\), \\(T\\) include un caso di test che esegue un cammino libero da definizioni da \\(i\\) ad __almeno uno__ degli elementi di \\(\operatorname{du}(i, x).\\)_

Ci si vuole cioè assicurare di testare tutte le definizioni, assicurandosi che funzionino osservando almeno un uso del valore da loro assegnato.
Matematicamente si può dire che:

$$
\begin{align*}
T \in C_{def} \Longleftrightarrow& \forall i \in P, \  \forall x \in \operatorname{def}(i), \ \exists j \in \operatorname{du}(i, \\, x), \\\\
& \exists t \in T \ \text{che esegue un cammino da $i$ a $j$ senza ulteriori definizioni di $x$}.
\end{align*}
$$

Riconsideriamo l'esempio già visto in precedenza, considerando la variabile \\(\mathtt{a}\\):

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

Partiamo definendo gli insiemi dei nodi degli usi \\(\operatorname{du}(i, \\, \mathtt a)\\):

1. \\(\operatorname{du}(5, \\, \mathtt a)\\) = \\(\{7, \\, 8, \\, 9, \\, 11, \\, 12\}\\);
2. \\(\operatorname{du}(9, \\, \mathtt a)\\) = \\(\{7, \\, 8, \\, 9, \\, 11, \\, 12\}\\).

È solo __un caso__ il fatto che in questo esempio tali insiemi siano uguali. \
Comunque sia, l'obiettivo è _per ognuna delle due definizioni_ ottenere un __uso__ di tale definizione:

1. Per la prima definizione la soluzione è banale, a riga 7 la variabile \\(\mathtt a\\) viene letta sempre:
\\(\D{5}\U{7}\\).
2. Per la seconda, invece, è necessario scegliere un valore tale per cui il flusso di esecuzione entri almeno una volta nel ciclo ed esegua almeno una volta la riga 9:
\\(\D{9}\U{7}\\).

Un test che soddisfa totalmente il criterio può essere il seguente:

$$
T = \{ \langle 8, \\, 4 \rangle \}.
$$

Come si vede, il criterio di copertura delle definizioni non copre tutti i comandi e di conseguenza __non implica il criterio di copertura dei comandi__.
