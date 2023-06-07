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

# Criterio di copertura degli usi

_Un test \\(\ T\\) soddisfa il __criterio di copertura degli usi__ se e solo se per ogni nodo \\(i\\) e ogni variabile \\(x\\) appartenente a \\(\operatorname{def}(i)\\), \\(T\\) include un caso di test che esegue un cammino libero da definizioni da \\(i\\) ad __ogni elemento__ di \\(\operatorname{du}(i, \\, x).\\)_

Sembra simile al precedente, con la differenza che ora bisogna coprire __tutti__ i potenziali usi di una variabile definita.
Questo appare ancora più chiaro osservando la formula matematica:

$$
\begin{align*}
T \in C_{path} \Longleftrightarrow& \forall i \in P, \  \forall x \in \operatorname{def}(i), \ \forall j \in \operatorname{du}(i, \\, x), \\\\
& \exists t \in T \ \text{che esegue un cammino da $i$ a $j$ senza ulteriori definizioni di $x$}.
\end{align*}
$$

Si noti però che il criterio di copertura degli usi __non implica il criterio di copertura delle definizioni__, perché nel caso in cui non esistano \\(j \in \operatorname{du}(i, \\, x)\\) l'uso del \\(\forall\\) è più _"permissivo"_ del \\(\exists\\) del criterio precedente: quest'ultimo richiedeva infatti che per ogni definizione esistesse almeno un uso, mentre il criterio di copertura degli usi non pone tale clausola (_se non ci sono usi il \\(\forall\\) è sempre vero_).
Viene quindi da sé che questo criterio non copre neanche il criterio di copertura dei comandi.

Riconsideriamo nuovamente il programma in C visto in precedenza come esempio:

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

Come prima, consideriamo la variabile \\(\mathtt a\\) e i relativi insieme dei nodi degli usi per ogni sua definizione:

1. \\(\operatorname{du}(5, \\, \mathtt a)\\) = \\(\{7, \\, 8, \\, 9, \\, 11, \\, 12\}\\);
2. \\(\operatorname{du}(9, \\, \mathtt a)\\) = \\(\{7, \\, 8, \\, 9, \\, 11, \\, 12\}\\).

Per ogni definizione occorre coprire __tutti gli usi__:

<style>
  #criterio-usi-tabella {
    text-align: center;
  }
  #criterio-usi-tabella p {
    margin-bottom: 0;
  }
</style>

<table id="criterio-usi-tabella" style="text-align: center;">
<tr>
  <th style="width: 50%">

\\(\operatorname{du}(5, \\, \mathtt a)\\)
  </th>
  <th>
  
  \\(\operatorname{du}(9, \\, \mathtt a)\\)</th>
</tr>
<tr>
  <td>
  
  \\(\D{5}\UG{7}\UG{8}\UG{11}\U{7}\UG{12}\\)
  </td>
  <td>
  
  \\(\dots \\, \D{9} \UG7 \UG8 \UG9 \dots\\)
  </td>
</tr>
<tr>
  <td>
  
  \\(\dots \\, \D5 \U7 \U8 \UG9 \dots\\)
  </td>
  <td>
  
  \\(\dots \\, \D9 \U7 \U8 \UG{12} \dots\\)
  </td>
</tr>
<tr>
  <td></td>
  <td>
  
  \\(\dots \\, \D9 \U7 \U8 \UG{11} \dots\\)
  </td>
</tr>
</table>

Un test che soddisfa totalmente il criterio può essere il seguente:

$$
T = \{ \langle 4, \\,  8 \rangle, \\, \langle 12, \\, 8 \rangle, \\, \langle 12, \\, 4 \rangle \}.
$$

Questo esempio permette di notare qualcosa sulla natura dei cicli: dovendo testare ogni percorso al loro interno è necessario fare almeno due iterazioni.
Può quindi sorgere un dubbio: è meglio che le due iterazioni siano fatte nello stesso caso di test o in casi test separati? Ovvero, è meglio __minimizzare__ i __casi di test__ o le __iterazioni per caso__? \
Opinione diffusa è quella secondo cui è preferibile __minimizzare le iterazioni__: partizionando le casistiche in diversi casi di test è possibile rilevare con più precisione gli errori, riducendo il tempo di debug.
In alcune situazioni però aumentare il numero di iterazioni può diminuire il tempo di esecuzione totale dei test, in quanto dovendo riavviare il programma per ciascun caso di test la somma dei tempi di startup può diventare significativa per software molto massicci.
