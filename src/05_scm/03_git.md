# git 

![Schema git](/assets/05_git-schema.png)

In figura, possiamo osservare 4 _livelli_ ordinati:
- __working directory__ (WD): rappresenta la _configurazione_ della directory di lavoro sul filesystem - esiste indipendentemente da git.
Può essere vista come l'unione dei _tracked_ and _untracked_ files; 
- __index__ (o __area di staging__): insieme dei _tracked_ files da git.
- (\\(n\\)?) __local repository__: insieme delle modifiche committate e relativo storico. 
- (\\(n\\)) __remote repository__: branch remoto; è possibile avere sia più branch per progetto remoto che più progetti remoti configurati.

Il termine ___repository___ è abbastanza _misleading_, perché è comunemente associato ad un progetto mentre in questa astrazione a livelli corrisponde di fatto a un __branch__.

Il passaggio tra un livello e l'altro non è mai automatico, ma è sempre esplicitato da un'operazione. 

## Operazioni di base

È consigliata la lettura di [git Cheatsheet](http://ndpsoftware.com/git-cheatsheet.html).

![Puntatori commit git](/assets/05_git-commits.png)

Per ogni branch c'è un puntatore all'ultimo commit di tale branch.
L'HEAD punta all'ultimo commit in cui siamo: normalmente corrisponde al puntatore del branch corrente; quando non è così siamo in una situazione di _HEAD scollegato_. 
È utile potersi spostare tra i commit per controllare revisioni precedenti, ma in caso di nuovi commit è importante creare un nuovo branch per poterci riferire ad esse.

### `git commit` &mdash; _record changes to the repository_

Il comando git commit ci permette di _salvare_ del contenuto dall'index al branch locale.

Dopo aver creato il commit, l'`HEAD` e il puntatore al branch corrente puntano al nuovo commit.
Anche il contenuto dell'index equivale al contenuto del commit.

![Puntatori commit git 2](/assets/05_git-commit.png)

#### `--amend`

Con l'opzione -\-amend è possibile rimpiazzare facilmente l'ultimo commit con uno nuovo. 

![git commit --amend](/assets/05_git-commit-amend.png)

### `git switch` &mdash; _switch branches_

Il comando git switch ha un sottoinsieme delle funzionalità del comando git checkout ed è più semplice da utilizzare.

Permette di passare a un nuovo branch semplicemente modificando l'HEAD (e di conseguenza il contenuto dell'index e dei file). 

![git checkout](/assets/05_git-checkout.png)

### `git merge` &mdash; _join two or more development histories together_

Il comando git merge è utile per unire branch (o più in generale alberi) insieme.

Se i due branch non sono divergenti, il merge avviene in modo banale con un _fast-forward_: nessun ulteriore commit verrà cambiato, verrà solo modificato il puntatore del branch e l'HEAD. 
Per forzare la creazione di un merge di commit (in gitFlow è apprezzato) occorre utilizzare l'opzione `--no-ff`.

In tutti gli altri casi, il merge può concludersi con successo oppure possono avvenire conflitti. 
Per risolverli, git ci proporrà un'interfaccia simile alla seguente.

    <<<<<<< yours:sample.txt
    Conflict resolution is hard;
    let's go shopping.
    =======
    git makes conflict resolution easy.
    >>>>>>> theirs:sample.txt

Una volta risolti tutti i conflitti è sufficiente committare le modifiche concludendo quindi il merge.

![git merge](/assets/05_git-merge.png)

La tecnica utilizzata per implementare la fusione di due rami è chiamata _3-way merge_, inizialmente vengono considerati i commit HEAD dei due branch da unire e il primo commit comune a questi due (ovvero il commit da dove è iniziata la diramazione).
A questo punto git cercherà di identificare le parti dei file modificate nelle diverse diramazioni sfruttando i commit considerati, se viene riscontrato un cambiamento della stessa porzione di file in entrambe le diramazioni significa che si è verificato un conflitto, e quindi verrà richiesto l'intervento manuale dell'utente, altrimenti verranno uniti automaticamente i due rami in un commit di merge.

### `git reset` &mdash; _reset current HEAD to the specified state_

Il comando git reset reimposta il contenuto dei file nell'_index_ (e, opzionalmente con l'opzione `--hard` nella WD) all'ultimo commit puntato da HEAD o ad un altro commit.

![git reset](/assets/05_git-reset.png)

L'opzione `--soft` si limita invece a spostare l'HEAD del branch corrente ad un commit specificato, senza modificare l'_index_ o la WD.
Cambia dunque solamente dove il branch corrente sta puntando.
Questo comando è utile quando si vogliono annullare i commit mantenendo però tutti i file e le modifiche.
Viene ad esempio utilizzato per effettuare lo _squash_ ("appiattimento") di più commit in uno unico.
