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

### Terminologia preliminari
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

## Principio _Tell-Don't-Ask_

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
