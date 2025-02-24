# Vitalità di una transizione

Una transizione \\(t\\) in una marcatura \\(M\\) si può dire _viva_ con un certo __grado__:
- __grado 0__ (o __morta__): non è abilitata in nessuna marcatura appartanente all'insieme di raggiungibilità, quindi qualunque evoluzione avvenga nella rete, la transizione non portà mai scattare (non è sempre un aspetto negativo);
- __grado 1__: esiste almeno una marcatura raggiungibile a partire da \\(M\\) in cui la transizione è abilitata;
- __grado 2__: per ogni numero \\(n\\) naturale escluso lo zero esiste almeno una sequenza di scatti ammissibile a partire da \\(M\\) in cui la transizione scatta \\(n\\) volte, ovvero è possibile far scattare la transizione un numero \\(n\\) grande a piacere di volte;
- __grado 3__: esiste una sequenza di scatti ammissibile a partire da \\(M\\) per cui la transizione scatta _infinite_ volte;
- __grado 4__ in _qualunque marcatura raggiungibile_ esiste una sequenza ammissibile in cui è possibile far scattare la transizione almeno una volta, di conseguenza può scattare infinite volte in qualunque situazione ci si trovi (ovvero in qualunque marcatura).  \
In questo caso si dice che la transizione è __viva__ _in maniera assoluta_.

Si noti come il concetto di _\\(n\\) grande a piacere_ presente nel grado 2 sia differente dal concetto di _infinite volte_ nel grado.
Gli esempi seguenti rappresentano delle situazioni verosimili riguardanti la vitalità delle transizioni:
- __grado 0__: qualunque cosa accada _la centrale nucleare non può esplodere_;
- __grado 1__: in un certo momento se si assume il controllo di tutto ciò che avverrà _è possibile portare la centrale nucleare allo spegnimento_;
- __grado 2__: Duccio, ingegnere della centrale nucleare che si trova in coffee break, è in grado di interagire con la macchinetta del caffé appena accesa in modo da avere un numero di caffé _grande a piacere_, almeno finchè qualcuno non inserisce una moneta nella macchinetta;
- __grado 3__: Biascica, guardia giurata della centrale, è in grado di fare alzare la sbarra per il parcheggio _un numero infinito di volte_;
- __grado 4__: se succede qualcosa fuori dal controllo all'interno della centrale si può comunque riuscire ad eseguire lo spegnimento (René urla _"chiudi tutto, Duccio!"_).

Una rete viene chiamata __viva__ quando tutte le sue transizioni sono vive.

## Esempio Interattivo


<div style="width:700px; height: 440px; overflow: hidden;">
    <iframe src="https://homes.di.unimi.it/bellettini/pnexec/?pn=(P0)%20200,0%0A(P1)%20200,400%0A(P2)%200,200%0A_T0_%20400,0%0A_T1_%20200,200%0A_T2_%200,400%0A_T3_%200,0%0A_T4_%20400,400%0AP0%20-%3E%20T0%0AP1%20-%3E%20T0%0AP0%20-%3E%20T1%0AT1%20-%3E%20P1%0AP0%20-%3E%20T3%0AT3%20-%3E%20P0%0AT3%20-%3E%20P2%0AP2%20-%3E%20T2%0AT2%20-%3E%20P1%0AP1%20-%3E%20T2%0AT4%20-%3E%20P1%0AP1%20-%3E%20T4%0A@P0:1" 
    width="1600" height="850" 
    style="transform: translate(0px, 0); border=none;">
    </iframe>
</div>
<br>

- Da questo esempio pratico è possibile notare come la transizione \\(t_0\\) è di **grado 0** in quanto non potrà mai scattare, perchè è impossibile che abbia i gettoni necessari nel preset per scattare (al massimo o in \\(p_0\\) o in \\(p_1\\)).
- La transizione \\(t_1\\) è di **grado 1** perchè esiste almeno una marcatura raggiungibile per cui essa scatti, infatti la marcatura corrente è quella che ne _permette_ lo scatto (ricordando ancora che se una transizione è abilitata allo scatto non significa che debba scattare).
- Osservando la transizione \\(t_3\\) è possibile notare che essa scatti infinite volte (e non \\(n\\) grande a piacere, quindi non si tratta di una transizione di grado 2), ma nel caso avvenga lo scatto di \\(t_1\\) la transizione \\(t_3\\) non potrà mai più essere abilitata (quindi esiste una marcatura in cui non sarà possibile il suo scatto) garantendo che non si tratta di una transizione di grado 4, ma bensì di **grado 3**.
- Il caso più particolare è quello della transizione \\(t_2\\): è noto che \\(t_3\\) può scattare infinite volte e quindi in \\(p_2\\) possono esserci infiniti gettoni; inoltre, conseguentemente allo scatto di \\(t_1\\) il posto \\(p_1\\) conterrà un gettone, ma comunque la transizione \\(t_2\\) non può scattare infinite volte.
Questo perchè è vero che all'infinito posso generare gettoni in \\(p_2\\), ma dal momento che scatta \\(t_1\\) si perde questa possibilità, permettendo a \\(t_2\\) di scattare tante volte quanti sono i gettoni in \\(p_2\\). 
La transazione è quindi di **grado 2**.
- Infine \\(t_4\\) è una transizione viva (di **grado 4**), perchè qualunque sia la marcatura raggiungibile dalla marcatura corrente è possibile prendere il controllo e sicuramente esiste una sequenza di scatti tale per cui \\(t_4\\) diventi abilitata.
