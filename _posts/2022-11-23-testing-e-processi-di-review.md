---
layout: post
title: "[13] Testing e Processi di review"
date: 2022-11-23 14:40:00 +0200
toc: true
---

# Correttezza di un software

La maggior parte dei problemi che si verificano durante lo sviluppo di un progetto sono causati da _problemi di comunicazione_. Ci posso essere incomprensioni quando le informazioni passano da una figura all'altra, come quando ci si interfaccia tra cliente, analista e programmatore.
Per esempio il programmatore dovrà adattare il proprio linguaggio per farsi comprendere dal cliente,
e man mano che si addentra nello sviluppo del progetto sarà necessario prestare maggiore attenzione alla formalità e alla chiarezza della comunicazione.
Più si spiegano le cose in maniera chiara, più è facile che non si incorra in problemi successivi.
Bisogna quindi fare più attenzione alla terminologia che viene usata.

Quando un programma si definisce corretto?

Consideriamo un generico programma $$P$$ come una funzione da un insieme di dati $$D$$ (dominio) a un insieme di dati $$R$$ (codominio):

* $$P(d)$$ indica l'esecuzione di $$P$$ su un dato in ingresso $$d \in D$$

* Il risultato $$P(d)$$ è corretto se soddisfa le specifiche, altrimenti è scorretto

* $$\operatorname{ok}(P, \, d)$$ indicherà la correttezza di $$P$$ per il dato $$d$$

Allora:

$$
P \text{ è } \textit{corretto} \Leftrightarrow \forall d \in D \: \operatorname{ok}(P, \, d)
$$

Cioè, possiamo dire che _un programma è corretto quando per ogni dato del dominio vale $$\operatorname{ok}(P, \, d)$$_,
_La correttezza del programma sarà indicata quindi con $${ok}(P, \, D)$$_.

### Test

_Un **test** è un sottoinsieme del dominio dei dati_ e _un singolo **caso di test** è un elemento di esso_.
Un test sono più stimolazioni, un caso di test è una singola stimolazione.

Per esempio:

* Un test $$T$$ per un programma $$P$$ è un sottoinsieme del dominio $$D$$

* un elemento $$t$$ di un test $$T$$ è detto _caso di test_

* l'esecuzione di un test consiste nell'esecuzione del programma $$\forall t \in T$$

Se ci poniamo dal punto di vista del programma, esso passa o supera un test:

$$
\operatorname{ok}(P, \, T) \Leftrightarrow \forall t \in T | \operatorname{ok}(P, \, t)
$$

Quindi, _un programma è corretto per un test quando per ogni caso di test è corretto_.

Dal punto di vista del test invece, _un test $$T$$ ha successo se rileva uno o più malfunzionamenti presenti nel programma $$P$$_:

$$
\operatorname{successo}(T, \, P) \Leftrightarrow \exists t \in T | \neg\operatorname{ok}(P,\,t) 
$$

### Test ideale

Nel caso in cui il test non rilevi alcun malfunzionamento, non vuol dire che il mio programma sia corretto,
il test è un'attività ottimistica e non garantisce la correttezza del programma.

_Un test $$T$$ è ideale_ per $$P$$ se e solo se $$\operatorname{ok}(P, \, T) \Rightarrow \operatorname{ok}(P, \, D)$$ ovvero _se il superamento del test implica la correttezza del programma_.

_In generale, è **impossibile trovare un test ideale**._

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

_Il **test esaustivo** è quindi **impraticabile**._

## Criterio di selezione

Come faccio a scegliere un _sottoinsieme del dominio_ intelligente cercando di approssimare il test ideale? Quali caratteristiche ci interessa che abbia il criterio che usiamo per selezionare questo sottoinsieme?

### Affidabilità
_Un criterio di selezione si dice **affidabile**_ _se presi due test $$T_1$$ e $$T_2$$ in base al criterio $$C$$ allora o entrambi hanno successo o nessuno dei due ha successo_.

$$
\operatorname{affidabile}(C, \, P) \Leftrightarrow [\forall T_1 \in C, \, \forall T_2 \in C \: \operatorname{successo}(T_1, \, P) \Leftrightarrow \operatorname{successo}(T_2, P)]
$$


### Validità
_Un criterio di selezione si dice **valido**_ _se qualora $$P$$ non sia corretto, allora esiste almeno un test $$T$$ selezionato in base al criterio $$C$$ che ha successo e quindi rileva uno o più malfunzionamenti per il programma $$P$$_

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
Un criterio che seleziona:

* _"sottoinsiemi di $$\{0, \, 2\}$$"_ è **affidabile**, perché il programma funziona sia con 0 sia con 2, ma **non valido**, perché sappiamo che il programma non è corretto e non viene trovato nessun malfunzionamento.

* _"i sottoinsiemi di $$\{0, \, 1, \, 2, \, 3, \, 4\}$$"_ è **non affidabile**, perché i risultati dei casi di test non sono tutti coerenti, ma **valido** perché rileva i malfunzionamenti.

* _"sottoinsieme finiti di $$D$$ con almeno un valore maggiore di $$18$$"_ è **affidabile**, perché i risultati dei casi di test sono tutti coerenti, e **valido** perché rileva i malfunzionamenti.

Quello che vorremmo è scegliere un criterio affidabile e valido, in astratto, senza conoscerne i malfunzionamenti. Se un criterio viene definito conoscendo già i malfunzionamenti non ha senso.
Ma se il test non ha successo, ci è utile avere un criterio valido e affidabile?
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

### Utilità di un test

Quali sono le caratteristiche che rendono utile un caso di test, ovvero che rendono "possibile" o "probabile" che il caso di test mi trovi l'errore?

