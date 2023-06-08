# Criterio di copertura delle condizioni

_Un test \\(\ T\\) soddisfa il __criterio di copertura delle condizioni__ se e solo se ogni singola condizione (effettiva) viene resa sia vera che falsa in corrispondenza di almeno un caso di test \\(\ t \in T\\)_. \
Similmente ai criteri precedenti, la metrica è quindi la percentuale delle __condizioni__ che sono state rese __sia vere che false__ su quelle per cui è possibile farlo.

Sebbene simile, si tratta di un criterio diverso da quello di copertura delle decisioni: in caso di condizioni composte, come per esempio `x != 0 && y < 3`, la copertura delle decisioni imporrebbe che l'_intera condizione_ sia resa sia vera che falsa, mentre la copertura delle condizioni richiede di rendere vere e false le singole _condizioni atomiche_ `x != 0` e `y < 3` in almeno un caso di test. \
Come vedremo nell'esempio, ciò non impone quindi di seguire tutti i percorsi sul diagramma di flusso e fa sì che questo criterio __non implica__ il soddisfacimento di nessuno dei precedenti.

<table>
<thead>
<tr>
    <th colspan="2">Esempio 3: copertura delle condizioni</th>
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
05      if (x != 0 || y > 0)
06          y = y / x;
07      else
08          y = (y + 2) / x
09      y = y / x;
10      write(x);
11      write(y);
12  }
```
</td>
<td>

![Esempio criterio decisioni](/assets/13_criteri-copertura-esempio-3.png)
</td>
</tr>
</tbody>
</table>

Nell'esempio sopra, il test \\( \{ \langle 0, \\, 5 \rangle , \\, \langle 5, \\, -5 \rangle \} \\) __soddisfa il criterio di copertura della condizioni__ \\
(`x != 0` è falsificato da \\(\langle 0, \\,5 \rangle\\) e verificato da \\(\langle 5, \\, -5 \rangle\\), mentre `y > 0` è verificato da \\(\langle 0, \\, 5 \rangle\\) e falsificato da \\(\langle 5, \\, -5 \rangle\\)), ma __la decisione è sempre vera__.

Sono infatti presenti anomalie alla riga 6 (possibile divisione per zero) e alla riga 8 (overflow e divisione per zero), ma i comandi contenuti nella riga 8 non sono coperti.
In questo caso più che mai, quindi, la copertura delle condizioni __non garantisce__ la correttezza del programma.
