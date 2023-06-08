# Bebugging

Talvolta può capitare che il team di testing __non trovi errori__ nel programma sotto osservazione.
Oltre ad essere scoraggiante per chi esegue la review questo è spesso indice del fatto che tale attività non viene svolta in maniera corretta, poiché raramente un programma è effettivamente corretto al 100% dopo la prima scrittura.

Un metodo efficace per risolvere questo problema è il cosiddetto __bebugging__, una tecnica secondo la quale gli sviluppatori __inseriscono deliberatamente \\(\bf{n}\\) errori__ nel codice prima di mandarlo in analisi al team di testing, a cui viene comunicato il numero \\(n\\) di errori da trovare.
L'ovvio vantaggio di questa tecnica è l'__incentivo__ per il team di testing a continuare a cercare errori, facendo sì che durante la ricerca ne vengano scovati molti altri non ancora noti.

La metrica utilizzata per valutare l'efficacia del testing tramite questa tecnica è dunque la __percentuale di errori trovati__ tra quelli inseriti artificialmente, che può fornire un'indicazione della frazione di errori che il team di testing è in grado di trovare.
Se per esempio il team di sviluppo ha aggiunto 10 bug _"artificiali"_ e durante il testing ne vengono trovati 8 più 2 non noti, si può supporre che il team di review riesce a trovare l'_80% degli errori_ e che quindi ce ne è ancora un altra porzione di errori _reali_ da scovare. \
Bisogna però essere molto cauti nel fare considerazioni di questo tipo: è possibile che gli errori immessi artificialmente siano __troppo facili__ o __troppo difficili__ da trovare, per cui conviene sempre prendere tutto con le pinze.
