# Criterio di copertura dei cammini

_Un test \\(\ T\\) soddisfa il __criterio di copertura dei cammini__ se e solo se ogni cammino del grafo di controllo del programma viene percorso per almeno un caso di \\(t \in T\\)_. \
La metrica è quindi il rapporto tra i __cammini percorsi__ e __quelli effettivamente percorribili__.

Questo criterio è molto generale ma è spesso impraticabile, anche per programmi semplici: la presenza di cicli imporrebbe infatti di testare tutti gli infiniti cammini che li attraversano un numero arbitrario di volte. Il criterio è quindi considerato __non applicabile__ in pratica.
