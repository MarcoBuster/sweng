# Evoluzione

Dovendo modellare lo __scorrere del tempo__, le reti Time Basic dovranno operare una serie di accortezze per quanto riguarda la loro evoluzione.

Abbiamo per esempio già detto che il tempo di scatto di una transizione dovrà necessariamente essere maggiore del suo tempo di abilitazione, e che tale tempo di scatto sarà pari al timestamp dei gettoni generati dalla transizione.
Tuttavia, questo non è abbastanza: il concetto di tempo è particolarmente sfuggente e, soprattutto, __difficile da definire in maniera univoca__. \
Al contrario, per le reti Time Basic vengono definite diverse __semantiche temporali__, ovvero diverse interpretazioni del concetto di "tempo" che richiederanno il rispetto di una serie di assiomi durante l'evoluzione della rete.
Tali interpretazioni, ciascuna utile per modellare diversi sistemi e requisiti di tempo, variano anche in complessità; in questo corso partiremo dunque dalla semantica più semplice per poi costruire su di essa quelle più complesse.

- [**Semantica temporale debole**](./01_wts.md) (WTS)
- [**Semantica temporale monotonica debole**](./02_mwts.md) (MWTS)
- [**Semantica temporale forte**](./03_sts.md) (STS)
- [**Semantica temporale mista**](./04_mista.md)
