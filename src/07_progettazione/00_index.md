# Progettazione

Durante le lezioni, per discutere di progettazione siamo partiti da un esempio di programma in C che stampa una canzone.
Il codice considerato è completamente illegibile:

```c
#include <stdio.h>
main(t,_,a)
char *a;
{
return!0<t?t<3?main(-79,-13,a+main(-87,1-_,main(-86,0,a+1)+a)):
1,t<_?main(t+1,_,a):3,main(-94,-27+t,a)&&t==2?_<13?
main(2,_+1,"%s %d %d\n"):9:16:t<0?t<-72?main(_,t,
"@n'+,#'/*{}w+/w#cdnr/+,{}r/*de}+,/*{*+,/w{%+,/w#q#n+,/#{l+,/n{n+,/+#n+,/#\
;#q#n+,/+k#;*+,/'r :'d*'3,}{w+K w'K:'+}e#';dq#'l \
q#'+d'K#!/+k#;q#'r}eKK#}w'r}eKK{nl]'/#;#q#n'){)#}w'){){nl]'/+#n';d}rw' i;# \
){nl]!/n{n#'; r{#w'r nc{nl]'/#{l,+'K {rw' iK{;[{nl]'/w#q#n'wk nw' \
iwk{KK{nl]!/w{%'l##w#' i; :{nl]'/*{q#'ld;r'}{nlwb!/*de}'c \
;;{nl'-{}rw]'/+,}##'*}#nc,',#nw]'/+kd'+e}+;#'rdq#w! nr'/ ') }+}{rl#'{n' ')# \
}'+}##(!!/")
:t<-50?_==*a?putchar(31[a]):main(-65,_,a+1):main((*a=='/')+t,_,a+1)
:0<t?main(2,2,"%s"):*a=='/'||main(0,main(-61,*a,
"!ek;dc i@bK'(q)-[w]*%n+r3#l,{}:\nuwloca-O;m .vpbks,fxntdCeghiry"),a+1);
} 
```

Successivamente abbiamo scomposto il codice per renderlo logicamente più sensato e facilmente modificabile, sono state __estratte le parti comuni__ e spostate in una funzione apposita, mentre le __parti mutabili sono state salvate in alcune strutture dati__; la canzone viene così stampata tramite un ciclo. 
In questo modo scrivendo un codice più semplice siamo stati in grado di creare una soluzione più generale e più aperta ai cambiamenti.

```java
public class TwelveDaysOfChristmas {
    static String[] days = {"first", "second", ..., "twelfth"};
    static String[] gifts = { "a partdrige in a pear tree", "two turtle doves", ... };

    static String firstLine(int day) {
        return "On the " + days[day] +
               " day of Christmas my true love gave to me:\n";
    }

    static String allGifts(int day) {
        if (day == 0) {
            return "and " + gifts[0];
        } else {
            return gifts[day] + "\n" + allGifts(day-1);
        }
    }

    public static void main(String[] args) {
        System.out.println(firstLine(0));
        System.out.println(gifts[0]);
        for (int day == 1; day < 12; day++) {
            System.out.println(firstLine(day));
            System.out.println(allGifts(day));
        }
    }
}
```

È importante quindi __adottare la soluzione più semplice__ (che __non è quella più stupida__!) e una misura convenzionale per dire quanto una cosa è semplice - almeno in Università - si esprime in termini del tempo dedicato dal programmatore all'implementazione.
Tale misura si sposa bene con il __TDD__, che richiede __brevi iterazioni__ di circa 10 minuti: se la feature attuale richiede più tempo è opportuno ridurre la portata scomponendo il problema.

- [**Refactoring**](./01_refactoring.md): modifiche al codice senza nuove funzionalità;
- [**Design knowledge**](./02_design-knowledge.md): dove mantenere la conoscenza del design?
- [**Conoscenze preliminari**](./03_conoscenze-preliminari.md): object orientation, SOLID principles, reference escaping, encapsulation e information hiding, immutabilità, code smell
- [**Principio Tell-Don't-Ask**](./04_tell-dont-ask.md)
- [**Interface segregation**](./05_interface-segregation.md)
- [**Esempio**](./06_esempio/00_index.md) applicando i principi precedenti
- [**Analisi del testo naturale**](./07_analisi-testo-naturale.md) con _noun extraction_
