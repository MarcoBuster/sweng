---
layout: post
title: "[13] Testing e Processi di review"
date: 2022-11-23 14:40:00 +0200
toc: true
---

## Correttezza di un software

La maggior parte dei problemi quando si lavora ad un progetto sorgono da problemi di comunicazione.
Ci posso essere incomprensioni quando le informazioni passano da una figura all'altra, per esempio quando ci si interfaccia tra cliente, analista e programmatore.
Con il cliente il programmatore dovrà cercare di adattare la propria terminologia per farsi comprendere, poi man mano che ci si sposta nel cerchio interno (the Inner Circle) dello sviluppo possiamo richederci uno sforzo in più in termini di formalità e chiarezza. 
Più si spiegano le cose in maniera chiara, più è facile che non si incorra in problemi successivi.

Bisogna quindi fare più attenzione alla terminologia che viene usata

Quando un programma si definisce corretto?

Consideriamo un generico programma $$P$$ come una funzione da un insieme di dati $$D$$ (dominio) a un insieme di dati $$R$$ (codominio);

$$P(d)$$ indica l'esecuzione di $$P$$ su un dato in ingresso $$d \in D$$;

il risultato $$P(d)$$ è corretto se soddisfa le specifiche, altrimenti è scorretto;

$$\operatorname{ok}(P, \, d)$$ indicherà la correttezza di $$P$$ per il dato $$d$$;

allora...

$$
P \text{ è } \textit{corretto} \Leftrightarrow \forall d \in D \: \operatorname{ok}(P, \, d)
$$

### Test

un test $$T$$ per un programma $$P$$ è un sottoinsieme del dominio $$D$$;

un elemento $$t$$ di un test $$T$$ è detto _caso di test_;

l'esecuzione di un test consiste nell'esecuzione del programma $$\forall t \in T$$;

un programma __passa__ o __supera__ un test:

$$
\operatorname{ok}(P, \, T) \Leftrightarrow \forall t \in T | \operatorname{ok}(P, \, t)
$$

un test $$T$$ _ha successo_ se rileva uno o più malfunzionamenti presenti nel programma $$P$$

$$
\operatorname{successo}(T, \, P) \Leftrightarrow \exist t \in T | \neg\operatorname{ok}(P,\,t) 
$$

### Test ideale

$$T$$ è _ideale_ per $$P$$ se e solo se $$\operatorname{ok}(P, \, T) \Rightarrow \operatorname{ok}(P, \, D)$$ ovvero se il superamento del test implica la correttezza del programma.

In generale, è __impossibile trovare un test ideale__.

> __Tesi di Dijkstra__:
>
> _Il test di un prorgamma può rilevare la presenza di malfunzionamenti ma non dimostrarne l'assenza._
>
>_Non esiste quindi un algoritmo che dato un programma arbitrario $$P$$ generi un test ideale finito (il caso $$T = D$$ non va considerato)._

Perché è impossibile trovare un test ideale esaustivo? 
Vediamo il seguente esempio:
```java
class Trivial {
    static int sum(int a, int b) {
        return a + b;
    }
}
```



In Java un int è espresso su 32 bit, quindi il dominio ha di cardinalità $$2^{32} \cdot 2^{32} = 2^{64} \sim 2 \cdot 10^{19}$$.
Considerando un tempo di 1 nanosecondo per ogni test, ci dovremmo mettere più di 600 anni.

### Criterio di selezione

Come faccio a scegliere un sottoinsieme del dominio _intelligente_ cercando di approssimare il test ideale? Quali caratteristiche ci interessa che abbia il criterio che usiamo per selezionare questo sottoinsieme?

#### Affidabilità
Un _criterio di selezione_ si dice __affidabile__ se presi due test $$T_1$$ e $$T_2$$ in base al criterio $$C$$ allora o entrambi hanno sucecsso o nessuno dei due ha successo.

$$
\operatorname{affidabile}(C, \, P) \Leftrightarrow [\forall T_1 \in C, \, \forall T_2 \in C \: \operatorname{successo}(T_1, \, P) \Leftrightarrow \operatorname{successo}(T_2, P)]
$$


