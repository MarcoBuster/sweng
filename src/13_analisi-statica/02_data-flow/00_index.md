<!-- KaTeX op macro definitions -->
<div style="display: none; margin: 0;">
$$
\require{color}
% Regular operations
\def\op#1{
  \fcolorbox{black}{white}{$\vphantom{d} \sf{#1}$}
}
\def\d{\op{d} \\,}
\def\a{\op{a} \\,}
\def\u{\op{u} \\,}
% Erroneous operations
\def\opR#1{
  \fcolorbox{black}{orangered}{$\vphantom{d} \color{white}{\sf{#1}}$}
}
\def\dR{\opR{d} \\,}
\def\aR{\opR{a} \\,}
\def\uR{\opR{u} \\,}
% Subscript operations
\def\Op#1#2{
  \fcolorbox{black}{white}{$\vphantom{d_6} \sf{#1}_{#2}$}
}
\def\D#1{\Op{d}{#1} \\,}
\def\A#1{\Op{a}{#1} \\,}
\def\U#1{\Op{u}{#1} \\,}
% Warning subscript operations
\def\OpW#1#2{
  \fcolorbox{black}{orange}{$\vphantom{d_6} \sf{#1}_{#2}$}
}
% Green subscript operations
\def\OpG#1#2{
  \fcolorbox{black}{lightgreen}{$\vphantom{d_6} \sf{#1}_{#2}$}
}
\def\DG#1{\OpG{d}{#1} \\,}
\def\AG#1{\OpG{a}{#1} \\,}
\def\UG#1{\OpG{u}{#1} \\,}
% Error
\def\Err{
  \color{red}{\sf{ERROR}}
}
\def\err{
  \\, \Err
}
$$
</div>

# Analisi Data Flow

Nata nell'ambito dell'__ottimizzazione dei compilatori__, che per migliorare le proprie performance ricercavano porzioni di codice non raggiungibile da non compilare, l'__analisi del flusso di dati__ è stata più avanti imbracciata dall'ingegneria del software per ricercare e prevenire le cause di errori simili. \
Parlando di flusso dei dati si potrebbe pensare a un'analisi prettamente dinamica come il testing, ma l'insieme dei controlli statici che si possono fare sul codice per comprendere come vengono _utilizzati_ i valori presenti nel programma è invece particolarmente significativo.

È possibile infatti analizzare staticamente il tipo delle operazioni eseguite su una variabile e l'__insieme dei legami di compatibilità__ tra di esse per determinare se il valore in questione viene usato in maniera _semanticamente sensata_ all'interno del codice. \
Nello specifico, le operazioni che possono essere eseguite su un __dato__ sono solamente di tre tipi:

- \\(\op{d}\\) (__definizione__): il comando __assegna un valore__ alla variabile; anche il passaggio del dato come parametro ad una funzione che lo modifica è considerata un'operazione di (ri)definizione;

- \\(\op{u}\\) (__uso__): il comando __legge il contenuto__ di una variabile, come per esempio l'espressione sul lato destro di un assegnamento;

- \\(\op{a}\\) (__annullamento__): al termine dell'esecuzione del comando il valore della variabile __non è significativo/affidabile__.
  Per esempio, dopo la _dichiarazione senza inizializzazione_ di una variabile e al termine del suo _scope_ il valore è da considerarsi inaffidabile.

Dal punto di vista di ciascuna variabile è possibile ridurre una qualsiasi sequenza d'istruzioni (_ovvero un cammino sul diagramma di flusso_) a una sequenza di definizioni, usi e annullamenti.

- [**Regole**](./01_regole.md)
- [**Sequenze**](02_sequenze.md)
