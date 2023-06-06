# Modelli statistici

Negli ultimi tempi si stanno sviluppando una serie di __modelli statistici__ sulla distribuzione degli errori nel codice che dovrebbero teoricamente aiutare l'attività di testing guidandola verso le porzioni di sorgente che _più probabilmente_ potrebbero presentare difetti.

Tali modelli propongono infatti una __correlazione statistica__ tra una serie di __metriche__ quali la lunghezza del codice, il tipo di linguaggio, il grado massimo di indentamento etc. e:

- __la presenza di errori__ per categoria di errore;
- __il numero di errori__ per categoria di errore.

L'idea sarebbe quindi di __predire la distribuzione e il numero di errori__ all'interno di uno specifico modulo del software in esame.

Occorre però __fare attenzione__ alle conclusioni di queste statistiche.
Utilizzare i risultati di tali modelli statistici come indicazioni sul fatto che su determinati moduli vada fatta più attività di testing rispetto ad altri potrebbe inizialmente sembrare la __soluzione più logica__.
Tuttavia, tali risultati non considerano l'attività di testing già effettuata e le correzioni successive e quindi __non cambiano__: codice inizialmente _"scritto male"_ secondo il modello rimarrà per sempre scritto male, anche se testato estensivamente.

Con ciò in mente, si cita spesso la __Legge di Pareto/Zipf (L24)__:
> _Circa l'80% dei difetti proviene dal 20% dei moduli._

Sebbene tale affermazione è indubbiamente probabilmente vera, è difficile sfruttare questa nozione in quanto non sono conosciuti in principio i __moduli particolarmente problematici__, e il testing è comunque necessario anche in tutti gli altri.
