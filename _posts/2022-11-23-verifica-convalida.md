---
layout: post
title: "[12] Verifica e convalida"
date:   2022-11-23 14:30:00 +0200
toc: true
---

# Introduzione

## Terminologia

- La __verifica__ è il confronto del software con le specifiche (formali) prodotte dall'analista.
- La __convalida__ è il confronto del software con i requisiti (informali) posti dal committente.

Spesso si utilizza il termine __errore__: l'attivita di verifica e convalida cerca gli errori.

Un __malfunzionamento__ (o __errore__) è uno _scostamento_ dal comportamento corretto del programma, e non dipende dal codice.
Può essere un malfunzionamento rispetto alle specifiche o alle aspettative.

Per esempio: 

```java
static int radoppia (int par) {
    int risultato;
    risultato = (par * par);
    return risultato;
} 
```
la funzione dovrebbe ritornare il doppio del numero in ingresso, ma se gli passiamo 3 ritorna 9.

Un __difetto__ (o __anomalia__) è invece un punto del codice che non fa quello che dovrebbe.

La presenza di un malfunzionamento è condizione sufficiente per la presenza di un difetto, ma la presenza di un difetto non è condizione sufficiente per la presenza di un malfunzionamento.

$$
\text{Malfunzionamento} \Rightarrow \text{Anomalia} \\
\text{Anomalia} \not \Rightarrow \text{Malfunzionamento}
$$

Uno __sbaglio__ (o __mistake__) è la causa di un'anomalia. Si tratta in genere di errore umano. Può essere, per l'esyoempio precedente:
- _battitura_: ho scritto "`*`" invece di "`+`";
- _concettuale_: non sa cosa vuol dire _raddoppiare_;
- _padronanza del linguaggio_: credeva che "`*`" fosse simbolo dell'addizione.

### Esempio: il caso Ariane 5

<iframe width="560" height="315" src="https://www.youtube.com/embed/PK_yguLapgA?start=67" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Il malfunziamento è chiaro: il razzo è esploso (SPOILER) e chiaramente non era il comportamento richiesto.

Quale era l'anomalia? Il malfunziamento si è verificato per una eccezione di overflow sollevatosi durante una conversione di 64 bit float a un 16 bit signed int del valore della velocità orizzontale. 
Questo ha bloccato sia l'unità principale che il backup.

Lo sbaglio? Tale eccezione non veniva gestita perché questa parte del software era stata ereditata da Ariane 4, la cui traiettora faceva sì che non si raggiungessero mai velocità orizzontali non rappresentabili con int 16 bit. 
La variabile incriminata non veniva protetta per gli _"ampi"_ margini di sicurezza.

Il comportamento della variabile non era mai stato analizzato con i dati relativi alla traiettoria da seguire.

## Tecniche

statiche vs dinamiche.

### Metodi formali

Tento di dimostrare l'_assenza_ di anomalie nel prodotto finali.
Posso utilizzare, per esempio:
- analisi di dataflow (?);
- dimostrazione di correttezza delle specifiche logiche.

Principio dell'__inaccuratezza pessimistica__: se non si riesce a dimostrare l'assenza di un problema allora non va bene. 
Forse un po' troppo pessimista?

### Testing

Il testing è l'insieme delle tecniche che si prefiggono di rilevare malfunzionamenti. 

Non può dimostrare la correttezza ma solo aumentare la fiducia.

Esistono diversi tipi di testing:
- __white box__: abbiamo accesso al codice da testare e cercare anomalie;
- __black box__: non abbiamo accesso al codice ma è possibile testare e cercare malfunzionamenti tramite le interfacce esterne;
- __gray box__: non abbiamo accesso al codice ma solo un'idea dell'implementazione ad alto livello; per esempio, in un modello MVC ci possiamo aspettare chiamate al database.

Principio dell'__inaccurattezza ottimistica__: se non si riesce a dimostrare la presenza di problemi allora va bene.
Forse un po' troppo ottimista?

### Debugging

Dato un programma e un malfunzionamento noto, il debugging è una tecnica che ci permette di localizzare le __anomalie__ che causano malfunzionamenti.

## Correttezza

Quando un programma si definisce corretto?

