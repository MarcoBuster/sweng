# \\(T\\)-invarianti

I \\(T\\)-invarianti sono concettualmente **molto simili** ai \\(P\\)-invarianti, ma pongono alcuni vincoli di **invariabilità** sulle **sequenze di scatti**, ovvero:

- si **possono ripetere** ciclicamente;
- portano alla situazione iniziale (**stato base**).

Partendo dall'equazione \\(m' = m + Cs\\), poniamo il **vincolo** \\(m' = m\\) in quanto la sequenza deve tornare alla marcatura iniziale.
Le **soluzioni** del sistema sono quindi:

$$
Cs = 0,
$$

con \\(C\\) costante e \\(s\\) un **vettore di incognite**, rappresentante una sequenza ammissibile.

Se si risolve il sistema e si trova un vettore \\(s\\) rappresentante una sequenza di scatti ammissibile, allora tale sequenza è **ciclica** per cui \\(s\\) è un \\(T\\)-invariante.

A differenza dei \\(P\\)-invarianti (trovarne uno è _condizione sufficiente_ purché sia valido), per un \\(T\\)-invariante soddisfare l'equazione è **condizione necessaria** ma non sufficiente per la **validità** della sequenza.

Se una rete è **limitata** e copribile da \\(T\\)-invarianti, allora è dimostrabile che è anche **viva**.
