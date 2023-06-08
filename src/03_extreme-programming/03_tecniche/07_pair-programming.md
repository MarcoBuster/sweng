# Pair programming

La programmazione a coppie (__pair programming__) è una tecnica controintuitiva: dal punto di vista del manager si pagano due persone per fare il lavoro di una, ma non è così.

Ci sono diversi __vantaggi__:
- in coppia, __ci si controlla a vicenda__ su ogni aspetto (codice, rispetto delle regole XP, idee); 
- mentre il _pilota_ attua le idee, il _navigatore_ pensa cosa fare subito dopo: forma di __refactoring__;
- favorisce l'__inserimento di nuovo personale__: piuttosto che lasciare i novizi da soli a studiare libroni, vengono affiancati e incitati a osservare e interagire con persone esperte che stanno lavorando;
- fa ottenere una __proprietà collettiva__ (conoscenza osmotica), come descritta da Crystal. 
Un altro punto importante sono i commenti _naive_ (ovvero fatti da programmatori junior) per permettere di chiarire concetti basilari date spesso per scontato. 

Raddoppiare il numero di persone raddoppia la produttività?
__No__, è stimato invece che la produttività aumenti circa del 50% - quindi non abbastanza per giustificare il costo.

Diversi studi si chiedono se la produttività calcolata puntualmente sia una metrica sensata. 
Secondo molti no, perché al termine di un'iterazione ciò che sembra poco produttivo in realtà lo è di più: il tempo non successivamente speso in verifica, convalida e refactoring è largamente assorbito dall'__ispezione continua del codice__ svoltasi durante le sessioni di pair programming.

## Critiche
Betrand Meyer, nel suo libro _"Agile! The Good, the Hype and the Ugly"_, scrive:

> __Applied judiciously, pair programming can unquestionably be useful__. Many developers enjoy the opportunity to program jointly with a peer, particularly to deal with a thorny part of an assignment. 
> The basic techniques, in particular the idea of speaking your thoughts aloud for immediate feedback, are well understood and widely applied. (As a manager I regularly hear, from a developer, “On this problem I would like to engage in a round of pair programming with X ”, and invariably find it a good idea.)
> 
> What is puzzling is the insistence of XP advocates that this technique is the only way to develop software and has to be applied at all times. __Such insistence makes no sense__, for two reasons.
> 
> The first is the __inconclusiveness of empirical evidence__, noted above. Granted, lack of data is often used as a pretext to block the introduction of new techniques. 
> When an idea is obviously productive, we should not wait for massive, incontrovertible proof. 
> But here there is actually a fair amount of empirical evidence, and it does not show a significant
advantage for pair programming. 
> Pair programming may be good in some circumstances, but if it were always the solution the studies would show it. 
> In the absence of scientific evidence, a universal move is based on ideology, not reason.
> 
> The second reason, which may also explain why studies’ results vary, is that __people are different__. 
> Many excellent programmers love interacting with someone else when
they write programs; and many excellent programmers do not. 
> Those of the second kind want to think in depth, undisturbed. 
> The general agile view is that communication should be encouraged and that the days of the solitary, silent genius are gone. 
> Fine; but if your team has an outstanding programmer who during the critical steps needs peace, quiet and solitude, do you kick him out of the team, or force him to work in a way that for him may be torture?

> It is one thing to require that people explain their work to others; it is another, quite dangerous, to __force a single work pattern__, especially in a highly creative and challenging intellectual endeavor. 
> When Linus Torvalds was writing Linux, he was pretty much by
himself; that did not prevent him from showing his code, and, later on, engaging thousands of people to collaborate on it.
