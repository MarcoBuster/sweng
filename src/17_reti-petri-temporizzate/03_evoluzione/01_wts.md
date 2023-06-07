# Semantica temporale debole (WTS)

Informalmente, la __semantica temporale debole__ (_Weak Time Semantic_, __WTS__) impone che una transizione possa scattare _solo_ in uno degli __istanti identificati dalla sua funzione temporale__ e __non possa scattare _prima_ di essere stata abilitata__.

Tuttavia, ___una transizione non è costretta a scattare___ anche se abilitata: essa _potrebbe_ scattare, ma non è forzata a farlo.
Questo permette di modellare eventi solo __parzialmente definiti__, ovvero che potrebbero accadere sotto determinate condizioni ma non è possibile dire se lo faranno o no: esempi notevoli sono guasti o decisioni umane, eventi cioè non completamente prevedibili.
Si noti che a differenza dei modelli stocastici delle reti di Petri in questo caso non ci interessa la _probabilità_ con cui gli eventi potrebbero accadere, ma solo che potrebbero accadere.

Per imporre questa interpretazione del concetto di tempo l'evoluzione di una rete Time Basic deve seguire i seguenti __assiomi temporali__:

- (__A1__) __Monotonicità rispetto alla marcatura iniziale__: tutti i tempi di scatto di una sequenza di scatto devono essere __non minori__ (\\(\geq\\)) di uno qualunque dei timestamp dei gettoni della marcatura iniziale. \
  Ogni marcatura deve cioè essere __consistente__, ovvero non contenere gettoni prodotti "nel futuro".

- (__A3__) __Divergenza del tempo__ (_non-zenonicità_): __non__ è possibile avere un __numero infinito__ di scatti in un intervallo di __tempo finito__. \
  Questo assioma serve ad assicurarsi che il tempo __avanzi__!
  Esso assicura cioè che il tempo non si possa fermare e soprattutto che esso non possa essere suddivisibile in infinitesimi: il sistema evolve soltanto quando il tempo va avanti.

Le sequenze di scatti che soddisfano questi due assiomi vengono dette __sequenze ammissibili in semantica debole__.