#### Validità
Un _criterio di selezione_ si dice __valido__ se qualora $$P$$ non sia corretto, allora esiste almeno un test $$T$$ selezionato in base al criterio $$C$$ che ha successo per il programma $$P$$

$$
\operatorname{valido}(C, \, P) \Leftrightarrow (\lnot \operatorname{ok}(P, \, D) \Rightarrow \exists T \in C \ | \ successo(T,\,P))
$$

__Esempio__: dato il codice
```java
public class Esempio {
    static int raddoppia(int par) {
            int risultato;
            risultato = (par * par);
            return risultato;
    }
}
```
un criterio che seleziona:
- _"sottoinsiemi di $$\{0, \, 2\}$$"_ è ___affidabile__ ma non valido_;
- _"i sottoinsiemi di $$\{0, \, 1, \, 2, \, 3, \, 4\}$$"_ è _non affidabile ma __valido___;
- _"sottoinsieme finiti di $$D$$ con almeno un valore maggiore di $$18$$"_ è ___affidabile e valido___ 

Ma siamo davvero sicuri?

Se il test non ha successo, ci è utile avere un criterio valido ed affidabile?
- Il fatto che il test non abbia avuto successo implica che non ci siano stati errori
- Il fatto che il criterio sia affidabile implica che tutti gli altri test che possiamo trovare per quel criterio non trovo errori
- Il fatto che il criterio sia valido, se ci fosse stato un errore almeno uno dei test lo avrebbe dovuto trovare

Quindi siamo __sicuri__ che il programma è corretto:
$$
\operatorname{affidabile}(C,P) \wedge \operatorname{valido}(C,P) \wedge T \in C \wedge \neg\operatorname{successo}(T,P)
$$
$$
\Longrightarrow
$$
$$
\operatorname{ok}(P,D)
$$

Ma trovare un criterio che sia _contemporaneamente_ affidabile e valido significherebbe trovare un criterio che selezioni _test ideali_ che sappiamo non esistere per la _tesi di Dijkstra_

#### Utilità di un test

Quali sono le caratteristiche che rendono utile un caso di test, ovvero che rendono "possibile" o "probabile" che il caso di test mi trovi l'errore?

- Eseguire il comando che contiene l'anomalia (altrimenti non è possibile che il malfunzionamento si manifesti)
- L'esecuzione del comando che contiene l'anomalia deve portare il sistema in uno stato inconsistente
- Lo stato inconsistente dell'output deve propagarsi fino all'uscita del codice in esame in modo da produrre un output diverso da quello atteso

Possiamo utilizzare un metro di misura legato alle caratteristiche del codice: ad ogni criterio è possibile associare una metrica che misuri la _copertura_ del codice rispetto ad uno specifico test (ovvero la percentuale di codice che vado ad "utilizzare" in tutto il test) e che ci permetta di decidere quando smettere di testare, decidere quali altri casi di test è opportuno aggiungere o confrontare la _bontà_ di Test diversi


## Criteri noti

### Criterio di copertura dei comandi

Un test $$T$$ soddisfa il criterio di __copertura dei comandi__ se e solo se ogni comando eseguibile del programma è eseguito in corrispondenza di almeno un caso di test $$t \in T$$.

#### Esempio
```c
void main(){
    float x,y;
    read(x);
    read(y);
    if (x!=0)
        x = x+10;
    y = y/x;
    write(x);
    write(y);
}
```

Posso ricostruire un diaramma di flusso di esecuzione del codice trasformando ogni comando in un nodo del diagramma:

{% responsive_image path: 'assets/13_flowChart.png' %}

Dire che voglio _coprire tutti i comandi_, avendo trasformato ogni comando in un nodo, significa voler passare per tutti i nodi raggiungibili.

Applicare il _criterio di copertura dei comandi_ significa quindi trovare un insieme dei casi di test per il cui per ogni nodo esiste un caso di test che passa per quel nodo.

Il caso di test $$<3,7>$$ risulterebbe quindi sufficiente, dato che soddisfa il criterio di copertura dei comandi al 100%

Questo però _non mi garantisce che il programma si corretto,_ perchè ci sono dei malfunzionamenti che non sono stati trovati, ad esempio il caso di testing $$<0,7>$$ che provoca una divisione per 0.


