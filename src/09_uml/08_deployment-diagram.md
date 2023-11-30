# Deployment diagram

Il _Deployment diagram_ permette di rappresentare la __dislocazione fisica__ delle risorse. \
Più precisamente, specifica la dislocazione fisica delle _istanze dei componenti_.

La conformazione del diagramma è quindi molto simile a quella del diagramma dei componenti, ma con qualche differenza:
* i __nodi__ del sistema indicano macchine fisiche;
* i __collegamenti__ tra nodi eplicitano le modalità di comunicazione tra gli stessi (_e.g._ RMI, HTTP).

![Esempio deployment diagram](/assets/11_deployment-diagram-example.png)

Il Deployment diagram risulta di particolare utilità per il _deployer_, _i.e._ la figura che si occupa dell'installazione fisica del sistema. Così si potranno evitare ripetizioni inutili delle stesse risorse ma ottimizzare il loro utilizzo trasversale tra le varie componenti del sistema.
