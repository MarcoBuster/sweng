# Refactoring
Durante il refactoring è opportuno rispettare le seguenti regole:
- le __modifiche al codice non devono modificare le funzionalità__:
il refactoring DEVE essere invisibile al cliente;
- __non possono essere inseriti test aggiuntivi__ rispetto alla fase verde appena raggiunta.

Se la fase di refactoring sta richiedendo troppo tempo allora è possibile fare rollback all'ultima versione verde e __pianificare meglio__ l'attività di refactoring, per esempio scomponendolo in più step.
Vale la regola del _"do it twice"_: il secondo approccio a un problema è solitamente più veloce e migliore.

## Motivazioni

Spesso le motivazioni dietro un refactoring sono:
- precedente __design molto complesso e poco leggibile__, a causa della velocità del passare ad uno _scenario verde_;
- __preparare il design di una funzionalità__ che non si integra bene in quello esistente; dopo aver raggiunto uno _scenario verde_ in una feature, è possibile che la feature successiva sia difficile da integrare. 
In questo caso, se il _refactoring_ non è banale è bene fermarsi, tornare indietro e evolvere il codice per facilitare l'iterazione successiva (__design for change__). 
- presenza di __debito tecnico__ su lavoro fatto in precendenza, ovvero debolezze e "scorciatoie" che ostacolano notevolmente evoluzioni future: _"ogni debito tecnico lo si ripaga con gli interessi"_.
