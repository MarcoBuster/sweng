# Fagan code inspection

La __Fagan code inspection__ è una metodologia sviluppata da Michael Fagan alla IBM negli anni '70.
La metodologia prevede che un __gruppo di esperti__ esegua una serie di passi per verificare la correttezza del codice sorgente al fine di individuare eventuali errori, incongruenze o altri problemi. \
È __la più diffusa__ tra le tecniche di ispezione, nonché la più rigorosa e definita.

## Ruoli

Essendo un'attività di gruppo, nella Fagan code inspection vengono identificati diversi ruoli:

- __Moderatore__: è colui che coordina i meeting, sceglie i partecipanti e ha la responsabilità di far rispettare le regole di cui parleremo tra poco.
  È di solito una persona che lavora ad un progetto diverso da quello in esame in modo da evitare conflitti di interessi.
- __Readers e Testers__: non sono persone diverse, semplicemente a seconda dei momenti i partecipanti possono coprire uno di questi due ruoli: i primi leggono il codice al gruppo, mentre i secondi cercano difetti al suo interno.
  La lettura del codice è una vera e propria _parafrasi_ di esso, ovvero un'interpretazione del codice nella quale si spiega quello che fa ma seguendo comunque la sua struttura.
- __Autore__: è colui che ha scritto il codice sotto ispezione; è un partecipante passivo che risponde solo a eventuali domande.
  È simile al ruolo del _cliente_ nell'eXtreme Programming: pronto a rispondere a qualsiasi domanda per accelerare il lavoro degli altri.

## Processo

Definiti i ruoli, secondo la tecnica __Fagan__ di ispezione del codice il processo si articola come segue:

1. __Planning__: in questa prima fase il moderatore sceglie i partecipanti, si definiscono i loro ruoli e il tempo da dedicare alla ispezione, pianificando anche i vari incontri.
2. __Overview__: viene fornito a tutti i partecipanti materiale sul progetto per permettere loro di farsi un'idea del contesto in cui l'oggetto dell'ispezione si inserisce in ottica della riunione vera e propria.
3. __Preparation__: i partecipanti _"offline"_ comprendono il codice e la sua struttura autonomamente sulla base anche del materiale distribuito nella fase precedente;
4. __Inspection__: la vera e propria fase di ispezione.
  In questa fase si verifica che il codice soddisfi le regole definite in precedenza e si segnalano eventuali problemi o anomalie.
  Durante l'ispezione, il gruppo di esperti esamina il codice riga per riga, confrontandolo con le specifiche e cercando di individuare errori, incongruenze o altri problemi.
5. __Rework__: una volta individuati i problemi, l'autore del codice si occupa di correggere i difetti individuati.
6. __Follow-up__: possibile re-ispezione del nuovo codice ottenuto dopo la fase precedente.

Se la maggior parte delle fasi è abbastanza autoesplicativa, è bene dare uno sguardo più approfondito all'attività di ispezione vera e propria.

### Ispezione

Durante la fase di ispezione, l'obiettivo è __trovare e registrare__ i difetti __senza correggerli__: la tentazione di correggere i difetti è sicuramente fortissima ma non è compito dei partecipanti alla riunione farlo.
Ciascuno di loro potrebbe infatti avere le proprie idee e preferenze e metterli d'accordo potrebbe non essere facile: si preferisce quindi che sia l'autore del codice a correggere successivamente i problemi trovati.

Per evitare ulteriormente di perdere tempo sono previste _al massimo_ 2 sessioni di ispezione di 2 ore al giorno, durante le quali lavorare approssimativamente a __150 linee di codice all'ora__.
Quest'ultimo vincolo è __molto variable__ in quanto cambia in base al linguaggio, al progetto, all'attenzione ai dettagli richiesta e alla complessità.

Una possibilità prevista in questa fase è anche quella di fare _"test a mano"_: si analizza
il flusso di controllo del programma su una serie di casi di test così da verificarne il funzionamento.

Ancora più prominente è però l'uso di una serie di __checklist__, di cui parliamo nel prossimo paragrafo.

### Checklist

Rispetto all'attività di testing, che a partire dai malfunzionamenti permetteva di risalire ai difetti e dunque agli sbagli commessi, il _thought-process_ per le __checklist__ è inverso: __si parte dagli _sbagli___ che più frequentemente hanno portato ad inserire determinate anomalie nel codice e si controlla che nessuno di questi sia stato commesso nuovamente.

In letteratura è reperibile la __conoscenza__ di tutto ciò che è meglio evitare poiché in passato ha portato più volte ad avere anomalie nel codice.
Tale conoscenza è raccolta in __checklist comuni__ per i vari linguaggi.

Inoltre, l'ispezione del codice funziona così bene anche perché tali checklist possono essere __redatte internamente__ all'azienda, in base all'esperienza passata e alla storia di un determinato progetto. \\
Man mano che il progetto va avanti, l'__individuazione di un nuovo sbaglio__ si traduce in un'__evoluzione della checklist__: dalla prossima ispezione si controllerà di non aver commesso lo stesso errore.

#### <big>Esempio NASA</big>

La NASA nel suo <a href="../assets/13_nasa-software-inspection.pdf"><i>Software Formal Inspections Guidebook</i></a> (1993) ha formalizzato circa __2.5 pagine di checklist__ per C e 4 per FORTRAN.

Sono divise in _functionality_, _data usage_, _control_, _linkage_, _computation_, _maintenance_ e _clarity_.

Di seguito sono elencati alcuni esempi dei punti di tali checklist:

> - [ ] Does each module have a single function?
> - [ ] Does the code match the Detailed Design?
> - [ ] Are all constant names upper case?
> - [ ] Are pointers not `typecast` (except assignment of `NULL`)?
> - [ ] Are nested `#include` files avoided?
> - [ ] Are non-standard usage isolated in subroutines and well documented?
> - [ ] Are there sufficient comments to understand the code?

## Struttura di incentivi

Perché l'ispezione del codice come è stata descritta funzioni bene, occorre prevedere una serie di __dinamiche positive__ di incentivi al suo interno.

In particolare, è importante sottolineare che i difetti trovati __non devono essere utilizzati__ per la valutazione del personale: questo evita che i programmatori nascondano i difetti nel proprio codice, minando la qualità del prodotto.

Dall'altro canto si possono invece considerare per la __valutazione di readers e tester__ i difetti trovati durante l'ispezione, in modo che questi siano incentivati a fare l'ispezione più accurata possibile.

## Variante: _active_ design reviews

Purché il processo di ispezione funzioni al meglio __le persone__ coinvolte __devono partecipare__, ma per come abbiamo descritto l'attività di Fagan Code Inspection nulla vieterebbe ai revisori non preparati di essere presenti ma non partecipare, rimanendo in silenzio e pensando ad altro.

Innanzitutto, per sopperire a questo problema i partecipanti andrebbero __scelti__ tra persone di adeguata esperienza e sopratutto assicurando che nel team vi siano revisori per diversi aspetti nel progetto.

Qualora questo non bastasse, una variante del processo che prende il nome di __active design review__ suggerisce che sia l'__autore__ a leggere le checklist e sollevare questioni all'attenzione dei revisori, chiedendo diverse domande.
Essendo presi direttamente in causa, i revisori saranno quindi costretti a partecipare.