- consideriamo un generico programma $$P$$ come una funzione da un insieme di dati $$D$$ (dominio) a un insieme di dati $$R$$ (codominio);
- $$P(d)$$ indica l'esecuzione di $$P$$ su un dato in ingresso $$d \in D$$;
- il risultato $$P(d)$$ è corretto se soddisfa le specifiche, altrimenti è scorretto;
- $$\operatorname{ok}(P, \, d)$$ indicherà la correttezza di $$P$$ per il dato $$d$$;

allora...

$$
P \text{ è } \textit{corretto} \Leftrightarrow \forall d \in D \: \operatorname{ok}(P, \, d)
$$

### Test

- un test $$T$$ per un programma $$P$$ è un sottoinsieme del dominio $$D$$;
- un elemento $$t$$ di un test $$T$$ è detto _caso di test_;
- l'esecuzione di un test consiste nell'esecuzione del programma $$\forall t \in T$$;
- un programma __passa__ o __supera__ un test:

$$
\operatorname{ok}(P, \, T) \Leftrightarrow \forall t \in T \: \operatorname{ok}(P, \, t)
$$

- un test $$T$$ ha successo se rileva uno o più malfunzionamenti presenti nel programma $$P$$

$$
\operatorname{successo}(T, \, P) TODO  
$$

#### Test ideale

$$T$$ è _ideale_ per $$P$$ se e solo se $$\operatorname{ok}(P, \, T) \Rightarrow \operatorname{ok}(P, \, D)$$ cioè se il superamento del test implica la correttezza del programma.

In generale, è __impossibile trovare un test ideale__.

> Il test di un prorgamma può rilevare la presenza di malfunzionamenti ma non dimostrarne l'assenza
> 
> ~ __Tesi di Dijkstra__

Non esiste quindi un algoritmo che dato un programma arbitrario $$P$$ generi un test ideale finito (il caso $$T = D$$ non va considerato).

```java
class Trivial {
    static int sum(int a, int b) {
        return a + b;
    }
}
```

Perché è impossibile trovare un test ideale esaustivo? 

In Java un int è espresso su 32 bit, quindi il dominio ha di cardinalità $$ 2^{32} \cdot 2^{32} = 2^{64} \sim 2 \cdot 10^{19}$$.
Considerando un tempo di 1 nanosecondo per ogni test, ci dovremmo mettere più di 600 anni.

#### Criterio di selezione

Come faccio a scegliere un sottoinsieme del dominio _intelligente_ cercando di approssimare il test ideale? 

Un _criterio di selezione_ si dice __affidabile__ se presi due test $$T_1$$ e $$T_2$$ in base al criterio $$C$$ allora o entrambi hanno sucecsso o nessuno dei due ha successo.

$$
\operatorname{affidabile}(C, \, P) \Leftrightarrow [\forall T_1 \in C, \, \forall T_2 \in C \: \operatorname{successo}(T_1, \, P) \Leftrightarrow \operatorname{successo}(T_2, P)]
$$

... __valido__ se qualora $$P$$ non sia corretto, allora esiste almeno un test $$T$$ selezionato in base al criterio $$C$$ che ha successo per il programma $$P$$

$$
\operatorname{valido}(C, \, P) \Leftrightarrow (\lnot \operatorname{ok}(P, \, D) \Rightarrow \exists T \in C ..................)
$$

__Esempio__: dato il codice
```java
static int raddoppia(int par) {
    int risultato;
    risultato = (par * par);
    return risultato;
}
```
un criterio che seleziona...
- _"sottoinsiemi di $$\{0, \, 2\}$$"_ è ___affidabile__ ma non valido_;
- _"i sottoinsiemi di $$\{0, \, 1, \, 2, \, 3, \, 4\}$$"_ è _non affidabile ma __valido___;
- _"sottoinsieme finiti di $$D$$ con almeno un valore maggiore di $$18$$"_ è ___affidabile e valido___.... 

    ma siamo davvero sicuri????

<!-- aggiungere slide 65 (osservazioni) -->

<!-- caratteristiche caso di test (slide 67) -->

<!-- anche slide 66 -->

<!-- e 68 -->

Un test $$T$$ soddisfa il criterio di __copertura dei comandi__ se e solo se ogni comando eseguibile del programam è eseguito in corrispondenza di almeno un caso di test $$t \in T$$.

Notare: nella definizione si parla di _comandi eseguibili_, ovvero la frazione di comandi eseguiti su quelli eseguibili.
