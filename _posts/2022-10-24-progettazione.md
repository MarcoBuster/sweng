---
layout: post
title: "[08] Progettazione"
date:   2022-10-24 14:30:00 +0200
toc: true
---

# Design?

Codice di merda: https://mdnahas.github.io/xmassong/.

## Alcuni concetti

### Semplicità

Quando una cosa è _semplice_? 
Va misurato in termini di _quanto tempo ci metto_.

### Refactoring

Il refactoring migliora il design del codice senza migliorare (o peggiorare) la funzionalità.

Perché lo faccio? 
1. Miglioro il design tenuto inizialmente "semplice"
2. Preparare il design per una funzionalità che non si integra bene in quello esistente
3. Eliminare le debolezze (debito tecnico)

## Dove è depositata la conoscenza?

0. La __memoria__ non è un buon posto dove depositare la conoscenza, banalmente perché poi le cose ce le dimentichiamo.
1. __Documenti di design__: ?
2. All'interno di piattaforme di discussione: posso farlo, ma è sparpagliata in molti posti.
3. Con modelli specializzati (__UML__): può portare approcci _generative programming_. È alla base della model driven development.
4. Nel codice, ma spesso è difficile rappresentare le __ragioni__ di certe scelte.

## ...e come la condividiamo?

1. Esistono __metodi__ (Agile, XP, ...)
2. __Design pattern__: sono sia un vocabolario da usare sia una scelta tecnica. Soluzioni generali a problemi ricorrenti.
3. Principi (come _solid_).

## Terminologia preliminari
- __Object Orientation__. Un ... si dice object oriented se supporta:
    - ereditarietà: è possibile descrivere una classe come differenza da un'altra classe;
    - polimorfismo: può assumere diverse forme;
    - collegamento dinamico: collegare un metodo di una classe a runtime in base del tipo attuale di essa.
- __Principi SOLID__
    - __Single Responsibility__: ogni classe dovrebbe avere solo una sola responsabilità;
    - __Open Close Principle__: le classi devono essere aperte ai cambiamenti senza dover ritoccare ciò che è stato scritto - non significa che non si deve far refactoring, ma che se si vogliono aggiungere funzionalità non si dovrebbe mai dover modificare la classe già implementata;
    - __Liskov Substitution Principle__: ogni implementazione delle classi figlie vale per tutte le precondizioni della classe genitore;
    - __Interface Segregation__: gli utilizzatori delle classi non dovrebbero essere forzati a dipendere di interfacce che non usano - frammentare le interfacce in modo da mantenerle il più semplici possibili;
    - __Dependency inversion__: ciò che è concreto deve dipendere da ciò che è astratto, non il contrario2;
- __Reference escaping__: violazione dell'encapsulazione: .................... 
    - getter ritorna un riferimento a un segret;
    - setter assegna al segreto un qualche riferimento che gli viene passato;
    - costruttore assegna al segreto un qualche riferimento che gli viene passato.
- __Encapsulation and information hide__ (L8): le funzioni pubbliche non dovrebbero essere mai cambiate, hanno un 'contratto' con l'utilizzatore che stabilisce che non dovrebbero mai cambiare. 
I due scopi fondamnetali sono:
    - facilitare la comprensione del codice - vengono definite le responsabilità;
    - rendere più facile modificarne una parte senza fare danni.
- __Immutabilità__: una classe è immutabile se non c'è modo di cambiare lo stato dell'oggetto da parte di nessuno. Una classe è immutabile se:
    - non fornisce metodi che modificano lo stato;
    - ha tutti attributi privati (non obbligatorio - si possono avere attributi final);
    - ha tutti gli attributi final (non obbligatorio dichiarlo - non significa necessariamente "non cambia", solo che non cambia il puntatore);
    - asssicura accesso esclusivo a tutte le parti non immutabili.
- __Code smell__: cose brutte indicatrici di cose più brutte più grosse?
    - codice duplicato: è meglio fattorizzare le parti in comune;
    - metodi troppo lunghi: ;
    - troppi livelli di identazione: ;
    - lunghe sequenze di if-else o switch;
    - classe troppo grande;
    - lista di parametri troppo lunga;
    - _numeri magici_;
    - presenza di commenti;
    - nomi oscuri o incosistenti;
    - codice morto (codice commentato);
    -   _getter_ e _setter_.

