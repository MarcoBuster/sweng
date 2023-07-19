# Conflitto

Due transizioni \\((t_1, \\, t_2)\\) sono in:
- __conflitto strutturale__ \\(\Longleftrightarrow \operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) \neq \varnothing \\);
- __conflitto effettivo__ in una marcatura \\(M\\) \\(\Longleftrightarrow\\):
    - \\(\boxed{M \\ [ \\ t_1 >} \land \boxed{M \\ [ \\ t_2 >}\\);
    - \\(\exists p \in \operatorname{Pre}(t_1) \cap \operatorname{Pre}(t_2) \mid M(p) < W(\langle p, \\, t_1 \rangle) + W(\langle  p, \\, t_2\rangle)\\).

Analizzando i due tipi di conflitto è possibile notare che:
- due transizioni sono in __conflitto strutturale__ se l'intersezione dei due preset non è vuota e quindi hanno posti in ingresso in comune: possono quindi interferire tra loro.
Il conflitto strutturale dipende solo dalla topologia dela rete, infatti non vengono citate le marcature;
- due transizioni sono in __conflitto effettivo__ se sono entrambe abilitate in una marcatura \\(M\\) ed esiste un posto in ingresso in comune ai due preset tale per cui il numero di gettoni in quel posto è minore della somma dei pesi dei due flussi che vanno dal posto alla transizione (quindi il posto in ingresso non ha abbastanza gettoni per far scattare entrambe le transizioni).
Entrano quindi in conflitto sulla disponibilità di gettoni nel preset.

Esiste una versione __rilassata__ della definizione di conflitto esplicitata dalla seguente formula:

$$
\boxed{M \\ [ \\ t_1 >} \\: \land \\: \boxed{M \\ [ \\ t_2 >} \\: \land \\: \lnot \\, \boxed{M \\ [ \\ t_1 t_2 >}.
$$

Questa proposizione indica che il conflitto è presente se \\(t_1\\) e \\(t_2\\) sono abilitate in una marcatura \\(M\\) e non è possibile la sequenza \\(t_1\\) \\(t_2\\) a partire da \\(M\\).
Ma cosa vuol dire che è una _versione rilassata_? 
Per capirlo si osservi questo l'esempio sottostante:

![Esempio conflitto](/assets/14_esempio-conflitto1.png)

Secondo le definizioni di conflitto che sono state date, in questa rete di Petri è presente un conflitto sia per la prima definizione che per la seconda.
È possibile però fare in modo che rimanga in conflitto per la prima definizione data ma non più per la definizione rilassata introducendo una piccola modifica:

![Esempio conflitto differenza](/assets/14_esempio-conflitto1-differenza.png)

Aggiungendo una relazione tra \\(t_1\\) a \\(p_1\\) si può notare che dopo lo scatto di \\(t_1\\) quest'ultima è ancora abilitata e quindi non rientra più sotto la definizione rilassata di conflitto.

Lasciando da parte la definizione rilassata, è facile osservare a questo punto che la definizione per il conflitto strutturale si basa solo sui preset, ignorando quindi qualsiasi arco in uscita, mentre quella per il conflitto effettivo ragiona anche sugli effetti dello scatto delle transizioni. Si noti che la presenza di un conflitto strutturale __non implica__ obbligatoriamente la presenza di un conflitto effettivo in quanto quest'ultimo per esistere necessita che venga soddisfatta una condizione in più.
Al contrario invece un conflitto effettivo __implica__ la presenza di un conflitto strutturale in quanto le condizioni di quest'ultimo sono comprese in quelle del conflitto effettivo. \
Di seguito viene mostrato un esempio di conflitto _effettivo_ e _strutturale_.

![Esempio conflitto effettivo e strutturale](/assets/14_conflitto-effettivo-e-strutturale.png)
