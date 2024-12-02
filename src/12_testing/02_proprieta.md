# Proprietà

## Affidabilità

_Un criterio di selezione \\(C\\) si dice __affidabile__ se presi due test \\(T_1\\) e \\(T_2\\) in base al criterio allora o entrambi hanno successo o nessuno dei due ha successo_.

$$
\boxed{
    \operatorname{affidabile}(C, \\, P) \Longleftrightarrow \left (
        \forall T_1 \in C, \\, \forall T_2 \in C \\:, \text{ } \operatorname{successo}(T_1, \\, P) \Leftrightarrow \operatorname{successo}(T_2, \\, P)
    \right )
}
$$

## Validità

_Un criterio di selezione si dice __valido___ _se qualora \\(P\\) non sia corretto, allora esiste almeno un test \\(T\\) selezionato in base al criterio \\(C\\) che ha successo e quindi rileva uno o più malfunzionamenti per il programma \\(P\\):_

$$
\boxed{
    \operatorname{valido}(C, \\, P) \Longleftrightarrow \left (
        \lnot \operatorname{ok}(P, \\, D) \Rightarrow \exists T \in C \\: | \operatorname{successo}(T,\,P)
    \right )
}
$$

## Esempio

Si consideri il seguente codice.

```java
static int raddoppia(int par) {
    int risultato;
    risultato = (par * par);
    return risultato;
}
```

Un criterio che seleziona:

- _"i sottoinsiemi di \\(\{0, \\, 2\}\\)”_ è __affidabile__, perché il programma funziona sia con \\(0\\) sia con \\(2\\), ma __non valido__, perché sappiamo che il programma non è corretto e non esiste un test che trovi malfunzionamenti;
- _"i sottoinsiemi di \\(\{0, \\, 1, \\, 2, \\, 3, \\, 4\}\\)”_ è __non affidabile__, perché i risultati dei casi di test non sono tutti coerenti (e quindi il test \\(T1=\{0,1\}\\) non ha successo mentre \\(T2=\{0, 3\}\\) sì), ma __valido__ perché esiste un test che rileva i malfunzionamenti.
- _"i sottoinsieme finiti di \\(D\\) con almeno un valore maggiore di \\(18\\)”_ è __affidabile__, perché i risultati dei casi di test sono tutti coerenti, e __valido__ perché rileva i malfunzionamenti.

In questo caso la ricerca di un criterio valido e affidabile era semplice perché conoscevamo già l'anomalia.
Tuttavia, lo stesso non si può dire di un qualunque programma \\(P\\) in quanto __non si conoscono i malfunzionamenti a priori__ e dunque è molto più difficile trovare criteri validi e affidabili.

## Conclusione

L'obiettivo sarebbe quindi quello di trovare un _criterio valido e affidabile_ sempre.
Tuttavia ciò è purtroppo impossibile in quanto un criterio di questo tipo selezionerebbe test ideali, che sappiamo non esistere.

Immaginiamo infatti di avere un _criterio valido e affidabile_ e che esista un test selezionato da esso che __non ha successo__.
Sapendo che:

- non avendo successo allora non sono stati trovati errori,
- essendo il criterio affidabile allora tutti gli altri test selezionati da quel criterio non troveranno errori,
- essendo il criterio valido allora se ci fosse stato un errore almeno uno dei test lo avrebbe trovato

allora il programma è __corretto__, ovvero abbiamo trovato un test che quando non ha successo implica la correttezza del programma: in poche parole, un _test ideale_.
Esiste quindi un altro modo per implicare la correttezza di un programma:

$$
\boxed{
    \operatorname{affidabile}(C, \\, P) \land \operatorname{valido}(C, \\, P) \land \exists T \in C \land \lnot\operatorname{successo}(T, \\, P)
    \Longrightarrow
    \operatorname{ok}(P, \\, D)
}
$$

In conclusione, trovare un criterio che sia __contemporaneamente__ affidabile e valido significherebbe trovare un criterio che selezioni __test ideali__ che sappiamo non esistere per la _tesi di Dijkstra_.
Dovremo dunque accontentarci di criteri che garantiscano solo una delle due caratteristiche.