> Solo ciò che è nascosto può essere cambiato liberamente e senza pericoli.
> ~ Parnas [L8] <!-- mangio fai la tua cosa carina -->                                                                      

### Principio _Tell-Don't-Ask_

Non chiedere i dati, ma dì cosa vuoi che faccia sui dati.
L'obiettivo è cercare di minimizzare i getter studiando cosa ci facciamo con il valore ritornato e definendo funzioni opportune.

```java
/* NO */

class Card {
    private Suit suit;
    private Rank rank;

    public Suit getSuit() {
        return this.suit;
    }
    public void setSuit(Suit s) {
        this.suit = s;
    }

    // ...
}
```

```java
/* SÌ */

class Card {
    private Suit suit;
    private Rank rank;

    public Card(Suit s, Rank r) {
        suit = s;
        rank = r;
    }

    @Override
    public String toString() {
        return rank + " of " + suit;
    }
}
```

### Contract based vs programmazione difensiva

- Contract based: assumo che chi mi ha chiamato rispetti il contratto che abbiamo stabilito (esempio: precondizioni).
- Prorgammazione difensiva: controllo le precodinzioni

```java
public interface CardSource {
    /**
     * @return The next available card.
     * @pre !isEmpty()
     */
    Card draw();

    /**
     * @return True if there is no card in the source.
     */
    boolean isEmpty();
}
```

### Loose coupling

Capacità di un identificatore di variabile/parametro di accettare oggetti in realtà di forme diverse, a patto che siano dei suoi sottotipi.

```java
Deck deck = new Deck();

CardSource source = deck;

List<Card> cards;
cards = drawCards(deck, 5);
```

### Indirittezze

Ogni volta che si aggiunge un'interfaccia, si ha un'indirettezza quindi una perdita di performance. 
Nella stragrande maggioranza dei casi i vantaggi di generalizzare superano le perdite di performance.

### Collegamento dinamico e _extensibility_

```java
public static List<Card> drawCards(CardSource cardSource, int number) {
    List<Card> result = new ArrayList<>();
    for (int i = 0; i < number && !cardSouce.isEmpty(); i++) {
        result.add(cardSource.draw());
    }
    return result;
}
```

Solo al momento del runtime si saprà il _runtime type_ della variabile cardSource.
Il compilatore non sa a tempo di compilazione quale metodo `draw()' dovrà chiamare.

Questo concetto permette quindi di __chiamare codice _non ancora scritto___, permettendo l'estensibilità.

#### Esempio in Java con shuffle

```java
public class Deck {
    private List<Card> cards = new ArrayList<>();

    public void shuffle() {
        Collections.shuffle(cards);
    }
}
```

`cards` (il tipo `List`) implementa `Shuffable`.

Un altro esempio è l'interfaccia `Comparable`.

```java
public interface Comparable<T> {
    public int compareTo(T o);
}
```
```java
// Definizione Collections.sort
public static <T extends Comparable<? super T>> void sort(List<T> list);
```

## UML

- Se qualcosa è in _corsivo_ significa che è astratto, non ancora implementato o un'interfaccia.
- Se qualcosa è <u>sottolineato</u> significa che il metodo o attributo è statico

### Frecce
- __tratteggiate__: relazione tra classi di __dipendenza__. Il codice scritto nella prima classe dipende dalla seconda.
- __diamanate__: relazione tra istanze di classe di __aggregazione__. Un istanza della prima contiene da N a M istanze della seconda.
<!-------- da rividere ---------------------------->
Il concetto di aggregazione è in mezzo tra quelli di:
    - __associazione__: un _professore_ insegna a più _studenti_. Il professore non è definito dai studenti che insegna (freccia senza rombo);
    - __aggregazione__: un _corso_ ha certe _ore_ di lezione (freccia con rombo bianco).
    - __composizione__: un _motore_ compone un aereo (freccia con rombo nero).
- __tratteggiata grossa bianca__: implementazione

