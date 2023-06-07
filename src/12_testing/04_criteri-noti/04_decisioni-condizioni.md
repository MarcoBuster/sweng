# Criterio di copertura delle decisioni e condizioni

_Un test \\(\ T\\) soddisfa il __criterio di copertura delle decisioni e delle condizioni__ se e solo se __ogni decisione__ vale sia vero che falso e __ogni condizione__ che compare nelle decisioni del programma vale sia vero che falso per diversi casi di test \\(\ t \in T\\)_.

È – intuitivamente – l'__intersezione__ del criterio di copertura delle decisioni con il criterio di copertura delle condizioni, per cui il soddisfacimento di questo criterio __implica__ sia il criterio di copertura delle condizioni che quello di copertura delle decisioni (e quindi dei comandi).

Nell'esempio 3, il test \\(\{ \langle 0, \\, -5 \rangle, \\, \langle 5, \\, 5 \rangle \}\\) soddisfa il criterio di copertura delle decisioni e condizioni e rileva l'anomalia alla riga 8 ma non quella alla riga 6.
__Non garantisce__ quindi neanche in questo caso la correttezza del programma.
