# <big>M</big>ODEL VIEW PRESENTER

Come preannunciato esiste una variante del Model View Controller chiamata __Model View Presenter__ che fornisce una soluzione al problema del testing delle viste e delle relative interfacce grafiche. 

Ci permettere di spezzare la catena circolare di dipendenze e rendere possibile il loro testing diviso per singole funzionalità _mockandone_ solo un altra.

Questo nuovo pattern eleva il ruolo del Controller, ora chiamato _Presenter_, a completo _intermediario tra View e Model_ in entrambi i sensi di comunicazione: non solo dunque le View delegano ai rispettivi Presenter la gestione delle interazioni con l'utente, ma al momento del cambiamento dell'informazione condivisa il Model notifica non direttamente le viste ma i Presenter stessi, i quali avranno dunque il compito di aggiornare la propria View per mostrare il dato modificato. 

![MVP](/assets/09_model-view-presenter.png)

Model e View perdono dunque alcun legame diretto, facendo apparire sempre più i Presenter come Adapter tra stato concreto (_model_) e stato virtuale mostrato all'utente (_view_).
La rottura di tale legame facilita il testing delle viste poiché invece di verificare che una vista abbia ricevuto e processato correttamente un aggiornamento del dato presente nel Model, è sufficiente verificare che un update del Model provochi nei Presenter un aggiornamento del dato mostrato dalla View.
In questo modo è possibile __isolare l'interfaccia logica da quella grafica__, rendendo più semplice il testing di entrambe e sfoggiando un esempio importante del cosiddetto _design for testing_.

Infine, utilizzando questo pattern è importante fare attenzione a mantenere segreta la rappresentazione interna del Model ai Presenter e viceversa, evitando in particolar modo eventuali _reference escaping_; la separazione delle responsabilità costruita con la suddivisione dei dati dalla loro logica di gestione perderebbe infatti ogni valenza se si legassero troppo strettamente Model e Presenter.
