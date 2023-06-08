# Reti con priorità

Ad ogni transizione è associata una **priorità**: quando in una marcatura \\(n\\) transizioni sono abilitate, la scelta della prossima da far scattare è **determinata** dalla sua priorità.

Date le opportune priorità, è quindi possibile **guidare** la progressione della rete verso la soluzione richiesta.

Ci sono due svantaggi principali a questo approccio:

- rischio di creare di **cicli infiniti**;
- si perde la _località di decisione_ della abilitazione di una transizione: non è quindi più possibile fare analisi locale.
