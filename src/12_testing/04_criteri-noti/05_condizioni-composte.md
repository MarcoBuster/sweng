# Criterio di copertura delle condizioni composte

_Un test \\(\ T\\) soddisfa il __criterio di copertura delle condizioni composte__ se e solo se ogni possibile composizione delle condizioni base vale sia vero che falso per diversi casi di test \\(\ t \in T\\)_.

Viene cioè testata ogni possibile combinazione di valori delle condizioni atomiche quando queste sono aggregate in condizioni composte: riprendendo per esempio la condizione `x != 0 && y < 3`, vengono testati separatamente i casi \\(\langle V, V\rangle\\), \\(\langle V, F\rangle\\), \\(\langle F, V\rangle\\) e \\(\langle F, F\rangle\\). \
È quindi facile notare che __questo criterio implica il precedente__ (criterio di copertura delle decisioni e condizioni), implicando a sua volta il criterio di copertura delle decisioni, delle condizioni e dei comandi.

Data la __natura combinatoria__ di questo criterio, all'aumento del numero di condizioni di base _il numero di casi di test_ cresce però troppo rapidamente, motivo per cui il soddisfacimento di questo criterio è considerato __non applicabile__ in pratica.
Inoltre, dato che le condizioni di base potrebbero non risultare indipendenti tra loro, potrebbero esistere __combinazioni non fattibili__ che non avrebbe alcun senso testare.
