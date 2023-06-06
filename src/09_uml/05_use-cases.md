# Use cases diagram

## Concetto e struttura

I **diagrammi dei casi d'uso** rappresentano l'astrazione di un insieme di scenari tra loro correlati. \
Essi adottano un linguaggio che verte alla risoluzione di esigenze comunicative tramite un lessico potenzialmente meno tecnico.
Tale natura "informale" li rende ottimi mezzi di comunicazione col *cliente*.

Possono essere utilizzati, ad esempio, per:
* eplicitare differenti modalità di fare un compito;
* stabilire quale dovrebbe essere la normale interazione nello scenario e le eccezioni che possono verificarsi.

Infatti, ogni _scenario_ è corredato di:
* __pre e post condizioni__ da rispettare;
* __flusso di esecuzione__ da percorrere in condizioni normali;
* eventuali __eccezioni__ e loro possibili trattamenti.

Infine, parte della versatilità degli *Use Case diagrams* risiede nella loro capacità di collegarsi, eventualmente, ad altri tipi di diagrammi (*Sequence, Activity, etc*) che possono essere impiegati per descriverne in modo più approfondito il flusso.

## Scenari

I componenti di ogni scenario si dividono in **Attori** e **Casi d'Uso**.

```plantuml
@startuml
scale 500 width

:Actor: - (Use)
"Attore" as Actor
"Caso d'uso" as (Use)
@enduml
```

In generale il *collegamento* tra un attore e un caso d'uso rappresenta una __relazione di partecipazione__, *i.e* "Questo attore partecipa a questo caso d'uso".

L'interazione può comunque essere denominata.

Sono contemplati anche collegamenti fra un caso d'uso e un altro (vedi [paragrafo dedicato](#assoc-ucuc)).

## Identificazione degli attori

Gli _attori_ non sono necessariamente persone fisiche.
Possono corrispondere anche a dei **ruoli** o addirittura ad un **sistema esterno**.

Ogni attore è un'entità esterna al sistema ed interagisce direttamente con esso, fungendo allo stesso tempo da *fonte* e *destinatario* di informazione.

Ci sono due attori particolari:

* **attore beneficiario**: colui che trae beneficio dall'interazione con lo use case, *i.e.* chi è **interessato** a quella funzionalità. \
Gli altri attori possono cambiare, ma il beneficiario rimmarrà probabilmente lo stesso;
* **attore primario**: colui che avvia l'interazione con lo use case.

## Identificazione use case
Il miglior modo di identificare i casi d'uso è interrogarsi su due fronti:

* **sistema**: _"quali funzionalità si desidera che il sistema possieda?"_;
* **attori beneficiari**: _"cosa vogliono?"_, _"come agiscono?"_, _"perchè si interfacciano col sistema?"_ e _"cosa si aspettano?"_.

## Associazioni

Ogni diagramma dei casi d'uso deve seguire due convenzioni per quanto riguarda le associazioni.

* > Ogni attore deve avere almeno un'interazione con un caso d'uso.

Un attore che non dovesse possedere alcuna associazione con un caso d'uso sarebbe impossibilitato a interagire col sistema e rappresentarlo nel diagramma non avrebbe alcun senso.

* > Ogni caso d'uso deve essere associato ad almeno un attore.

Un caso d'uso che non coinvolge alcun attore è un caso d'uso che, per definizione, non ha senso di esistere, poichè nessuno è in grado di interagirvi.

### <a name="assoc-ucuc"></a>Relazioni _use case - use case_
Esistono due tipologie di relazioni tra use case:
* **inclusione (*include*)**: relazione che esprime il predicato *"far parte di"*.  \
Chi include conosce sempre gli inclusi, ma non viceversa.
La parte inclusa *deve* essere eseguita;
* **estensione (*extend*)**: relazione che viene utilizzata per rappresentare casi eccezionali che specificano comportamenti particolari in alcuni use case.

### Generalizzazione

L'associazione di **generalizzazione** rappresenta un particolare tipo di relazione, applicabile sia ad una coppia *attore - attore* che ad una coppia *use case - use case*.

La sua semantica dipende dal contesto a cui viene applicata:
* **tra attori**: permette di esplicitare eventuali relazioni tra ruoli. \
Ad esempio un ruolo potrebbe includerne un altro.
* **tra use case**: la semantica è simile all'*extend*, ma senza punti d'estensione. Infatti, alcune parti della descrizione vengono *ereditate* e altre vengono *sostituite*. Non si applica  il secondo principio della Liskov.

## Esempi di utilizzo

Nel seguente diagramma,

```plantuml
@startuml
scale 800 width

"Book Borrower" as BB
"Extend Loan" as (ext)
"Borrow copy of a book" as (bor)
"Check for reservation" as (chk)
BB -- ext
BB -- bor
ext ..> chk : << include >>
bor ..> chk : << include >>
@enduml
```

l'attore _Book Borrower_ è associato alle seguenti operazioni:
- prendere in prestito un libro;
- chiedere l'estensione del prestito di un libro.

In entrambi i casi, il bibliotecario deve controllare l'esistenza di una richiesta di prenotazione per il libro.

Il prossimo diagramma è differente:

```plantuml
@startuml
scale 1024 width

"Book Borrower" as BB
usecase bor as "Borrow copy of book
--
**extension points**
status validation:
after confirming identity"
"Refuse loan" as (ref)
BB - bor
bor <. ref : << extend >>
@enduml
```

_rifiuta il prestito_ può essere l'__estensione__ di un comportamento normale come _prendi in prestito il libro_.
In quest'ultimo ci sono dei punti di estensione in cui vengono fatti dei controlli, come la verifica dello stato di prestito del libro o dell'identità del richiedente.
