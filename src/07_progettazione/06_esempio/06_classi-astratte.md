# Classi astratte

Una classe astratta che implementa un'interfaccia __non deve necessariamente implementarne__ tutti i metodi, ma può delegarne l'implementazione alle sottoclassi impedendo l'istanziamento di oggetti del suo tipo.

Le interfacce diminuiscono leggermente le performance, però migliorano estremamente la generalità (che aiutano l'espandibilità ed evolvibilità del programma), quindi vale la pena di utilizzarle.

È possibile utilizzare le __classi astratte__ anche per classi complete, ma che __non ha senso che siano istanziate__.
Un buon esempio sono le classi _utility_ della libreria standard di Java.

#### Classe utility della libreria standard di Java

Un esempio è __`Collections.shuffle(List<?> list)`__ che accetta una lista omogenea di elementi e la mischia.
Il _tipo_ degli elementi è volutamente ignorato in quanto non è necessario conoscerlo per mischiarli.

Per l'__ordinamento__, invece, è necessario conoscere il tipo degli oggetti in quanto bisogna confrontarli tra loro per poterli ordinare.
La responsabilità della comparazione è però delegata all'oggetto, che deve aderire all'interfaccia `Comparable<T>`.

__`Collections.sort(...)`__ ha, infatti, la seguente signature:
```java
public static <T extends Comparable<? super T>> void sort(List<T> list)
```

La notazione di generico __aggiunge dei vincoli__ su `T`, ovvero il tipo degli elementi contenuti nella lista:
- `T extends Comparable<...>` significa che `T` deve estendere - e quindi implementare - l'interfaccia `Comparable<...>`;
- `Comparable<? super T>` significa che tale interfaccia può essere implementata su un antenato di `T` (o anche `T` stesso).

`Comparable` è un altro esempio di _interface segregation_: serve per specificare che un oggetto ha bisogno della caratteristica di essere comparabile.

__Digressione__: la classe Collections era l'unico modo per definire dei metodi sulle interfacce (es: dare la possibilità di avere dei metodi sulle collezioni, ovvero liste, mappe, ecc), ma ora si possono utilizzare i metodi di default.
