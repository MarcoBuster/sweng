# Interfacce multiple

Tornando all'esempio, la classe `Deck` (che implementa `CardSource`) __può implementare anche altre interfacce__, come `Shuffable` o `Iterable<Card>`. 
Al metodo precedente interessa solo che Deck abbia le capacità specificate in `CardSource`, se poi implementa anche altre interfaccie è ininfluente.

```plantuml
@startuml
scale 1024 width

class Client1
class Client2
class Client3

interface Iterable<Card> << interface >> {
    + {abstract} Iterator<Card> iterator()
}

class Deck implements Iterable, Shuffable, CardSource {
    + void shuffle()
    + Card draw()
    + boolean isEmpty()
    + Iterator<Card> iterator()
}

interface Shuffable << interface >> {
    + {abstract} void shuffle()
}

interface CardSource << interface >> {
    + {abstract} Card draw()
    + {abstract} boolean isEmpty()
}

Client2 ..> Iterable
Client1 ..> Shuffable
Client3 ..> Iterable
Client3 ..> CardSource

hide empty fields
hide empty methods
@enduml
```