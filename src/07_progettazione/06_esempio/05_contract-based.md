# _Contract-based_ design vs programmazione difensiva

Tornando alla [specificazione](./01_interface-segregation.md#cardsource) dell'interfaccia di `CardSource`, è possibile notare dei commenti in formato Javadoc che specificano le __precondizioni__ e le __postcondizioni__ (il valore di ritorno) del metodo. Secondo il ___contract-based_ design__, esiste un _"contratto"_ tra chi implementa un metodo e chi lo chiama.

Per esempio, considerando il metodo `draw()`, __è responsabilità del chiamante__ verificare il soddisfacimento delle precondizioni (_"il mazzo non è vuoto"_) prima di invocare il metodo.
Se `draw()` viene chiamato quando il mazzo è vuoto ci troviamo in una situazione di __violazione di contratto__ e può anche esplodere la centrale nucleare.

Per specificare il contratto si possono utilizzare delle __asserzioni__ o il `@pre` nei __commenti__. 
Le prime sono particolarmenti utili in fase di sviluppo perché interrompono l'esecuzione del programma in caso di violazione, ma vengono solitamente rimosse in favore delle seconde nella fase di deployment.

Un'altro approccio è la __programmazione difensiva__ che al contrario delega la responsabilità del soddisfacimento delle precondizioni al _chiamato_, e non al chiamante.
