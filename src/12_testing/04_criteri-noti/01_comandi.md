# Criterio di copertura dei comandi

_Un test \\(\ T\\) soddisfa il __criterio di copertura dei comandi__ se e solo se ogni comando eseguibile del programma è eseguito in corrispondenza di almeno un caso di test \\(t \in T\\)._ \
La metrica è dunque la frazione di __comandi eseguibili su quelli eseguiti__ dall'intero test.

Consideriamo per esempio il seguente programma in pseudocodice:

<table>
<thead>
<tr>
    <th colspan="2">Esempio 1: copertura dei comandi</th>
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
05      if (x != 0)
06          x = x + 10;
07      y = y / x;
08      write(x);
09      write(y);
10  }
```
</td>
<td>

![Esempio criterio copertura comandi](/assets/13_criteri-copertura-esempio-1.png)
</td>
</tr>
</tbody>
</table>

È possibile ricostruire un __diagramma di flusso di esecuzione__ del codice trasformando ogni comando in un nodo del diagramma: _coprire tutti i comandi_ significa quindi visitare tutti i nodi raggiungibili.

Applicare il _criterio di copertura dei comandi_ significa quindi trovare un insieme di casi di test in cui _per ogni nodo esiste un caso di test che lo attraversa_.

Nel nostro esempio il singolo caso di test \\( \langle 3, \\, 7 \rangle\\) risulterebbe quindi sufficiente, dato che la sua esecuzione permette di _coprire_ tutti i comandi del programma.
Tuttavia, pur massimizzando la metrica di copertura dei comandi tale test non è in grado di rilevare l'anomalia alla riga 7, in cui viene fatta una divisione senza prima controllare che il divisore sia diverso da zero.

Soddisfare il criterio di copertura dei comando __non garantisce__ dunque la correttezza del programma.
Come sappiamo infatti un'anomalia non sempre genera un malfunzionamento, per cui eseguire semplicemente tutte le righe di codice raggiungibili non assicura di rilevare eventuali errori.
