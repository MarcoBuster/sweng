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

# Regole

Fatta questa semplificazione è allora possibile individuare la presenza di anomalie nell'uso delle variabili definendo alcune __regole di flusso__: alcune di queste devono essere necessariamente rispettate in un programma corretto (1 e 3), mentre altre hanno più a che fare con la semantica dell'uso di un valore (2).

<ol>

<li>

  L'**uso di una variabile** deve essere **sempre preceduto** in ogni sequenza **da una definizione senza annullamenti intermedi**.

  $$
  \a\u\err
  $$
</li>
<li>

  La **definizione di una variabile** deve essere **sempre seguita** da **un uso**, **prima** di un suo **annullamento** o nuova **definizione**.

  $$
  \d\a\err \\\\
  \d\d\err
  $$

</li>
  <li>

  L'**annullamento di una variabile** deve essere **sempre seguito** da **una definizione**, **prima** di un **uso** o **altro annullamento**.
  
  $$
  \a\a\err
  $$

</li>
</ol>

Riassumendo, \\(\a\op{u}\\), \\(\d\op{a}\\), \\(\d\op{d}\\) e \\(\a\op{a}\\) sono sequenze che identificano __situazioni anomale__, anche se non necessariamente dannose: se per esempio usare una variabile subito dopo averla annullata rende l'esecuzione del programma non controllabile, un annullamento subito dopo una definizione non crea nessun problema a runtime, ma è altresì indice di un possibile errore concettuale.

<table align="center" style="width: 50%">
<tr>
  <th></th>
  <th>
  
  \\(\a\\)</th>
  <th>
  
  \\(\d\\)</th>
  <th>
  
  \\(\u\\)</th>
</tr>
<tr>
  <th>
  
  \\(\a\\)</th>
  <th>
  
  \\(\Err\\)</th>
  <th></th>
  <th>
  
  \\(\Err\\)</th>
</tr>
<tr>
  <th>
  
  \\(\d\\)</th>
  <th>
  
  \\(\Err\\)</th>
  <th>
  
  \\(\Err\\)</th>
  <th></th>
</tr>
<tr>
  <th>
  
  \\(\u\\)</th>
  <th></th>
  <th></th>
  <th></th>
</tr>
</table>

#### Esempio

Consideriamo la seguente funzione C con il compito di scambiare il valore di due variabili:

```c
void swap(int &x1, int &x2) {
    int x1;
    x3 = x1;
    x3 = x2;
    x2 = x1;
}
```

Analizzando il codice, le sequenze per ogni variabile sono le seguenti:

| Variabile | Sequenza | Anomalie |
|-|-|-|
| `x1` | \\(\aR\uR\u\a\\) | `x1` viene usata 2 volte senza essere stata prima definita |
| `x2` | \\(\dots \d\u\op{d} \dots\\) | Nessuna |
| `x3` | \\(\dots \d\dR\opR{d} \dots\\) | `x3` viene definita più volte senza nel frattempo essere stata usata |

Come si vede, in un codice sintatticamente corretto l'analisi Data Flow ci permette quindi di scovare un errore semantico osservando le sequenze di operazioni sulle sue variabili.
