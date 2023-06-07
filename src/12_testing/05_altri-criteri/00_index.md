# Altri criteri

I criteri visti finora __non considerano i cicli__ e possono essere soddisfatti da test che percorrono ogni ciclo al più una volta.
Molti errori però si verificano durante __iterazioni successive alla prima__, come per esempio quando si superano i limiti di un array.

Occorre quindi sviluppare dei criteri che tengano conto anche delle iterazioni e stimolino i cicli un numero di volte sufficiente.

<table>
<thead>
<tr>
    <th colspan="2">Esempio 4: copertura delle iterazioni</th>
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
01  void main() {
02      float a, b, x, y;
03      read(x);
04      read(y);
05      a = x;
06      b = y;
07      while (a != b) {
08          if (a > b)
09              a = a - b;
10          else
11              b = b - a;
12      }
13      write(a);
14  }
```
</td>
<td>

![Esempio criteri di copertura](/assets/13_criteri-copertura-esempio-4.png)
</td>
</tr>
</tbody>
</table>

- [**Criterio di copertura dei cammini**](./01_cammini.md)
- [**Criterio di \\(n\\)-copertura dei cicli**](./02_cicli.md)
