# Modelli iterativi

Osservando il modello a cascata e le sue varianti ci si è ben presto resi conto che la stringente sequenzialità delle fasi costituiva un grosso limite non conciliabile con la flessibilità richiesta dallo sviluppo software e con la naturale mutevolezza dei requisiti imposti dal cliente. Si inizia dunque a pensare di permettere agli sviluppatori di _ripetere_ alcune fasi più di una volta, ciclando su di esse fino a ottenere un prodotto soddisfacente: nascono così i primi __modelli interativi__.

## Modello a cascata con singola retroazione

![Waterfall con retroazione](/assets/02_waterfall-retroazione.png)

Uno dei primi modelli iterativi è in realtà una variante del modello a cascata, in cui si permette di fare un'unico salto indietro; a parire da una fase si può cioè __ritornare alla fase precedente__: così, per esempio, si può _iterare_ tra _Codifica_ e _Testing_ fino a consegnare il prodotto.

Anche in questo modello non si può però tornare indietro dalla consegna per eseguire attività di manutenzione; inoltre, l'introduzione di un'iterazione rende molto __più difficile pianificare__ il lavoro e monitorarne l'avanzamento: si tratta questa di una caratteristica condivisa da molti modelli iterativi.

## Modello a fontana

![Modello a fontana](/assets/02_fountain-model.png)

Nel 1993 nasce, in contrapposizione al modello a cascata, il cosiddetto __modello a fontana__, che amplia il concetto di iterazione permettendo in qualunque momento di __tornare alla fase iniziale__: se ci si accorge della presenza di errori si torna indietro all'inizio (_software pool_) e si ricontrollano tutte le fasi precedenti. Ovviamente questo non implica buttare tutto il lavoro già fatto, quanto piuttosto risolvere l'errore con un approccio che parta innanzitutto dalla modifica dei requisiti (se possibile), delle specifiche e solo dopo del codice, evitando di rattoppare solo quest'ultimo alla bell'e meglio come nel modello _code-and-fix_.

Il modello a fontana è inoltre il primo in cui sono previste delle azioni dopo la consegna; dopo l'ultima fase (_programma in uso_), infatti, si aprono ancora due strade: __manutenzione ed evoluzione__. La consegna del prodotto non è quindi più l'atto finale, ma solo un altro step del processo: ecco quindi che si aprono le porte ad una __visione incrementale__ dello sviluppo software, che approfondiremo nel prossimo paragrafo.

Anche qui si perdono purtroppo le garanzie sui tempi di sviluppo: una volta ritornato all'inizio per sistemare un errore non è infatti affatto detto che riuscirò a ritornare alla fase da cui sono partito, ma potrei imbattermi in altri errori durante le fasi precedenti costringendomi a iterare su di esse più di una volta.
