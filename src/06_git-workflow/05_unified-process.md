# Unified Process

Conosciuto nelle sue versioni commerciali anche come:
- __USDP__ Unified Software Development Process
- __RUP__ Rational Unified Process

È un modello di processo definito dagli stessi creatori di UML, é un modello _Orientato agli Oggetti_ (__"OO"__), quindi ottimo da utilizzare in contemporanea.
Esistono anche altri modelli __OO__ come ad esempio _"Object Oriented Software Process"_ (__OOSP__)

In base al livello di astrazione nel quale ci troviamo è un meta-modello che può essere definito come:

- __Sequenziale__: Dato che si compone di 4 nuove fasi che vengono ripetute in sequenza, e vengono chiamate:
    - __Inception__;
    - __Elaboration__;
    - __Construction__;
    - __Transition__.
- __Iterativo__: Ogni fase è svolta in maniera iterativa. In ogni iterazione si ripetono
(in modo più o meno presente) le diverse attività che già conosciamo.
- __Incrementale__: Alla fine delle 4 fasi si arriva ad una "release" e successivamente si riprende dalla prima (in modo iterativo, appunto) per proseguire con lo sviluppo.

## Fasi
![Unified Process phases](/assets/06_unified-process-phases.png)

Le diverse righe rappresentano le attività che conosciamo, viste in tutti gli altri modelli, e in questo modello vengono chiamate _workflow_ o _activity_. Questi _workflow_ non si susseguono come siamo stati abituati a vedere, ma si sovrappongono (__over-lapping__) all'interno delle diverse fasi.
È possibile definire lo scopo di una fase ma non in maniera precisa, ad esempio la fase di construction rappresenta prevalentemente la parte di creazione del codice all'interno del progetto, ma come è possibile notare nel grafico anche tutti gli altri workflows sono presenti anche se in modo meno predominante

Questo schema permette di comprendere la complessità di un processo, ma che riconosce la necessità di un rigore, ovvero dei momenti in cui è necessario concentrarsi in modo maggiore su certe attività, infatti sono presenti delle __mile-stone__, ovvero un documento che indica la fine di una certa fase (si intende la fine della fase nell'iterazione corrente, infatti tutte le fasi vengono rieseguite ad ogni iterazione).

Le attività sono tutte troppo intersecanti tra loro, per questo motivo è definito come __meta-modello__, infatti non potrà essere seguito alla lettera ma dovrà essere configurato in base alle esigenze del progetto e del team di sviluppo. Può essere addirittura reso _agile_ con le opportune modifiche.