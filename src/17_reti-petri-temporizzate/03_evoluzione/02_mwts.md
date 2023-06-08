# Semantica temporale monotonica debole (MWTS)

Come i più attenti avranno notato, nell'elencare gli assiomi necessari per la semantica temporale debole abbiamo saltato un ipotetico assioma A2.
Ebbene, ciò non è un caso: esiste infatti un'estensione della semantica WTS che aggiunge tra i propri requisiti il rispetto di tale assioma.

Si tratta della __semantica temporale monotonica debole__ (_Monotonic WTS_, __MWTS__), e differisce dalla semantica WTS perché impone necessariamente che i tempi di scatto delle transizioni all'interno di una sequenza siano monotoni non decrescenti, forzando così il fatto che nell'intera rete __il tempo non possa tornare indietro__. \
Più formalmente, la semantica introduce il seguente assioma:

- (__A2__) __Monotonicità dei tempi di scatto di una sequenza__: tutti i tempi di scatto di una sequenza di scatti devono essere ordinati nella sequenza in maniera __monotonicamente non decrescente__ (\\(\geq\\)). \
  Anche questo serve a garantire la proprietà intuitiva di __consistenza__, evitando cioè che il tempo torni indietro.
  Non richiedendo però che i tempi siano disposti in modo strettamente crescente ma ammettendo che nella sequenza lo __stesso tempo sia ripetuto__ si lascia aperta la possibilità che nella rete più transizioni scattino in contemporanea, oppure che due transizioni scattino in tempi talmente ravvicinati che la granularità temporale del modello non è in grado di rilevare la differenza.

Le sequenze di scatti che soddisfano gli assiomi A1, A2 e A3 vengono dette __sequenze ammissibili in semantica monotonica debole__. \
Sebbene sembri una differenza da nulla, imporre la monotonicità dei tempi di scatto ha in realtà ripercussioni piuttosto grandi: in una rete che segue la MWTS quando si analizzano gli scatti è necessario non solo fare un'analisi locale del preset e del tempo di abilitazione e scatto della transizione, ma anche assicurarsi che non ci sia nessuna transizione nella rete in grado di scattare prima.
Si __perde cioè la caratteristica di località__, introducendo la necessità di mantenere un'informazione comune sull'__ultimo scatto__ nella rete.

## WTS \\(\equiv\\) MWTS

Fortunatamente per noi esiste un teorema che afferma che _per ogni sequenza di scatti ammissibile in semantica debole \\(S_{WTS}\\) __esiste__ una sequenza di scatti ammissibile in semantica monotonica debole \\(S_{MWTS}\\) __equivalente__ ottenibile per semplice __permutazione__ delle occorrenze degli scatti._

Non si tratterà di sequenze uguali, ma entrambe le sequenze produrranno la __stessa marcatura finale__.
Questo è un enorme vantaggio, in quanto ciò ci permette di infischiarcene della monotonicità degli scatti durante l'analisi della rete, potendo così sfruttare la __località__ e conseguentemente le __tecniche di analisi per le reti di Petri__ (ad alto livello) già viste in precedenza.

### Esempio di traduzione

Si prenda in esame la rete in figura:

![](/assets/16_esempio-wts-mwts.png)

Assumendo i timestamp iniziali di tutti i gettoni uguali a zero, si consideri la seguente sequenza ammissibile WTS di scatti:

$$ \text{T1 scatta al tempo 12} \rightarrow \text{T3 scatta al tempo 14} \rightarrow \text{T2 scatta al tempo 4} $$

Tale sequenza non rispetta la monotonicità, in quanto T2 scatta "nel passato" dopo lo scatto di T3, e produce la marcatura \\(\langle0, 0, 1, 0, 1\rangle\\).
Tuttavia, riordinando la sequenza come:

$$ \text{T2 scatta al tempo 4} \rightarrow \text{T1 scatta al tempo 12} \rightarrow \text{T3 scatta al tempo 14} $$

è possibile ottenere una marcatura identica ma con una sequenza che rispetta ora la monotonicità, essendo cioè ammissibile in semantica temporale monotonica debole.