- Eseguire il comando che contiene l'anomalia (altrimenti non è possibile che il malfunzionamento si manifesti)
- L'esecuzione del comando che contiene l'anomalia deve portare il sistema in uno stato inconsistente
- Lo stato inconsistente dell'output deve propagarsi fino all'uscita del codice in esame in modo da produrre un output diverso da quello atteso

Possiamo utilizzare un metro di misura legato alle caratteristiche del codice: _a ogni criterio è possibile associare una **metrica**_ che misuri la _copertura del codice rispetto a uno specifico test_ (ovvero la percentuale di codice che vado ad "utilizzare" in tutto il test) e che _ci permetta di decidere quando smettere di testare_, decidere _quali altri casi di test è opportuno aggiungere_ o _confrontare la bontà di test diversi_.

### Criteri noti

#### Criterio di copertura dei comandi

_Un test $$T$$ soddisfa il criterio di __copertura dei comandi__ se e solo se ogni comando eseguibile del programma è eseguito in corrispondenza di almeno un caso di test $$t \in T$$._

Per esempio:
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

Posso ricostruire un diagramma di flusso di esecuzione del codice trasformando ogni comando in un nodo del diagramma:

{% responsive_image path: 'assets/13_flowChart.png' %}

Dire che voglio _coprire tutti i comandi_, avendo trasformato ogni comando in un nodo, significa voler passare per tutti i nodi raggiungibili.

Applicare il _criterio di copertura dei comandi_ significa quindi trovare un insieme dei casi di test per il cui per ogni nodo esiste un caso di test che passa per quel nodo.

Il caso di test $$<3,7>$$ risulterebbe quindi sufficiente, dato che soddisfa il criterio di copertura dei comandi al 100%

Questo però _non mi garantisce che il programma si corretto,_ perché ci sono dei malfunzionamenti che non sono stati trovati, ad esempio il caso di testing $$<0,7>$$ che provoca una divisione per 0.


#### Criterio di copertura delle decisioni

_Un test T soddisfa il criterio di copertura delle decisioni se e solo se ogni decisione effettiva viene resa sia vera che falsa in corrispondenza di almeno un caso di test t contenuto in T_
s
La metrica è la percentuale delle decisioni totali possibili presenti nel codice che sono state rese sia vere che false nel test.

Si noti come il criterio di copertura delle decisioni implichi il criterio di copertura dei comandi: andando a estrarre il codice in un diagramma di flusso, io copro tutte le decisioni se e solo se attraverso ogni arco presente nel flusso. Considerando un grafo connesso per il diagramma di flusso, se io attraverso tutti gli archi allora ho attraversato tutti i possibili nodi. Non è invece vero l'inverso.

Per esempio:

Riprendendo l'esempio precedente, se si volesse applicare il criterio di copertura delle decisioni si dovrebbero utilizzare almeno due casi di test, ad esempio $$<3,7>$$ e $$<0,5>$$, che se compresi nello stesso test restituirebbero una copertura delle decisioni pari al 100%.

Ma non tutti i malfunzionamenti vengono trovati, ad esempio a riga 6 è possibile che ad x sia assegnato un valore tale per cui se sommo 10 ottengo un overflow.

#### Criterio di copertura delle condizioni

_Un test T soddisfa il criterio di copertura delle condizioni se e solo se ogni singola condizione (effettiva) viene resa sia vera che falsa in corrispondenza di almeno un caso di test t contenuto in T_

Similmente ai test precedenti, la metrica è la percentuale delle condizioni che sono state rese sia vere che false su quelle per cui è possibile farlo.

Si noti come questo criterio non implichi i criteri precedenti

Per esempio:


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

#### Criterio di copertura delle decisioni e condizioni

È intuitivamente l'intersezione del Criterio di copertura delle decisioni con quello di copertura delle condizioni.

#### Criterio di copertura delle condizioni composte

_Un test T soddisfa il criterio di copertura delle condizioni composte se e solo se ogni possibile composizione delle condizioni base vale sia vero che falso per diversi casi di test in T_

Si noti come questo criterio comporti il precedente (Criterio di copertura delle decisioni e condizioni)

Data la natura combinatoria di questo criterio, all'aumento del numero di condizioni di base _il numero di casi di test cresce troppo rapidamente_. Inoltre dato che le condizioni di base potrebbero non risultare indipendenti tra loro, potrebbero esistere combinazioni non fattibili che non sarebbe opportuno testare.

#### Criterio di copertura delle condizioni e delle decisioni modificate

Ci si è accorti che certe combinazioni sono "più vicine o più lontane ad altre": se modificando una sola condizione base riesco a modificare la decisione, allora quella modifica è una modifica molto significativa indipendentemente da quanto sia grande. Se invece la decisione rimane la stessa, posso ipotizzare che quella modifica sia più neutra e meno significativa.

Si va quindi a dare importanza, nella selezione delle combinazioni, al fatto che la modifica di una singola condizione base porti a modificare la decisione. Per ogni condizione base devono quindi esistere 2 casi di test che modificano il valore di una sola condizione base e che modificano il valore della decisione

È inoltre dimostrabile che se si hanno $$N$$ condizioni base sono sufficienti $$N+1$$ casi di test per coprire il criterio.

#### Implicazioni tra criteri di copertura

<!--- immagine implicazioni tra criteri di copertura --->

Il criterio delle condizioni composte va considerato troppo oneroso e quindi non applicabile. Gli altri criteri invece possono essere applicati.

### Altri criteri

_I criteri visti finora non considerano i **cicli**_ e possono essere soddisfatti da test che percorrono ogni ciclo al più una volta. 

Molti errori però si verificano durante iterazioni successive alla prima, come per esempio quando si superano i limiti di un array.

Occorre quindi un criterio che tenga conto anche delle iterazioni.

#### Criterio di copertura dei cammini