### Criterio di copertura delle decisioni

Un test T soddisfa il criterio di copertura delle decisioni se e solo se ogni decisione effettiva viene resa sia vera che falsa in corrispondenza di almeno un caso di test t contenuto in T

La metrica è la percentuale delle decisioni totali possibili presenti nel codice che sono state rese sia vere che false nel test.

Si noti come il criterio di copertura delle decisioni implichi il criterio di copertura dei comandi: andando ad estrarre il codice in un diagramma di flusso, io copro tutte le decisioni se e solo se attraverso ogni arco presente nel flusso. Considerando un grafo connesso per il diagramma di flusso, se io attraverso tutti gli archi allora ho attraversato tutti i possibili nodi. Non è invece vero l'inverso.

#### Esempio
Riprendendo l'esempio precedente, se volessi applicare il criterio di copertura delle decisioni dovrei utilizzare almeno due casi di test, ad esempio $$<3,7>$$ e $$<0,5>$$, che se compresi nello stesso test mi restituiscono una copertura delle decisioni pari al 100%.

Ma non tutti i malfunzionamenti vengono trovati, ad esempio a riga 6 è possibile che ad x sia assegnato un valore tale per cui se sommo 10 ottengo un overflow.

### Criterio di copertura delle condizioni

Un test T soddisfa il criterio di _copertura delle condizioni_ se e solo se ogni singola condizione (effettiva) viene resa sia vera che falsa in corrispondenza di almeno un caso di test t contenuto in T

Similmente ai test precedenti, la metrica è la percentuale delle condizioni che sono state rese sia vere che false su quelle per cui è possibile farlo.

Si noti come questo criterio non implichi i criteri precedenti

#### Esempio

Modifichiamo un po' l'esempio usato fino ad'ora:

```c
void main(){
    float x,y;
    read(x);
    read(y);
    if (x!=0 || y>0)
        y = y/x;
    else
        y = (y+2)/x
    y = y/x;
    write(x);
    write(y);
}
```

{% responsive_image path: 'assets/13_flowChart-2.png' %}


Prendendo come Test i casi $$<0,5>$$ e $$<5,-5>$$ soddisfo al 100% il criterio di copertura delle condizioni (`x!=0` è falsificato da $$<0,5>$$ e verificato da $$<5,-5>$$, mentre `y>0` è verificato da $$<0,5>$$ e falsificato da $$<5,-5>$$), ma la decisione è sempre vera.

Ci sono quindi anomalie sia alla riga 6 (possibile divisione per 0) che alla riga 8(Overflow e divisione per 0), ma quelle alla riga 8 non verrebbero scoperte dato che non viene coperta.

### Criterio di copertura delle decisioni e condizioni

È intuitivamente l'intersezione del Criterio di copertura delle decisioni con quello di copertura delle condizioni.

### Criterio di copertura delle condizioni composte

Un test T soddisfa il criterio di copertura delle condizioni composte se e solo se ogni possibile composizione delle condizioni base vale sia vero che falso per diversi casi di test in T

Si noti come questo criterio comporti il precedente (Criterio di copertura delle decisioni e condizioni)

Data la natura combinatoria di questo criterio, all'aumento del numero di condizioni di base il numero di casi di test cresce __troppo rapidamente__. Inoltre dato che le condizioni di base potrebbero non riusltare indipendenti tra loro, potrebbero esistere combinazioni non fattibili che non sarebbe opportuno testare.

### Criterio di copertura delle condizioni e delle decisioni modificate

Ci si è accorti che certe combinazioni sono "più vicine o più lontane ad altre": se modificando una sola condizione base riesco a modificare la decisione, allora quella modifica è una modifica molto significativa indipendentemente da quanto sia grande. Se invece la decisione rimane la stessa, posso ipotizzare che quella modifcia sia più neutra e meno significativa.

Si va quindi a dare importanza, nella selezione delle combinazioni, al fatto che la modifica di una singola condizione base porti a modificare la decisione. Per ogni condizione base devono quindi esistere 2 casi di test che modificano il valore di una sola condizione base e che modificano il valore della decisione

È inoltre dimostrabile che se ho $$N$$ condizioni base sono sufficienti $$N+1$$ casi di test per coprire il criterio.