# Criterio di copertura delle decisioni

_Un test \\(\ T\\) soddisfa il __criterio di copertura delle decisioni__ se e solo se ogni decisione (effettiva) viene resa sia vera che falsa in corrispondenza di almeno un caso di test \\(t \in T\\)_. \
La metrica è quindi la frazione delle __decisioni totali possibili__ presenti nel codice che sono state rese __sia vere che false__ nel test.

Dovendo attraversare ogni possibile flusso di controllo il criterio di copertura delle decisioni __implica il criterio di copertura dei comandi__.
Estraendo il codice in un diagramma di flusso, infatti, è possibile coprire tutte le decisioni se e solo se ogni arco (_e quindi ogni nodo_) viene attraversato.
Non è invece vero l'inverso.

<table>
<thead>
<tr>
    <th colspan="2">Esempio 2: copertura delle decisioni</th>
</tr>
<tr>
    <td style="width: 50%" align="center">Pseudocodice</td>
    <td style="width: 50%" align="center">Diagramma di flusso di esecuzione</td>
</tr>
</thead>
<tbody>
<tr>
<td>

```c
01  void main(){
02      float x, y;
03      read(x);
04      read(y);
05      if (x != 0 && y > 0)
06          x = x + 10;
07      else
08          y = y / x
09      write(x);
10      write(y);
11  }
```
</td>
<td>

![Esempio criterio decisioni](/assets/13_criteri-copertura-esempio-2.png)
</td>
</tr>
</tbody>
</table>

Dall'esempio sopra, un test che soddisfi il suddetto criterio potrebbe includere \\(\{ \langle 3, \\, 7 \rangle, \\, \langle 3, \\, -2 \rangle \}\\).
Nonostante sia un criterio _"migliore"_ del precedente, la copertura delle decisioni __non garantisce__ la correttezza del programma: nell'esempio il caso \\(\langle 0, \\, 5 \rangle\\) eseguirebbe comunque una divisione per zero.
