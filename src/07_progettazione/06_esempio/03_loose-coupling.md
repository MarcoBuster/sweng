# _Loose coupling_
Il _loose coupling_ è la capacità di una variabile o un parametro di accettare l'assegnamento di oggetti aventi tipo diverso da quello della variabile o parametro, a patto che sia un sottotipo.

```java
Deck deck = new Deck();
CardSource source = deck;
List<Card> cards = drawCards(deck, 5);
```
