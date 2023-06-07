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

# Oltre le variabili

L'analisi del flusso dati si può estendere anche su altri _"oggetti"_, non solo variabili. \
Per esempio, è possibile prevedere le seguenti operazioni su un __file__:

- \\(\op{a}\\) (__apertura__): specializzata in _per lettura_ o _per scrittura_;
- \\(\op{c}\\) (__chiusura__);
- \\(\op{l}\\) (__lettura__);
- \\(\op{s}\\) (__scrittura__).

Date queste operazioni si possono individuare una serie di regole, come per esempio:

1. \\(\op{l}\\), \\(\op{s}\\) e \\(\op{c}\\) devono essere precedute da \\(\op{a}\\) senza \\(\op{c}\\) intermedie;
2. \\(\op{a}\\) deve essere seguita da \\(\op{c}\\) prima di un'altra \\(\op{a}\\);
3. legami tra tipo di apertura (per lettura o per scrittura) e relative operazioni.

È interessante notare il __legame__ tra l'attività di analisi del flusso di dati e i diagrammi UML a stati finiti: un _oggetto_ risponde a una certa _tipologia di eventi_, può essere in diversi _stati_ e in certi _stati_ non sono ammesse alcune _operazioni_.
Si noti come nessuna delle due discipline entra comunque nel merito del valore delle variabili, relegato ad un'analisi a runtime.

## Criterio di _copertura del budget_

Molto spesso nei contesti reali l'unico criterio applicato è quello di __copertura del budget__: si continuano a creare casi di test finché non sono finite le risorse (tempo e soldi).
Questa tecnica ovviamente non fornisce alcuna garanzia sull'efficacia dei test, ed è sicuramente sconsigliata.
