# Classi di equivalenza

La tecnica delle classi di equivalenza si pone l'obiettivo di dividere il dominio del programma in __classi di dati__, ovvero gruppi di valori di input che _dovrebbero_ __stimolare il programma nella stessa maniera__.
Non si tratta quindi di classi di equivalenza degli output, ovvero valori che dati in pasto al programma forniscono lo stesso risultato, quanto piuttosto valori che dati in pasto al programma forniscono un risultato diverso ma _prodotto nello stesso modo_.

Una volta individuate le classi di dati l'obiettivo sarebbe quindi di estrarre da esse casi di test in modo da testare il funzionamento del programma in tutti suoi funzionamenti standard. \
In realtà, dunque, si cercano di individuare casi di test che rivelino eventuali __classi di equivalenza di errori__, ovvero insiemi di valori che generano malfunzionamenti per lo stesso motivo.
Classi di equivalenza di questo tipo sono solitamente più _"stabili"_ rispetto alle normali classi di equivalenza in quanto il risultato ottenuto, ovvero l'errore, è spesso lo stesso o molto simile.

Volendo dare una definizione più formale, _una __classe di equivalenza__ rappresenta un insieme di __stati validi o non validi__ per i dati in input e un insieme di stati validi per i dati di output_, dove per dato si intendono valori, intervalli o insiemi di valori correlati. \
È importante comprendere anche i possibili _stati non validi_ in quanto bisogna testare che il programma reagisca bene all'input mal formattato.
Ogni dominio avrà quindi almeno due classi di equivalenza:

- la classe degli __input validi__
- la classe degli __input non validi__

Per fare un esempio si può considerare un programma che chiede in input un __codice PIN di 4 cifre__.
Il suo dominio può quindi essere suddiviso in due semplici classi di equivalenza:

1. PIN corretto;
2. tutti i numeri di 4 cifre diversi dal PIN.

Volendo fare un altro esempio, se ci si aspetta che i valori in input ricadano in un intervallo, per esempio \\([100, \\, 700]\\)), si possono definire la classe di equivalenza valida \\(x \in [100, 700]\\) e la classe di equivalenza non valida \\(x \notin [100, 700]\\).
Per voler aumentare la granularità si può però spezzare la classe degli input non validi in due, ottenendo una classe valida e due non valide:

1. \\(x \in [100, 700]\\);
2. \\(x < 100\\);
3. \\(x > 700\\).

Come si vede, la scelta delle classi di equivalenza da considerare non è univoca, e richiede un minimo di conoscenza di dominio.
Alternativamente esistono delle tecniche standard di individuazione delle classi di equivalenza a partire dalle specifiche che prendono il nome di __category partition__.
