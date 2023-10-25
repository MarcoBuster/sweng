# Discutere di pattern: i meta-patterns

Prima di iniziare a parlare dei principali pattern che un informatico dovrebbe conoscere, possiamo chiederci come possiamo parlare di pattern: semplice, con dei _meta-patterns_, pattern con cui costruire altri pattern!

Nello specifico, i meta-patterns identificano due elementi base su cui ragionare quando si trattano i pattern:

- __HookMethod__: un "metodo astratto" che, implementato, determina il comportamento specifico nelle sottoclassi; è il _punto caldo_ su cui interveniamo per adattare lo schema alla situazione.

- __TemplateMethod__: metodo che coordina generalmente più HookMethod per realizzare il design voluto; è l'_elemento freddo_ di invariabilità del pattern che ne realizza la rigida struttura.

Ovviamente i metodi _template_ devono avere un modo per accedere ai metodi _hook_ se intendono utilizzarli per realizzare i pattern.
Tale collegamento può essere fatto in tre modi differenti:

- __Unification__: _hook_ e _template_ si trovano nella stessa classe astratta, classe da cui erediteranno le classi concrete per implementare i metodi _hook_ e, di conseguenza, il pattern; i metodi _template_ sono invece già implementati in quanto la loro struttura non si deve adattare alla specifica applicazione.


```plantuml
@startuml
class TemplateHookClass {
  {abstract} hookMethod()
  templateMethod()
}
@enduml
```

- __Connection__: _hook_ e _template_ sono in classi separate, indicate rispettivamente come _hook class_ (astratta) e _template class_ (concreta), collegate tra di loro da un'aggregazione: la classe template contiene cioè un'istanza della classe hook, in realtà un'istanza della classe concreta che realizza i metodi hook usati per implementare il pattern.

```plantuml
@startuml
class TemplateClass {
  templateMethod()
}
class HookClass {
  {abstract} hookMethod()
}
TemplateClass o--> HookClass
@enduml
```

- __Recursive connection__: come nel caso precedente _hook_ e _template_ sono in classi separate, ma oltre all'aggregazione tali classi sono qui legate anche da una relazione di generalizzazione: la classe template dipende infatti dalla classe hook.

```plantuml
@startuml
class TemplateClass {
  templateHookMethod()
}
class HookClass {
  {abstract} templateHookMethod()
}
TemplateClass --|> HookClass
TemplateClass o--> HookClass
@enduml
```

Vedremo a quale meta-pattern aderiranno i pattern che vediamo. 
A tal proposito,i pattern che vedremo fanno parte dei cosiddetti "__Gang Of Four patterns__", una serie di 23 pattern definiti da Erich Gamma, Richard Helm, Ralph Johnson e John Vlissides, ormai molti anni fa ma ancora attuali. Oltre ad averli definiti li hanno divisi in tre categorie:

- __Creazionali__: legati alla creazione di oggetti
- __Comportamentali__: legati all'interazione tra oggetti
- __Strutturali__: legati alla composizioni di classi e oggetti
