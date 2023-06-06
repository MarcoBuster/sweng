# Pro e contro

Finito di descrivere il processo di ispezione del software possiamo chiederci: funziona?
Prove empiriche parrebbero suggerire che la risposta sia __sì__ e evidenziano anche che tale tecnica è particolarmente _cost-effective_.

I vantaggi dell'uso di questa tecnica di verifica e convalida sono infatti numerosi:

- Esiste un __processo rigoroso e dettagliato__;
- Si basa sull'__accumulo dell'esperienza__, auto-migliorandosi con il tempo (vd. _checklist_);
- Il processo integra una serie di __incentivi sociali__ che spingono l'autore del codice ad analizzarlo in modo critico;
- A differenza del testing è possibile per la mente umana __astrarre il dominio completo__ dei dati, considerando quindi in un certo senso tutti i casi di test;
- È applicabile anche a __programmi incompleti__.

La software inspection funziona così bene che è spesso utilizzata come _baseline_ per valutare altre tecniche di verifica e convalida.

Questo non significa però che essa sia esente da __limiti__. \
Innanzitutto il test può essere fatto __solo a livello di unità__ in quanto la mente umana ha difficoltà a lavorare in situazioni in cui sono presenti molte informazioni contemporaneamente in assenza di astrazioni e indirettezze.
Inoltre la software inspection __non è incrementale__: spesso infatti la fase di follow-up non è così efficace, in quanto il codice è cambiato talmente tanto che è necessario ricominciare l'ispezione da capo.

Ciò non toglie però che, come afferma la __Legge di Fagan (L17)__:
> _Le ispezioni aumentano in maniera significativa la produttività, qualità e la stabilità del progetto._
