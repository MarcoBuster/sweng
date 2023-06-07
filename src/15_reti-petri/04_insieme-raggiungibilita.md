<span style="display: none;">\\(\def\pt{\mathcal{P/T}}\\)</span>

# Insieme di raggiungibilità 

L'insieme di raggiungibilità \\(R\\) di una rete \\(\pt\\) a partire da una marcatura \\(M\\) è il più piccolo insieme di marcature tale che:
- \\(M \in R(\pt, \\, M)\\);
- \\(M' \in R(\pt, \\, M) \land \exists t \in T \quad \boxed{\boxed{M' \\ [\\ t >} \\, M''} \Longrightarrow M'' \in R(\pt, \\, M)\\).

Questa definizione induttiva viene interpretata nel seguente modo:
- __passo base__: la marcatura \\(M\\) appartiene all'insieme di raggiungibilità \\(R(\pt, \\, M)\\) \\
(\\(M\\) indica la marcatura iniziale mentre \\(\pt\\) indica la rete posti-transizioni);
- __passo induttivo__: se \\(M'\\) appartiene all'insieme di raggiungibilità (quindi si dice che _è raggiungibile_) ed esiste una transizione della rete tale per cui è abilitata in \\(M'\\) e porta in \\(M''\\) &mdash; per cui con uno scatto è possibile passare dalla marcatura \\(M'\\) alla marcatura \\(M''\\) &mdash; _allora_ anche quest'ultima è __raggiungibile__.

Procedendo ricorsivamente con questa definizione è possibile ottenere tutte le marcature raggiungibili.
